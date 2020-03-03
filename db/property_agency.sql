DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    address VARCHAR(255),
    year_built INT,
    buy_let_status VARCHAR(255),
    square_footage INT
);
