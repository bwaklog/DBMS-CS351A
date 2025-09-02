CREATE TABLE Fest (
    Fest_ID VARCHAR(10) PRIMARY KEY,
    Fest_name VARCHAR(100) NOT NULL,
    Year INT NOT NULL,
    Head_teamID VARCHAR(10)
);

desc fest;

CREATE TABLE Teams (
    Team_ID VARCHAR(10) PRIMARY KEY,
    Team_name VARCHAR(100) NOT NULL,
    Team_type ENUM('MNG', 'ORG') DEFAULT 'ORG',
    FestID VARCHAR(10),
    FOREIGN KEY (FestID) REFERENCES Fest(Fest_ID) ON DELETE CASCADE
);

desc teams;

ALTER TABLE fest
ADD FOREIGN KEY (Head_teamID) REFERENCES Teams(Team_ID) 
ON DELETE SET NULL;

CREATE TABLE Members (
    Mem_ID VARCHAR(10) PRIMARY KEY,
    Mem_name VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Super_MemID VARCHAR(10),
    TeamID VARCHAR(10),
    FOREIGN KEY (Super_MemID) REFERENCES Members(Mem_ID) ON DELETE SET NULL,
    FOREIGN KEY (TeamID) REFERENCES Teams(Team_ID) ON DELETE CASCADE
);

desc Members;

CREATE TABLE Event (
    Event_ID VARCHAR(10) PRIMARY KEY,
    Event_name VARCHAR(100) NOT NULL,
    Building VARCHAR(50) NOT NULL,
    Floor INT NOT NULL,
    Room_no VARCHAR(10) NOT NULL,
    Price DECIMAL(6,2) CHECK (Price <= 1500),
    TeamID VARCHAR(10),
    FOREIGN KEY (TeamID) REFERENCES Teams(Team_ID) ON DELETE CASCADE
);

desc Event;

CREATE TABLE Event_conduction (
    Event_ID VARCHAR(10),
    Date_of_conduction DATE,
    PRIMARY KEY (Event_ID, Date_of_conduction),
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID) ON DELETE CASCADE
);

desc event_conduction;

CREATE TABLE Participants (
    SRN VARCHAR(15) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    semester INT NOT NULL,
    gender CHAR(1) NOT NULL
);

desc Participants;

CREATE TABLE Visitors (
    SRN VARCHAR(15),
    Name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender CHAR(1) NOT NULL,
    PRIMARY KEY (SRN, Name),
    FOREIGN KEY (SRN) REFERENCES Participants(SRN) ON DELETE CASCADE
);

desc visitors;

CREATE TABLE Registration (
    Event_ID VARCHAR(10),
    SRN VARCHAR(15),
    RegistrationID VARCHAR(15),
    PRIMARY KEY (Event_ID, SRN),
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID) ON DELETE CASCADE,
    FOREIGN KEY (SRN) REFERENCES Participants(SRN) ON DELETE CASCADE
);

desc Registration;

CREATE TABLE Stall (
    Stall_ID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    Fest_ID VARCHAR(10),
    FOREIGN KEY (Fest_ID) REFERENCES Fest(Fest_ID) ON DELETE CASCADE
);

desc stall;

CREATE TABLE Item (
    Name VARCHAR(100),
    Type ENUM('Veg', 'Non-veg') NOT NULL,
    PRIMARY KEY (Name)
);

desc Item;

CREATE TABLE Stall_Items (
    Stall_ID VARCHAR(10),
    Item_name VARCHAR(100),
    Price_per_unit DECIMAL(6,2) NOT NULL,
    Total_quantity INT NOT NULL,
    PRIMARY KEY (Stall_ID, Item_name),
    FOREIGN KEY (Stall_ID) REFERENCES Stall(Stall_ID) ON DELETE CASCADE,
    FOREIGN KEY (Item_name) REFERENCES Item(Name) ON DELETE CASCADE
);

desc Stall_Items;

CREATE TABLE Purchased (
    SRN VARCHAR(15),
    Stall_ID VARCHAR(10),
    Item_name VARCHAR(100),
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Quantity INT NOT NULL,
    PRIMARY KEY (SRN, Stall_ID, Item_name, Timestamp),
    FOREIGN KEY (SRN) REFERENCES Participants(SRN) ON DELETE CASCADE,
    FOREIGN KEY (Stall_ID, Item_name) REFERENCES Stall_Items(Stall_ID, Item_name) ON DELETE CASCADE
);

desc Purchased;

show tables;