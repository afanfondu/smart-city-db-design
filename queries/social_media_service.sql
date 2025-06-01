CREATE TABLE IF NOT EXISTS social_media_users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizen_id INT NOT NULL,
  username VARCHAR(50) NOT NULL,
  bio TEXT,
  registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  provider_id INT NOT NULL,

  FOREIGN KEY (citizen_id) REFERENCES citizens (id) ON DELETE CASCADE,
  FOREIGN KEY (provider_id) REFERENCES service_providers (id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS posts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  likes_count INT DEFAULT 0,
  user_id INT NOT NULL,
  provider_id INT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES social_media_users (id),
  FOREIGN KEY (provider_id) REFERENCES service_providers (id)
);

CREATE TABLE IF NOT EXISTS comments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  post_id INT NOT NULL,
  content TEXT NOT NULL,
  likes_count INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES social_media_users (id),
  FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE
);

-- should contain accepted_date
CREATE TABLE IF NOT EXISTS friends (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  friend_id INT NOT NULL,
  status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  accepted_date DATE,
  
  FOREIGN KEY (user_id) REFERENCES social_media_users (id) ON DELETE CASCADE,
  FOREIGN KEY (friend_id) REFERENCES social_media_users (id) ON DELETE CASCADE
);

INSERT INTO addresses (street, landmark, zone_code) VALUES
('1 Hacker Way', 'Tech Park', 'TECH-01'),         
('1355 Market Street', 'Downtown', 'TECH-02'),     
('715 Broadway', 'University District', 'TECH-03');

INSERT INTO service_providers (provider_name, status, address_id, service_id) VALUES
('Facebook', 'active', 34, 8),
('Twitter', 'active', 35, 8),
('Instagram', 'active', 36, 8);

INSERT INTO social_media_users (citizen_id, username, bio, provider_id) VALUES
-- Facebook users
(1, 'robert.j', 'Family man, tech enthusiast', 14),
(2, 'jen_johnson', 'Love travel and photography', 14),
(3, 'mike_williams', 'Sports fan and coffee lover', 14),
(4, 'sarah.w', 'Book lover and hiking enthusiast', 14),
(5, 'david_t', 'Working in healthcare, love music', 14),
-- Twitter users
(6, 'emily_thompson', 'Engineer by day, chef by night', 15),
(7, 'j_anderson', 'Always learning something new', 15),
(8, 'chris_wilson', 'Podcast addict & tech geek', 15),
(9, 'jess_martinez', 'Marketing professional, travel junkie', 15),
(10, 'daniel_taylor', 'Fitness enthusiast, dog lover', 15),
-- Instagram users
(11, 'sophia_lee', 'Fashion, food, and fun', 16),
(12, 'matt_brown', 'Photographer capturing life moments', 16),
(13, 'olivia_g', 'Artist sharing my creative journey', 16),
(14, 'will_miller', 'Nature lover and outdoor enthusiast', 16),
(15, 'elizabeth_m', 'Foodie exploring local cuisine', 16);

-- Facebook posts
INSERT INTO posts (content, created_at, likes_count, user_id, provider_id) VALUES
('Just celebrated my anniversary! 25 years and counting', '2023-03-10 19:30:00', 42, 1, 14),
('My new garden project is finally complete. So happy with how it turned out!', '2023-03-12 14:15:00', 36, 2, 14),
('Anyone watching the game tonight? Go team!', '2023-03-15 17:45:00', 15, 3, 14),
('Just finished this amazing book. Highly recommend!', '2023-03-18 21:20:00', 28, 4, 14),
('Excited to announce my promotion at work! New challenges ahead.', '2023-03-20 10:00:00', 67, 5, 14);

-- Twitter posts
INSERT INTO posts (content, created_at, likes_count, user_id, provider_id) VALUES
('Just learned a new coding technique that saved me hours of work! #programming #productivity', '2023-03-11 12:30:00', 53, 6, 15),
('Hot take: pineapple absolutely belongs on pizza. Fight me.', '2023-03-13 19:45:00', 124, 7, 15),
('New podcast episode recommendation: The future of AI in healthcare is mind-blowing!', '2023-03-16 08:20:00', 37, 8, 15),
('Marketing tip: consistency beats perfection every time. #MarketingTips', '2023-03-19 15:10:00', 89, 9, 15),
('5 AM workouts changed my life. The discipline transfers to everything else.', '2023-03-21 06:15:00', 76, 10, 15);

-- Instagram posts
INSERT INTO posts (content, created_at, likes_count, user_id, provider_id) VALUES
('Today\'s outfit details in bio! #OOTD #FashionInspo', '2023-03-12 11:00:00', 132, 11, 16),
('Captured this sunset at the beach yesterday. No filter needed!', '2023-03-14 20:30:00', 215, 12, 16),
('New painting completed! This one took me 3 weeks. #ArtProcess', '2023-03-17 13:45:00', 178, 13, 16),
('Hiking the mountain trail - the view was worth every step!', '2023-03-20 18:20:00', 145, 14, 16),
('Tried this new restaurant downtown. The pasta was incredible! #FoodieFinds', '2023-03-22 19:30:00', 98, 15, 16);


