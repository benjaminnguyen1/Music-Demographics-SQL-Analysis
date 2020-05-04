#See the popularity of the based on the artist name 

DELIMITER $$

DROP PROCEDURE IF EXISTS get_artist_name_popularity_level$$

CREATE PROCEDURE get_artist_name_popularity_level (in_artist_name VARCHAR(255), OUT out_artist_popularity_level VARCHAR(255))

BEGIN

	SET @artist_name := in_artist_name;
	
	SET @artist_popularity := NULL;

	PREPARE artist_popularity_select_stmt FROM 
		'
			SELECT artist_popularity INTO @artist_popularity
			FROM artists
			WHERE artist_name = ?
		';

	EXECUTE artist_popularity_select_stmt USING @artist_name;

	DEALLOCATE PREPARE artist_popularity_select_stmt;

	SELECT @artist_popularity;
	
	IF (@artist_popularity < 80) THEN
		SET out_artist_popularity_level := 'One-Hit-Wonder';
	ELSEIF (@artist_popularity BETWEEN 80 AND 90) THEN
		SET out_artist_popularity_level := 'Mildly Popular';
	ELSEIF (@artist_popularity BETWEEN 90 AND 95) THEN
		SET out_artist_popularity_level := 'More Popular';
	ELSE
		SET out_artist_popularity_level := 'Extremely Popular';
	END IF;


END$$

DELIMITER ;

CALL get_artist_name_popularity_level('Travis Scott', @artist_popularity_level);
SELECT @artist_popularity_level;

CALL get_artist_name_popularity_level('MEDUZA', @artist_popularity_level);
SELECT @artist_popularity_level;

CALL get_artist_name_popularity_level('Post Malone', @artist_popularity_level);
SELECT @artist_popularity_level;

CALL get_artist_name_popularity_level('DripReport', @artist_popularity_level);
SELECT @artist_popularity_level;

/*
This stored procedure will take an input of an artist name and then print out that artists popularity level. 
Additionally, when selected on the out variable it will display the case, 
categorizing the artist as either mildly popular, more popular, or extremely popular
*/