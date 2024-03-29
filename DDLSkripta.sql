-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at        2024-01-15 011517 CET
--   site      Oracle Database 11g
--   type      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE aktivnost (
    akt_sif              INTEGER NOT NULL,
    tipaktivnosti_id_tip INTEGER NOT NULL
);

CREATE UNIQUE INDEX aktivnost__idx ON
    aktivnost (
        tipaktivnosti_id_tip
    ASC );

ALTER TABLE aktivnost ADD CONSTRAINT aktivnost_pk PRIMARY KEY ( akt_sif,
                                                                tipaktivnosti_id_tip );

CREATE TABLE biblioteka (
    pr_sif   INTEGER NOT NULL,
    adr_bibl VARCHAR2(20 CHAR),
    naz_bibl VARCHAR2(30 CHAR)
);

ALTER TABLE biblioteka ADD CONSTRAINT biblioteka_pk PRIMARY KEY ( pr_sif );

CREATE TABLE bibliotekar (
    zap_sif INTEGER NOT NULL,
    isk     INTEGER
);

ALTER TABLE bibliotekar ADD CONSTRAINT bibliotekar_pk PRIMARY KEY ( zap_sif );

CREATE TABLE clan (
    cl_sif      INTEGER NOT NULL,
    br_don      INTEGER,
    br_uk_bod   INTEGER,
    clan_cl_sif INTEGER NOT NULL
);

ALTER TABLE clan ADD CONSTRAINT clan_pk PRIMARY KEY ( cl_sif );

CREATE TABLE clanskakartica (
    kar_sif     INTEGER NOT NULL,
    br_bod      INTEGER,
    dat_izd     DATE,
    clan_cl_sif INTEGER NOT NULL
);

CREATE UNIQUE INDEX clanskakartica__idx ON
    clanskakartica (
        clan_cl_sif
    ASC );

ALTER TABLE clanskakartica ADD CONSTRAINT clanskakartica_pk PRIMARY KEY ( kar_sif,
                                                                          clan_cl_sif );

CREATE TABLE ima (
    pr_sif   INTEGER NOT NULL,
    sekc_sif INTEGER NOT NULL
);

ALTER TABLE ima ADD CONSTRAINT ima_pk PRIMARY KEY ( pr_sif,
                                                    sekc_sif );

CREATE TABLE izdavanje (
    dat_izd             DATE,
    bibliotekar_zap_sif INTEGER NOT NULL,
    knjiga_sc_knj       INTEGER NOT NULL
);



ALTER TABLE izdavanje ADD CONSTRAINT izdavanje_pk PRIMARY KEY (bibliotekar_zap_sif, knjiga_sc_knj);

CREATE TABLE izlagac (
    zap_sif INTEGER NOT NULL,
    spec    VARCHAR2(16 CHAR)
);

ALTER TABLE izlagac ADD CONSTRAINT izlagac_pk PRIMARY KEY ( zap_sif );

CREATE TABLE klub (
    kl_sif      INTEGER NOT NULL,
    pred_kl     VARCHAR2(30 CHAR),
    tip_kl      VARCHAR2(30 CHAR),
    soba_pr_sif INTEGER
);

ALTER TABLE klub ADD CONSTRAINT klub_pk PRIMARY KEY ( kl_sif );

CREATE TABLE knjiga (
    sc_knj  INTEGER NOT NULL,
    zanr    VARCHAR2(30 CHAR),
    ime_pis VARCHAR2(30 CHAR),
    god_izd INTEGER,
    nasl    VARCHAR2(30 CHAR),
    dost    VARCHAR2(30 CHAR)
);

ALTER TABLE knjiga ADD CONSTRAINT knjiga_pk PRIMARY KEY ( sc_knj );

CREATE TABLE koristi (
    id_tip INTEGER NOT NULL,
    pr_sif INTEGER NOT NULL
);

ALTER TABLE koristi ADD CONSTRAINT koristiv1_pk PRIMARY KEY ( id_tip,
                                                              pr_sif );

CREATE TABLE nadgleda (
    zap_sif INTEGER NOT NULL,
    akt_sif INTEGER NOT NULL,
    id_tip  INTEGER NOT NULL
);

ALTER TABLE nadgleda
    ADD CONSTRAINT nadgleda_pk PRIMARY KEY ( zap_sif,
                                             akt_sif,
                                             id_tip );

CREATE TABLE poseduje (
    klub_kl_sif INTEGER NOT NULL,
    clan_cl_sif INTEGER NOT NULL
);

ALTER TABLE poseduje ADD CONSTRAINT poseduje_pk PRIMARY KEY ( klub_kl_sif,
                                                              clan_cl_sif );

CREATE TABLE prostor (
    pr_sif INTEGER NOT NULL,
    tip_pr VARCHAR2(20)
);

