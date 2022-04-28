--DBS311 Group 1
--Mohammadhossein Sobhanmanesh 116523200
--Muhammad Ahmed 146908207
--Chungon Tse 154928188
--DATA FOR THE PROJECT

  CREATE TABLE department
  (
    departmentID      NUMBER PRIMARY KEY,
    departmentName    VARCHAR2(255) NOT NULL,
    deptPhone         VARCHAR2(255) NOT NULL
  );

  CREATE TABLE financial
  (
    financialID	        NUMBER PRIMARY KEY,
    balance             DEC(9,2) NOT NULL,
    bankName            VARCHAR2(255) NOT NULL,
    bankAccNum          NUMBER,
    cardNum             NUMBER
  );

  CREATE TABLE program
  (
    programID	        NUMBER PRIMARY KEY,
    programName         VARCHAR2(255) NOT NULL,
    departmentID	    NUMBER,               --fk
    CONSTRAINT program_dept_fk FOREIGN KEY( departmentID ) REFERENCES department(departmentID) ON DELETE CASCADE
  );

  CREATE TABLE course
  (
    courseID          NUMBER PRIMARY KEY,
    courseName        VARCHAR2(255) NOT NULL,
    crsDescription    VARCHAR2(255),
    creditNumber      NUMBER NOT NULL,
    programID         NUMBER,               --fk
    CONSTRAINT crs_prog_fk FOREIGN KEY (programID) REFERENCES program(programID) ON DELETE CASCADE
  );

  CREATE TABLE professor
  (
    professorID	            NUMBER PRIMARY KEY,
    profFirstname           VARCHAR2(255) NOT NULL,
    profLastName            VARCHAR2(255) NOT NULL,
    profAddress             VARCHAR2(255) NOT NULL,
    profPhone	            VARCHAR2(255) NOT NULL,
    SIN                     VARCHAR2(255) NOT NULL,
    departmentID	        NUMBER,            --fk
    financialID             NUMBER,            --fk
    CONSTRAINT pro_dep_fk   FOREIGN KEY(departmentID) REFERENCES department(departmentID) ON DELETE CASCADE,
    CONSTRAINT pro_fin_fk   FOREIGN KEY(financialID) REFERENCES financial(financialID) ON DELETE CASCADE
  );
  
  CREATE TABLE student
  (
    studentID	        NUMBER PRIMARY KEY,
    firstName           VARCHAR2(255) NOT NULL,
    lastName            VARCHAR2(255) NOT NULL,
    stEmail             VARCHAR2(255) NOT NULL,
    dateOfBirth         DATE NOT NULL,
    stAddress           VARCHAR2(255) NOT NULL,
    stPhone	            VARCHAR2(255) NOT NULL,
    cumulativeGPA	    DEC(4,2),
    programID	        NUMBER,               --fk
    financialID	        NUMBER,               --fk
    CONSTRAINT stu_prog_fk FOREIGN KEY (programID) REFERENCES program (programID) ON DELETE CASCADE,
    CONSTRAINT stu_fin_fk FOREIGN KEY (financialID) REFERENCES financial(financialID) ON DELETE CASCADE
  );
  
  CREATE TABLE section
  (
    sectionID         NUMBER PRIMARY KEY,  
    professorID       NUMBER,               --fk
    courseID          NUMBER,               --fk
    classNumber      NUMBER NOT NULL,
    courseTime       VARCHAR2(255) NOT NULL,
    CONSTRAINT sec_pro_fk FOREIGN KEY (professorID) REFERENCES professor(professorID) ON DELETE CASCADE,
    CONSTRAINT sec_crs_fk FOREIGN KEY (courseID) REFERENCES course(courseID) ON DELETE CASCADE
  );

ALTER TABLE program DISABLE CONSTRAINT program_dept_fk;
ALTER TABLE course DISABLE CONSTRAINT crs_prog_fk;
ALTER TABLE professor DISABLE CONSTRAINT pro_dep_fk;
ALTER TABLE professor DISABLE CONSTRAINT pro_fin_fk;
ALTER TABLE student DISABLE CONSTRAINT stu_prog_fk;
ALTER TABLE student DISABLE CONSTRAINT stu_fin_fk;
ALTER TABLE section DISABLE CONSTRAINT sec_pro_fk;
ALTER TABLE section DISABLE CONSTRAINT sec_crs_fk;

--10 student entries: not all in Canada.
--10 prof entries: not all in Canada.
--"211--"=student ID.
--"390--"=bank acc num
--"490--"=card num
--"606-"=programs; 1337 is the department of all.
--"725-"=prof ID.
--"800--"=bank account.
--"905--"=section ID.
--"5/9 + eight digits"=SIN
--3-digit course code

