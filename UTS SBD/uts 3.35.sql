CREATE TABLE air_plame_type 
    ( 
     tipe_nama VARCHAR  NOT NULL , 
     max_seats INTEGER  NOT NULL , 
     company   VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE air_plame_type 
    ADD CONSTRAINT air_plame_type_PK PRIMARY KEY ( tipe_nama ) ;

CREATE TABLE airplane 
    ( 
     airplane_id              INTEGER  NOT NULL , 
     total_bangku             INTEGER  NOT NULL , 
     air_plame_type_tipe_nama VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE airplane 
    ADD CONSTRAINT airplane_PK PRIMARY KEY ( airplane_id ) ;

CREATE TABLE airport 
    ( 
     code  VARCHAR  NOT NULL , 
     nama  VARCHAR  NOT NULL , 
     city  VARCHAR  NOT NULL , 
     state VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE airport 
    ADD CONSTRAINT airport_PK PRIMARY KEY ( code ) ;

CREATE TABLE can_land 
    ( 
     airport_code             VARCHAR  NOT NULL , 
     air_plame_type_tipe_nama VARCHAR  NOT NULL 
    ) 
;

CREATE TABLE fare 
    ( 
     fare_code          VARCHAR  NOT NULL , 
     amount             NUMERIC  NOT NULL , 
     restriction        VARCHAR  NOT NULL , 
     flight_nomor_fliht VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE fare 
    ADD CONSTRAINT fare_PK PRIMARY KEY ( fare_code ) ;

CREATE TABLE flight 
    ( 
     nomor_fliht VARCHAR  NOT NULL , 
     airline     VARCHAR  NOT NULL , 
     weekdays    VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE flight 
    ADD CONSTRAINT flight_PK PRIMARY KEY ( nomor_fliht ) ;

CREATE TABLE fliht_leg 
    ( 
     leg_no             INTEGER  NOT NULL , 
     jadwal_berangkat   VARCHAR  NOT NULL , 
     jadwal_datang      VARCHAR  NOT NULL , 
     airport_code       VARCHAR  NOT NULL , 
     airport_code2      VARCHAR  NOT NULL , 
     flight_nomor_fliht VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE fliht_leg 
    ADD CONSTRAINT fliht_leg_PK PRIMARY KEY ( leg_no ) ;

CREATE TABLE leg_instance 
    ( 
     leg_date             VARCHAR  NOT NULL , 
     avail_seats          NUMERIC  NOT NULL , 
     airplane_airplane_id INTEGER  NOT NULL , 
     fliht_leg_leg_no     INTEGER  NOT NULL 
    ) 
;

ALTER TABLE leg_instance 
    ADD CONSTRAINT leg_instance_PK PRIMARY KEY ( leg_date ) ;

CREATE TABLE reservasi 
    ( 
     seat_no               VARCHAR  NOT NULL , 
     customer_name         VARCHAR  NOT NULL , 
     customer_no           VARCHAR  NOT NULL , 
     leg_instance_leg_date VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE reservasi 
    ADD CONSTRAINT reservasi_PK PRIMARY KEY ( seat_no ) ;

ALTER TABLE airplane 
    ADD CONSTRAINT airplane_air_plame_type_FK FOREIGN KEY 
    ( 
     air_plame_type_tipe_nama
    ) 
    REFERENCES air_plame_type 
    ( 
     tipe_nama
    ) 
;

ALTER TABLE can_land 
    ADD CONSTRAINT can_land_air_plame_type_FK FOREIGN KEY 
    ( 
     air_plame_type_tipe_nama
    ) 
    REFERENCES air_plame_type 
    ( 
     tipe_nama
    ) 
;

ALTER TABLE can_land 
    ADD CONSTRAINT can_land_airport_FK FOREIGN KEY 
    ( 
     airport_code
    ) 
    REFERENCES airport 
    ( 
     code
    ) 
;

ALTER TABLE fare 
    ADD CONSTRAINT fare_flight_FK FOREIGN KEY 
    ( 
     flight_nomor_fliht
    ) 
    REFERENCES flight 
    ( 
     nomor_fliht
    ) 
;

ALTER TABLE fliht_leg 
    ADD CONSTRAINT fliht_leg_airport_FK FOREIGN KEY 
    ( 
     airport_code
    ) 
    REFERENCES airport 
    ( 
     code
    ) 
;

ALTER TABLE fliht_leg 
    ADD CONSTRAINT fliht_leg_airport_FKv2 FOREIGN KEY 
    ( 
     airport_code2
    ) 
    REFERENCES airport 
    ( 
     code
    ) 
;

ALTER TABLE fliht_leg 
    ADD CONSTRAINT fliht_leg_flight_FK FOREIGN KEY 
    ( 
     flight_nomor_fliht
    ) 
    REFERENCES flight 
    ( 
     nomor_fliht
    ) 
;

ALTER TABLE leg_instance 
    ADD CONSTRAINT leg_instance_airplane_FK FOREIGN KEY 
    ( 
     airplane_airplane_id
    ) 
    REFERENCES airplane 
    ( 
     airplane_id
    ) 
;

ALTER TABLE leg_instance 
    ADD CONSTRAINT leg_instance_fliht_leg_FK FOREIGN KEY 
    ( 
     fliht_leg_leg_no
    ) 
    REFERENCES fliht_leg 
    ( 
     leg_no
    ) 
;

ALTER TABLE reservasi 
    ADD CONSTRAINT reservasi_leg_instance_FK FOREIGN KEY 
    ( 
     leg_instance_leg_date
    ) 
    REFERENCES leg_instance 
    ( 
     leg_date
    ) 
;