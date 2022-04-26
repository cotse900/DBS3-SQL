--CRUD -> Create, Read, Update, Delete
--Muhammad Ahmed -> Section table
--Chungon Tse -> Course table
--Mohammadhossein Sobhanmanesh -> Financial table



-- SETTING UP SERVER TO ALLOW AND DISPLAY OUTPUT TO CONSOLE 
SET SERVEROUTPUT ON;



-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------
-- SECTION TABLE STORED PROCEDURES --
------------------------------------- 
CREATE OR REPLACE PROCEDURE spSectionInsert(
err_code OUT INTEGER,
m_sectionID IN section.sectionid%type, 
m_professorID section.professorid%type DEFAULT NULL, 
m_courseID section.courseid%type DEFAULT NULL, 
m_classNumber IN section.classnumber%type, 
m_courseTime IN section.coursetime%type
) AS 
BEGIN
    INSERT INTO section (sectionid, professorid, courseid, classnumber, coursetime)
    VALUES (m_sectionID, m_professorID, m_courseID, m_classNumber, m_courseTime);

    err_code := sql%rowcount;
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS
            THEN err_code := -1;
END;

CREATE OR REPLACE PROCEDURE spSectionRead(
err_code OUT INTEGER,
m_sectionID IN section.sectionid%type,
m_professorID OUT section.professorid%type, 
m_courseID OUT section.courseid%type, 
m_classNumber OUT section.classnumber%type, 
m_courseTime OUT section.coursetime%type
) AS
BEGIN
    SELECT professorid, courseid, classnumber, coursetime
    INTO m_professorID, m_courseID, m_classNumber, m_courseTime
    FROM section 
    WHERE sectionid=m_sectionID;

    err_code := sql%rowcount;
    
    EXCEPTION
        WHEN OTHERS
            THEN err_code := -1;
END;

CREATE OR REPLACE PROCEDURE spSectionUpdate(
err_code OUT INTEGER,
m_sectionID IN section.sectionid%type, 
m_professorID section.professorid%type DEFAULT NULL, 
m_courseID section.courseid%type DEFAULT NULL, 
m_classNumber IN section.classnumber%type, 
m_courseTime IN section.coursetime%type
) AS 
BEGIN
    UPDATE section 
        SET professorid=m_professorID,
            courseid=m_courseID,
            classnumber=m_classNumber,
            coursetime=m_courseTime
    WHERE sectionid=m_sectionID;

    err_code := sql%rowcount;
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS
            THEN err_code := -1;
END;

CREATE OR REPLACE PROCEDURE spSectionDelete(
err_code OUT INTEGER,
m_sectionID IN section.sectionid%type
) AS 
BEGIN
    DELETE FROM section 
    WHERE sectionid=m_sectionID;
    
    err_code := sql%rowcount;
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS
            THEN err_code := -1;
END;

CREATE OR REPLACE PROCEDURE spSectionDisplayAll AS 
sectionEntry section%rowtype;
CURSOR selectAllSections IS
    SELECT * FROM section;
BEGIN
    OPEN selectAllSections;

    LOOP
        FETCH selectAllSections INTO sectionEntry;
        
        EXIT WHEN selectAllSections%notfound;
        
        dbms_output.put_line('Section ID:   ' || sectionEntry.sectionid);
        dbms_output.put_line('Professor ID: ' || sectionEntry.professorid);
        dbms_output.put_line('Course ID:    ' || sectionEntry.courseid);
        dbms_output.put_line('Class Number: ' || sectionEntry.classnumber);
        dbms_output.put_line('Class Time:   ' || sectionEntry.coursetime);
        dbms_output.put_line(chr(10)); -- To display a new blank line in PL/SQL, you can use the chr(10) carriage return character
    END LOOP;
    
     EXCEPTION
        WHEN NO_DATA_FOUND
            THEN DBMS_OUTPUT.PUT_LINE('ERROR: No data to display.');
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE('ERROR: Unknown error occurred.');
END;



-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
------------------------------------
-- COURSE TABLE STORED PROCEDURES --
------------------------------------ 
--Insert
Create or replace PROCEDURE spCourseInsertByID    
(
cseId IN course.courseid%type, 
cseName IN course.coursename%type,
cseDesc IN course.crsdescription%type,
cseCredit IN course.creditnumber%type,
pId IN course.programid%type,
err_code OUT NUMBER)
AS  
BEGIN
	INSERT INTO course (courseid, coursename, crsdescription, creditnumber, programid)
	VALUES (cseId, cseName, cseDesc, cseCredit, pId);

	err_code:= 1;
    COMMIT;

    EXCEPTION
        WHEN OTHERS
            THEN err_code := -1;
END;

--Read
Create or replace PROCEDURE spCourseReadByID
(
cseId IN course.courseid%type, 
cseName OUT course.coursename%type,
cseDesc OUT course.crsdescription%type,
cseCredit OUT course.creditnumber%type,
pId OUT course.programid%type,
err_code OUT NUMBER)
AS 
BEGIN
	SELECT coursename, crsdescription, creditnumber, programid
    INTO cseName, cseDesc, cseCredit, pId
    FROM Course
    WHERE courseid=cseId;
        err_code := sql%rowcount;
	    EXCEPTION
        WHEN OTHERS
            THEN err_code := -1;
