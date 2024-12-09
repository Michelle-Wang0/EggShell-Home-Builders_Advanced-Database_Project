--------------------------------------
------------DROP TABLES---------------
--------------------------------------

DROP TABLE task CASCADE CONSTRAINTS;
DROP TABLE sale CASCADE CONSTRAINTS;
DROP TABLE room CASCADE CONSTRAINTS;
DROP TABLE progress CASCADE CONSTRAINTS;
DROP TABLE options CASCADE CONSTRAINTS;
DROP TABLE lot CASCADE CONSTRAINTS;
DROP TABLE escrow_agent CASCADE CONSTRAINTS;
DROP TABLE elevation CASCADE CONSTRAINTS;
DROP TABLE deco_items CASCADE CONSTRAINTS;
DROP TABLE deco_choices CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE bank CASCADE CONSTRAINTS;
DROP TABLE staff CASCADE CONSTRAINTS;
DROP TABLE style CASCADE CONSTRAINTS;
DROP TABLE subdivision CASCADE CONSTRAINTS;
DROP TABLE school_district CASCADE CONSTRAINTS;

--------------------------------------
------------CREATE TABLES-------------
--------------------------------------

CREATE TABLE bank (
    bank_id   VARCHAR2(50) NOT NULL,
    bank_name VARCHAR2(50) NOT NULL,
    phone     VARCHAR2(20),
    fax       VARCHAR2(20),
    street    VARCHAR2(100),
    city      VARCHAR2(100),
    state     CHAR(2),
    zip       VARCHAR2(9)
);

ALTER TABLE bank ADD CONSTRAINT bank_pk PRIMARY KEY ( bank_id );

CREATE TABLE customer (
    customer_id VARCHAR2(50) NOT NULL,
    fname       VARCHAR2(50) NOT NULL,
    lname       VARCHAR2(50) NOT NULL,
    street      VARCHAR2(100),
    city        VARCHAR2(100),
    state       CHAR(2),
    zip         VARCHAR2(9)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customer_id );

CREATE TABLE deco_choices (
    deco_choice_id       VARCHAR2(50) NOT NULL,
    stage                NUMBER(2) NOT NULL,
    "date"               DATE NOT NULL,
    buyer_signature_date DATE,
    buyer_signature_url  VARCHAR2(255),
    lot_lot_id           VARCHAR2(50) NOT NULL,
    staff_staff_id       VARCHAR2(50) NOT NULL
);

ALTER TABLE deco_choices ADD CHECK ( stage BETWEEN 0 AND 99 );

ALTER TABLE deco_choices ADD CONSTRAINT deco_choices_pk PRIMARY KEY ( deco_choice_id );

CREATE TABLE deco_items (
    deco_item_id                VARCHAR2(50),
    room_id                     VARCHAR2(50),
    description                 CLOB,
    price                       NUMBER(10, 2),
    deco_choices_deco_choice_id VARCHAR2(50) NOT NULL,
    options_option_id           CHAR(4),
    options_stage               NUMBER(2)
);

ALTER TABLE deco_items ADD CHECK ( price BETWEEN 0 AND 9999999 );

ALTER TABLE deco_items ADD CHECK ( options_stage BETWEEN 0 AND 99 );

CREATE TABLE elevation (
    elevation_type   CHAR(1) NOT NULL,
    description      CLOB NOT NULL,
    cost             NUMBER(10, 2),
    sketch_url       VARCHAR2(255),
    style_style_name VARCHAR2(100) NOT NULL
);

ALTER TABLE elevation
    ADD CHECK ( elevation_type IN ( 'A', 'B', 'C', 'D', 'E' ) );

ALTER TABLE elevation ADD CHECK ( cost BETWEEN 0 AND 9999999 );

ALTER TABLE elevation ADD CONSTRAINT elevation_pk PRIMARY KEY ( elevation_type,
                                                                style_style_name );

CREATE TABLE escrow_agent (
    escrow_agent_id VARCHAR2(50) NOT NULL,
    fname           VARCHAR2(50) NOT NULL,
    lname           VARCHAR2(50) NOT NULL,
    street          VARCHAR2(100),
    city            VARCHAR2(100),
    state           CHAR(2),
    zip             VARCHAR2(9)
);

ALTER TABLE escrow_agent ADD CONSTRAINT escrow_agent_pk PRIMARY KEY ( escrow_agent_id );

CREATE TABLE lot (
    lot_id                       VARCHAR2(50) NOT NULL,
    longitude                    NUMBER(10, 6),
    latitude                     NUMBER(10, 6),
    zipcode                      VARCHAR2(9),
    subdivision_subdivision_name VARCHAR2(100) NOT NULL,
    style_style_name             VARCHAR2(100) NOT NULL
);

ALTER TABLE lot ADD CONSTRAINT lot_pk PRIMARY KEY ( lot_id );

CREATE TABLE options (
    option_id   CHAR(4) NOT NULL,
    description CLOB,
    stage       NUMBER(2) NOT NULL,
    category    VARCHAR2(50) NOT NULL,
    cost        NUMBER(10, 2) NOT NULL
);

ALTER TABLE options ADD CHECK ( stage BETWEEN 0 AND 99 );

ALTER TABLE options ADD CHECK ( cost BETWEEN 0 AND 9999999 );

ALTER TABLE options ADD CONSTRAINT options_pk PRIMARY KEY ( option_id,
                                                            stage );

CREATE TABLE progress (
    progress_id    VARCHAR2(50) NOT NULL,
    city           VARCHAR2(100),
    "date"         DATE NOT NULL,
    stage          NUMBER(2) NOT NULL,
    photo_url      VARCHAR2(255),
    time_estimate  NUMBER(5),
    lot_lot_id     VARCHAR2(50) NOT NULL,
    staff_staff_id VARCHAR2(50) NOT NULL
);

ALTER TABLE progress ADD CHECK ( stage BETWEEN 0 AND 99 );

ALTER TABLE progress ADD CHECK ( time_estimate BETWEEN 0 AND 9999 );

CREATE UNIQUE INDEX progress__idx ON
    progress (
        lot_lot_id
    ASC );

ALTER TABLE progress ADD CONSTRAINT progress_pk PRIMARY KEY ( progress_id );

CREATE TABLE room (
    room_id    VARCHAR2(50) NOT NULL,
    "size"     NUMBER(6, 2),
    floor      NUMBER(2),
    comments   CLOB,
    windows    NUMBER(2),
    celling    CLOB,
    lot_lot_id VARCHAR2(50) NOT NULL
);