-- Comments on Facebook posts
INSERT INTO comments (user_id, post_id, content, likes_count, created_at) VALUES
(2, 1, 'Congratulations! Wishing you many more happy years together!', 12, '2023-03-10 20:15:00'),
(3, 1, 'You two are relationship goals!', 8, '2023-03-10 21:30:00'),
(4, 2, 'It looks amazing! Would love to know what plants you used.', 7, '2023-03-12 15:20:00'),
(5, 3, 'I\'ll be watching! Should be a great match.', 4, '2023-03-15 18:00:00'),
(1, 4, 'Adding this to my reading list right away!', 6, '2023-03-18 22:10:00');

-- Comments on Twitter posts
INSERT INTO comments (user_id, post_id, content, likes_count, created_at) VALUES
(7, 6, 'Could you share more details about this technique?', 15, '2023-03-11 13:45:00'),
(8, 7, 'Strongly disagree, but respect your bravery in stating this publicly 😂', 32, '2023-03-13 20:30:00'),
(9, 8, 'Just listened to it - absolutely mind-blowing stuff!', 11, '2023-03-16 10:15:00'),
(10, 9, 'This is so true. Consistency has been key to my success too.', 17, '2023-03-19 16:45:00'),
(6, 10, 'How long did it take you to adjust to that early schedule?', 9, '2023-03-21 08:30:00');

-- Comments on Instagram posts
INSERT INTO comments (user_id, post_id, content, likes_count, created_at) VALUES
(12, 11, 'Love this outfit! Where did you get that jacket?', 23, '2023-03-12 12:30:00'),
(13, 12, 'This is absolutely breathtaking!', 35, '2023-03-14 21:15:00'),
(14, 13, 'Your talent is incredible! I love seeing your process.', 29, '2023-03-17 14:30:00'),
(15, 14, 'Which trail is this? Would love to try it!', 18, '2023-03-20 19:45:00'),
(11, 15, 'That pasta looks divine! Adding this restaurant to my list.', 16, '2023-03-22 20:15:00');

-- Facebook friendships
INSERT INTO friends (user_id, friend_id, status, created_at, accepted_date) VALUES
(1, 2, 'accepted', '2023-02-15 09:30:00', '2023-02-15'),  -- Robert and Jennifer
(1, 3, 'accepted', '2023-02-18 14:20:00', '2023-02-19'),  -- Robert and Michael
(2, 4, 'accepted', '2023-02-20 11:45:00', '2023-02-21'),  -- Jennifer and Sarah
(3, 5, 'accepted', '2023-02-22 16:30:00', '2023-02-23'),  -- Michael and David
(4, 5, 'pending', '2023-03-01 13:15:00', NULL),           -- Sarah and David (pending)
(3, 4, 'rejected', '2023-02-25 10:30:00', NULL);          -- Michael and Sarah (rejected)

-- Twitter connections
INSERT INTO friends (user_id, friend_id, status, created_at, accepted_date) VALUES
(6, 7, 'accepted', '2023-02-16 10:45:00', '2023-02-16'),  -- Emily and James
(7, 8, 'accepted', '2023-02-19 15:30:00', '2023-02-20'),  -- James and Christopher
(8, 9, 'accepted', '2023-02-21 12:20:00', '2023-02-22'),  -- Christopher and Jessica
(9, 10, 'accepted', '2023-02-23 17:45:00', '2023-02-24'), -- Jessica and Daniel
(6, 10, 'pending', '2023-03-02 14:30:00', NULL),          -- Emily and Daniel (pending)
(7, 9, 'rejected', '2023-02-26 11:15:00', NULL);          -- James and Jessica (rejected)

-- Instagram connections
INSERT INTO friends (user_id, friend_id, status, created_at, accepted_date) VALUES
(11, 12, 'accepted', '2023-02-17 11:30:00', '2023-02-17'), -- Sophia and Matthew
(12, 13, 'accepted', '2023-02-20 16:45:00', '2023-02-21'), -- Matthew and Olivia
(13, 14, 'accepted', '2023-02-22 13:20:00', '2023-02-23'), -- Olivia and William
(14, 15, 'accepted', '2023-02-24 18:30:00', '2023-02-25'), -- William and Elizabeth
(11, 15, 'pending', '2023-03-03 15:45:00', NULL),          -- Sophia and Elizabeth (pending)
(12, 14, 'rejected', '2023-02-27 12:30:00', NULL);         -- Matthew and William (rejected)

-- Cross-platform connections (people who use multiple platforms)
INSERT INTO friends (user_id, friend_id, status, created_at, accepted_date) VALUES
(1, 6, 'accepted', '2023-03-05 09:15:00', '2023-03-06'),   -- Robert (FB) and Emily (Twitter)
(7, 11, 'accepted', '2023-03-08 14:30:00', '2023-03-09'),  -- James (Twitter) and Sophia (Instagram)
(5, 15, 'accepted', '2023-03-10 17:45:00', '2023-03-11'),  -- David (FB) and Elizabeth (Instagram)
(4, 9, 'pending', '2023-03-12 10:30:00', NULL),            -- Sarah (FB) and Jessica (Twitter) (pending)
(3, 14, 'rejected', '2023-03-07 13:15:00', NULL);          -- Michael (FB) and William (Instagram) (rejected)

select * from friends;