END;
--------------------------------------------
--Update
Create or replace PROCEDURE spCourseUpdateByID
(
cseId IN course.courseid%type, 
cseName IN course.coursename%type,
cseDesc IN course.crsdescription%type,
cseCredit IN course.creditnumber%type,
pid IN course.programid%type,
err_code OUT NUMBER)
AS 
BEGIN
	UPDATE course SET coursename= cseName, crsdescription=cseDesc, creditnumber=cseCredit, programid=pid
	WHERE courseid=cseId;

	err_code:= 1;
    COMMIT;

    EXCEPTION
        WHEN OTHERS
            THEN err_code := -1;
END;


--Delete
Create or replace PROCEDURE spCourseDeleteByID

( cseId IN course.courseid%type, err_code OUT NUMBER)
AS 
BEGIN
	DELETE FROM course WHERE courseid=cseId;

	err_code:= 1;
    COMMIT;

    EXCEPTION
        WHEN OTHERS
            THEN err_code := -1;
END;
---------------------------------------------
--Display All

CREATE OR REPLACE PROCEDURE spCourseDisplayAll AS
courseEntry course%rowtype;
CURSOR selectAllCourses IS
    SELECT * FROM course;
BEGIN
    OPEN selectAllCourses;

    LOOP
        FETCH selectAllCourses INTO courseEntry;

        EXIT WHEN selectAllCourses%notfound;

        dbms_output.put_line('Course ID:   ' || courseEntry.courseid);
        dbms_output.put_line('Course Name: ' || courseEntry.coursename);
        dbms_output.put_line('Description:    ' || courseEntry.crsdescription);
        dbms_output.put_line('Credit: ' || courseEntry.creditnumber);
        dbms_output.put_line('Program ID:   ' || courseEntry.programid);
        dbms_output.put_line(chr(10));
    END LOOP;

    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN DBMS_OUTPUT.PUT_LINE('ERROR: No data to display.');
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE('ERROR: Unknown error occurred.');
END;



-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
---------------------------------------
-- FINANCIAL TABLE STORED PROCEDURES --
--------------------------------------- 
--INSERT
create or replace PROCEDURE spFinancialInsertByID
(fid IN financial.financialid%type,
 blnc IN financial.balance%type, 
 bankName IN financial.bankname%type, 
 bankAccNum IN financial.bankaccnum%type, 
 cardNum IN financial.cardnum%type,
 result OUT INTEGER) 
 AS
 BEGIN
 
 INSERT INTO Financial(financialid, balance, bankname, bankaccnum, cardnum)
 VALUES (fid, blnc, bankName, bankAccNum, cardNum);
 
 result := SQL%rowcount;  -- 1 = success, -1 = fail
     COMMIT;

 EXCEPTION
  WHEN OTHERS
  THEN
  result := -1;
 END;


--UPDATE
 create or replace PROCEDURE spFinancialUpdateByID(fid IN financial.financialid%type,
 blnc IN financial.balance%type, 
 bkName IN financial.bankname%type, 
 bkAccNum IN financial.bankaccnum%type, 
 cdNum IN financial.cardnum%type,
 result OUT INTEGER) 
 AS
 BEGIN
 UPDATE Financial
 SET  financial.balance = blnc, financial.bankname= bkName, financial.bankaccnum = bkAccNum, financial.cardnum= cdNum
 WHERE financialid = fid;
 
 result := SQL % rowcount;
 COMMIT;
 
  EXCEPTION
  WHEN OTHERS
  THEN
  result := -1;
 END;

--READ
create or replace PROCEDURE spFinancialSelectByID(fid IN financial.financialid%type, balance OUT INTEGER, bankName OUT STRING, bankaccnum OUT INTEGER, cardNum OUT INTEGER, result OUT INTEGER )
AS
finID  financial.financialid%TYPE ;
blnc      financial.balance%TYPE;
bnkName   financial.bankname%type;
bnkAcc    financial.bankaccnum%type;
crdnum     financial.cardnum%type;

BEGIN
SELECT balance, bankname, bankAccNum, cardNum INTO blnc,bnkName,bnkAcc, crdnum 
From financial
WHERE financialid = fid;

result:= SQL%rowcount;
balance:= blnc;
bankName:= bnkName;
bankaccnum:= bnkAcc;
cardNum:= crdnum;

EXCEPTION
WHEN OTHERS
THEN

result := -1;
END;


--DELETE
create or replace PROCEDURE spFinancialDeleteByID(fid IN financial.financialid%type, result OUT INTEGER )
AS 
BEGIN
DELETE FROM financial WHERE financialid=fid;
result:= 1;
COMMIT;

EXCEPTION
WHEN  OTHERS
THEN
result:= -1;
END;

--DISPLAY ALL
CREATE OR REPLACE PROCEDURE spFinancialDisplayAll AS
financialEntry financial%rowtype;
CURSOR selectAllFinancial IS
SELECT * FROM Financial;
BEGIN
OPEN selectAllFinancial;

LOOP
FETCH selectAllFinancial INTO financialEntry;

dbms_output.put_line('Financial ID: ' || financialEntry.financialid);
dbms_output.put_line('Balance: ' || financialEntry.balance);
dbms_output.put_line('Bank Name: ' || financialEntry.bankname);
dbms_output.put_line('Bank Account Number: ' || financialEntry.bankaccnum);
dbms_output.put_line('Card Number: ' || financialEntry.cardnum);
dbms_output.put_line(chr(10));

EXIT WHEN selectAllFinancial%notfound;
END LOOP;



EXCEPTION
    WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('ERROR: No data to display.');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('ERROR: Unknown error occurred.');
END;




