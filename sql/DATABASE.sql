DROP DATABASE IF EXISTS vault;

CREATE DATABASE IF NOT EXISTS vault
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE vault;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    display_name VARCHAR(100) NOT NULL,
    xp_points INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE media_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE media (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    status ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_media_category FOREIGN KEY (category_id) REFERENCES media_categories(id)
);

CREATE TABLE user_library (
    user_id INT NOT NULL,
    media_id INT NOT NULL,
    rating TINYINT UNSIGNED,
    favorite BOOLEAN NOT NULL DEFAULT FALSE,
    watched_at TIMESTAMP NULL,
    PRIMARY KEY (user_id, media_id),
    CONSTRAINT fk_user_library_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_user_library_media FOREIGN KEY (media_id) REFERENCES media(id)
);

INSERT INTO media_categories (name) VALUES ('film'), ('serie'), ('jeu');

INSERT INTO users (username, email, display_name, xp_points)
VALUES ('yanis', 'yanis@example.com', 'Yanis B.', 3280),
       ('benjamin', 'benjamin@example.com', 'Benjamin', 2450),
       ('fatima', 'fatima@example.com', 'Fatima', 2930);

INSERT INTO media (category_id, title, description, image_url, status)
VALUES
    (1, 'Titanic', 'Deux vies se croisent à bord du paquebot...', 'https://cdng.europosters.eu/pod_public/1300/266355.jpg', 'published'),
    (1, 'Le Parrain', 'Une dynastie de mafieux à New York.', 'https://media.posterlounge.com/img/products/710000/707663/707663_poster.jpg', 'published'),
    (2, 'Breaking Bad', 'Un professeur de chimie se lance dans le crime.', 'https://m.media-amazon.com/images/M/MV5BMzU5ZGYzNmQtMTdhYy00OGRiLTg0NmQtYjVjNzliZTg1ZGE4XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg', 'published'),
    (2, 'The Boys', 'Des super-héros sous le contrôle d’une corporation.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5DU3vHasM7HF9hrRj3z1JBdordNGISVQtQku0jHF0zA&s=10', 'published'),
    (3, 'Minecraft', 'Un bac à sable créatif et sur vivant.', 'https://i.ebayimg.com/images/g/Y9IAAOSwM2ddrpX2/s-l1200.jpg', 'published'),
    (3, 'Fortnite', 'Un battle royale compétitif et explosif.', 'https://i.ebayimg.com/images/g/rKYAAOSwqY5fhrmq/s-l1200.jpg', 'published');

INSERT INTO user_library (user_id, media_id, rating, favorite, watched_at)
VALUES
    (1, 1, 5, TRUE, NOW()),
    (1, 3, 5, TRUE, NOW()),
    (1, 5, 4, TRUE, NOW());