--just 1 school
REM INSERTING into department
SET DEFINE OFF;
Insert into department (departmentID, departmentName, deptPhone) values
(1337, 'School of Software Design and Data Science', '416.491.5050');

REM INSERTING into financial
SET DEFINE OFF;
--10 profs
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80001,80000.89,'RBC',39000,49000);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80002,57000.79,'TD Bank',39001,49001);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80003,1200050.69,'TD Bank',39002,49002);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80004,17000.59,'Scotia',39003,49003);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80005,23000.49,'Scotia',39004,49004);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80006,46000.39,'CIBC',39005,49005);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80007,920800.29,'CIBC',39006,49006);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80008,35000.19,'Mizuho',39007,49007);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80009,120090.09,'Standard Chartered',39008,49008);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80010,150000.99,'BNP Paribus',39009,49009);
--10 students
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80011,7800.89,'RBC',39010,49010);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80012,4343.79,'RBC',39011,49011);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80013,2189.69,'Cairo Amman',39012,49012);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80014,55300.59,'BOM',39013,49013);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80015,1800.49,'BOM',39014,49014);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80016,120000.39,'TD Bank',39015,49015);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80017,4300.29,'CIBC',39016,49016);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80018,8600.19,'Oschadbank',39017,49017);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80019,68000.09,'RBC',39018,49018);
Insert into financial (financialID, balance, bankName, bankAccNum, cardNum) values
(80020,42100.99,'Scotia',39019,49019);

REM INSERTING into program
SET DEFINE OFF;
Insert into program (programID, programName, departmentID) values
(6060,'Bachelor of Technology in Software Development',1337);
Insert into program (programID, programName, departmentID) values
(6061,'Bachelor of Data Science and Analytics',1337);
Insert into program (programID, programName, departmentID) values
(6062,'Bachelor of Business Technology Management',1337);
Insert into program (programID, programName, departmentID) values
(6063,'Computer Programming',1337);
Insert into program (programID, programName, departmentID) values
(6064,'Computer Programming and Analysis',1337);
Insert into program (programID, programName, departmentID) values
(6065,'Database Application Developer',1337);
Insert into program (programID, programName, departmentID) values
(6066,'Business Analytics',1337);
Insert into program (programID, programName, departmentID) values
(6067,'Financial Technology',1337);
Insert into program (programID, programName, departmentID) values
(6068,'Monty Python in Programming',1337);
Insert into program (programID, programName, departmentID) values
(6069,'Gaming',1337);

REM INSERTING into course
SET DEFINE OFF;
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(144,'C Language','The basics of programming and how to write in C',3,6060);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(100,'Intro to Programming','The basic principles of programming',3,6061);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(150,'Statistics','Basics of statistics for data science',3,6062);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(210,'Data Management','Structured and unstructured data management',3,6063);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(244,'OOP using C++','Object-oriented programming in C++',3,6064);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(311,'Advanced Database Services','Database using PL/SQL, NoSQL, and MongoDB',3,6065);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(140,'Data Visualization','How to visualize data and present them',3,6066);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(105,'Business Analysis for Fintech','Different phases of Fintech project life cycle and development strategies',3,6067);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(123,'Holy Grail','A quest for Holy Grail and how to find fantastic elderberries in the general direction',3,6068);
Insert into course (courseID, courseName, crsDescription, creditNumber, programID) values
(168,'Minecraft','How to play Minecraft and associate it with general programming techniques',3,6069);

REM INSERTING into professor
SET DEFINE OFF;
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7250,'Snape','Severus','4913 Sheppard Ave, Toronto, ON M1S 1T4, Canada','647-333-7167','518923930',1337,80001);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7251,'Tarly','Samwell','658 Dundas St, London, ON N6B 3L5, Canada','519-282-8116','518923931',1337,80002);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7252,'White','Walter Hartwell','3277 Bay Street Toronto, ON M5H 2S8, Canada','416-238-5397','518923932',1337,80003);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7253,'Doe','John','1831 Dundas St, London, ON N6B 3L5, Canada','519-878-5866','518923933',1337,80004);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7254,'Parks','Rosa','4594 Danforth Avenue, Toronto, ON M4K 1A6, Canada','416-461-6483','518923934',1337,80005);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7255,'Margetts','Karen','2282 Maria St, Burlington, ON L7R 2G6, Canada','905-333-8110','518923935',1337,80006);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7256,'Kao','Charles','1463 Smith Avenue, Hamilton, ON L9H 1E6, Canada','905-928-0886','918923936',1337,80007);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7257,'Akutsu','Maya','2 Chome-6-15 Kasuga, Bunkyo City, Tokyo 112-0003, Japan','81-3-3811-0000','918923937',1337,80008);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7258,'Poon','Yvonne Fung-yee','Craighall Ave, Edinburgh EH6 4RT, United Kingdom','44-131-478-5000','918923938',1337,80009);
Insert into professor (professorID, profFirstname, profLastName, profAddress, profPhone, SIN, departmentID, financialID) values
(7259,'Baud','Irina','23 Rue Gosselet, 59000 Lille, France','33-32-85-50-000','918923939',1337,80010);

