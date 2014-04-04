
-- Connect to your Postgres server and set the active database to MoviesDb.  Then . . .

DROP TABLE IF EXISTS moviecast;
DROP TABLE IF EXISTS movieCrew;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS persons;
DROP TABLE IF EXISTS movies;


-- Person --
CREATE TABLE persons (
  pid          serial not null primary key,
  name         varchar(50),
  address      varchar(50),
  DOB          date
);

-- Actors --
CREATE TABLE actors(
  aid           int primary key references persons(pid),
  haircolor     varchar(20),
  eyecolor      varchar(20),
  heightINCH    int,
  weightLBS     int,
  actorGuildAnivDate date
);


-- Directors --
CREATE TABLE directors(
  did      int not null primary key references persons(pid),
  filmschool text,
  directorguildanivdate date
);


-- Movies --
CREATE TABLE movies (
  mid serial not null primary key,
  moviename text,
  releaseyear NUMERIC(4),
  domesticsalesUSD int,
  foreignsalesUSD int,
  dvdblueraysalesUSD int
);        

-- Movie Cast -- 
CREATE TABLE moviecast(
  aid int not null references actors(aid),
  mid  int not null references movies(mid)
);


-- Movie Crew -- 
CREATE TABLE moviecrew(
  did int not null references directors(did),
  mid int not null references movies(mid)
);


-- Insert Persons--
INSERT INTO persons(name, address, DOB)
  VALUES('Adam Scott', 'Santa Cruz, California,United States', '3/4/1973');

INSERT INTO persons(name, address, DOB)
  VALUES('Sean Connery', 'Edinburgh, Scotland, United Kingdom', '7/25/1930');

INSERT INTO persons (name, address, DOB)
VALUES ('Brad Pit', 'Shawnee, Oklahoma, United States', '12/18/1963');

INSERT INTO persons(name, address, DOB)
VALUES ('Mark Wahlberg', 'Boston, Massachusettes, United States', '5/5/1971');

INSERT INTO persons(name, address, DOB)
VALUES ('Kate Beckinsale', 'London, England, Unitesd Kingdom', '6/26/1973');

INSERT INTO persons(name, address, DOB)
VALUES ('Daniela Bianchi', 'Rome, Lazio, Italy', '1/31/1942');

INSERT INTO persons(name, address, DOB)
VALUES ('Jeremiah S. Chechik','Montreal,Quebec, Canada', '10/14/1951' );

INSERT INTO persons(name, address, DOB)
  VALUES ('David Fincher', 'Denver, Colorado, United States', '7/26/1962');

INSERT INTO persons(name, address, DOB)
  VALUES ('Baltasar Kormákur','Reykjavik, Iceland', '2/27/1966');

INSERT INTO persons(name, address, DOB)
  VALUES ('Adam McKay','Philadelphia, Pennsylvania, United States', '4/17/1968');

INSERT INTO persons(name, address, DOB)
  VALUES ('Brian De Palma','Newark, New Jersey, United States', '9/11/1940');

INSERT INTO persons(name, address, DOB)
  VALUES ('Terence Young','Shanghai, China', '6/20/1915');

  
-- Insert Actors --
INSERT INTO actors (aid, haircolor, eyecolor, heightINCH, weightLBS, actorGuildAnivDate)
  VALUES ((select pid
	  from persons
	  where persons.name = 'Adam Scott'),'brown', 'blue', 69, 200, '10/14/1994');

INSERT INTO actors(aid, haircolor, eyecolor, heightINCH, weightLBS, actorGuildAnivDate)
  VALUES((select pid
	  from persons
	  where persons.name = 'Sean Connery'),'grey', 'blue', 75, 185, '5/12/1955');

INSERT INTO actors(aid, haircolor, eyecolor, heightINCH, weightLBS, actorGuildAnivDate)
  VALUES((select pid
	  from persons
	  where persons.name = 'Brad Pit'),'brown', 'brown', 71, 190, '9/22/1978');

INSERT INTO actors(aid, haircolor, eyecolor, heightINCH, weightLBS, actorGuildAnivDate)
  VALUES((select pid
	  from persons
	  where persons.name = 'Mark Wahlberg'),'brown', 'green', 60, 180, '8/2/1994');

INSERT INTO actors(aid, haircolor, eyecolor, heightINCH, weightLBS, actorGuildAnivDate)
  VALUES((select pid
	  from persons
	  where persons.name = 'Kate Beckinsale'),'brown', 'brown', 68, 150, '7/13/2000');

INSERT INTO actors(aid, haircolor, eyecolor, heightINCH, weightLBS, actorGuildAnivDate)
  VALUES((select pid
	  from persons
	  where persons.name = 'Daniela Bianchi'),'blonde', 'blue', 67, 140, '3/11/1960');



---------------------------------------------------------------------------------------------------------------------------------

 -- Insert Directors --
INSERT INTO directors (did, filmschool, directorguildanivdate)
	VALUES ((select pid
		from persons
		where persons.name = 'Jeremiah S. Chechik'),'Marist College', '2/6/1980' );

INSERT INTO directors (did, filmschool, directorguildanivdate)
	VALUES ((select pid
		from persons
		where persons.name = 'David Fincher'),'New York Institute', '4/4/1999' );

INSERT INTO directors (did, filmschool, directorguildanivdate)
	VALUES ((select pid
		from persons
		where persons.name = 'Baltasar Kormákur'),'Hogwarts', '12/15/2012' );

INSERT INTO directors (did, filmschool, directorguildanivdate)
	VALUES ((select pid
		from persons
		where persons.name = 'Adam McKay'),'The School Behind Things', '10/22/1980' );