ALTER TABLE room ADD CHECK ( "size" BETWEEN 0 AND 999999 );

ALTER TABLE room ADD CHECK ( floor BETWEEN 0 AND 999 );

ALTER TABLE room ADD CHECK ( windows BETWEEN 0 AND 99999 );

ALTER TABLE room ADD CONSTRAINT room_pk PRIMARY KEY ( room_id );

CREATE TABLE sale (
    sale_id                      VARCHAR2(50) NOT NULL,
    "date"                       DATE NOT NULL,
    base_price                   NUMBER(10, 2),
    financing_method             VARCHAR2(100),
    lot_premium                  NUMBER(10, 2),
    escrow_deposit               NUMBER(10, 2),
    agreement_received           CHAR(1),
    disclosure_form_received     CHAR(1),
    contract_received            CHAR(1),
    staff_staff_id               VARCHAR2(50) NOT NULL,
    customer_customer_id         VARCHAR2(50) NOT NULL,
    bank_bank_id                 VARCHAR2(50) NOT NULL,
    escrow_agent_escrow_agent_id VARCHAR2(50) NOT NULL,
    lot_lot_id                   VARCHAR2(50) NOT NULL
);

ALTER TABLE sale ADD CHECK ( base_price BETWEEN 0 AND 9999999 );

ALTER TABLE sale ADD CHECK ( lot_premium BETWEEN 0 AND 999999 );

ALTER TABLE sale ADD CHECK ( escrow_deposit BETWEEN 0 AND 9999999 );

CREATE UNIQUE INDEX sale__idx ON
    sale (
        lot_lot_id
    ASC );

ALTER TABLE sale ADD CONSTRAINT sale_pk PRIMARY KEY ( sale_id );

CREATE TABLE school_district (
    school_district_id           VARCHAR2(50) NOT NULL,
    elementary_school            VARCHAR2(50),
    middle_school                VARCHAR2(50),
    high_school                  VARCHAR2(50),
    subdivision_subdivision_name VARCHAR2(100) NOT NULL
);

CREATE UNIQUE INDEX school_district__idx ON
    school_district (
        subdivision_subdivision_name
    ASC );

ALTER TABLE school_district ADD CONSTRAINT school_district_pk PRIMARY KEY ( school_district_id );

CREATE TABLE staff (
    staff_id       VARCHAR2(50) NOT NULL,
    staff_title    VARCHAR2(50),
    fname          VARCHAR2(50) NOT NULL,
    lname          VARCHAR2(50) NOT NULL,
    license_number VARCHAR2(50)
);

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( staff_id );

CREATE TABLE style (
    style_name  VARCHAR2(100) NOT NULL,
    description CLOB,
    base_price  NUMBER(10, 2),
    photo_url   VARCHAR2(255),
    "size"      NUMBER(6, 2)
);

ALTER TABLE style ADD CHECK ( base_price BETWEEN 0 AND 9999999 );

ALTER TABLE style ADD CHECK ( "size" BETWEEN 0 AND 999999 );

ALTER TABLE style ADD CONSTRAINT style_pk PRIMARY KEY ( style_name );

CREATE TABLE subdivision (
    subdivision_name VARCHAR2(100) NOT NULL
);

ALTER TABLE subdivision ADD CONSTRAINT subdivision_pk PRIMARY KEY ( subdivision_name );

CREATE TABLE task (
    task_id              VARCHAR2(50) NOT NULL,
    description          CLOB,
    percent_completed    NUMBER(5, 2),
    progress_progress_id VARCHAR2(50) NOT NULL
);

ALTER TABLE task ADD CHECK ( percent_completed BETWEEN 0 AND 100 );

ALTER TABLE task ADD CONSTRAINT task_pk PRIMARY KEY ( task_id,
                                                      progress_progress_id );

ALTER TABLE deco_choices
    ADD CONSTRAINT deco_choices_lot_fk FOREIGN KEY ( lot_lot_id )
        REFERENCES lot ( lot_id );

ALTER TABLE deco_choices
    ADD CONSTRAINT deco_choices_staff_fk FOREIGN KEY ( staff_staff_id )
        REFERENCES staff ( staff_id );

ALTER TABLE deco_items
    ADD CONSTRAINT deco_items_deco_choices_fk FOREIGN KEY ( deco_choices_deco_choice_id )
        REFERENCES deco_choices ( deco_choice_id );

ALTER TABLE deco_items
    ADD CONSTRAINT deco_items_options_fk FOREIGN KEY ( options_option_id,
                                                       options_stage )
        REFERENCES options ( option_id,
                             stage );

ALTER TABLE elevation
    ADD CONSTRAINT elevation_style_fk FOREIGN KEY ( style_style_name )
        REFERENCES style ( style_name );

ALTER TABLE lot
    ADD CONSTRAINT lot_style_fk FOREIGN KEY ( style_style_name )
        REFERENCES style ( style_name );

ALTER TABLE lot
    ADD CONSTRAINT lot_subdivision_fk FOREIGN KEY ( subdivision_subdivision_name )
        REFERENCES subdivision ( subdivision_name );

ALTER TABLE progress
    ADD CONSTRAINT progress_lot_fk FOREIGN KEY ( lot_lot_id )
        REFERENCES lot ( lot_id );

ALTER TABLE progress
    ADD CONSTRAINT progress_staff_fk FOREIGN KEY ( staff_staff_id )
        REFERENCES staff ( staff_id );

ALTER TABLE room
    ADD CONSTRAINT room_lot_fk FOREIGN KEY ( lot_lot_id )
        REFERENCES lot ( lot_id );

ALTER TABLE sale
    ADD CONSTRAINT sale_bank_fk FOREIGN KEY ( bank_bank_id )
        REFERENCES bank ( bank_id );