ALTER TABLE prostor
    ADD CHECK ( tip_pr IN ( 'BIBLIOTEKA', 'SOBA' ) );

ALTER TABLE prostor ADD CONSTRAINT prostor_pk PRIMARY KEY ( pr_sif );

CREATE TABLE realizacija (
    real_sif                       INTEGER NOT NULL,
    dat_poc                        DATE,
    dat_traj                       DATE,
    br_bod                         INTEGER,
    komentar                       VARCHAR2(20 CHAR),
    aktivnost_akt_sif              INTEGER NOT NULL,
    aktivnost_tipaktivnosti_id_tip INTEGER NOT NULL
);

CREATE UNIQUE INDEX realizacija__idx ON
    realizacija (
        aktivnost_akt_sif
    ASC,
        aktivnost_tipaktivnosti_id_tip
    ASC );

ALTER TABLE realizacija ADD CONSTRAINT realizacija_pk PRIMARY KEY ( real_sif );

CREATE TABLE rukovodilac (
    zap_sif INTEGER NOT NULL,
    sek     VARCHAR2(10 CHAR)
);

ALTER TABLE rukovodilac ADD CONSTRAINT rukovodilac_pk PRIMARY KEY ( zap_sif );

CREATE TABLE sadrzi (
    knjiga_sc_knj    INTEGER NOT NULL,
    sekcija_sekc_sif INTEGER NOT NULL
);

ALTER TABLE sadrzi ADD CONSTRAINT relation_6_pk PRIMARY KEY ( knjiga_sc_knj,
                                                              sekcija_sekc_sif );

CREATE TABLE sekcija (
    sekc_sif        INTEGER NOT NULL,
    zanr            VARCHAR2(30 CHAR),
    br_knj          INTEGER,
    izlagac_zap_sif INTEGER,
    klub_kl_sif     INTEGER
);

CREATE UNIQUE INDEX sekcija__idx ON
    sekcija (
        klub_kl_sif
    ASC );

ALTER TABLE sekcija ADD CONSTRAINT sekcija_pk PRIMARY KEY ( sekc_sif );

CREATE TABLE soba (
    pr_sif  INTEGER NOT NULL,
    br_sobe INTEGER,
    spr     INTEGER
);

ALTER TABLE soba ADD CONSTRAINT soba_pk PRIMARY KEY ( pr_sif );

CREATE TABLE superclan (
    sc_sif                         INTEGER,
    dat_poc                        DATE,
    rok_traj                       INTEGER,
    usl                            VARCHAR2(30 CHAR),
    tip_pr                         VARCHAR2(20 CHAR),
    ucestvuje_realizacija_real_sif INTEGER NOT NULL,
    ucestvuje_clan_cl_sif          INTEGER NOT NULL
);

CREATE TABLE tipaktivnosti (
    id_tip  INTEGER NOT NULL,
    naz_tip VARCHAR2(20 CHAR),
    opis    VARCHAR2(30 CHAR)
);

ALTER TABLE tipaktivnosti ADD CONSTRAINT tipaktivnosti_pk PRIMARY KEY ( id_tip );

CREATE TABLE ucestvuje (
    realizacija_real_sif INTEGER NOT NULL,
    clan_cl_sif          INTEGER NOT NULL
);

ALTER TABLE ucestvuje ADD CONSTRAINT ucestvuje_pk PRIMARY KEY ( realizacija_real_sif,
                                                                clan_cl_sif );

CREATE TABLE zaposleni (
    zap_sif INTEGER NOT NULL,
    zan     VARCHAR2(20) NOT NULL,
    ime     VARCHAR2(10 CHAR) NOT NULL,
    prz     VARCHAR2(16 CHAR) NOT NULL
);

ALTER TABLE zaposleni
    ADD CHECK ( zan IN ( 'Bibliotekar', 'Izlagac', 'Rukovodilac' ) );

ALTER TABLE zaposleni ADD CONSTRAINT zaposleni_pk PRIMARY KEY ( zap_sif );

ALTER TABLE aktivnost
    ADD CONSTRAINT aktivnost_tipaktivnosti_fk FOREIGN KEY ( tipaktivnosti_id_tip )
        REFERENCES tipaktivnosti ( id_tip );

ALTER TABLE biblioteka
    ADD CONSTRAINT biblioteka_prostor_fk FOREIGN KEY ( pr_sif )
        REFERENCES prostor ( pr_sif );

ALTER TABLE bibliotekar
    ADD CONSTRAINT bibliotekar_zaposleni_fk FOREIGN KEY ( zap_sif )
        REFERENCES zaposleni ( zap_sif );

ALTER TABLE clan
    ADD CONSTRAINT clan_clan_fk FOREIGN KEY ( clan_cl_sif )
        REFERENCES clan ( cl_sif );

ALTER TABLE clanskakartica
    ADD CONSTRAINT clanskakartica_clan_fk FOREIGN KEY ( clan_cl_sif )
        REFERENCES clan ( cl_sif );