REM INSERTING into student
SET DEFINE OFF;
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21101,'Al-Musami','Haneen','haneena@myseneca.ca',to_date('1990-06-01','YYYY-MM-DD'),'1139 Eglinton Avenue, Toronto, ON M4P 1A6, Canada','647-123-6743',3.1,6060,80011);
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21102,'Rafiei','Ahmad','ahmadr@myseneca.ca',to_date('1984-01-15','YYYY-MM-DD'),'2724 Adelaide St, Toronto, ON M5H 1P6, Canada','647-123-6739',2.9,6061,80012);
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21103,'Al-Adnan','Maisam','maisama@myseneca.ca',to_date('1998-09-04','YYYY-MM-DD'),'Taha Al-Hashemi Street, Amman, Jordan','962-6462-9000',2.8,6062,80013);
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21104,'Han','So-hee','soheeh@myseneca.ca',to_date('1994-11-18','YYYY-MM-DD'),'2383 Steeles Ave, Toronto, ON M3J 3A8, Canada','416-987-8098',3.0,6063,80014);
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21105,'Chong','Ching-man','chingmanc@myseneca.ca',to_date('1995-11-15','YYYY-MM-DD'),'4902 Wyecroft Road, Burlington, ON L7P 2S9, Canada','905-335-1770',3.2,6064,80015);
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21106,'Kruspe','Richard','richardk@myseneca.ca',to_date('1997-06-24','YYYY-MM-DD'),'1245 Eglinton Avenue, Toronto, ON M4P 1A6, Canada','416-723-5649',3.9,6065,80016);
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21107,'Tran','Alice','alicet@myseneca.ca',to_date('1999-10-10','YYYY-MM-DD'),'2744 Tycos Dr, Toronto, ON M5T 1T4, Canada','416-979-5579',3.6,6066,80017);
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21108,'Kovalchuk','Yulia','yuliak@myseneca.ca',to_date('2000-06-21','YYYY-MM-DD'),'Troitska Square, 5a, Dnipro, Dnipropetrovsk Oblast, Ukraine, 49000','380-966-100-000',3.4,6067,80018);
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21109,'Kumar','Pramod','pramodk@myseneca.ca',to_date('2000-04-11','YYYY-MM-DD'),'1549 Victoria Park Ave, Toronto, ON M2J 3T7, Canada','416-719-4865',3.5,6068,80019);
--this student is registering for 2205 and not yet enrolled
Insert into student (studentID, firstName, lastName, stEmail, dateOfBirth, stAddress, stPhone, cumulativeGPA, programID, financialID) values
(21110,'Lee','Stanley','stanleyl@myseneca.ca',to_date('1996-10-19','YYYY-MM-DD'),'638 Richmond Street, Oshawa, ON S4P 3Y2, Canada','905-434-5663',0,6069,80020);

REM INSERTING into section
SET DEFINE OFF;
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90501, 7250, 144, 12, 'Monday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90502, 7251, 100, 11, 'Tuesday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90503, 7252, 150, 10, 'Wednesday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90504, 7253, 210, 9, 'Thursday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90505, 7254, 244, 8, 'Friday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90506, 7255, 311, 7, 'Monday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90507, 7256, 140, 6, 'Tuesday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90508, 7257, 105, 5, 'Wednesday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90509, 7258, 123, 4, 'Thursday');
Insert into section (sectionID, professorID, courseID, classNumber, courseTime) values
(90510, 7259, 168, 3, 'Friday');

ALTER TABLE program ENABLE CONSTRAINT program_dept_fk;
ALTER TABLE course ENABLE CONSTRAINT crs_prog_fk;
ALTER TABLE professor ENABLE CONSTRAINT pro_dep_fk;
ALTER TABLE professor ENABLE CONSTRAINT pro_fin_fk;
ALTER TABLE student ENABLE CONSTRAINT stu_prog_fk;
ALTER TABLE student ENABLE CONSTRAINT stu_fin_fk;
ALTER TABLE section ENABLE CONSTRAINT sec_pro_fk;
ALTER TABLE section ENABLE CONSTRAINT sec_crs_fk;