ALTER TABLE sale
    ADD CONSTRAINT sale_customer_fk FOREIGN KEY ( customer_customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE sale
    ADD CONSTRAINT sale_escrow_agent_fk FOREIGN KEY ( escrow_agent_escrow_agent_id )
        REFERENCES escrow_agent ( escrow_agent_id );

ALTER TABLE sale
    ADD CONSTRAINT sale_lot_fk FOREIGN KEY ( lot_lot_id )
        REFERENCES lot ( lot_id );

ALTER TABLE sale
    ADD CONSTRAINT sale_staff_fk FOREIGN KEY ( staff_staff_id )
        REFERENCES staff ( staff_id );

ALTER TABLE school_district
    ADD CONSTRAINT school_district_subdivision_fk FOREIGN KEY ( subdivision_subdivision_name )
        REFERENCES subdivision ( subdivision_name );

ALTER TABLE task
    ADD CONSTRAINT task_progress_fk FOREIGN KEY ( progress_progress_id )
        REFERENCES progress ( progress_id );

--------------------------------------
------------INSERT DATA---------------
--------------------------------------

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B001', 'First National Bank', '555-1234', '555-5678', '123 Main St', 'Springfield', 'IL', '62701');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B002', 'City Bank', '555-8765', '555-4321', '456 Elm St', 'Chicago', 'IL', '60601');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B003', 'State Bank', '555-1111', '555-2222', '789 Oak St', 'New York', 'NY', '10001');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B004', 'Trust Bank', '555-3333', '555-4444', '321 Maple St', 'Los Angeles', 'CA', '90001');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B005', 'Alliance Bank', '555-5555', '555-6666', '654 Pine St', 'Dallas', 'TX', '75001');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B006', 'Global Bank', '555-7777', '555-8888', '789 Cedar St', 'San Francisco', 'CA', '94101');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B007', 'Metro Bank', '555-9999', '555-0000', '123 Birch St', 'Miami', 'FL', '33101');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B008', 'Capital Bank', '555-1112', '555-1314', '456 Spruce St', 'Atlanta', 'GA', '30301');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B009', 'United Bank', '555-1516', '555-1718', '789 Ash St', 'Houston', 'TX', '77001');

INSERT INTO bank (bank_id, bank_name, phone, fax, street, city, state, zip) VALUES
('B010', 'Pioneer Bank', '555-1920', '555-2122', '321 Redwood St', 'Denver', 'CO', '80014');

-- insert data to customer 
INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C001', 'John', 'Barack', '111 First St', 'New York', 'NY', '10001');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C002', 'Kamala', 'Smith', '222 Second St', 'Los Angeles', 'CA', '90001');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C003', 'Michael', 'Brown', '333 Third St', 'Chicago', 'IL', '60601');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C004', 'Emily', 'Harris', '444 Fourth St', 'Houston', 'TX', '77001');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C005', 'David', 'Chen', '555 Fifth St', 'Phoenix', 'AZ', '85001');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C006', 'Sophia', 'Wang', '666 Sixth St', 'Philadelphia', 'PA', '19101');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C007', 'James', 'Trump', '777 Seventh St', 'San Antonio', 'TX', '78201');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C008', 'Obama', 'Wilson', '888 Eighth St', 'San Diego', 'CA', '92101');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C009', 'JD', 'Moore', '999 Ninth St', 'Dallas', 'TX', '75001');

INSERT INTO customer (customer_id, fname, lname, street, city, state, zip) VALUES
('C010', 'Emma', 'Vance', '1010 Tenth St', 'San Jose', 'CA', '95101');


-- Insert data into escrow_agent table
INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E001', 'John', 'Best', '123 River St', 'Austin', 'TX', '73301');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E002', 'Lucy', 'Johnson', '456 Lake Rd', 'Seattle', 'WA', '98101');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E003', 'Michael', 'Wu', '789 Ocean Blvd', 'Miami', 'FL', '33101');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E004', 'Lana', 'Brown', '321 Desert Dr', 'Phoenix', 'AZ', '85001');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E005', 'David', 'Mars', '654 Forest Ln', 'Denver', 'CO', '80201');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E006', 'Peter', 'Zeng', '987 Mountain Ave', 'Salt Lake City', 'UT', '84101');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E007', 'James', 'Lee', '741 Palm St', 'Los Angeles', 'CA', '90001');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E008', 'Ava', 'Rose', '852 Sun St', 'Orlando', 'FL', '32801');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E009', 'Clinton', 'Davis', '963 Meadow St', 'Dallas', 'TX', '75001');

INSERT INTO escrow_agent (escrow_agent_id, fname, lname, street, city, state, zip) 
VALUES ('E010', 'Mia', 'Gu', '159 Snow Ave', 'Boston', 'MA', '02101');


-- Insert data into staff table
INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S001', 'Sales Manager', 'Sarah', 'Ku', 'LIC123456');

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S002', 'Project Manager', 'Chris', 'Taylor', null);

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S003', 'Construction Manager', 'Heng', 'Jiang', null);

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S004', 'Real Estate Agent', 'Michelle', 'Wang', 'LIC456789');

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S005', 'Project Manager', 'Chenkai', 'Lin', null);

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S006', 'Engineer', 'Ben', 'Harris', null);

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S007', 'Engineer', 'Laura', 'Davis', null);

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S008', 'Designer', 'Karen', 'Lewis', null);

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S009', 'Sales Director', 'Amelia', 'Lee', 'LIC222324');

INSERT INTO staff (staff_id, staff_title, fname, lname, license_number) 
VALUES ('S010', 'Sales Manager', 'Alan', 'Walker', 'LIC252627');

-- Insert data into subdivision table
INSERT INTO subdivision (subdivision_name) VALUES ('Sunset Valley');
INSERT INTO subdivision (subdivision_name) VALUES ('Sunup Valley');
INSERT INTO subdivision (subdivision_name) VALUES ('Mountain View');
INSERT INTO subdivision (subdivision_name) VALUES ('Sea View');
INSERT INTO subdivision (subdivision_name) VALUES ('Apple Park');
INSERT INTO subdivision (subdivision_name) VALUES ('Pear Park');
INSERT INTO subdivision (subdivision_name) VALUES ('Orange Park');
INSERT INTO subdivision (subdivision_name) VALUES ('Maple Grove');
INSERT INTO subdivision (subdivision_name) VALUES ('Cedar Ridge');
INSERT INTO subdivision (subdivision_name) VALUES ('Oakwood Hills');

-- Insert data into style
INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Industrial', 'Urban design.', 580000, 'industrial.jpg', 2800);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Modern', 'Sleek and minimalist.', 500000, 'modern.jpg', 1500);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Colonial', 'Traditional design.', 400000, 'colonial.jpg', 1800);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Ranch', 'Single-story design.', 350000, 'ranch.jpg', 2000);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Craftsman', 'Artisan design.', 450000, 'craftsman.jpg', 1750);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Victorian', 'Ornate design.', 600000, 'victorian.jpg', 2200);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Mediterranean', 'Warm roofs.', 550000, 'mediterranean.jpg', 2400);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Contemporary', 'Modern design.', 500000, 'contemporary.jpg', 2100);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Cottage', 'Cozy design.', 380000, 'cottage.jpg', 1300);

