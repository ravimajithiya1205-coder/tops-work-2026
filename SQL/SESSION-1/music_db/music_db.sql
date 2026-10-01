create database  music_streaming_db;

use music_streaming_db;

CREATE TABLE artists (
    artist_id INT PRIMARY KEY AUTO_INCREMENT,
    artist_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    genre VARCHAR(50),
    created_at DATE
);

INSERT INTO artists
(artist_name, country, genre, created_at)
VALUES
('Arijit Singh', 'India', 'Bollywood', '2010-01-15'),
('A.R. Rahman', 'India', 'Indian Classical', '1992-01-01'),
('Shreya Ghoshal', 'India', 'Bollywood', '2002-05-20'),
('The Weeknd', 'Canada', 'Pop', '2011-01-01'),
('Ed Sheeran', 'United Kingdom', 'Pop', '2011-06-01'),
('Taylor Swift', 'United States', 'Pop', '2006-10-01'),
('Adele', 'United Kingdom', 'Pop', '2008-01-01'),
('Bruno Mars', 'United States', 'Pop', '2010-01-01'),
('Diljit Dosanjh', 'India', 'Punjabi', '2004-01-01'),
('Neha Kakkar', 'India', 'Bollywood', '2008-01-01');

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    country VARCHAR(50),
    subscription_type VARCHAR(20),
    signup_date DATE
);

INSERT INTO users
(user_name, email, country, subscription_type, signup_date)
VALUES
('Ravi Patel', 'ravi@example.com', 'India', 'Premium', '2025-01-10'),
('Amit Shah', 'amit@example.com', 'India', 'Free', '2025-02-15'),
('Priya Mehta', 'priya@example.com', 'India', 'Premium', '2025-03-05'),
('Neha Joshi', 'neha@example.com', 'India', 'Free', '2025-03-20'),
('Rahul Desai', 'rahul@example.com', 'India', 'Premium', '2025-04-12'),
('Emma Brown', 'emma@example.com', 'United Kingdom', 'Premium', '2025-05-01'),
('John Smith', 'john@example.com', 'United States', 'Free', '2025-05-18'),
('Karan Singh', 'karan@example.com', 'India', 'Premium', '2025-06-11'),
('Meera Patel', 'meera@example.com', 'India', 'Free', '2025-07-09'),
('Sahil Verma', 'sahil@example.com', 'India', 'Premium', '2025-08-14');

CREATE TABLE albums (
    album_id INT PRIMARY KEY AUTO_INCREMENT,
    artist_id INT NOT NULL,
    album_name VARCHAR(150) NOT NULL,
    release_year YEAR,
    album_type VARCHAR(30),
    FOREIGN KEY (artist_id)
        REFERENCES artists(artist_id)
);

INSERT INTO albums
(artist_id, album_name, release_year, album_type)
VALUES
(1, 'Aashiqui 2', 2013, 'Soundtrack'),
(2, 'Rockstar', 2011, 'Soundtrack'),
(3, 'Devdas', 2002, 'Soundtrack'),
(4, 'After Hours', 2020, 'Studio'),
(5, 'Divide', 2017, 'Studio'),
(6, '1989', 2014, 'Studio'),
(7, '25', 2015, 'Studio'),
(8, 'Doo-Wops & Hooligans', 2010, 'Studio'),
(9, 'G.O.A.T.', 2023, 'Studio'),
(10, 'Cocktail', 2012, 'Soundtrack');



CREATE TABLE songs (
    song_id INT PRIMARY KEY AUTO_INCREMENT,
    album_id INT NOT NULL,
    artist_id INT NOT NULL,
    song_title VARCHAR(150) NOT NULL,
    duration_seconds INT NOT NULL,
    release_date DATE,
    language VARCHAR(30),
    FOREIGN KEY (album_id)
        REFERENCES albums(album_id),
    FOREIGN KEY (artist_id)
        REFERENCES artists(artist_id)
);

INSERT INTO songs
(album_id, artist_id, song_title, duration_seconds, release_date, language)
VALUES
(1, 1, 'Tum Hi Ho', 262, '2013-04-08', 'Hindi'),
(1, 1, 'Hum Mar Jayenge', 300, '2013-04-08', 'Hindi'),
(1, 1, 'Chahun Main Ya Naa', 300, '2013-04-08', 'Hindi'),

(2, 2, 'Kun Faya Kun', 470, '2011-11-11', 'Hindi'),
(2, 2, 'Nadaan Parindey', 390, '2011-11-11', 'Hindi'),

(3, 3, 'Dola Re Dola', 365, '2002-07-12', 'Hindi'),
(3, 3, 'Silsila Ye Chahat Ka', 315, '2002-07-12', 'Hindi'),

