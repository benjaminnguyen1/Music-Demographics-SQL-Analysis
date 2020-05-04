#Create a log for new artists
CREATE TABLE artists_Log (
	artist_id VARCHAR(255),
	artist_name VARCHAR(255),
	artist_popularity INT(3),
	genre_id INT(2),
	LogDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)ENGINE = innoDB;

#trigger to show when a new artist is entered into the artist table
DELIMITER $$
CREATE TRIGGER artist_after_insert
	AFTER INSERT ON artists
	FOR EACH ROW
BEGIN

	INSERT INTO artists_Log 
	(artist_id, artist_name, artist_popularity, genre_id)
	VALUES
	(NEW.artist_id, NEW.artist_name, NEW.artist_popularity, NEW.genre_id);

END$$
DELIMITER ;

INSERT INTO artists
VALUES ('0Y5tJX1MQlPlqiwlOH1tJY','Travis Scott', 98, 3);

SELECT *
FROM artists
WHERE artist_name = 'Travis Scott';

/*
This trigger is to indicate everytime an artist is added to the artist table.
Everytime an artist is added to the database we can see when the artist entry was added.
*/





#Create a log for songs entering and leaving the top 50 playlist
CREATE TABLE top_50_songs_log (
	old_track_name VARCHAR(255),
	old_artist_id VARCHAR(255),
	new_track_name VARCHAR(255),
	new_artist_id VARCHAR(255),
	new_release_date DATETIME,
	LogDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)ENGINE = innoDB;

#trigger for when there is an update on the top_50_songs table
DELIMITER $$
CREATE TRIGGER top_50_songs_after_update
	AFTER UPDATE ON top_50_songs
	FOR EACH ROW
BEGIN

	INSERT INTO top_50_songs_log 
	(old_track_name, old_artist_id, new_track_name, new_artist_id, new_release_date )
	VALUES
	(OLD.track_name, OLD.artist_id, NEW.track_name, NEW.artist_id, NEW.release_date);

END$$
DELIMITER ;

SELECT *
FROM top_50_songs
WHERE artist_id = '4ofCBoyEiGSePFAG500xev';

UPDATE top_50_songs
SET artist_id = '0Y5tJX1MQlPlqiwlOH1tJY', track_name = 'THE SCOTTS', release_date = '2020-04-25'
WHERE artist_id = '4ofCBoyEiGSePFAG500xev';

SELECT *
FROM top_50_songs
WHERE artist_id = '0Y5tJX1MQlPlqiwlOH1tJY';

SELECT *
FROM top_50_songs_log;

/*
The purpose of this trigger was to show when a new song has entered the top 50 songs playlist. 
Everytime there is a new entry that means that another entry had been deleted of the chart. 
On every update the trigger is executed.
*/


