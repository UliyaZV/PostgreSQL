SET search_path TO public;
CREATE TABLE IF NOT EXISTS genre (
id_genre SERIAL PRIMARY KEY,
g_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS artist (
id_artist SERIAL PRIMARY KEY,
art_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS artist_genre (
id_genre INTEGER REFERENCES genre(id_genre),
id_artist INTEGER REFERENCES artist(id_artist),
PRIMARY KEY (id_genre, id_artist)
);

CREATE TABLE IF NOT EXISTS album (
id_album SERIAL PRIMARY KEY,
al_name VARCHAR(100) NOT NULL,
year INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS album_artist (
id_artist INTEGER REFERENCES artist(id_artist),
id_album INTEGER REFERENCES album(id_album),
PRIMARY KEY (id_artist, id_album)
);

CREATE TABLE IF NOT EXISTS track (
id_track SERIAL PRIMARY KEY,
tr_name VARCHAR(100) NOT NULL,
duration INTEGER NOT NULL,
id_album INTEGER REFERENCES album(id_album)
);

CREATE TABLE IF NOT EXISTS collection (
id_collection SERIAL PRIMARY KEY,
col_name VARCHAR(100) NOT NULL,
year INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS collection_track (
id_collection INTEGER REFERENCES collection(id_collection),
id_track INTEGER REFERENCES track(id_track),
PRIMARY KEY (id_collection, id_track)
);