
-- DROP TABLE `final_project`.Systeminfo;

CREATE TABLE `final_project`.Systeminfo (
	ID char(10) NOT null,
	pass varchar(512) NOT null,
	register_date date,
	register_time time,
	PRIMARY KEY (ID)
)


-- DROP TABLE `final_project`.personal_info;

CREATE TABLE `final_project`.personal_info (
    user_id char(10) NOT null,
	name varchar(512),
	last_name varchar(512),
	gender varchar(10),
	b_date date,
	has_disease varchar(5),
	PRIMARY KEY (user_id),
	FOREIGN KEY(user_id) REFERENCES Systeminfo(ID)
    	ON DELETE CASCADE
    	ON UPDATE CASCADE
)



-- DROP TABLE `final_project`.nurse;

CREATE TABLE `final_project`.nurse (
    ID char(10) NOT null,
    nurse_ID char(8) NOT null,
    nurse_level varchar(20),
	PRIMARY KEY (nurse_ID),
	FOREIGN KEY(ID) REFERENCES personal_info(user_id)
    	ON DELETE CASCADE
    	ON UPDATE CASCADE
)


-- DROP TABLE `final_project`.doctor;
-- 
CREATE TABLE `final_project`.doctor (
    ID char(10) NOT null,
    doc_ID char(5) NOT null,
	PRIMARY KEY (doc_ID),
	FOREIGN KEY(ID) REFERENCES personal_info(user_id)
    	ON DELETE CASCADE
    	ON UPDATE CASCADE
)

-- DROP TABLE `final_project`.brand;

CREATE TABLE `final_project`.brand (
    name varchar(255),
    brand_dose_num integer,
    days integer,
    doc_ID char(5) NOT null,
    PRIMARY KEY(name),
    foreign key (doc_ID) references doctor(doc_ID)
        ON DELETE CASCADE
        ON UPDATE cascade
)


-- DROP TABLE `final_project`.vial;

CREATE TABLE `final_project`.vial (
    serial_num varchar(255),
    brand_name varchar(255),
    p_date date,
    dose_num integer,
    PRIMARY KEY(serial_num),
    FOREIGN KEY(brand_name) REFERENCES brand(name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
-- DROP TABLE `final_project`.vaccination_center;

CREATE TABLE `final_project`.vaccination_center (
    name varchar(255),
    address varchar(511),
    PRIMARY KEY(name)
)

-- DROP TABLE `final_project`.vaccination_history;

CREATE TABLE `final_project`.vaccination_history (
    person_ID char(10),
    vaccinator_ID char(8),
    vaccination_center_name varchar(255),
    vial_serial varchar(255),
    vaccination_date date,
    rate integer,
    FOREIGN KEY(person_ID) REFERENCES personal_info(user_id)
	    ON DELETE CASCADE
	    ON UPDATE CASCADE,
    FOREIGN KEY(vaccinator_ID) REFERENCES nurse(nurse_ID)
	    ON DELETE CASCADE
	    ON UPDATE CASCADE,
    FOREIGN KEY(vaccination_center_name) REFERENCES vaccination_center(name),
    FOREIGN KEY(vial_serial) REFERENCES vial(serial_num),
    PRIMARY KEY(person_ID, vaccinator_ID, vaccination_center_name, vial_serial) 
)


-- DROP TABLE `final_project`.login_info;
CREATE TABLE `final_project`.login_info (
    user_id char(10),
    login_time time,
    primary key(user_id),
    foreign key (user_id) references personal_info (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)







