CREATE TABLE IF NOT EXISTS music_service_users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  username VARCHAR(50) NOT NULL,
  membership_type ENUM('free', 'premium') DEFAULT 'free',
  registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  provider_id INT NOT NULL,

  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE,
  FOREIGN KEY (provider_id) REFERENCES service_providers (id)
);

CREATE TABLE IF NOT EXISTS playlists (
  id INT AUTO_INCREMENT PRIMARY KEY,
  playlist_name VARCHAR(255) NOT NULL,
  creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_public BOOLEAN DEFAULT TRUE,
  user_id INT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES music_service_users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS songs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  artist_name VARCHAR(255) NOT NULL,
  album_name VARCHAR(255),
  genre ENUM('pop', 'rock', 'jazz', 'hip-hop', 'classical', 'other') DEFAULT 'other',
  duration INT NOT NULL, -- seconds
  release_date DATE NOT NULL,
  provider_id INT NOT NULL,

  FOREIGN KEY (provider_id) REFERENCES service_providers (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS playlist_songs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  playlist_id INT NOT NULL,
  song_id INT NOT NULL,

  FOREIGN KEY (playlist_id) REFERENCES playlists (id) ON DELETE CASCADE,
  FOREIGN KEY (song_id) REFERENCES songs (id) ON DELETE CASCADE
);

INSERT INTO addresses (street, landmark, zone_code) VALUES
('345 Park Avenue', 'Entertainment District', 'TECH-05'),
('2000 Avenue of the Stars', 'Media Center', 'TECH-06'); 

INSERT INTO service_providers (provider_name, status, address_id, service_id) VALUES
('Spotify', 'active', 37, 9),
('Apple Music', 'active', 38, 9);

INSERT INTO music_service_users (citizen_id, username, membership_type, registration_date, provider_id) VALUES
-- Spotify users
(1, 'robert_music', 'premium', '2022-07-15 10:30:00', 17),
(3, 'mike.beats', 'free', '2022-08-20 14:45:00', 17),
(5, 'davidt_tunes', 'premium', '2022-09-10 09:15:00', 17),
(7, 'james.groove', 'free', '2022-10-05 16:30:00', 17),
(9, 'jessica_mix', 'premium', '2022-11-12 11:20:00', 17),
(11, 'sophia.sounds', 'free', '2022-12-08 13:40:00', 17),
(13, 'olivia.playlists', 'premium', '2023-01-15 10:10:00', 17),
-- Apple Music users
(2, 'jenny_tunes', 'premium', '2022-07-25 09:45:00', 18),
(4, 'sarah_beats', 'free', '2022-08-30 15:20:00', 18),
(6, 'emily_music', 'premium', '2022-09-18 12:30:00', 18),
(8, 'chris_jams', 'free', '2022-10-22 14:15:00', 18),
(10, 'daniel_songs', 'premium', '2022-11-30 10:50:00', 18),
(12, 'matt_tracks', 'free', '2022-12-20 16:05:00', 18),
(14, 'will_rhythm', 'premium', '2023-01-28 11:35:00', 18);

-- Add songs to Spotify
INSERT INTO songs (title, artist_name, album_name, genre, duration, release_date, provider_id) VALUES
-- Pop songs
('Shape of You', 'Ed Sheeran', 'Divide', 'pop', 234, '2017-01-06', 17),
('Blinding Lights', 'The Weeknd', 'After Hours', 'pop', 201, '2019-11-29', 17),
('Someone Like You', 'Adele', '21', 'pop', 285, '2011-01-24', 17),
('Bad Guy', 'Billie Eilish', 'When We All Fall Asleep, Where Do We Go?', 'pop', 194, '2019-03-29', 17),
('Uptown Funk', 'Mark Ronson ft. Bruno Mars', 'Uptown Special', 'pop', 270, '2014-11-10', 17),
-- Rock songs
('Bohemian Rhapsody', 'Queen', 'A Night at the Opera', 'rock', 355, '1975-10-31', 17),
('Stairway to Heaven', 'Led Zeppelin', 'Led Zeppelin IV', 'rock', 482, '1971-11-08', 17),
('Sweet Child O\' Mine', 'Guns N\' Roses', 'Appetite for Destruction', 'rock', 356, '1987-07-21', 17),
('Back In Black', 'AC/DC', 'Back In Black', 'rock', 255, '1980-07-25', 17),
('Smells Like Teen Spirit', 'Nirvana', 'Nevermind', 'rock', 301, '1991-09-10', 17),
-- Hip-hop songs
('Lose Yourself', 'Eminem', '8 Mile Soundtrack', 'hip-hop', 326, '2002-10-28', 17),
('Empire State of Mind', 'Jay-Z ft. Alicia Keys', 'The Blueprint 3', 'hip-hop', 276, '2009-10-20', 17),
('God\'s Plan', 'Drake', 'Scorpion', 'hip-hop', 198, '2018-01-19', 17),
('Alright', 'Kendrick Lamar', 'To Pimp a Butterfly', 'hip-hop', 219, '2015-03-15', 17),
('Sicko Mode', 'Travis Scott', 'Astroworld', 'hip-hop', 312, '2018-08-03', 17);

-- Add songs to Apple Music
INSERT INTO songs (title, artist_name, album_name, genre, duration, release_date, provider_id) VALUES
-- Pop songs
('As It Was', 'Harry Styles', 'Harry\'s House', 'pop', 167, '2022-04-01', 18),
('Stay', 'The Kid LAROI & Justin Bieber', 'F*CK LOVE 3: OVER YOU', 'pop', 138, '2021-07-09', 18),
('Watermelon Sugar', 'Harry Styles', 'Fine Line', 'pop', 174, '2019-11-16', 18),
('Levitating', 'Dua Lipa', 'Future Nostalgia', 'pop', 203, '2020-10-01', 18),
('Shivers', 'Ed Sheeran', '=', 'pop', 207, '2021-09-10', 18),
-- Classical music
('Moonlight Sonata', 'Ludwig van Beethoven', 'Piano Sonatas', 'classical', 360, '1801-01-01', 18),
('Four Seasons - Spring', 'Antonio Vivaldi', 'Four Seasons', 'classical', 169, '1723-01-01', 18),
('Symphony No. 5', 'Ludwig van Beethoven', 'Symphony Collection', 'classical', 425, '1808-01-01', 18),
('Claire de Lune', 'Claude Debussy', 'Suite bergamasque', 'classical', 300, '1905-01-01', 18),
('Ride of the Valkyries', 'Richard Wagner', 'Die Walküre', 'classical', 320, '1870-01-01', 18),
-- Jazz songs
('Take Five', 'Dave Brubeck', 'Time Out', 'jazz', 324, '1959-09-29', 18),
('So What', 'Miles Davis', 'Kind of Blue', 'jazz', 565, '1959-08-17', 18),
('Fly Me to the Moon', 'Frank Sinatra', 'It Might as Well Be Swing', 'jazz', 147, '1964-01-01', 18),
('Summertime', 'Ella Fitzgerald & Louis Armstrong', 'Porgy and Bess', 'jazz', 293, '1957-01-01', 18),
('What a Wonderful World', 'Louis Armstrong', 'What a Wonderful World', 'jazz', 140, '1967-01-01', 18);

-- Create playlists for Spotify users
INSERT INTO playlists (playlist_name, creation_date, is_public, user_id) VALUES
('Workout Motivation', '2023-01-05 08:15:00', TRUE, 1),  -- Robert's public playlist
('Focus Time', '2023-01-10 15:30:00', FALSE, 1),         -- Robert's private playlist
('Road Trip Jams', '2023-01-15 14:45:00', TRUE, 3),      -- Mike's playlist
('Chill Evening', '2023-01-20 19:20:00', TRUE, 5),       -- David's playlist
('Throwback Hits', '2023-01-25 16:10:00', TRUE, 7),      -- James's playlist
('Party Mix', '2023-02-01 20:30:00', TRUE, 9),           -- Jessica's playlist
('Morning Wake Up', '2023-02-05 07:45:00', FALSE, 11),   -- Sophia's playlist
('Weekend Vibes', '2023-02-10 12:30:00', TRUE, 13);      -- Olivia's playlist

-- Create playlists for Apple Music users
INSERT INTO playlists (playlist_name, creation_date, is_public, user_id) VALUES
('Classical Relaxation', '2023-01-08 21:15:00', TRUE, 2),   -- Jenny's playlist
('Jazz Lounge', '2023-01-12 18:30:00', FALSE, 4),           -- Sarah's playlist
('Pop Favorites', '2023-01-18 13:20:00', TRUE, 6),          -- Emily's playlist
('Study Session', '2023-01-23 09:45:00', TRUE, 8),          -- Chris's playlist
('Dinner Party', '2023-01-28 17:00:00', TRUE, 10),          -- Daniel's playlist
('Sleep Time', '2023-02-03 22:15:00', FALSE, 12),           -- Matt's playlist
('Sunday Morning', '2023-02-08 10:30:00', TRUE, 14);        -- Will's playlist

-- Robert's Workout Motivation playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(1, 1),  -- Shape of You
(1, 5),  -- Uptown Funk
(1, 9),  -- Back In Black
(1, 13), -- Empire State of Mind
(1, 15); -- Sicko Mode

-- Robert's Focus Time playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(2, 3),  -- Someone Like You
(2, 7),  -- Stairway to Heaven
(2, 11); -- Lose Yourself

-- Mike's Road Trip Jams playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(3, 5),  -- Uptown Funk
(3, 8),  -- Sweet Child O' Mine
(3, 9),  -- Back In Black
(3, 12); -- Empire State of Mind

-- David's Chill Evening playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(4, 3),  -- Someone Like You
(4, 7),  -- Stairway to Heaven
(4, 14); -- Alright

-- James's Throwback Hits playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(5, 6),  -- Bohemian Rhapsody
(5, 7),  -- Stairway to Heaven
(5, 8),  -- Sweet Child O' Mine
(5, 9),  -- Back In Black
(5, 10); -- Smells Like Teen Spirit

-- Jessica's Party Mix playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(6, 1),  -- Shape of You
(6, 2),  -- Blinding Lights
(6, 4),  -- Bad Guy
(6, 5),  -- Uptown Funk
(6, 13); -- Empire State of Mind

-- Sophia's Morning Wake Up playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(7, 1),  -- Shape of You
(7, 2),  -- Blinding Lights
(7, 5);  -- Uptown Funk

-- Olivia's Weekend Vibes playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(8, 1),  -- Shape of You
(8, 4),  -- Bad Guy
(8, 5),  -- Uptown Funk
(8, 8),  -- Sweet Child O' Mine
(8, 14); -- Alright

-- Add songs to Apple Music playlists
-- Jenny's Classical Relaxation playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(9, 21),  -- Moonlight Sonata
(9, 22),  -- Four Seasons - Spring
(9, 23),  -- Symphony No. 5
(9, 24);  -- Claire de Lune

-- Sarah's Jazz Lounge playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(10, 26), -- Take Five
(10, 27), -- So What
(10, 28), -- Fly Me to the Moon
(10, 30); -- What a Wonderful World

-- Emily's Pop Favorites playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(11, 16), -- As It Was
(11, 17), -- Stay
(11, 18), -- Watermelon Sugar
(11, 19), -- Levitating
(11, 20); -- Shivers

-- Chris's Study Session playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(12, 21), -- Moonlight Sonata
(12, 24), -- Claire de Lune
(12, 26), -- Take Five
(12, 27); -- So What

-- Daniel's Dinner Party playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(13, 26), -- Take Five
(13, 28), -- Fly Me to the Moon
(13, 29), -- Summertime
(13, 30); -- What a Wonderful World

-- Matt's Sleep Time playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(14, 21), -- Moonlight Sonata
(14, 24), -- Claire de Lune
(14, 30); -- What a Wonderful World

-- Will's Sunday Morning playlist
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(15, 22), -- Four Seasons - Spring
(15, 24), -- Claire de Lune
(15, 28), -- Fly Me to the Moon
(15, 30); -- What a Wonderful World

select * from playlist_songs ps
JOIN playlists p ON p.id = ps.playlist_id
JOIN songs s ON s.id = ps.song_id;;