INSERT INTO directors (did, filmschool, directorguildanivdate)
	VALUES ((select pid
		from persons
		where persons.name = 'Brian De Palma'),'CIA', '10/22/1980' );

INSERT INTO directors (did, filmschool, directorguildanivdate)
	VALUES ((select pid
		from persons
		where persons.name = 'Terence Young'),'Cambridge', '3/6/1940' );

		
----------------------------------------------------------------------------------------------------------------------
--Insert Movies--
INSERT INTO movies (moviename, releaseyear, domesticsalesUSD, foreignsalesUSD, dvdblueraysalesUSD)
	VALUES ('Fight Club','1999','20000000','15000000','1000000');

INSERT INTO movies (moviename, releaseyear, domesticsalesUSD,foreignsalesUSD, dvdblueraysalesUSD)
	VALUES ('Step Brothers','2008','37500000','20000000','66500000');

INSERT INTO movies (moviename, releaseyear, domesticsalesUSD,foreignsalesUSD, dvdblueraysalesUSD)
	VALUES ('Contraband','2012','17500000', '9000000', '1000000');
	
INSERT INTO movies (moviename, releaseyear, domesticsalesUSD,foreignsalesUSD, dvdblueraysalesUSD)
	VALUES ('2Guns','2013','1200000', '600000', '82000');

INSERT INTO movies (moviename, releaseyear, domesticsalesUSD,foreignsalesUSD, dvdblueraysalesUSD)
	VALUES ('James Bond: From Russia With Love','1963','2000000', '250000','20000');

INSERT INTO movies (moviename, releaseyear, domesticsalesUSD, foreignsalesUSD, dvdblueraysalesUSD)
	VALUES ('Untouchables','1967','800000','900000', '200000' );

INSERT INTO movies (moviename, releaseyear, domesticsalesUSD,foreignsalesUSD, dvdblueraysalesUSD)
	VALUES ('The Rock','1996','750000', '650000','860000' );

INSERT INTO movies (moviename, releaseyear, domesticsalesUSD,foreignsalesUSD, dvdblueraysalesUSD)
	VALUES ('The Avengers','1996','42300000', '89120000','8860000' );

----------------------------------------------------------------------------------------------------------------------

--Insert Movie Cast --

INSERT INTO moviecast (aid, mid)
	VALUES ((select pid
		from persons
		where name = 'Brad Pit'),
		(select mid
		from movies
		where moviename = 'Fight Club'));

INSERT INTO moviecast (aid, mid)
	VALUES ((select pid
		from persons
		where name = 'Adam Scott'),
		(select mid
		from movies
		where moviename = 'Step Brothers'));

INSERT INTO moviecast (aid, mid)
	VALUES ((select pid
		from persons
		where name = 'Mark Wahlberg'),
		(select mid
		from movies
		where moviename = 'Contraband'));

INSERT INTO moviecast (aid, mid)
	VALUES ((select pid
		from persons
		where name = 'Mark Wahlberg'),
		(select mid
		from movies
		where moviename = '2Guns'));

INSERT INTO moviecast (aid, mid)
	VALUES ((select pid
		from persons
		where name = 'Sean Connery'),
		(select mid
		from movies
		where moviename = 'James Bond: From Russia With Love'));

INSERT INTO moviecast (aid, mid)
	VALUES ((select pid
		from persons
		where name = 'Sean Connery'),
		(select mid
		from movies
		where moviename = 'Untouchables'));

		
-- Insert Movie Crew --

INSERT INTO moviecrew (did, mid)
	VALUES ((select pid
		from persons
		where name = 'Brian De Palma'),
		(select mid
		from movies
		where moviename = 'Untouchables'));

INSERT INTO moviecrew (did, mid)
	VALUES ((select pid
		from persons
		where name = 'Adam McKay'),
		(select mid
		from movies
		where moviename = 'Step Brothers'));

INSERT INTO moviecrew (did, mid)
	VALUES ((select pid
		from persons
		where name = 'David Fincher'),
		(select mid
		from movies
		where moviename = 'Fight Club'));

INSERT INTO moviecrew (did, mid)
	VALUES ((select pid
		from persons
		where name = 'David Fincher'),
		(select mid
		from movies
		where moviename = 'The Avengers'));

INSERT INTO moviecrew (did, mid)
	VALUES ((select pid
		from persons
		where name = 'Jeremiah S. Chechik'),
		(select mid
		from movies
		where moviename = 'The Avengers'));

INSERT INTO moviecrew (did, mid)
	VALUES ((select pid
		from persons
		where name = 'Baltasar Kormákur'),
		(select mid
		from movies
		where moviename = 'Contraband'));


INSERT INTO moviecrew (did, mid)
	VALUES ((select pid
		from persons
		where name = 'Baltasar Kormákur'),
		(select mid
		from movies
		where moviename = '2Guns'));

INSERT INTO moviecrew (did, mid)
	VALUES ((select pid
		from persons
		where name = 'Terence Young'),
		(select mid
		from movies
		where moviename = 'James Bond: From Russia With Love'));

							

				
SELECT DISTINCT persons.name as Director 
FROM 	persons,
 	movies,
 	directors,
 	moviecrew
 WHERE moviecrew.did = directors.did 
	AND movies.mid = moviecrew.mid 
	AND directors.did = persons.pid 
	AND moviecrew.mid IN (SELECT movies.mid 
				FROM	persons,
					actors,
					movies,
					moviecast 
				WHERE persons.pid = actors.aid 
					AND movies.mid = moviecast.mid 
					AND actors.aid = moviecast.aid 
					AND persons.name = 'Sean Connery' 
					);