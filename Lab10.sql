----------------------------------------------------------------------------------------
-- Courses and Prerequisites
-- by Alan G. Labouseur
-- Tested on Postgres 9.3.2
----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Prerequisites;
DROP TABLE IF EXISTS Courses;
--
-- The table of courses.
--
create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


--
-- Courses and their prerequisites
--
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;


---------------------------------------------------------
---Returns the immediate prerequisites for the passed-in course number.---


create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   course_num int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  courses.num IN (select p.preReqNum
				from Prerequisites p
				where course_num = p.courseNum);
   return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(499, 'results');
Fetch all from results;

-------------------------------------------------------------
--- Returns the courses for which the passed-in course number is an immediate pre-requisite ---

create or replace function IsPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   preReq_num int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  courses.num IN (select courseNum
				from Prerequisites
				where preReq_num = preReqNum);
   return resultset;
end;
$$ 
language plpgsql;

select IsPreReqFor(221, 'results');
Fetch all from results;

---------------------------------------------------------------
--- function that takes a passed-in course number and generates all of its prerequisites ---


create or replace function get_all_preReq(int, function IsPreReqFor, REFCURSOR) returns refcursor as 
$$
declare
   course_num int       := $1;
   IsPreReqFor function := $2;
   resultset   REFCURSOR := $3;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  courses.num IN (select courseNum
				from Prerequisites
				where preReq_num = preReqNum);
   return resultset;
end;
$$ 
language plpgsql;

select get_all_preReq(499, 'results');
Fetch all from results;

select * from prerequisites