INSERT INTO style (style_name, description, base_price, photo_url, "size") VALUES
('Farmhouse', 'Rural design.', 420000, 'farmhouse.jpg', 1900);


-- Insert data into elevation
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('A', 'Standard model', 10000, 'standard_A.jpg', 'Modern');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('B', 'Luxury model', 20000, 'luxury_B.jpg', 'Craftsman');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('C', 'Eco model', 15000, 'eco_C.jpg', 'Contemporary');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('D', 'Compact model', 8000, 'compact_D.jpg', 'Cottage');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('E', 'Expanded model', 25000, 'expanded_E.jpg', 'Ranch');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('A', 'Basic economy model', 9000, 'economy_A.jpg', 'Colonial');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('B', 'Deluxe model', 30000, 'deluxe_B.jpg', 'Victorian');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('C', 'Sustainable model', 22000, 'solar_C.jpg', 'Mediterranean');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('D', 'Urban model', 18000, 'urban_D.jpg', 'Farmhouse');
INSERT INTO elevation (elevation_type, description, cost, sketch_url, style_style_name) VALUES ('E', 'Family model', 27000, 'family_E.jpg', 'Industrial');

-- Insert data into school district table
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD001', 'Maple Elementary', 'Starbucks Middle School', 'Subway High School', 'Sunset Valley');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD002', 'River Elementary', 'Forest Middle School', 'Sky High School', 'Sunup Valley');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD003', 'Hill Elementary', 'Lake Middle School', 'Cloud High School', 'Mountain View');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD004', 'Sea Elementary', 'Sand Middle School', 'Sun High School', 'Sea View');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD005', 'Leaf Elementary', 'Wood Middle School', 'Forest High School', 'Apple Park');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD006', 'Field Elementary', 'Mountain Middle School', 'River High School', 'Pear Park');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD007', 'Spring Elementary', 'Milk Middle School', 'Cat High School', 'Orange Park');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD008', 'Donue Elementary', 'Dumpling Middle School', 'Hill High School', 'Maple Grove');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD009', 'Orange Elementary', 'Apple Middle School', 'Banana High School', 'Cedar Ridge');
INSERT INTO school_district (school_district_id, elementary_school, middle_school, high_school, subdivision_subdivision_name) VALUES ('SD010', 'Brook Elementary', 'Creek Middle School', 'Stream High School', 'Oakwood Hills');

-- Insert data into lot table
-- each subdivision has 3 lots
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT001', -121.4944, 38.5816, '95814', 'Sunset Valley', 'Modern');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT002', -122.4194, 37.7749, '94102', 'Sunup Valley', 'Craftsman');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT003', -118.2437, 34.0522, '90012', 'Mountain View', 'Contemporary');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT004', -116.4142, 43.6187, '83702', 'Sea View', 'Ranch');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT005', -93.2650, 44.9778, '55401', 'Apple Park', 'Cottage');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT006', -122.6764, 45.5231, '97209', 'Pear Park', 'Victorian');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT007', -87.6298, 41.8781, '60604', 'Orange Park', 'Mediterranean');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT008', -104.9903, 39.7392, '80202', 'Maple Grove', 'Industrial');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT009', -149.9003, 61.2181, '99501', 'Cedar Ridge', 'Colonial');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT010', -74.0060, 40.7128, '10004', 'Oakwood Hills', 'Farmhouse');

INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT011', -121.4850, 38.5755, '95814', 'Sunset Valley', 'Contemporary');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT012', -122.4000, 37.7800, '94102', 'Sunup Valley', 'Modern');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT013', -118.2500, 34.0500, '90012', 'Mountain View', 'Ranch');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT014', -116.4200, 43.6200, '83702', 'Sea View', 'Colonial');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT015', -93.2700, 44.9800, '55401', 'Apple Park', 'Victorian');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT016', -122.6900, 45.5200, '97209', 'Pear Park', 'Cottage');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT017', -87.6300, 41.8800, '60604', 'Orange Park', 'Farmhouse');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT018', -104.9900, 39.7400, '80202', 'Maple Grove', 'Modern');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT019', -149.9000, 61.2200, '99501', 'Cedar Ridge', 'Contemporary');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT020', -74.0100, 40.7100, '10004', 'Oakwood Hills', 'Industrial');

INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT021', -121.5000, 38.5800, '95814', 'Sunset Valley', 'Victorian');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT022', -122.4200, 37.7700, '94102', 'Sunup Valley', 'Craftsman');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT023', -118.2550, 34.0550, '90012', 'Mountain View', 'Modern');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT024', -116.4300, 43.6100, '83702', 'Sea View', 'Ranch');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT025', -93.2500, 44.9700, '55401', 'Apple Park', 'Cottage');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT026', -122.6800, 45.5300, '97209', 'Pear Park', 'Modern');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT027', -87.6200, 41.8900, '60604', 'Orange Park', 'Contemporary');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT028', -104.9800, 39.7300, '80202', 'Maple Grove', 'Industrial');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT029', -149.8900, 61.2300, '99501', 'Cedar Ridge', 'Ranch');
INSERT INTO lot (lot_id, longitude, latitude, zipcode, subdivision_subdivision_name, style_style_name) VALUES ('LOT030', -74.0050, 40.7150, '10004', 'Oakwood Hills', 'Colonial');

