== AUFGABE 1

DROP IF EXISTS klausur_db;
CREATE DATABASE klausur_db;
USE klausur_db;

CREATE TABLE kunde(
    id_kunde int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(200),
    vorname varchar(200),
    geburtsdatum date,
    geschlecht char(1)
);

CREATE TABLE auftrag(
    id_auftrag int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_kunde int NOT NULL,
    datum date,
    auftragssumme decimal(12,2),
    CONSTRAINT fk_kunde FOREIGN KEY(id_kunde) REFERENCES kunde(id_Kunde) ON DELETE CASCADE 
);
CREATE INDEX ifk_kunde ON auftrag(id_kunde);

CREATE TABLE auftrag_buch(
    id_auftrag int NOT NULL,
    id_buch int NOT NULL,
    PRIMARY KEY(id_auftrag, id_buch),
    CONSTRAINT fk_auftrag FOREIGN KEY(id_auftrag) REFERENCES auftrag(id_auftrag),
    CONSTRAINT fk_buch FOREIGN KEY(id_buch) REFERENCES buch(id_buch) ON DELETE RESTRICT
);

CREATE TABLE buch(
    id_buch int NOT NULL AUTP INCREMENT PRIMARY KEY,
    isbn varchar(13),
    titel varchar(200),
    autor varchar(200)
);


== AUFGABE 2

a. 
SELECT name, vorname FROM kunde ORDER BY name ASC;

b.
SELECT datum, auftragssumme, name, vorname FROM auftrag LEFT JOIN kunde ON kunde.kunde_id = auftrag.kunde_id;

c.
(SELECT name, vorname, kunde_id FROM kunde LEFT JOIN auftrag ORDER BY auftragssumme DESC LIMIT 1)
UNION
(SELECT name, vorname, kunde_id FROM kunde LEFT JOIN auftrag ORDER BY auftragssumme ASC LIMIT 1)

d.
SELECT isbn, titel, autor FROM buch NATURAL JOIN auftrag_buch ON buch.id_buch = auftrag_buch.buch_id WHERE id_auftrag is NULL;

e.
SELECT DISTINCT name, vorname, kunde.id_kunde FROM kunde LEFT JOIN auftrag ON kunde.id_kunde = auftrag.id_kunde 
WHERE auftragssumme > 500 AND auftragssumme > (SELECT avg(auftragssumme) FROM auftrag);

f.
SELECT name, vorname, id_kunde, ifnull(count(id_auftrag),0) FROM kunde LEFT JOIN auftrag ON kunde.id_kunde = auftrag.id_kunde;


== AUFGABE 3

DELIMITER $$
CREATE FUNCTION aufgabe3(string1 varchar(200), string2 varchar(200))
RETURN varchar(401)
BEGIN
RETURN concat(UPPER(left(string1,1)), substring(string1,2)," ", UPPER(left(string2),1),substring(string2,2));
END$$
DELIMITER ;
SELECT aufgabe3(name, vorname) FROM kunde;



CREATE TRIGGER update_log_trigger 
ON kunde
AFTER UPDATE
BEGIN
    IF(OLD.name <> NEW.name) THEN 
    INSERT INTO pKunde(id_kunde, alt_name, neu_name, benutzer, datum)
    VALUES(NEW.id_kunde, OLD.name, NEW.name, CURRENT_USER, CURRENT_TIMESTAMP)
END