(4, 4, 'Blinding Lights', 200, '2020-03-20', 'English'),
(4, 4, 'Save Your Tears', 215, '2020-03-20', 'English'),

(5, 5, 'Shape of You', 234, '2017-01-06', 'English'),
(5, 5, 'Perfect', 263, '2017-03-03', 'English'),

(6, 6, 'Blank Space', 231, '2014-11-10', 'English'),
(6, 6, 'Style', 231, '2015-02-09', 'English'),

(7, 7, 'Hello', 295, '2015-10-23', 'English'),
(7, 7, 'Someone Like You', 285, '2011-01-24', 'English'),

(8, 8, 'Just the Way You Are', 221, '2010-07-20', 'English'),
(8, 8, 'Grenade', 223, '2010-09-28', 'English'),

(9, 9, 'Born to Shine', 218, '2023-06-01', 'Punjabi'),
(9, 9, 'Lemonade', 200, '2023-06-01', 'Punjabi'),

(10, 10, 'Second Hand Jawaani', 240, '2012-07-13', 'Hindi');

CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    created_date DATE,
    is_public BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

INSERT INTO playlists
(user_id, playlist_name, created_date, is_public)
VALUES
(1, 'My Favorites', '2025-01-20', TRUE),
(2, 'Workout Songs', '2025-02-20', TRUE),
(3, 'Romantic Songs', '2025-03-10', TRUE),
(4, 'Bollywood Hits', '2025-03-25', TRUE),
(5, 'English Pop', '2025-04-20', TRUE),
(6, 'Morning Music', '2025-05-10', FALSE),
(8, 'Travel Playlist', '2025-06-20', TRUE),
(10, 'Best of 2025', '2025-08-20', TRUE);


-- Session-2 --

CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(150) NOT NULL,
    release_year YEAR,
    genre VARCHAR(50),
    language VARCHAR(30),
    rating DECIMAL(2,1)
);

INSERT INTO movies
(movie_name, release_year, genre, language, rating)
VALUES
('3 Idiots', 2009, 'Comedy Drama', 'Hindi', 8.4),
('Dangal', 2016, 'Sports Drama', 'Hindi', 8.3),
('Jawan', 2023, 'Action', 'Hindi', 7.0),
('Pathaan', 2023, 'Action', 'Hindi', 5.9),
('The Dark Knight', 2008, 'Action', 'English', 9.0),
('Inception', 2010, 'Sci-Fi', 'English', 8.8),
('Interstellar', 2014, 'Sci-Fi', 'English', 8.7),
('Titanic', 1997, 'Romance', 'English', 7.9),
('Avatar', 2009, 'Sci-Fi', 'English', 7.8),
('Avengers: Endgame', 2019, 'Action', 'English', 8.4);

select * from movies;

SELECT
    movie_name AS 'Title',
    release_year AS 'Year Released'
FROM movies;

-- SESSION 3 --
SELECT *
FROM movies
WHERE release_year > 2020
  AND genre = 'Action';
  
ALTER TABLE users ADD city VARCHAR(50);

UPDATE users SET city = 'Ahmedabad' WHERE user_id = 1;
UPDATE users SET city = 'Mumbai' WHERE user_id = 2;
UPDATE users SET city = 'Delhi' WHERE user_id = 3;
UPDATE users SET city = 'Bhavnagar' WHERE user_id = 4;
UPDATE users SET city = 'Surat' WHERE user_id = 5;
UPDATE users SET city = 'Ahmedabad' WHERE user_id = 6;
UPDATE users SET city = 'Bhavnagar' WHERE user_id = 7;
UPDATE users SET city = 'Surat' WHERE user_id = 8;
UPDATE users SET city = 'Ahmedabad' WHERE user_id = 9;
UPDATE users SET city = 'Bharuch' WHERE user_id = 10;


UPDATE users SET country = 'India' WHERE user_id = 6;
UPDATE users SET country = 'India' WHERE user_id = 7;

ALTER TABLE users ADD followers INT;
  
UPDATE users SET followers = 1500 WHERE user_id = 1;
UPDATE users SET followers = 500 WHERE user_id = 2;
UPDATE users SET followers = 1200 WHERE user_id = 3;
UPDATE users SET followers = 1100 WHERE user_id = 4;
UPDATE users SET followers = 1000 WHERE user_id = 5;
UPDATE users SET followers = 900 WHERE user_id = 6;
UPDATE users SET followers = 1500 WHERE user_id = 7;
UPDATE users SET followers = 1400 WHERE user_id = 8;
UPDATE users SET followers = 1900 WHERE user_id = 9;
UPDATE users SET followers = 1400 WHERE user_id = 10;

select * from users;
  
SELECT *
FROM users
WHERE NOT city = 'Ahmedabad'
  AND followers > 1000;