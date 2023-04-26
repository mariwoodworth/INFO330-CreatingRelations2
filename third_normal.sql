/* 3NF: In 2NF, no transitive dependencies */

-- Create a table to separate out the 'against' attacks with pokedex number and type id.
CREATE TABLE pokemon_against AS
SELECT t1.pokedex_number, t2.typeid, t1.against_bug, t1.against_dark, t1.against_dragon, t1.against_electric, t1.against_fairy,
  t1.against_fight, t1.against_fire, t1.against_flying, t1.against_ghost, t1.against_grass, t1.against_ground, t1.against_ice,
  t1.against_normal, t1.against_poison, t1.against_psychic, t1.against_rock, t1.against_steel, t1.against_water
FROM imported_pokemon_data AS t1, pokemon_types AS t2;

-- Create 3NF table
CREATE TABLE thirdnfpokedex AS
SELECT pokedex_number, capture_rate, experience_growth, base_egg_steps, base_happiness, base_total,
  attack, sp_attack, defense, sp_defense, height_m, hp, name, percentage_male, speed, weight_kg, generation, is_legendary
FROM secondnfpokedex
