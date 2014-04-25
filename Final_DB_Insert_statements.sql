-- People_Persons --
select * from people_persons;


INSERT INTO people_persons(name, phone_num, address)
  VALUES('Adam Scott',1234567890, '17 Walabee Lane');

INSERT INTO people_persons(name, phone_num, address)
  VALUES ('Tom Mc', 6313327857, 'Florida');

INSERT INTO people_persons(name, phone_num, address)
  VALUES('Plunkett', 1564315342, 'yonkers');

INSERT INTO people_persons(name, phone_num, address)
  VALUES('Chris Smith', 456456456, 'Queens');

INSERT INTO people_persons(name, phone_num, address)
  VALUES('Jones', 898998989, 'Poughkeepsie');

INSERT INTO people_persons(name, phone_num, address)
  VALUES('Farrell', 323232111, 'Hawaii');

INSERT INTO people_persons(name, phone_num, address)
  VALUES('Dillon', 1235455698, 'Colorado');

INSERT INTO people_persons(name, phone_num, address)
  VALUES('Mac Attack', 1365659895, 'Cuba');

INSERT INTO people_persons(name, phone_num, address)
  VALUES('The X Factor', 1289654766, 'Ireland');

-- Insert Students --
select * from students;

INSERT INTO students(cwid, gradYear)
  VALUES(1, 2014);

INSERT INTO students(cwid, gradYear)
  VALUES(2, 2015);
  
INSERT INTO students(cwid, gradYear)
  VALUES(3, 2014);
  
 INSERT INTO students(cwid, gradYear)
  VALUES(6, 2014);

INSERT INTO students(cwid, gradYear)
  VALUES(7, 2015);
  
INSERT INTO students(cwid, gradYear)
  VALUES(8, 2014);
  
--Insert RD--
select * from RD;

INSERT INTO RD(rd_id,years_experience)
  VALUES(4, 4);
  
INSERT INTO RD(rd_id,years_experience)
  VALUES(5, 3);

  
  -- Insert RA --
  select * from RD;
  select * from students;
  select * from people_persons;

  INSERT INTO RA(RA_ID, years_experience)
  VALUES(7,2);

  INSERT INTO RA(RA_ID, years_experience)
  VALUES(8,2);
  
  INSERT INTO RA(RA_ID, years_experience)
  VALUES(6,0);

  -- Insert Dorm --
  select * from dorm;

  INSERT INTO Dorm(name)
  VALUES('Leo');
   INSERT INTO Dorm(name)
  VALUES('Champ');
   INSERT INTO Dorm(name)
  VALUES('Marian');
   INSERT INTO Dorm(name)
  VALUES('Sheean');
   INSERT INTO Dorm(name)
  VALUES('Foy');
   INSERT INTO Dorm(name)
  VALUES('L New');
   INSERT INTO Dorm(name)
  VALUES('U New');
   INSERT INTO Dorm(name)
  VALUES('Gartland');
  INSERT INTO Dorm(name)
  VALUES( 'U West');
   INSERT INTO Dorm(name)
  VALUES('U Fulton');
   INSERT INTO Dorm(name)
  VALUES('L Fulton');
   INSERT INTO Dorm(name)
  VALUES('L West');

/*
-- Insert Write Ups --
select * from write_up;

INSERT INTO write_up(descrip)
  VALUES('Noise Complaint');

INSERT INTO write_up(descrip)
  VALUES('Alcohol');
*/

-- Insert Violations -- 
select * from violations;

INSERT INTO violations(points_deduct)
  VALUES(1);
  
INSERT INTO violations(points_deduct)
  VALUES(2);


-- Insert Write Up Violations --
select * from write_up_violations;

INSERT INTO write_up_violations(wid, vid)
  VALUES(1,1);

INSERT INTO write_up_violations(wid, vid)
  VALUES(2,2);


-- Insert Write Up Report--
select * from write_up_report;

INSERT INTO write_up_report(report_ID, lid, descrip)
  VALUES(1, 6, 'To Many Lines of code');
  
INSERT INTO write_up_report(report_ID, lid, descrip)
  VALUES(2, 3, 'Music too loud');

  -- Insert RD Violation --
  select * from RD_violations;
  select * from rd;

INSERT INTO RD_violations(rd_id, vid, report_id)
  VALUES(4,1,1);
  
INSERT INTO RD_violations(rd_id, vid, report_id)
  VALUES(5,2, 2);


  -- Insert RA Write Up --
  select * from RA_write_up;
  select * from write_up_report;
  

 INSERT INTO RA_write_up(ra_id, report_id)
  VALUES(7, 1);
  
 INSERT INTO RA_write_up(ra_id,report_id)
  VALUES(8, 2);



  -- Insert studs_written_up --
