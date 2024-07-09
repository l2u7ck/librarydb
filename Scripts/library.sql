DROP TABLE IF EXISTS library_cards CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS pass CASCADE;
DROP TABLE IF EXISTS racks CASCADE;

CREATE TABLE IF NOT EXISTS library_cards (
	library_card_id SERIAL PRIMARY KEY,
	name_user VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	patronymic VARCHAR(50),
	address VARCHAR(100) NOT NULL,
	phone CHAR(12) NOT NULL CHECK (phone LIKE ('+7%') OR phone LIKE ('8%')),
	date_of_birth DATE NOT NULL, 
	issue_date_card DATE NOT NULL,
	CHECK (date_of_birth BETWEEN DATE(NOW() + INTERVAL '-120' YEAR) AND DATE(NOW() + INTERVAL '-14' YEAR)),
	CHECK (issue_date_card BETWEEN DATE(NOW() + INTERVAL '-120' YEAR) AND DATE(NOW()))
);

CREATE TABLE IF NOT EXISTS racks (
	rack_id SERIAL PRIMARY KEY,
	shelf_count INTEGER NOT NULL CHECK (shelf_count BETWEEN 1 AND 1000),
	rack_lenght INTEGER CHECK (rack_lenght BETWEEN 30 AND 10000)
);

CREATE TABLE IF NOT EXISTS books (
	book_id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	author VARCHAR(50) NOT NULL,
	year_of_issue INTEGER NOT NULL CHECK (year_of_issue BETWEEN 1600 AND EXTRACT(YEAR FROM NOW())),
	page_count INTEGER NOT NULL CHECK (page_count BETWEEN 10 AND 4000),
	book_cost INTEGER NOT NULL CHECK (book_cost BETWEEN 1 AND 20000000),
	book_count INTEGER NOT NULL CHECK (book_count BETWEEN 1 AND 100000)
); 

CREATE TABLE IF NOT EXISTS pass (
	pass_id SERIAL PRIMARY KEY,
	library_card_id INTEGER REFERENCES library_cards(library_card_id),
	book_id INTEGER REFERENCES books(book_id),
	date_of_issue DATE NOT NULL CHECK (date_of_issue = DATE(NOW())),
	date_return DATE CHECK (date_of_issue BETWEEN date_of_issue AND DATE(NOW())),
	normative_period INTEGER NOT NULL CHECK (normative_period BETWEEN 5 AND 15)
); 

CREATE TABLE IF NOT EXISTS book_positions (
	book_position_id SERIAL PRIMARY KEY,
	rack_id INTEGER REFERENCES racks(rack_id),
	book_id INTEGER REFERENCES books(book_id),
	number_shelf INTEGER NOT NULL CHECK (number_shelf BETWEEN 1 AND 1000)
	
);

