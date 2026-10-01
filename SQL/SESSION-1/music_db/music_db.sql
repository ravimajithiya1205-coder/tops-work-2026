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