-- insert data into room 
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R101', 15.0, 1, 'Master bedroom', 3, 'Vaulted', 'LOT001');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R102', 12.0, 1, 'Living room', 2, 'High', 'LOT001');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R103', 15.0, 1, 'Master bedroom', 3, 'Vaulted', 'LOT002');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R104', 14.0, 1, 'Family room', 4, 'High', 'LOT002');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R105', 16.0, 2, 'Kids bedroom', 2, 'Standard', 'LOT003');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R106', 14.0, 1, 'Kitchen', 1, 'Standard', 'LOT003');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R107', 17.0, 1, 'Office room', 2, 'High', 'LOT004');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R108', 15.0, 1, 'Living room', 3, 'High', 'LOT004');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R109', 18.0, 2, 'Master bedroom', 3, 'Vaulted', 'LOT005');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R110', 20.0, 1, 'Art Room', 2, 'Vaulted', 'LOT005');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R111', 16.0, 1, 'Master bedroom', 4, 'Vaulted', 'LOT006');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R112', 18.0, 1, 'Dining room', 3, 'High', 'LOT006');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R113', 14.0, 1, 'Sunroom', 5, 'High', 'LOT007');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R114', 13.0, 1, 'Mudroom', 0, 'Standard', 'LOT007');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R115', 17.0, 2, 'Guest bedroom', 2, 'High', 'LOT008');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R116', 15.0, 2, 'Play area', 2, 'Standard', 'LOT008');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R117', 20.0, 1, 'Master suite', 3, 'Vaulted', 'LOT009');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R118', 18.0, 1, 'living room', 3, 'High', 'LOT009');

INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R119', 22.0, 1, 'Entertainment room ', 2, 'High', 'LOT010');
INSERT INTO room (room_id, "size", floor, comments, windows, celling, lot_lot_id) VALUES ('R120', 19.0, 1, 'Home gym', 2, 'High', 'LOT010');

----- options
-- Electrical options
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP01', 'Wire for ceiling fan', 1, 'Electrical', 200);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP01', 'Wire for ceiling fan', 4, 'Electrical', 250);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP01', 'Wire for ceiling fan', 7, 'Electrical', 300);

INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP02', 'Phone jack', 1, 'Electrical', 100);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP02', 'Phone jack', 4, 'Electrical', 120);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP02', 'Phone jack', 7, 'Electrical', 140);

INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP03', 'Electrical outlet', 1, 'Electrical', 150);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP03', 'Electrical outlet', 4, 'Electrical', 175);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP03', 'Electrical outlet', 7, 'Electrical', 200);

-- Plumbing options
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP04', 'Garage sink', 1, 'Plumbing', 500);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP04', 'Garage sink', 4, 'Plumbing', 550);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP04', 'Garage sink', 7, 'Plumbing', 600);

INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP05', 'Fixture upgrade', 1, 'Plumbing', 750);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP05', 'Fixture upgrade', 4, 'Plumbing', 800);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP05', 'Fixture upgrade', 7, 'Plumbing', 850);

-- Interior options
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP06', 'Cabinet upgrade - level 1', 1, 'Interior', 1000);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP06', 'Cabinet upgrade - level 1', 4, 'Interior', 1100);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP06', 'Cabinet upgrade - level 1', 7, 'Interior', 1200);

INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP07', 'Cabinet upgrade - level 2', 1, 'Interior', 1500);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP07', 'Cabinet upgrade - level 2', 4, 'Interior', 1600);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP07', 'Cabinet upgrade - level 2', 7, 'Interior', 1700);

INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP08', 'Kitchen countertop', 1, 'Interior', 2000);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP08', 'Kitchen countertop', 4, 'Interior', 2200);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP08', 'Kitchen countertop', 7, 'Interior', 2400);

INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP09', 'Countertop grout', 1, 'Interior', 300);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP09', 'Countertop grout', 4, 'Interior', 350);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP09', 'Countertop grout', 7, 'Interior', 400);

INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP10', 'Carpet upgrade - level 1', 1, 'Interior', 1500);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP10', 'Carpet upgrade - level 1', 4, 'Interior', 1600);
INSERT INTO options (option_id, description, stage, category, cost) VALUES ('OP10', 'Carpet upgrade - level 1', 7, 'Interior', 1700);

-- Insert data into deco_choices table
INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC001', 1, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-02', 'YYYY-MM-DD'), 'http://signature1.jpg', 'LOT001', 'S001');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC002', 2, TO_DATE('2024-10-03', 'YYYY-MM-DD'), TO_DATE('2024-10-04', 'YYYY-MM-DD'), 'http://signature2.jpg', 'LOT002', 'S002');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC003', 1, TO_DATE('2024-10-05', 'YYYY-MM-DD'), TO_DATE('2024-10-06', 'YYYY-MM-DD'), 'http://signature3.jpg', 'LOT003', 'S003');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC004', 2, TO_DATE('2024-10-07', 'YYYY-MM-DD'), TO_DATE('2024-10-08', 'YYYY-MM-DD'), 'http://signature4.jpg', 'LOT004', 'S004');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC005', 1, TO_DATE('2024-10-09', 'YYYY-MM-DD'), TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'http://signature5.jpg', 'LOT005', 'S005');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC006', 2, TO_DATE('2024-10-11', 'YYYY-MM-DD'), TO_DATE('2024-10-12', 'YYYY-MM-DD'), 'http://signature6.jpg', 'LOT006', 'S006');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC007', 1, TO_DATE('2024-10-13', 'YYYY-MM-DD'), TO_DATE('2024-10-14', 'YYYY-MM-DD'), 'http://signature7.jpg', 'LOT007', 'S007');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC008', 2, TO_DATE('2024-10-15', 'YYYY-MM-DD'), TO_DATE('2024-10-16', 'YYYY-MM-DD'), 'http://signature8.jpg', 'LOT008', 'S008');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC009', 1, TO_DATE('2024-10-17', 'YYYY-MM-DD'), TO_DATE('2024-10-18', 'YYYY-MM-DD'), 'http://signature9.jpg', 'LOT009', 'S009');

INSERT INTO deco_choices (deco_choice_id, stage, "date", buyer_signature_date, buyer_signature_url, lot_lot_id, staff_staff_id) VALUES
('DC010', 2, TO_DATE('2024-10-19', 'YYYY-MM-DD'), TO_DATE('2024-10-20', 'YYYY-MM-DD'), 'http://signature10.jpg', 'LOT010', 'S010');

-- Insert data into deco_items table
INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI001', 'R101', 'Wallpaper for master bedroom', 450.00, 'DC001', 'OP06', 1);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI002', 'R102', 'Carpeting for living room', 600.00, 'DC002', 'OP10', 1);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI003', 'R103', 'Wooden blinds for bedroom windows', 350.00, 'DC003', 'OP01', 1);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI004', 'R104', 'kitchen hardware', 800.00, 'DC004', 'OP08', 1);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI005', 'R105', 'ighting fixtures', 500.00, 'DC005', 'OP01', 4);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI006', 'R106', 'Stylish sofa', 1200.00, 'DC006', 'OP10', 4);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI007', 'R107', 'study desk', 700.00, 'DC007', 'OP06', 7);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI008', 'R108', 'Custom bookshelves', 950.00, 'DC008', 'OP06', 7);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI009', 'R109', 'bed frame', 1500.00, 'DC009', 'OP10', 7);

