--название и продолжительность самого длительного трека;
SELECT  tr_name, duration
FROM track
ORDER BY duration DESC
LIMIT 1;

--название треков, продолжительность которых не менее 3,5 минуты (210 сек);
SELECT  tr_name, duration
FROM track
WHERE duration >=3.5*60;

--названия сборников, вышедших в период с 2018 по 2020 год включительно;
SELECT al_name, year
FROM album
WHERE year BETWEEN 2018 AND 2020;

--исполнители, чье имя состоит из 1 слова;
SELECT  art_name
FROM artist
WHERE art_name NOT LIKE '% %';

--название треков, которые содержат слово "мой"/"my";
SELECT  tr_name
FROM track
WHERE tr_name ILIKE '%my%' OR tr_name ILIKE '%мой%';