ALTER TABLE ima
    ADD CONSTRAINT ima_biblioteka_fk FOREIGN KEY ( pr_sif )
        REFERENCES biblioteka ( pr_sif );

ALTER TABLE ima
    ADD CONSTRAINT ima_sekcija_fk FOREIGN KEY ( sekc_sif )
        REFERENCES sekcija ( sekc_sif );

ALTER TABLE izdavanje
    ADD CONSTRAINT izdavanje_bibliotekar_fk FOREIGN KEY ( bibliotekar_zap_sif )
        REFERENCES bibliotekar ( zap_sif );

ALTER TABLE izdavanje
    ADD CONSTRAINT izdavanje_knjiga_fk FOREIGN KEY ( knjiga_sc_knj )
        REFERENCES knjiga ( sc_knj );

ALTER TABLE izlagac
    ADD CONSTRAINT izlagac_zaposleni_fk FOREIGN KEY ( zap_sif )
        REFERENCES zaposleni ( zap_sif );

ALTER TABLE klub
    ADD CONSTRAINT klub_soba_fk FOREIGN KEY ( soba_pr_sif )
        REFERENCES soba ( pr_sif );

ALTER TABLE koristi
    ADD CONSTRAINT koristiv1_soba_fk FOREIGN KEY ( pr_sif )
        REFERENCES soba ( pr_sif );

ALTER TABLE koristi
    ADD CONSTRAINT koristiv1_tipaktivnosti_fk FOREIGN KEY ( id_tip )
        REFERENCES tipaktivnosti ( id_tip );

ALTER TABLE nadgleda
    ADD CONSTRAINT nadgleda_aktivnost_fk FOREIGN KEY ( akt_sif,
                                                       id_tip )
        REFERENCES aktivnost ( akt_sif,
                               tipaktivnosti_id_tip );

ALTER TABLE nadgleda
    ADD CONSTRAINT nadgleda_rukovodilac_fk FOREIGN KEY ( zap_sif )
        REFERENCES rukovodilac ( zap_sif );

ALTER TABLE poseduje
    ADD CONSTRAINT poseduje_clan_fk FOREIGN KEY ( clan_cl_sif )
        REFERENCES clan ( cl_sif );

ALTER TABLE poseduje
    ADD CONSTRAINT poseduje_klub_fk FOREIGN KEY ( klub_kl_sif )
        REFERENCES klub ( kl_sif );

ALTER TABLE realizacija
    ADD CONSTRAINT realizacija_aktivnost_fk FOREIGN KEY ( aktivnost_akt_sif,
                                                          aktivnost_tipaktivnosti_id_tip )
        REFERENCES aktivnost ( akt_sif,
                               tipaktivnosti_id_tip );

ALTER TABLE sadrzi
    ADD CONSTRAINT relation_6_knjiga_fk FOREIGN KEY ( knjiga_sc_knj )
        REFERENCES knjiga ( sc_knj );

ALTER TABLE sadrzi
    ADD CONSTRAINT relation_6_sekcija_fk FOREIGN KEY ( sekcija_sekc_sif )
        REFERENCES sekcija ( sekc_sif );

ALTER TABLE rukovodilac
    ADD CONSTRAINT rukovodilac_zaposleni_fk FOREIGN KEY ( zap_sif )
        REFERENCES zaposleni ( zap_sif );

ALTER TABLE sekcija
    ADD CONSTRAINT sekcija_izlagac_fk FOREIGN KEY ( izlagac_zap_sif )
        REFERENCES izlagac ( zap_sif );

ALTER TABLE sekcija
    ADD CONSTRAINT sekcija_klub_fk FOREIGN KEY ( klub_kl_sif )
        REFERENCES klub ( kl_sif );

ALTER TABLE soba
    ADD CONSTRAINT soba_prostor_fk FOREIGN KEY ( pr_sif )
        REFERENCES prostor ( pr_sif );

ALTER TABLE superclan
    ADD CONSTRAINT superclan_ucestvuje_fk FOREIGN KEY ( ucestvuje_realizacija_real_sif,
                                                        ucestvuje_clan_cl_sif )
        REFERENCES ucestvuje ( realizacija_real_sif,
                               clan_cl_sif );

ALTER TABLE ucestvuje
    ADD CONSTRAINT ucestvuje_clan_fk FOREIGN KEY ( clan_cl_sif )
        REFERENCES clan ( cl_sif );

ALTER TABLE ucestvuje
    ADD CONSTRAINT ucestvuje_realizacija_fk FOREIGN KEY ( realizacija_real_sif )
        REFERENCES realizacija ( real_sif );



-- Oracle SQL Developer Data Modeler Summary Report 
-- 
-- CREATE TABLE                            23
-- CREATE INDEX                             5
-- ALTER TABLE                             51
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           5
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