select * from studs_written_up;

 INSERT INTO studs_written_up(cwid, report_id)
  VALUES(1, 1);

 INSERT INTO studs_written_up(cwid, report_id)
  VALUES(2, 2);
  


-----------------------------------------------------------

------------------------REPORTS----------------------------

------------------------------------------------------------


Select DISTINCT Name, gradyear
From people_persons p,
	students s,
	studs_written_up swu,
	write_up_report wur
Where   s.CWID = p.pid
	AND s.cwid = swu.cwid
        AND wur.report_ID = swu.report_ID
Order By s.GradYear;



select p1.name, p2.name
	
from 	people_persons p1,
	people_persons p2,
	ra r,
	students s,
	ra_write_up rwu,
	studs_written_up swu,
	write_up_report wur
	
where   p1.pid = r.ra_id
	AND p2.pid = s.cwid
	AND s.cwid = swu.cwid
	AND r.ra_id = rwu.ra_id
	AND rwu.report_id = wur.report_id
	AND swu.report_id = wur.report_id
	

-----------------------------------------------------------

------------------STORED PROCEUDRES-------------------------

------------------------------------------------------------


create or replace function chk_student_report(int, refcursor) returns refcursor
as $$
declare
   nameparam int := $1;
   resultset refcursor := $2;
begin
open resultset for
  select p1.pid, p1.name as "Student", p2.name as"RA", wur.descrip
  from  people_persons p1,
        people_persons p2,
	students s,
	studs_written_up swu,
	write_up_report wur,
	ra,
	ra_write_up rwu
where   p1.pid = s.cwid
	AND s.cwid = swu.cwid
	AND p2.pid = ra.ra_id
	AND ra.ra_id = rwu.ra_id
	AND rwu.report_id = wur.report_id
	AND swu.report_id = wur.report_id
	AND p1.pid = nameparam;
   return resultset;
end;
$$ language plpgsql;

select chk_student_report(2, 'results');
fetch all from results;


---------------------------------------------------------------------------


create or replace function chk_student_penalties(int, refcursor) returns refcursor
as $$
declare
   nameparam int := $1;
   resultset refcursor := $2;
begin
open resultset for
  select p.pid, p.name, wur.descrip, v.points_deduct as "Priority Point Lost"
  from  people_persons p,
	students s,
	studs_written_up swu,
	RD_violations rv,
	write_up_report wur,
	violations v
where   p.pid = s.cwid
	AND s.cwid = swu.cwid
	AND swu.report_id = wur.report_id
	AND wur.report_id = rv.report_id
	AND rv.vid = v.vid
	AND p.pid = nameparam;
   return resultset;
end;
$$ language plpgsql;

select chk_student_report(2, 'results');
fetch all from results;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


Create Function 
DROP FUNCTION chk_student_report_table(name_lookup TEXT)

create or replace function chk_student_report_table(name_lookup TEXT) 
returns table(Name Text) 
as $$
begin
  select p.pid, p.name, p.phone_num, p.address
  from  people_persons p,
	students s,
	studs_written_up swu,
	write_up_report wur
where   p.pid = s.cwid
	AND s.cwid = swu.cwid
	AND swu.report_id = wur.report_id
	AND p.pid ~ name_lookup;
	END;
$$ language plpgsql;

select chk_student_report('tom', 'results');
fetch all from results;

------------------------------------------------------------------
--------------------TRIGGERS--------------------------------------
------------------------------------------------------------------
CREATE TRIGGER deleteReport
	AFTER DELETE ON write_up_report
	FOR EACH ROW 
	EXECUTE PROCEDURE deleteReport

	
Create Trigger deleteReport()
RETURN tigger AS $$
Begin 
	DELETE FROM violations
	WHERE v.report_id NOT EXISTS( SELECT report_ID
					FROM write_up_report)



----------------------------------------------------------------------------
--------------------------------VIEWS---------------------------------------
----------------------------------------------------------------------------


CREATE OR REPLACE VIEW Students_WRITTEN_UP_IN_MARIAN AS
Select s.cwid, p.name, s.gradyear, p.phone_num, p.address
from    people_persons p,
	students s,
	studs_written_up swu,
	write_up_report wur,
	dorm d
where p.pid = s.cwid
	AND s.cwid = swu.cwid
	AND swu.report_id = wur.report_id
	AND wur.lid= d.dorm_id
	AND d.name = 'Marian'



select *
from Students_WRITTEN_UP_IN_Marian