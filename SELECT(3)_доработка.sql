-- количество исполнителей в каждом жанре;
SELECT genre.g_name, count(artist_genre.id_artist) 
  FROM genre 
  JOIN artist_genre ON genre.id_genre = artist_genre.id_genre
  GROUP BY genre.g_name;

-- количество треков, вошедших в альбомы 2019-2020 годов;
SELECT album.al_name, album.year, count(track.id_album) 
  FROM album
  JOIN track ON album.id_album = track.id_album
  WHERE album.year BETWEEN 2019 AND 2020
  GROUP BY album.al_name, album.year;

--средняя продолжительность треков по каждому альбому;
SELECT album.al_name, AVG(track.duration)
  FROM album
  JOIN track ON album.id_album = track.id_album
  GROUP BY album.al_name;

--все исполнители, которые не выпустили альбомы в 2020 году;
SELECT artist.art_name 
FROM artist
WHERE artist.art_name NOT IN (
    SELECT artist.art_name 
    FROM artist
    JOIN album_artist ON artist.id_artist = album_artist.id_artist
    JOIN album ON album_artist.id_album = album.id_album
    WHERE album.year = 2020);


--названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT collection.col_name 
  FROM collection
  JOIN collection_track ON collection.id_collection = collection_track.id_collection
  JOIN track ON collection_track.id_track = track.id_track
  JOIN album ON track.id_album = album.id_album
  JOIN album_artist ON album.id_album = album_artist.id_album
  JOIN artist ON artist.id_artist = album_artist.id_artist
  WHERE artist.art_name = 'Моргенштерн';