INSERT INTO deco_items (deco_item_id, room_id, description, price, deco_choices_deco_choice_id, options_option_id, options_stage) VALUES
('DI010', 'R110', 'High-end TV system', 2200.00, 'DC010', 'OP10', 7);

-- Insert data into progress table
INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P001', 'New York', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 1, 'http://progress1.jpg', 30, 'LOT001', 'S001');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P002', 'Los Angeles', TO_DATE('2024-10-11', 'YYYY-MM-DD'), 2, 'http://progress2.jpg', 45, 'LOT002', 'S002');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P003', 'Chicago', TO_DATE('2024-10-12', 'YYYY-MM-DD'), 1, 'http://progress3.jpg', 60, 'LOT003', 'S003');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P004', 'Houston', TO_DATE('2024-10-13', 'YYYY-MM-DD'), 3, 'http://progress4.jpg', 15, 'LOT004', 'S004');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P005', 'Phoenix', TO_DATE('2024-10-14', 'YYYY-MM-DD'), 2, 'http://progress5.jpg', 20, 'LOT005', 'S005');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P006', 'Philadelphia', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 1, 'http://progress6.jpg', 25, 'LOT006', 'S006');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P007', 'San Antonio', TO_DATE('2024-10-16', 'YYYY-MM-DD'), 3, 'http://progress7.jpg', 35, 'LOT007', 'S007');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P008', 'San Diego', TO_DATE('2024-10-17', 'YYYY-MM-DD'), 2, 'http://progress8.jpg', 40, 'LOT008', 'S008');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P009', 'Dallas', TO_DATE('2024-10-18', 'YYYY-MM-DD'), 1, 'http://progress9.jpg', 50, 'LOT009', 'S009');

INSERT INTO progress (progress_id, city, "date", stage, photo_url, time_estimate, lot_lot_id, staff_staff_id) VALUES
('P010', 'San Jose', TO_DATE('2024-10-19', 'YYYY-MM-DD'), 3, 'http://progress10.jpg', 55, 'LOT010', 'S010');

-- Insert data into task table
INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T001', 'Foundation laying for new building', 25.0, 'P001');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T002', 'Plumbing installation', 50.0, 'P002');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T003', 'wiring setup', 75.0, 'P003');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T004', 'Interior painting', 90.0, 'P004');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T005', 'Roof installation', 30.0, 'P005');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T006', 'Landscape design', 45.0, 'P006');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T007', 'External work', 60.0, 'P007');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T008', 'Flooring bathrooms', 85.0, 'P008');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T009', 'Window fittings', 20.0, 'P009');

INSERT INTO task (task_id, description, percent_completed, progress_progress_id) VALUES
('T010', 'Final inspection and cleanup', 95.0, 'P010');

-- Insert data into sale table
INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S001', TO_DATE('2024-10-20', 'YYYY-MM-DD'), 500000, 'Mortgage', 10000, 5000, 'Y', 'Y', 'Y', 'S001', 'C001', 'B001', 'E001', 'LOT001');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S002', TO_DATE('2024-10-21', 'YYYY-MM-DD'), 550000, 'Cash', 15000, 5500, 'Y', 'Y', 'Y', 'S002', 'C002', 'B002', 'E002', 'LOT002');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S003', TO_DATE('2024-10-22', 'YYYY-MM-DD'), 600000, 'Finance', 20000, 6000, 'Y', 'Y', 'Y', 'S003', 'C003', 'B003', 'E003', 'LOT003');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S004', TO_DATE('2024-10-23', 'YYYY-MM-DD'), 650000, 'Mortgage', 25000, 6500, 'Y', 'N', 'Y', 'S004', 'C004', 'B004', 'E004', 'LOT004');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S005', TO_DATE('2024-10-24', 'YYYY-MM-DD'), 700000, 'Cash', 30000, 7000, 'Y', 'Y', 'N', 'S005', 'C005', 'B005', 'E005', 'LOT005');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S006', TO_DATE('2024-10-25', 'YYYY-MM-DD'), 750000, 'Finance', 35000, 7500, 'N', 'Y', 'Y', 'S006', 'C006', 'B006', 'E006', 'LOT006');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S007', TO_DATE('2024-10-26', 'YYYY-MM-DD'), 800000, 'Mortgage', 40000, 8000, 'Y', 'N', 'N', 'S007', 'C007', 'B007', 'E007', 'LOT007');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S008', TO_DATE('2024-10-27', 'YYYY-MM-DD'), 850000, 'Cash', 45000, 8500, 'N', 'N', 'Y', 'S008', 'C008', 'B008', 'E008', 'LOT008');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S009', TO_DATE('2024-10-28', 'YYYY-MM-DD'), 900000, 'Finance', 50000, 9000, 'Y', 'Y', 'Y', 'S009', 'C009', 'B009', 'E009', 'LOT009');

INSERT INTO sale (sale_id, "date", base_price, financing_method, lot_premium, escrow_deposit, agreement_received, disclosure_form_received, contract_received, staff_staff_id, customer_customer_id, bank_bank_id, escrow_agent_escrow_agent_id, lot_lot_id) VALUES
('S010', TO_DATE('2024-10-29', 'YYYY-MM-DD'), 950000, 'Mortgage', 55000, 9500, 'N', 'Y', 'N', 'S010', 'C010', 'B010', 'E010', 'LOT010');

--------------------------------------
------------CREATE VIEWS--------------
--------------------------------------

-- A view of properties that is estimated to be finished construction in less than 30 days
-- To prepare for delivery, the view provides info on time remaining, lot info, customer info, and staff info.
-- Ordered by time remaining.
CREATE OR REPLACE VIEW near_finish_properties (lot_id, time_remaining, customer_id, customer_fname, customer_lname, staff_id, staff_fname, staff_lname) AS
SELECT p.lot_lot_id, p.time_estimate, c.customer_id, c.fname, c.lname, st.staff_id, st.fname, st.lname
FROM progress p
INNER JOIN sale s
ON p.lot_lot_id = s.lot_lot_id
INNER JOIN customer c
ON c.customer_id = s.customer_customer_id
INNER JOIN staff st
ON s.staff_staff_id = st.staff_id
WHERE p.time_estimate<30
ORDER BY p.time_estimate ASC;

