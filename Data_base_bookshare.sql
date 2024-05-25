-- Généré par Oracle SQL Developer Data Modeler 23.1.0.087.0806

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE emprunt (
    id_emprunt                 NUMBER NOT NULL,
    date_emprunt               VARCHAR2(30) NOT NULL 
    date_retour                VARCHAR2(20) NOT NULL,
    id_utilisateur             NUMBER(30) NOT NULL,
    livre_id                   NUMBER(30) NOT NULL,
    livre_id_livre             NUMBER(30) NOT NULL,
    utilisateur_id_utilisateur NUMBER NOT NULL
);

ALTER TABLE emprunt ADD CONSTRAINT emprunt_pk PRIMARY KEY ( id_emprunt );

--Insertion des données 
INSERT INTO emprunt (id_emprunt, date_emprunt, date_retour, utilisateur_id_utilisateur, livre_id_livre) VALUES 
(1, '2024-05-01', '2024-05-15', 1, 5),
(2, '2024-05-03', '2024-05-17', 2, 1),
(3, '2024-05-05', '2024-05-19', 3, 2),
(4, '2024-05-07', '2024-05-21', 4, 3),
(5, '2024-05-09', '2024-05-23', 5, 4),
(6, '2024-05-11', '2024-05-25', 6, 1),
(7, '2024-05-13', '2024-05-27', 1, 7),
(8, '2024-05-15', '2024-05-29', 2, 8),
(9, '2024-05-17', '2024-05-31', 3, 9),
(10, '2024-05-19', '2024-06-02', 4, 10);
COMMIT;

SELECT *
FROM emprunt;


CREATE TABLE historique (
    id_historique              NUMBER(30) NOT NULL,
    emprunt_id                 NUMBER(30) NOT NULL,
    utilisateur_id             NUMBER(30),
    utilisateur_id_utilisateur NUMBER NOT NULL
);

ALTER TABLE historique ADD CONSTRAINT historique_pk PRIMARY KEY ( id_historique );

--Insertion des données
INSERT INTO historique (id_historique, emprunt_id, utilisateur_id_utilisateur) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 1),
(8, 8, 2),
(9, 9, 3),
(10, 10, 4);
COMMIT;

SELECT *
FROM historique;



CREATE TABLE livre (
    id_livre                   NUMBER(30) NOT NULL,
    titre                      VARCHAR2(30) NOT NULL,
    auteur                     VARCHAR2(30),
    genre                      VARCHAR2(30),
    statut                     VARCHAR2(30), 
    utilisateur_id             NUMBER(30) NOT NULL,
    utilisateur_id_utilisateur NUMBER NOT NULL
);

ALTER TABLE livre ADD CONSTRAINT livre_pk PRIMARY KEY ( id_livre );




CREATE TABLE utilisateur (
    id_utilisateur NUMBER NOT NULL,
    nom            VARCHAR2(50) NOT NULL,
    email          VARCHAR2(20),
    mot_passe      NUMBER(20)
);

ALTER TABLE utilisateur ADD CONSTRAINT utilisateur_pk PRIMARY KEY ( id_utilisateur );




ALTER TABLE emprunt
    ADD CONSTRAINT emprunt_livre_fk FOREIGN KEY ( livre_id_livre )
        REFERENCES livre ( id_livre );

ALTER TABLE emprunt
    ADD CONSTRAINT emprunt_utilisateur_fk FOREIGN KEY ( utilisateur_id_utilisateur )
        REFERENCES utilisateur ( id_utilisateur );

ALTER TABLE historique
    ADD CONSTRAINT historique_utilisateur_fk FOREIGN KEY ( utilisateur_id_utilisateur )
        REFERENCES utilisateur ( id_utilisateur );

ALTER TABLE livre
    ADD CONSTRAINT livre_utilisateur_fk FOREIGN KEY ( utilisateur_id_utilisateur )
        REFERENCES utilisateur ( id_utilisateur );

-- Ceci va creer un URI sous le URL qui pourra etre utilise pour y activer les tables en mode REST
BEGIN
  ORDS.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'RESTSCOTT',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'bookshare',
    p_auto_rest_auth      => FALSE
  );
    
  COMMIT;
END;
/

-- Activation de la table hotel pour acces REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE, -- Default  { TRUE | FALSE }
    p_schema       => 'RESTSCOTT',
    p_object       => 'UTILISATEUR',
    p_object_type  => 'TABLE', -- Default  { TABLE | VIEW }
    p_object_alias => 'utilisateur'
  );
    
  COMMIT;
END;
/

-- Activation de la table personnel hotel pour acces REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE, -- Default  { TRUE | FALSE }
    p_schema       => 'RESTSCOTT',
    p_object       => 'LIVRE',
    p_object_type  => 'TABLE', -- Default  { TABLE | VIEW }
    p_object_alias => 'livre'
  );
    
  COMMIT;
END;
/

-- Activation de la table client pour acces REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE, -- Default  { TRUE | FALSE }
    p_schema       => 'RESTSCOTT',
    p_object       => 'EMPRUNT',
    p_object_type  => 'TABLE', -- Default  { TABLE | VIEW }
    p_object_alias => 'emprunt'
  );
    
  COMMIT;
END;
/

-- Activation de la table reservation pour acces REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE, -- Default  { TRUE | FALSE }
    p_schema       => 'RESTSCOTT',
    p_object       => 'HISTORIQUE',
    p_object_type  => 'TABLE', -- Default  { TABLE | VIEW }
    p_object_alias => 'historique'
  );
    
  COMMIT;
END;
/

-- Confirmation de l'activation du schema
SELECT *
FROM user_ords_schemas;

-- Confirmation de l'activation des tables pour REST
SELECT *
FROM   user_ords_enabled_objects;