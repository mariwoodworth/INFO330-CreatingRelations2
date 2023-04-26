/* 2NF: In 1NF, no partial dependencies */

-- TYPES
-- No repeating groups - put types in a separate table to remove many-to-many relationship.

-- Create table with each pokemon's number and their corresponding types.
CREATE TABLE pokenum_type as
  select distinct pokedex_number, type1, type2
  from firstnfpokedex;

-- Separate unique type combos
create table poke_types as
select distinct type1, type2
from pokenum_type;

-- Create type table corresponding types to id #s
CREATE TABLE types_ids (
 typeid integer primary key autoincrement,
 name1 VARCHAR DEFAULT NULL,
 name2 varchar default null
);
insert into types_ids (name1, name2)
select * from poke_types;

-- Join tables so pokedex number has their type composite key.
create table pokenum_id as
select imported_pokemon_data.pokedex_number, types_ids.typeid
from imported_pokemon_data, types_ids
where types_ids.name1 = imported_pokemon_data.type1
and types_ids.name2 = imported_pokemon_data.type2;

-- Drop temp tables
drop table pokenum_type;
drop table poke_types;

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
