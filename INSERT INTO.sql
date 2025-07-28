INSERT INTO artist (art_name) 
  VALUES ('Моргенштерн'), 
  ('Ария'), ('Coma'), ('Flysolo'), 
  ('Филип Киркоров'), ('IOWA'), ('Мумий Тролль'), 
  ('Тату'), ('Lacrimosa');
  
  
INSERT INTO genre (g_name) 
  VALUES ('рэп'), ('рок'), ('witch house'), ('поп'), ('gothic');
  
  
INSERT INTO artist_genre (id_genre, id_artist) 
  VALUES (1, 1), (2, 2), (3, 3), (3, 4), (4, 5), (4, 6), (2, 7), (4, 8), (5, 9);
  
  
INSERT INTO album (al_name, year) 
  VALUES ('Million Dollar', 2021), 
  ('Штиль', 2002), ('Химера', 2001), ('Index of', 2018), 
  ('Crush', 2019), ('Blue', 2018), ('Import', 2015), ('OST Вампиры средней полосы', 2020), 
  ('Морская', 1997), ('200 по встречной', 2000), ('Senhsucht', 2018), ('Testimonium', 2020);  
  
  
INSERT INTO album_artist (id_artist, id_album) 
  VALUES (1, 1), (2, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 7), (7, 8), (7, 9), (8, 10), (9, 11), (9, 12);

INSERT INTO track (tr_name, duration, id_album) 
  VALUES ('El Problema', 240, 1), ('Aristocrat', 150, 1), 
  ('Cadillac', 180, 1), ('Беспечный ангел', 215, 2), ('Штиль', 320, 3), 
  ('I monster', 1140, 4), ('Мой беспечный ангел', 150, 5), ('Цвет настроения синий', 150, 6), 
  ('Одно и то же', 271, 7), ('Призраки завтра', 265, 8), ('Владивосток 2000', 143, 9), 
  ('Нас не догонят', 262, 10), ('I lost my star in Krasnodar', 324, 11), ('Zwischen allen stuhlen', 250, 12),
  ('Я сошла с ума', 210, 10); 
  

INSERT INTO collection (col_name, year) 
  VALUES ('The Best of the best', 2020), ('Тыц-тыц', 2019), 
  ('Цой жив', 2021), ('Yankee go home', 2018), ('Для души', 2017), ('Forever', 2015), 
  ('Для кофе', 2021), ('В машину', 2019); 
  

INSERT INTO collection_track (id_track, id_collection) 
  VALUES (1, 1), (2, 2), (3, 4), (4, 3), (5, 3), (6, 6), 
  (7, 5), (7, 8), (9, 2), (10, 7), (11, 8), (12, 1), (13, 6), (14, 3), (15, 2);