-- a view of popular deco options
CREATE OR REPLACE VIEW popular_deco_options (option_id, stage, description, category, selected_count) AS
SELECT op.options_option_id as option_id, op.stage,o.description, o.category, op.count as count
FROM (
SELECT options_option_id, options_stage as stage, count(*) AS count
FROM deco_items
GROUP BY options_option_id, options_stage) op
LEFT JOIN options o
ON op.options_option_id = o.option_id and op.stage = o.stage
ORDER BY count DESC;

--------------------------------------
------------CREATE SEQUENCE-----------
--------------------------------------

-- need to create surrogate keys for subdivision table
DROP SEQUENCE subdivision_sequence;

CREATE SEQUENCE subdivision_sequence
START WITH 1
INCREMENT BY 1;

ALTER TABLE subdivision ADD subdivision_id NUMBER(10);

UPDATE subdivision 
SET subdivision_id = subdivision_sequence.NEXTVAL;

-- need to create surrogate keys for style table
DROP SEQUENCE style_sequence;

CREATE SEQUENCE style_sequence
START WITH 1
INCREMENT BY 1;

ALTER TABLE style ADD style_id NUMBER(10);

UPDATE style 
SET style_id = style_sequence.NEXTVAL;

--------------------------------------
------------CREATE PROCEDURES---------
--------------------------------------

--1. track the consturction progress
CREATE OR REPLACE PROCEDURE update_construction_progress (
    p_lot_id IN progress.lot_lot_id%TYPE,
    p_new_stage IN progress.stage%TYPE,
    p_new_time IN progress.time_estimate%TYPE) 
    AS 
    v_lot_exists NUMBER;
    v_progress_id progress.progress_id%TYPE;
BEGIN
    -- Check if the lot exists in progress
    SELECT COUNT(*)
    INTO v_lot_exists
    FROM progress
    WHERE lot_lot_id = p_lot_id;

    IF v_lot_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Lot ID is not found in the progress.');
        RETURN;
    END IF;

    SELECT progress_id
    INTO v_progress_id
    FROM progress
    WHERE lot_lot_id = p_lot_id;


    -- Update the progress stage and completion percentage
    UPDATE progress
    SET stage = p_new_stage,"date" = SYSTIMESTAMP, time_estimate = p_new_time
    WHERE lot_lot_id = p_lot_id;

    -- Update the task completion percentage
    IF p_new_time<5 THEN
        UPDATE task
        SET percent_completed = 1
        WHERE progress_progress_id = v_progress_id;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Construction progress updated successfully.');

EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No data found for the given inputs!');
WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('Dividing by zero!');
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Too many rows being returned!');
WHEN INVALID_CURSOR THEN DBMS_OUTPUT.PUT_LINE('Invalid cursor!');
WHEN CURSOR_ALREADY_OPEN THEN DBMS_OUTPUT.PUT_LINE('CursorEXCEP already open!');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('other error');

END update_construction_progress;
/

-- 2. add a new subdivision 
-- automatically add surrogate key

CREATE OR REPLACE PROCEDURE add_subdivision(
    p_subdivision_name subdivision.subdivision_name%TYPE
) IS v_surrogate subdivision.subdivision_id%TYPE;

BEGIN 
SELECT subdivision_sequence.NEXTVAL INTO v_surrogate FROM dual;

INSERT INTO subdivision (subdivision_name,subdivision_id)
VALUES(p_subdivision_name,v_surrogate);

DBMS_OUTPUT.PUT_LINE('subdivision added');

EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No data found for the given inputs!');
WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('Dividing by zero!');
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Too many rows being returned!');
WHEN INVALID_CURSOR THEN DBMS_OUTPUT.PUT_LINE('Invalid cursor!');
WHEN CURSOR_ALREADY_OPEN THEN DBMS_OUTPUT.PUT_LINE('CursorEXCEP already open!');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('other error');

END add_subdivision;
/

--------------------------------------
------------CREATE FUNCTIONS----------
--------------------------------------

DROP FUNCTION calculate_total_sale;

--function: calculate the total price (base price + lot premium)
CREATE OR REPLACE FUNCTION calculate_total_sale (p_sale_id sale.sale_id%TYPE)
RETURN NUMBER IS
  v_base_price sale.base_price%TYPE;
  v_lot_premium sale.lot_premium%TYPE;
  v_total_price NUMBER;
BEGIN
  SELECT base_price, lot_premium INTO v_base_price, v_lot_premium
  FROM sale
  WHERE sale_id = p_sale_id;
  
  v_total_price := v_base_price + v_lot_premium;
  RETURN v_total_price;
END;
/

--------------------------------------
------------CREATE PACKAGE------------
--------------------------------------

CREATE OR REPLACE PACKAGE egg_shell_package IS
PROCEDURE update_construction_progress (
    p_lot_id IN progress.lot_lot_id%TYPE,
    p_new_stage IN progress.stage%TYPE,
    p_new_time IN progress.time_estimate%TYPE);

PROCEDURE add_subdivision(
    p_subdivision_name subdivision.subdivision_name%TYPE
);

FUNCTION calculate_total_sale (p_sale_id sale.sale_id%TYPE)
RETURN NUMBER;

END egg_shell_package;
/

CREATE OR REPLACE PACKAGE BODY egg_shell_package AS

PROCEDURE update_construction_progress (
    p_lot_id IN progress.lot_lot_id%TYPE,
    p_new_stage IN progress.stage%TYPE,
    p_new_time IN progress.time_estimate%TYPE) 
    AS 
    v_lot_exists NUMBER;
    v_progress_id progress.progress_id%TYPE;
BEGIN
    -- Check if the lot exists in progress
    SELECT COUNT(*)
    INTO v_lot_exists
    FROM progress
    WHERE lot_lot_id = p_lot_id;

    IF v_lot_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Lot ID is not found in the progress.');
        RETURN;
    END IF;

    SELECT progress_id
    INTO v_progress_id
    FROM progress
    WHERE lot_lot_id = p_lot_id;


    -- Update the progress stage and completion percentage
    UPDATE progress
    SET stage = p_new_stage,"date" = SYSTIMESTAMP, time_estimate=p_new_time
    WHERE lot_lot_id = p_lot_id;

    -- Update the task completion percentage
    IF p_new_time<5 THEN
        UPDATE task
        SET percent_completed = 1
        WHERE progress_progress_id = v_progress_id;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Construction progress updated successfully.');

EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No data found for the given inputs!');
WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('Dividing by zero!');
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Too many rows being returned!');
WHEN INVALID_CURSOR THEN DBMS_OUTPUT.PUT_LINE('Invalid cursor!');
WHEN CURSOR_ALREADY_OPEN THEN DBMS_OUTPUT.PUT_LINE('CursorEXCEP already open!');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('other error');

END update_construction_progress;

PROCEDURE add_subdivision(
    p_subdivision_name subdivision.subdivision_name%TYPE
) IS v_surrogate subdivision.subdivision_id%TYPE;

BEGIN 
SELECT subdivision_sequence.NEXTVAL INTO v_surrogate FROM dual;

INSERT INTO subdivision (subdivision_name,subdivision_id)
VALUES(p_subdivision_name,v_surrogate);

DBMS_OUTPUT.PUT_LINE('subdivision added');

EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No data found for the given inputs!');
WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('Dividing by zero!');
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Too many rows being returned!');
WHEN INVALID_CURSOR THEN DBMS_OUTPUT.PUT_LINE('Invalid cursor!');
WHEN CURSOR_ALREADY_OPEN THEN DBMS_OUTPUT.PUT_LINE('CursorEXCEP already open!');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('other error');

END add_subdivision;

FUNCTION calculate_total_sale (p_sale_id sale.sale_id%TYPE)
RETURN NUMBER IS
  v_base_price sale.base_price%TYPE;
  v_lot_premium sale.lot_premium%TYPE;
  v_total_price NUMBER;
BEGIN
  SELECT base_price, lot_premium INTO v_base_price, v_lot_premium
  FROM sale
  WHERE sale_id = p_sale_id;
  
  v_total_price := v_base_price + v_lot_premium;
  RETURN v_total_price;
END calculate_total_sale;

END egg_shell_package;
/

--------------------------------------
------------CREATE TRIGGER------------
--------------------------------------

-- 1.Print update logs
CREATE OR REPLACE TRIGGER log_lot_progress_update
AFTER UPDATE ON progress
FOR EACH ROW
WHEN (NEW.stage <> OLD.stage)  -- only if the stage has changed
BEGIN
    DBMS_OUTPUT.PUT_LINE('Lot Updated: ' || :NEW.lot_lot_id);
    DBMS_OUTPUT.PUT_LINE('Stage Updated From: ' || :OLD.stage);
    DBMS_OUTPUT.PUT_LINE('Stage Updated To: ' || :NEW.stage);
    DBMS_OUTPUT.PUT_LINE('Time: ' || SYSTIMESTAMP);
END;
/

--2. check duplicates when adding new subdivisions
CREATE OR REPLACE TRIGGER no_dup_subdivision
BEFORE INSERT ON subdivision
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM subdivision
    WHERE subdivision_name = :NEW.subdivision_name;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'name already exists!');
    END IF;
END;
/

--------------------------------------
------------SCHEDULED JOB------------
--------------------------------------

-- a scheduled job to raise price by 2 percent every year

CREATE OR REPLACE PROCEDURE yearly_price_raise IS
BEGIN
    UPDATE options
    SET cost = cost * 1.02;
        DBMS_OUTPUT.PUT_LINE('deco option prices increased by 2%.');
END yearly_price_raise;
/

BEGIN
    DBMS_SCHEDULER.create_job (
        job_name        => 'yearly_price_raise_job',
        job_type        => 'STORED_PROCEDURE',
        job_action      => 'yearly_price_raise',
        start_date      => SYSTIMESTAMP, 
        repeat_interval => 'FREQ=YEARLY;', 
        enabled         => TRUE
    );
END;
/

--------------------------------------
------------ALTERNATE INDEX-----------
--------------------------------------

-- an alternative index on customers' first name and last name
-- because we often search customer full names.
DROP INDEX customer_name_idx;
CREATE INDEX customer_name_idx ON customer(fname, lname);

--------------------------------------
------------CREATE ROLES--------------
--------------------------------------

DROP ROLE sales_agent_role;
CREATE ROLE sales_agent_role;

DROP ROLE construction_manager_role;
CREATE ROLE construction_manager_role;

--------------------------------------
------------GRANT PRIVILEDGES---------
--------------------------------------

GRANT SELECT, INSERT, UPDATE ON sale TO sales_agent_role;
GRANT SELECT, INSERT, UPDATE ON customer TO sales_agent_role;
GRANT SELECT ON lot TO sales_agent_role;
GRANT SELECT ON bank TO sales_agent_role;
GRANT SELECT ON elevation TO sales_agent_role;
GRANT SELECT ON options TO sales_agent_role;
GRANT SELECT ON style TO sales_agent_role;
GRANT SELECT ON subdivision TO sales_agent_role;
GRANT SELECT ON school_district TO sales_agent_role;

GRANT SELECT ON sale TO construction_manager_role;
GRANT SELECT ON customer TO construction_manager_role;
GRANT SELECT ON lot TO construction_manager_role;
GRANT SELECT ON elevation TO construction_manager_role;
GRANT SELECT ON style TO construction_manager_role;
GRANT SELECT ON subdivision TO construction_manager_role;
GRANT SELECT ON deco_choices TO construction_manager_role;
GRANT SELECT ON deco_items TO construction_manager_role;
GRANT SELECT, INSERT, UPDATE ON options TO construction_manager_role;
GRANT SELECT, INSERT, UPDATE ON progress TO construction_manager_role;
GRANT SELECT, INSERT, UPDATE ON task TO construction_manager_role;

--------------------------------------
------------DE-NORMALIZATION----------
--------------------------------------

-- merge subdivision and school district table
-- merge school district info into subdivision and drop the school district table

ALTER TABLE subdivision
ADD (elementary_school VARCHAR2(50),
     middle_school VARCHAR2(50),
     high_school    VARCHAR2(50));

UPDATE subdivision s
SET s.elementary_school = (SELECT sd.elementary_school FROM school_district sd WHERE sd.subdivision_subdivision_name = s.subdivision_name),
    s.middle_school = (SELECT sd.middle_school FROM school_district sd WHERE sd.subdivision_subdivision_name = s.subdivision_name),
    s.high_school = (SELECT sd.high_school FROM school_district sd WHERE sd.subdivision_subdivision_name = s.subdivision_name);

DROP TABLE school_district;



















