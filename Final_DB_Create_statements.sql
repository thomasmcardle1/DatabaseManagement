
-- Connect to your Postgres server and set the active database to MoviesDb.  Then . . .

DROP TABLE IF EXISTS studs_written_up;
DROP TABLE IF EXISTS RA_write_up;
DROP TABLE IF EXISTS write_up_report;
DROP TABLE IF EXISTS write_up_violations;
DROP TABLE IF EXISTS RD_violations;
DROP TABLE IF EXISTS violations;
DROP TABLE IF EXISTS write_up;
DROP TABLE IF EXISTS Dorm;
DROP TABLE IF EXISTS RA;
DROP TABLE IF EXISTS RD;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS people_persons;



-- People --
CREATE TABLE people_persons (
  pid          serial not null primary key,
  name         varchar(50),
  phone_num numeric(10),
  address varchar (100)
);


-- Students --
CREATE TABLE students (
  CWID int not null references people_persons(pid) unique ,
  GradYear numeric(4)
  );

-- RD --
CREATE TABLE RD (
  RD_ID int not null references people_persons(pid) unique ,
  years_experience numeric(4)
);

-- RA --
CREATE TABLE RA (
  RA_ID int not null references students(cwid) unique,
  years_experience numeric(4)
);

-- DORM --
CREATE TABLE Dorm (
  Dorm_ID serial not null primary key,
  Name varchar(50) Unique
  CONSTRAINT chk_name CHECK (name IN ('Leo', 'Champ', 'Marian', 'Sheean', 'Foy', 'L New', 'U New', 'Gartland','U West', 'U Fulton', 'L Fulton','L West'))
);


-- Violations --
CREATE TABLE violations (
  VID serial not null primary key,
  points_deduct  int Unique
);


-- Write Up Report --
CREATE TABLE write_up_report (
  report_ID serial not null primary Key,
  LID  int not null references Dorm(dorm_ID),
  Descrip varchar(250)
);

-- RD Violations --
CREATE TABLE RD_violations (
  RD_ID int not null references RD(RD_ID),
  VID  int not null references violations(VID),
  Report_ID int not null references write_up_report(Report_ID)
);

-- Students Written Up --
CREATE TABLE studs_written_up(
  CWID         int not null references students(CWID),
  Report_ID  int not null references write_up_report(report_ID)
);


-- RA WRITE UP --
CREATE TABLE RA_write_up(
  RA_ID int not null references ra(ra_id) ,
  report_ID  int not null references write_up_report(report_ID)
);

