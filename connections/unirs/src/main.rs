use std::{fmt::format, result, str::FromStr, sync::Arc};

use axum::{
    self, extract::{Path, Query, State}, http, routing::{delete, get, post, put}, Json, Router
};
use dotenv;
use serde::{Deserialize, Serialize};
use serde_json::json;
use sqlx::{self, MySql};

struct AppState {
    pool: sqlx::Pool<MySql>,
}

#[derive(Serialize, Deserialize, Debug)]
struct Student {
    student_id: i32,
    name: Option<String>,
    department: Option<String>,
}

#[derive(Serialize, Deserialize, Debug)]
struct Subject {
    subject_id: i32,
    name: Option<String>,
}

#[derive(Serialize, Deserialize, Debug)]
struct Mark {
    student_id: i32,
    student_name: Option<String>,
    subject_name: Option<String>,
    marks: Option<i32>,
}

#[derive(Serialize, Deserialize, Debug)]
struct UpdateMarksPayload {
    student_id: i32,
    subject_id: i32,
    marks: i32,
}

#[derive(Serialize, Deserialize, Debug)]
struct ReportResult {
    student_id: i32,
    student_name: Option<String>,
    marks: Option<i32>,
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    dotenv::dotenv()?;

    let opts = sqlx::mysql::MySqlConnectOptions::from_str(std::env::var("DATABASE_URL")?.as_str())?;
    let pool = sqlx::MySqlPool::connect_with(opts).await?;

    let state = Arc::new(AppState { pool: pool });

    let app = Router::new()
        .route("/students", get(get_students))
        .route("/students", post(add_student))
        .route("/subjects", get(get_subjects))
        .route("/marks", get(get_marks))
        .route("/student/{id}", delete(delete_student))
        .route("/marks", post(add_marks))
        .route("/marks", put(update_marks))
        .route("/report/{id}", get(generate_report))
        .with_state(state);

    let listener = tokio::net::TcpListener::bind(std::env::var("LISTENER_ADDR")?).await?;
    axum::serve(listener, app).await?;

    Ok(())
}

async fn get_students(
    State(state): State<Arc<AppState>>,
) -> Result<axum::Json<Vec<Student>>, axum::http::StatusCode> {
    let students = sqlx::query_as!(Student, "SELECT * from students")
        .fetch_all(&state.pool)
        .await;

    if let Ok(students) = students {
        return Ok(axum::Json(students));
    }

    Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR)
}

async fn add_student(
    State(state): State<Arc<AppState>>,
    Json(payload): Json<Student>,
) -> Result<Json<serde_json::Value>, axum::http::StatusCode> {
    let result = sqlx::query!(
        r#"
        INSERT INTO students (student_id, name, department)
        VALUES (?, ?, ?)
        "#,
        payload.student_id, payload.name, payload.department
    ).execute(&state.pool).await;

    if result.is_ok() {
        return Ok(Json(json!({
            "rows_affected": result.unwrap().rows_affected(),
            "status": format!("added student with id: {}", payload.student_id),
        })));
    }

    Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR)
}

async fn get_subjects(
    State(state): State<Arc<AppState>>,
) -> Result<axum::Json<Vec<Subject>>, axum::http::StatusCode> {
    let subjects = sqlx::query_as!(Subject, "SELECT * from subjects")
        .fetch_all(&state.pool)
        .await;

    if let Ok(subjects) = subjects {
        return Ok(axum::Json(subjects));
    }

    Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR)
}

async fn get_marks(
    State(state): State<Arc<AppState>>,
) -> Result<axum::Json<Vec<Mark>>, axum::http::StatusCode> {
    let marks = sqlx::query_as!(
        Mark,
        r#"
        SELECT s.student_id as student_id, s.name as student_name, sub.name as subject_name, m.marks
        FROM marks as m 
        JOIN students as s ON m.student_id = s.student_id
        JOIN subjects as sub ON m.subject_id = sub.subject_id
        "#
    )
    .fetch_all(&state.pool)
    .await;

    if let Ok(marks) = marks {
        return Ok(axum::Json(marks));
    }

    Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR)
}

async fn update_marks(
    State(state): State<Arc<AppState>>,
    Json(payload): Json<UpdateMarksPayload>,
) -> Result<Json<serde_json::Value>, axum::http::StatusCode> {
    let result = sqlx::query!(
        r#"
        UPDATE marks
        SET marks = ?
        WHERE student_id = ? AND subject_id = ?
        "#,
        payload.marks,
        payload.student_id,
        payload.subject_id
    )
    .execute(&state.pool)
    .await;

    if result.is_ok() {
        return Ok(Json(json!({
            "rows_affected": result.unwrap().rows_affected(),
            "status": format!("updated marks to {} for student_id: {} and subject_id: {}", payload.marks, payload.student_id, payload.subject_id)
        })));
    }

    Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR)
}

async fn add_marks(
    State(state): State<Arc<AppState>>,
    Json(payload): Json<UpdateMarksPayload>,
) -> Result<Json<serde_json::Value>, axum::http::StatusCode> {
    let result = sqlx::query!(
        r#"
        INSERT INTO marks (student_id, subject_id, marks)
        VALUES (?, ?, ?)
        "#,
        payload.student_id,
        payload.subject_id,
        payload.marks
    )
    .execute(&state.pool)
    .await;

    if result.is_ok() {
        return Ok(Json(json!({
            "rows_affected": result.unwrap().rows_affected(),
            "status": format!("added marks {} for student_id: {} and subject_id: {}", payload.marks, payload.student_id, payload.subject_id)
        })));
    }

    Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR)
}

async fn delete_student(
    State(state): State<Arc<AppState>>,
    Path(student_id): Path<i32>,
) -> Result<Json<serde_json::Value>, axum::http::StatusCode> {
    // begin a transaction
    let tx = state.pool.begin().await;
    if tx.is_err() {
        return Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR);
    }

    let mut tx = tx.unwrap();
    let marks_del = sqlx::query!(
        r#"
        DELETE FROM marks
        WHERE student_id = ?
        "#,
        student_id
    )
    .execute(&mut *tx)
    .await;

    if marks_del.is_err() {
        _ = tx.rollback().await.ok();
        return Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR);
    }

    let stu_delete = sqlx::query!(
        r#"
        DELETE FROM students
        WHERE student_id = ?
        "#,
        student_id
    )
    .execute(&mut *tx)
    .await;

    if stu_delete.is_err() {
        _ = tx.rollback().await.ok();
        return Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR);
    }

    let commit_res = tx.commit().await;

    if commit_res.is_err() {
        return Err(axum::http::StatusCode::INTERNAL_SERVER_ERROR);
    }

    Ok(Json(json!({
        "marks deleted": marks_del.unwrap().rows_affected(),
        "student row deleted": stu_delete.unwrap().rows_affected(),
        "transaction": format!("deleted student with id: {}", student_id)
    })))
}

async fn generate_report(
    State(state): State<Arc<AppState>>,
    Path(subject_id): Path<i32>,
) -> Result<Json<Vec<ReportResult>>, axum::http::StatusCode> {
    let results = sqlx::query_as!(
        ReportResult,
        r#"
        SELECT s.student_id as student_id, s.name as student_name, m.marks
        FROM marks as m
        JOIN students as s ON m.student_id = s.student_id
        WHERE m.subject_id = ?
        "#,
        subject_id
    )
    .fetch_all(&state.pool)
    .await;

    if let Ok(results) = results {
        return Ok(Json(results));
    }

    Err(axum::http::StatusCode::NOT_FOUND)
}
