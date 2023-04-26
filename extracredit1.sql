/* Introduce new Pokemon! (2 pts)
Write a SQL script that adds "Huskichu", a "Mascot"-type Pokemon.
You may decide for yourself what attacks it has. It has no evolution form.
(Huskichu Pokemon are very good, they rival Mew and Mewtwo in power--make sure your data reflects this!)

Write another SQL script that adds "Cougarite", another "Mascot"-type Pokemon.
Cougarites have one attack, a "Slow Attack", which does no damage. (Cougarite
Pokemon are not very good. They lose to Magikarp in most battles.) */

CREATE TABLE pokedexec AS
SELECT * FROM imported_pokemon_data;

-- Insert HUSKICHU
INSERT INTO pokedexec(abilities, against_bug,against_dark,against_dragon,against_electric,against_fairy,
  against_fight,against_fire,against_flying,against_ghost,against_grass,against_ground,
  against_ice,against_normal,against_poison,against_psychic,against_rock,against_steel,against_water,
  attack,base_egg_steps,base_happiness,base_total,capture_rate,classfication,defense,experience_growth,
  height_m,hp,name,percentage_male,pokedex_number,sp_attack,sp_defense,speed,type1,type2,weight_kg,generation,is_legendary)
  VALUES(['Cute Charm', 'Hustle', 'Pressure', 'Synchronize'],2,2,1,1,1,0.5,1,1,2,1,1,1,1,1,0.5,1,1,1,135,
  30720,100,700,25,"New Species Pokemon",80,1250000,1.2,103,'Huskichu',NULL,802,150,125,130,'mascot','',60.0,1,1);

-- Insert COUGARITE
INSERT INTO pokedexec(abilities, against_bug,against_dark,against_dragon,against_electric,against_fairy,
  against_fight,against_fire,against_flying,against_ghost,against_grass,against_ground,
  against_ice,against_normal,against_poison,against_psychic,against_rock,against_steel,against_water,
  attack,base_egg_steps,base_happiness,base_total,capture_rate,classfication,defense,experience_growth,
  height_m,hp,name,percentage_male,pokedex_number,sp_attack,sp_defense,speed,type1,type2,weight_kg,generation,is_legendary)
  VALUES(['Slow Attack'],0.5,0.5,0.5,0.5,0.5,1,0.5,1,1,0.5,1,0.5,1,0.5,1,0.5,0.5,0.5,3,
  400,10,100,260,"New Species Pokemon",25,1000000,1.2,10,'Cougarite',NULL,803,13,15,50,'mascot','',10.0,1,0);
