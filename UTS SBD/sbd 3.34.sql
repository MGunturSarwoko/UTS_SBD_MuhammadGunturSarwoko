CREATE TABLE author 
    ( 
     email     VARCHAR  NOT NULL , 
     lastname  VARCHAR  NOT NULL , 
     firstname VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE author 
    ADD CONSTRAINT author_PK PRIMARY KEY ( email ) ;

CREATE TABLE paper 
    ( 
     paper_id     NUMERIC  NOT NULL , 
     title        VARCHAR  NOT NULL , 
     file_name    VARCHAR  NOT NULL , 
     author_email VARCHAR  NOT NULL 
    ) 
;

ALTER TABLE paper 
    ADD CONSTRAINT paper_PK PRIMARY KEY ( paper_id ) ;

CREATE TABLE paper_author 
    ( 
     author_email   VARCHAR  NOT NULL , 
     paper_paper_id NUMERIC  NOT NULL 
    ) 
;

ALTER TABLE paper_author 
    ADD CONSTRAINT paper_author_PK PRIMARY KEY ( author_email, paper_paper_id ) ;

CREATE TABLE review 
    ( 
     tm                   NUMERIC  NOT NULL , 
     kebaca               NUMERIC  NOT NULL , 
     origanality          NUMERIC  NOT NULL , 
     relevan              NUMERIC  NOT NULL , 
     rekomendasi          VARCHAR  NOT NULL , 
     coments_comite       TEXT , 
     komen_author         TEXT  NOT NULL , 
     paper_paper_id       NUMERIC  NOT NULL , 
     reviewer_reviewer_ID NUMERIC  NOT NULL 
    ) 
;

ALTER TABLE review 
    ADD CONSTRAINT review_PK PRIMARY KEY ( paper_paper_id ) ;

CREATE TABLE review_topic 
    ( 
     topic                VARCHAR  NOT NULL , 
     reviewer_reviewer_ID NUMERIC  NOT NULL 
    ) 
;

ALTER TABLE review_topic 
    ADD CONSTRAINT review_topic_PK PRIMARY KEY ( topic ) ;

CREATE TABLE reviewer 
    ( 
     phone       VARCHAR  NOT NULL , 
     affiliation VARCHAR  NOT NULL , 
     reviewer_ID NUMERIC  NOT NULL 
    ) 
;

ALTER TABLE reviewer 
    ADD CONSTRAINT reviewer_PK PRIMARY KEY ( reviewer_ID ) ;

ALTER TABLE paper_author 
    ADD CONSTRAINT paper_author_author_FK FOREIGN KEY 
    ( 
     author_email
    ) 
    REFERENCES author 
    ( 
     email
    ) 
;

ALTER TABLE paper 
    ADD CONSTRAINT paper_author_FK FOREIGN KEY 
    ( 
     author_email
    ) 
    REFERENCES author 
    ( 
     email
    ) 
;

ALTER TABLE paper_author 
    ADD CONSTRAINT paper_author_paper_FK FOREIGN KEY 
    ( 
     paper_paper_id
    ) 
    REFERENCES paper 
    ( 
     paper_id
    ) 
;

ALTER TABLE review 
    ADD CONSTRAINT review_paper_FK FOREIGN KEY 
    ( 
     paper_paper_id
    ) 
    REFERENCES paper 
    ( 
     paper_id
    ) 
;

ALTER TABLE review 
    ADD CONSTRAINT review_reviewer_FK FOREIGN KEY 
    ( 
     reviewer_reviewer_ID
    ) 
    REFERENCES reviewer 
    ( 
     reviewer_ID
    ) 
;

ALTER TABLE review_topic 
    ADD CONSTRAINT review_topic_reviewer_FK FOREIGN KEY 
    ( 
     reviewer_reviewer_ID
    ) 
    REFERENCES reviewer 
    ( 
     reviewer_ID
    ) 
;

CREATE SEQUENCE reviewer_reviewer_ID_SEQ 
START WITH 1 
    CACHE 1 ;

CREATE FUNCTION reviewer_reviewer_ID_TRG_FN() RETURNS TRIGGER AS $$
BEGIN 
    IF NEW.reviewer_ID IS NULL THEN
        NEW.reviewer_ID := nextval('reviewer_reviewer_ID_SEQ'); 
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER reviewer_reviewer_ID_TRG 
BEFORE INSERT ON reviewer 
FOR EACH ROW 
EXECUTE FUNCTION reviewer_reviewer_ID_TRG_FN();