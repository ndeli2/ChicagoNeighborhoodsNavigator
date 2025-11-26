-- ==============================
-- 1. USERS
-- ==============================

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);


-- ==============================
-- 2. NEIGHBORHOODS
-- ==============================

CREATE TABLE Neighborhoods (
    neighborhood_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    population INT,
    median_income INT,
    region VARCHAR(50)
);


-- ==============================
-- 3. CRIME STATS (1-to-1 with Neighborhoods)
-- ==============================

CREATE TABLE CrimeStats (
    crime_id INT AUTO_INCREMENT PRIMARY KEY,
    neighborhood_id INT NOT NULL UNIQUE,
    crime_score VARCHAR(20),
    annual_incidents INT,
    FOREIGN KEY (neighborhood_id) REFERENCES Neighborhoods(neighborhood_id)
        ON DELETE CASCADE
);


-- ==============================
-- 4. AFFORDABILITY (1-to-1 with Neighborhoods)
-- ==============================

CREATE TABLE Affordability (
    afford_id INT AUTO_INCREMENT PRIMARY KEY,
    neighborhood_id INT NOT NULL UNIQUE,
    median_rent INT,
    median_home_value INT,
    affordability_category VARCHAR(50),
    FOREIGN KEY (neighborhood_id) REFERENCES Neighborhoods(neighborhood_id)
        ON DELETE CASCADE
);


-- ==============================
-- 5. FAVORITES (Many-to-Many via Junction Table)
-- ==============================

CREATE TABLE Favorites (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    neighborhood_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (neighborhood_id) REFERENCES Neighborhoods(neighborhood_id)
        ON DELETE CASCADE
);