CREATE DATABASE Wontons;

USE Wontons;

GRANT ALL PRIVILEGES on Wontons.* to 'webapp'@'%';
flush PRIVILEGES;

CREATE TABLE tables (
    table_num char(3) PRIMARY KEY NOT NULL,
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

INSERT INTO tables VALUES(001, FALSE, 6), (002, TRUE, 4);

INSERT INTO waiters VALUES(123457, 4, 'Joshua', 123457),
(123456, 3, 'Angel', 123457);

INSERT INTO customers VALUES(12345, 'Joseph', '2022-11-18 22:23:12',
                            123456, 001, 100, TRUE),
                          (12346, 'Ethan', '2022-11-18 22:23:13',
                            123457, 002, 100, FALSE);


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

CREATE TABLE menu_item (
    name varchar(40) PRIMARY KEY NOT NULL,
    price DECIMAL NOT NULL,
    details LONGTEXT NOT NULL
);

INSERT INTO menu_item VALUES('Steak', 40.00, 'Steak info'),
                            ('Pasta', 18.00, 'Pasta info');

CREATE TABLE ingredients (
    ingredient_name varchar(40) PRIMARY KEY NOT NULL,
    stock INTEGER NOT NULL
);

INSERT INTO ingredients VALUES('Vegetable Oil', 10),
                              ('Butter', 5);


CREATE TABLE customer_menu (
    cust_id char(6) NOT NULL,
    menu_name varchar(40) NOT NULL,
    PRIMARY KEY ( cust_id, menu_name ),
    CONSTRAINT fk_cust_menu_1
        FOREIGN KEY (cust_id) REFERENCES customers (cust_id),
    CONSTRAINT fk_cust_menu_2
        FOREIGN KEY (menu_name) REFERENCES menu_item (name)
);

INSERT INTO customer_menu VALUES(12345, 'Steak'),
                                (12345, 'Pasta');

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
                             (0000002, 'Pasta');

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
                             ('Butter', 'Steak', 2.0);
