/* 1NF: remove duplicate data, break data at granular level
*/

-- Create separate table with pokemon data
CREATE TABLE temppokedex AS
SELECT *
FROM imported_pokemon_data;

-- Drop abilities column to replace with separated values in 1NF
ALTER TABLE temppokedex
DROP COLUMN abilities;

-- Break abilities down into separate values
CREATE TABLE split_abilities AS
SELECT pokedex_number,
	trim(value, '[]''') AS abilities
FROM imported_pokemon_data,
	json_each('["' || replace(abilities, ', ', '","') || '"]')
WHERE abilities <> '';

-- Create new 1NF table with split values in it
CREATE TABLE firstnfpokedex AS
SELECT split.abilities, temp.*
FROM temppokedex AS temp, split_abilities AS split
WHERE temp.pokedex_number = split.pokedex_number;

-- Drop temp tables used
DROP TABLE split_abilities;
DROP TABLE temppokedex;
