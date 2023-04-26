/* 2NF: In 1NF, no partial dependencies */

-- TYPES
-- Put all types (type1 and 2) into one column so no repeating groups
CREATE TABLE type_id (
 typeid integer primary key autoincrement,
 name VARCHAR DEFAULT NULL
);

INSERT INTO type_id (name)
SELECT DISTINCT type1 FROM imported_pokemon_data;

-- Create temp table to put all type1 and type2 attributes into one column
CREATE TABLE temptype (
 pokedex_number INT,
 type VARCHAR DEFAULT NULL
);

INSERT INTO temptype
 SELECT pokedex_number, type1
 FROM imported_pokemon_data
 WHERE type1 != '';

 INSERT INTO temptype
  SELECT pokedex_number, type2
  FROM imported_pokemon_data
  WHERE type2 != '';

-- Joining tables together to connect typeid and type name in table
CREATE TABLE pokemon_types as
  select temp.pokedex_number, type_id.typeid
  from temptype as temp, type_id
  where temp.type = type_id.name;

-- Dropping type columns from 2nf table, temp tables
DROP TABLE temptype;

-- ABILITIES

-- Separate out abilities into separate tables
CREATE TABLE ability_id (
 abilityid integer primary key autoincrement,
 name VARCHAR DEFAULT NULL
);

INSERT INTO ability_id (name)
SELECT DISTINCT abilities FROM firstnfpokedex;

-- Create temp table for abilities and id - connect together
CREATE TABLE tempabilities AS
SELECT pokedex_number, abilities
FROM firstnfpokedex;

-- Joining tables together to connect ability id and pokedex # in table
CREATE TABLE pokemon_abilities as
  select temp.pokedex_number, ability_id.abilityid
  from tempabilities as temp, ability_id
  where temp.abilities = ability_id.name;

-- Drop temp table for abilities
DROP TABLE tempabilities;

-- CLASSIFICATION
-- Separate out classification names as they rely on pokedex #
CREATE TABLE tempclass1 AS
SELECT pokedex_number, classfication
FROM imported_pokemon_data;

-- Creating table to give each classification an id
CREATE TABLE class_id (
  classid integer primary key autoincrement,
  name varchar
);

INSERT INTO class_id (name)
SELECT DISTINCT classfication FROM imported_pokemon_data;

-- Joining classification id and pokedex # together
CREATE TABLE tempclass2 as
  select class.pokedex_number, class_id.classid
  from tempclass1 as class, class_id
  where class.classfication = class_id.name;

-- Create 2NF table by copying 1NF / remove abilities column
CREATE TABLE draft2nf AS
SELECT * FROM imported_pokemon_data;

ALTER TABLE draft2nf
DROP COLUMN abilities;

-- Create 2nf table with classid
CREATE TABLE secondnfpokedex AS
SELECT draft.*, tempclass2.classid
FROM draft2nf AS draft, tempclass2
WHERE draft.pokedex_number = tempclass2.pokedex_number;

-- Drop columns from 2nf table
ALTER TABLE secondnfpokedex
DROP COLUMN classfication;

ALTER TABLE secondnfpokedex
DROP COLUMN type1;

ALTER TABLE secondnfpokedex
DROP COLUMN type2;

-- Drop temp tables
DROP TABLE tempclass1;
DROP TABLE tempclass2;
DROP TABLE draft2nf;
