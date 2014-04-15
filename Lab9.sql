-- Connect to your Postgres server and set the active database to MoviesDb.  Then . . .


DROP TABLE IF EXISTS spaceCraftLink;
DROP TABLE IF EXISTS crew;
DROP TABLE IF EXISTS flightControl;
DROP TABLE IF EXISTS astronauts;
DROP TABLE IF EXISTS engineers;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS spaceCraftSystems;
DROP TABLE IF EXISTS catalog;
DROP TABLE IF EXISTS systems;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS spaceCraft;


-- People --
CREATE TABLE people (
  pid          serial not null primary key,
  name         varchar(100),
  age          varchar(3)
  );


-- Flight Control --
CREATE TABLE flightControl(
  fid           int not null primary key references people(pid),
  chairPref     varchar(45),
  DrinkPref     varchar(45)
);


-- Astronauts --
CREATE TABLE astronauts(
  aid      int not null primary key references people(pid),
  yearsFlying varchar(2),
  golfHandicap varchar(25)
);


-- Engineers --
CREATE TABLE engineers(
  eid int not null primary key references people(pid),
  highestDegree  varchar(100),
  favVideoGame   varchar(45)
  );


-- Space Craft --
CREATE TABLE spaceCraft(
  scraftID serial not null primary key,
  name     varchar(100),
  tailNum  varchar(225),
  weightTONS double precision,
  fuelType   varchar(45),
  crewCapacity  varchar(5)
  );


-- Crew -- 
CREATE TABLE crew(
  scraftID  int not null references spaceCraft(scraftID),
  aid       int not null references astronauts(aid)
);

-- spaceCraftLink -- 
CREATE TABLE spaceCraftLink(
  scraftID  int not null references spaceCraft(scraftID),
  eid       int not null references engineers(eid),
  fid       int not null references flightControl(fid)
);


-- Suppliers --
CREATE TABLE suppliers(
  supID  serial not null primary key,
  name   varchar (100),
  address varchar (100),
  paymentTerms  varchar(100)
  );


-- Parts --
CREATE TABLE parts(
  pid   serial not null primary key,
  name  varchar(100),
  descrip  varchar (225)
  );


-- Systems --
CREATE TABLE systems (
  sysID  serial not null primary key,
  name   varchar(100),
  descrip varchar (225)
); 


-- Catalog --
CREATE TABLE catalog (
  supID  int not null references suppliers(supID),
  pid    int not null references parts(pid),
  sysID  int not null references systems(sysID)
);


-- SpaceCraftSystem Link --
CREATE TABLE spaceCraftSystems(
  sysID     int not null references systems(sysID),
  scraftID  int not null references spacecraft(scraftID)
  );



-- Insert People--

INSERT INTO people(name, age)
  VALUES('Adam Scott', '25');

INSERT INTO people(name, age)
  VALUES('Tom McArdle', '28');

 INSERT INTO people(name, age)
  VALUES('Joe Shmoe', '36');

 INSERT INTO people(name, age)
  VALUES('Frank Cinatra', '50');
  
 INSERT INTO people(name, age)
  VALUES('Albert Einstein', '100');

 INSERT INTO people(name, age)
  VALUES('Dylan Fox', '34');

 INSERT INTO people(name, age)
  VALUES('Sam Slam' , '22');
  
-- Insert Flight Control --
  
INSERT INTO flightControl(fid, chairPref, DrinkPref)
  VALUES ((select pid
	  from people
	  where people.pid = 1),'Rollie', 'Red Wine');


INSERT INTO flightControl(fid, chairPref, DrinkPref)
  VALUES ((select pid
	  from people
	  where people.pid = 2),'Recliner', 'Classic Coka Cola');

-- Insert Astronauts --

INSERT INTO astronauts(aid, yearsFlying, golfHandicap)
  VALUES ((select pid
	  from people
	  where people.pid = 3),'11', '6');


INSERT INTO astronauts(aid, yearsFlying, golfHandicap)
  VALUES ((select pid
	  from people
	  where people.pid = 4),'13', '5');

-- Insert Engineers --

INSERT INTO engineers(eid, highestDegree, favVideoGame)
  VALUES ((select pid
	  from people
	  where people.pid = 5),'Masters', 'Halo');


INSERT INTO engineers(eid, highestDegree, favVideoGame)
  VALUES ((select pid
	  from people
	  where people.pid = 6),'Masters', 'Fifa 2012');


INSERT INTO engineers(eid, highestDegree, favVideoGame)
  VALUES ((select pid
	  from people
	  where people.pid = 7),'Bachelors', 'Maden 2010');


-- INSERT Crew --
INSERT INTO crew(aid)
VALUES ((select aid
	from astronauts 
	where aid = 3)
);

INSERT INTO crew(aid)
VALUES ((select aid
	from astronauts 
	where aid = 4));



