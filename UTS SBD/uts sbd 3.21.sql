CREATE TABLE bill 
    ( 
     bill_id          NUMERIC  NOT NULL , 
     bill_name        VARCHAR (51)  NOT NULL , 
     date_of_vote     DATE  NOT NULL , 
     passed_or_failed VARCHAR (3) 
    ) 
;

ALTER TABLE bill 
    ADD CONSTRAINT bill_PK PRIMARY KEY ( bill_id ) ;

CREATE TABLE congress_person 
    ( 
     cong_id          NUMERIC  NOT NULL , 
     nama             VARCHAR (51)  NOT NULL , 
     distrik          NUMERIC  NOT NULL , 
     start_date       NUMERIC  NOT NULL , 
     party            VARCHAR (51)  NOT NULL , 
     State_nama_state VARCHAR (111)  NOT NULL 
    ) 
;

ALTER TABLE congress_person 
    ADD CONSTRAINT congress_person_PK PRIMARY KEY ( cong_id ) ;

CREATE TABLE sponsor 
    ( 
     congress_person_cong_id NUMERIC  NOT NULL , 
     bill_bill_id            NUMERIC  NOT NULL 
    ) 
;

ALTER TABLE sponsor 
    ADD CONSTRAINT sponsor_PK PRIMARY KEY ( congress_person_cong_id, bill_bill_id ) ;

CREATE TABLE State 
    ( 
     nama_state VARCHAR (111)  NOT NULL , 
     daerah     VARCHAR (111)  NOT NULL 
    ) 
;

ALTER TABLE State 
    ADD CONSTRAINT State_PK PRIMARY KEY ( nama_state ) ;

CREATE TABLE vote 
    ( 
     vote                    VARCHAR , 
     congress_person_cong_id NUMERIC  NOT NULL , 
     bill_bill_id            NUMERIC  NOT NULL 
    ) 
;

ALTER TABLE vote 
    ADD CONSTRAINT vote_PK PRIMARY KEY ( congress_person_cong_id, bill_bill_id ) ;

ALTER TABLE congress_person 
    ADD CONSTRAINT congress_person_State_FK FOREIGN KEY 
    ( 
     State_nama_state
    ) 
    REFERENCES State 
    ( 
     nama_state
    ) 
;

ALTER TABLE sponsor 
    ADD CONSTRAINT sponsor_bill_FK FOREIGN KEY 
    ( 
     bill_bill_id
    ) 
    REFERENCES bill 
    ( 
     bill_id
    ) 
;

ALTER TABLE sponsor 
    ADD CONSTRAINT sponsor_congress_person_FK FOREIGN KEY 
    ( 
     congress_person_cong_id
    ) 
    REFERENCES congress_person 
    ( 
     cong_id
    ) 
;

ALTER TABLE vote 
    ADD CONSTRAINT vote_bill_FK FOREIGN KEY 
    ( 
     bill_bill_id
    ) 
    REFERENCES bill 
    ( 
     bill_id
    ) 
;

ALTER TABLE vote 
    ADD CONSTRAINT vote_congress_person_FK FOREIGN KEY 
    ( 
     congress_person_cong_id
    ) 
    REFERENCES congress_person 
    ( 
     cong_id
    ) 
;