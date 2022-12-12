CREATE DATABASE Wontons;

USE Wontons;

GRANT ALL PRIVILEGES on Wontons.* to 'webapp'@'%';
flush PRIVILEGES;

CREATE TABLE tables (
    table_num varchar(3) PRIMARY KEY NOT NULL,
    state BOOLEAN,
    occupancy INTEGER NOT NULL
);

CREATE TABLE waiters (
    waiter_id char(6) PRIMARY KEY NOT NULL,
    hours INTEGER NOT NULL,
    name varchar(40) NOT NULL,
    wsuper_id char(6),
    CONSTRAINT fk_1
        FOREIGN KEY (wsuper_id) REFERENCES waiters (waiter_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE customers (
    cust_id char(5) PRIMARY KEY NOT NULL,
    name varchar(40) NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    waiter_id char(6),
    table_num char(3),
    payment INTEGER,
    active BOOLEAN NOT NULL,
    CONSTRAINT c1
        FOREIGN KEY (waiter_id) REFERENCES waiters (waiter_id),
    CONSTRAINT c2
        FOREIGN KEY (table_num) REFERENCES tables (table_num)
);

INSERT INTO tables VALUES(1, FALSE, 6), (2, FALSE, 4), (3, FALSE, 2), (4, FALSE, 4), (5, TRUE, 4);

INSERT INTO waiters VALUES(100000, 10, 'Karen', NULL), (123457, 4, 'Joshua', 100000),
(123456, 3, 'Angel', 100000);

INSERT INTO customers VALUES(12345, 'Joseph', '2022-11-18 22:23:12',
                            123456, 001, 100, TRUE),
                          (12346, 'Ethan', '2022-11-18 22:23:13',
                            123457, 002, 100, FALSE),
                          (00001, 'Jonathan', '2022-11-18 22:23:13',
                            123456, 003, 0, TRUE),
                          (00002, 'Anna', '2022-11-18 22:23:13',
                            123456, 004, 0, TRUE);


CREATE TABLE cooks (
    cook_id char(7) PRIMARY KEY NOT NULL,
    name varchar(40) NOT NULL,
    work_hours INTEGER NOT NULL,
    csuper_id char(7),
    CONSTRAINT fk_cooks_1
        FOREIGN KEY (csuper_id) REFERENCES cooks (cook_id)
);

INSERT INTO cooks VALUES(0000001, 'Jack', 4, 0000001),
                        (0000002, 'Vergil', 8, NULL);
insert into cooks (cook_id, name, work_hours, csuper_id) values (5200448, 'Had', 9, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (3842508, 'Harlene', 2, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (9883049, 'Kimball', 6, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (3808199, 'Tome', 2, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (7359367, 'Boniface', 2, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (2699947, 'Daile', 10, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (4799816, 'Opaline', 4, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (1094586, 'Bendicty', 8, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (3663174, 'Ignacio', 7, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (2717692, 'Bald', 2, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (1936084, 'Bernice', 6, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (2866794, 'Dionisio', 1, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (4317142, 'Leola', 8, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (0307542, 'Bettye', 1, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (1294139, 'Dalila', 8, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (3705618, 'Martynne', 4, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (8326427, 'Elianora', 9, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (6276253, 'Clarisse', 3, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (2308846, 'Locke', 10, 0000002);
insert into cooks (cook_id, name, work_hours, csuper_id) values (9249643, 'Phineas', 4, 0000002);


CREATE TABLE menu_item (
    name varchar(40) PRIMARY KEY NOT NULL,
    price DECIMAL NOT NULL,
    details LONGTEXT NOT NULL
);

INSERT INTO menu_item VALUES('Steak', 40.00, 'Steak info'),
                            ('Pasta', 18.00, 'Pasta info'),
                            ('Fried Rice', 10.50, 'Fried Rice info'),
                            ('BBQ Chicken', 21.00, 'BBQ Chicken info'),
                            ('Wonton Soup', 15.00, 'Wonton Soup info'),
                            ('Egg Soup', 16.00, 'Egg Soup info'),
                            ('Soup Noodles', 17.00, 'Soup Noodles info');

CREATE TABLE ingredients (
    ingredient_name varchar(40) PRIMARY KEY NOT NULL,
    stock INTEGER NOT NULL
);

INSERT INTO ingredients VALUES('Vegetable Oil', 10),
                              ('Butter', 5),
                              ('Shrimp', 231),
                              ('Tomato', 100),
                              ('Salt', 543),
                              ('Cheese', 24),
                              ('Eggs', 100),
                              ('Noodles', 100),
                              ('Chicken', 50),
                              ('Rice', 100);


CREATE TABLE customer_menu (
    id INT AUTO_INCREMENT NOT NULL,
    cust_id char(6) NOT NULL,
    menu_name varchar(40) NOT NULL,
    fulfilled BOOLEAN NOT NULL DEFAULT FALSE,
    served BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id, cust_id, menu_name ),
    CONSTRAINT fk_cust_menu_1
        FOREIGN KEY (cust_id) REFERENCES customers (cust_id),
    CONSTRAINT fk_cust_menu_2
        FOREIGN KEY (menu_name) REFERENCES menu_item (name)
);

INSERT INTO customer_menu (cust_id, menu_name, fulfilled, served)
VALUES(12345, 'Steak', false, false), (12345, 'Pasta', false, false);

CREATE TABLE waiters_menu (
    waiter_id char(6) NOT NULL,
    menu_name varchar(40) NOT NULL,
    PRIMARY KEY ( waiter_id, menu_name ),
    CONSTRAINT fk_waiters_menu_1
        FOREIGN KEY (waiter_id) REFERENCES waiters (waiter_id),
    CONSTRAINT fk_waiters_menu_2
        FOREIGN KEY (menu_name) REFERENCES menu_item (name)
);

INSERT INTO waiters_menu VALUES(123456, 'Steak'),
                               (123457, 'Pasta');

CREATE TABLE cooks_menu (
    cook_id char(7) NOT NULL,
    menu_name varchar(40) NOT NULL,
    PRIMARY KEY ( cook_id, menu_name ),
    CONSTRAINT fk_cooks_menu_1
        FOREIGN KEY (cook_id) REFERENCES cooks (cook_id),
    CONSTRAINT fk_cooks_menu_2
        FOREIGN KEY (menu_name) REFERENCES menu_item (name)
);

INSERT INTO cooks_menu VALUES(0000001, 'Steak'),
                             (0000002, 'Pasta'),
                             (0000001, 'Fried Rice'),
                             (0000002, 'BBQ Chicken');

CREATE TABLE cooks_waiters (
    waiter_id char(6) NOT NULL,
    cook_id char(7) NOT NULL,
    PRIMARY KEY ( waiter_id, cook_id ),
    order_details LONGTEXT NOT NULL,
    CONSTRAINT fk_cooks_waiters_1
        FOREIGN KEY (cook_id) REFERENCES cooks (cook_id),
    CONSTRAINT fk_cooks_waiters_2
        FOREIGN KEY (waiter_id) REFERENCES waiters (waiter_id)
);

INSERT INTO cooks_waiters VALUES(123456, 0000001, 'Order details'),
                                (123457, 0000002, 'Order details');

CREATE TABLE ingre_menu (
    ingredient_name varchar(40) NOT NULL,
    menu_name varchar(40) NOT NULL,
    PRIMARY KEY ( ingredient_name, menu_name ),
    amount DECIMAL NOT NULL,
    CONSTRAINT fk_ingre_menu_1
        FOREIGN KEY (ingredient_name) REFERENCES ingredients (ingredient_name),
    CONSTRAINT fk_ingre_menu_2
        FOREIGN KEY (menu_name) REFERENCES menu_item (name)
);

INSERT INTO ingre_menu VALUES('Vegetable Oil', 'Pasta', 3.4),
                             ('Butter', 'Steak', 2.0),
                             ('Salt', 'Steak', 1.0),
                             ('Shrimp', 'Pasta', 4.0),
                             ('Tomato', 'Pasta', 4.1),
                             ('Cheese', 'Pasta', 1.1),
                             ('Rice', 'Fried Rice', 1.0),
                             ('Tomato', 'Fried Rice', 1.0),
                             ('Chicken', 'BBQ Chicken', 1.0),
                             ('Eggs', 'Egg Soup', 1.0);