-- Insert SpaceCraft --
INSERT INTO spaceCraft(Name, TailNum, WeightTons, FuelType, CrewCapacity)
VALUES ('Apollo 1', '25XTG4416D1G', '6.4', '87', '5');

INSERT INTO spaceCraft(Name, TailNum, WeightTons, FuelType, CrewCapacity)
VALUES ('Flight 370', 'YV622UDBFS66', '5.9', '87', '6');

INSERT INTO spaceCraft(Name, TailNum, WeightTons, FuelType, CrewCapacity)
VALUES ('Where is Malaysia', '4RYSDFG68704', '6.2', '87', '6');


-- Space Craft Link --

INSERT INTO spaceCraftLink(scraftID, eid, fid)
VALUES (1, 5, 1);

INSERT INTO spaceCraftLink(scraftID, eid, fid)
VALUES (1, 6, 1);

INSERT INTO spaceCraftLink(scraftID, eid, fid)
VALUES (2, 6, 2);

INSERT INTO spaceCraftLink(scraftID, eid, fid)
VALUES (2, 7, 1);

INSERT INTO spaceCraftLink(scraftID, eid, fid)
VALUES (2, 7, 2);

INSERT INTO spaceCraftLink(scraftID, eid, fid)
VALUES (3, 5, 2);

INSERT INTO spaceCraftLink(scraftID, eid, fid)
VALUES (3, 5, 1);


-- Insert Suppliers --


INSERT INTO suppliers(name, address, paymentTerms)
VALUES ('OptimusPrime United', '200 Auto Bot Lane, Cant Scratch This, NY', 'Confindetial');

INSERT INTO suppliers(name, address, paymentTerms)
VALUES ('Grumman', '2000 W NASA Blvd, Melbourne, Florida 32901', 'Bi-Weekly');

INSERT INTO suppliers(name, address, paymentTerms)
VALUES ('Boeing', '100 North Riverside Chicago, Illinois 60606', 'Monthly');

INSERT INTO suppliers(name, address, paymentTerms)
VALUES ('IKEA', '100 Main Street, Poughkeepsie, NY', 'Monthly');


-- Insert Parts --

INSERT INTO parts(name, descrip)
VALUES ('Engine', 'thrusters');

INSERT INTO parts(name, descrip)
VALUES ('Throtle', 'Controls Engine');

INSERT INTO parts(name, descrip)
VALUES ('wheels', 'rubber landing wheels');

INSERT INTO parts(name, descrip)
VALUES ('Parachute', 'Large Cavas sheet for landing');

INSERT INTO parts(name, descrip)
VALUES ('seats', 'comortable leather reclining seats');

INSERT INTO parts(name, descrip)
VALUES ('radar', 'know whos near your ship at all times');

INSERT INTO parts(name, descrip)
VALUES ('Beds', 'The confiest beds from sleepies; doing it right');

INSERT INTO parts(name, descrip)
VALUES ('telephone', 'Cisco');

INSERT INTO parts(name, descrip)
VALUES ('gps', 'garmin');


-- Systems --

INSERT INTO systems(name, descrip)
VALUES ('Navigation', 'how do i get home');

INSERT INTO systems(name, descrip)
VALUES ('Radar', 'Whats around me');

INSERT INTO systems(name, descrip)
VALUES ('Communication', 'Whos out there');

INSERT INTO systems(name, descrip)
VALUES ('Avaiation', 'This is how we roll');

INSERT INTO systems(name, descrip)
VALUES ('Sleep', 'Need my rest');

INSERT INTO systems(name, descrip)
VALUES ('Ground Transportation', 'Lets Move out');

-- Insert Catalog --

INSERT INTO catalog(pid, sysID, supID)
VALUES (1, 4, 4);

INSERT INTO catalog(pid, sysID, supID)
VALUES (2, 4, 3);

INSERT INTO catalog(pid, sysID, supID)
VALUES (3, 6, 2);

INSERT INTO catalog(pid, sysID, supID)
VALUES (4, 6, 1);

INSERT INTO catalog(pid, sysID, supID)
VALUES (5, 5, 4);

INSERT INTO catalog(pid, sysID, supID)
VALUES (6, 2, 3);

INSERT INTO catalog(pid, sysID, supID)
VALUES (7, 5, 1);

INSERT INTO catalog(pid, sysID, supID)
VALUES (8, 3, 2);

INSERT INTO catalog(pid, sysID, supID)
VALUES (9, 1, 1);


-- Insert SpaceCraft Systems -- 

INSERT INTO spacecraftSystems(scraftID, sysID)
VALUES (1,1);

INSERT INTO spacecraftSystems(scraftID, sysID)
VALUES (1,2);

INSERT INTO spacecraftSystems(scraftID, sysID)
VALUES (1,3);

INSERT INTO spacecraftSystems(scraftID, sysID)
VALUES (2,4);

INSERT INTO spacecraftSystems(scraftID, sysID)
VALUES (2,5);

INSERT INTO spacecraftSystems(scraftID, sysID)
VALUES (2,6);

