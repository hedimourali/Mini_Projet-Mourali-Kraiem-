 -- Contrainte : le poids d’un bagage doit être > 0
ALTER TABLE Baggage
ADD CONSTRAINT chk_poids_bagage CHECK (Poids > 0);

-- Contrainte : la capacité d’un avion doit être > 0
ALTER TABLE Avion
ADD CONSTRAINT chk_capacite_avion CHECK (Capacite > 0);

-- Contrainte : le montant du paiement doit être positif
ALTER TABLE Paiement
ADD CONSTRAINT chk_montant_paiement CHECK (Montant >= 0);

ALTER TABLE Vol
  MODIFY Aeroport_Depart  CHAR(3),
  MODIFY Aeroport_Arrivee CHAR(3);

/* Immatriculation -> VARCHAR(10) comme Avion(Immatriculation) */
ALTER TABLE Vol
  MODIFY Immatriculation VARCHAR(10);

/* === Rendre non-nuls les champs métier essentiels === */
ALTER TABLE Avion
  MODIFY Modele   VARCHAR(50) NOT NULL,
  MODIFY Capacite INT         NOT NULL;

ALTER TABLE Siege
  MODIFY Rangee          VARCHAR(10) NOT NULL,
  MODIFY Immatriculation VARCHAR(10) NOT NULL;

ALTER TABLE Passager
  MODIFY Nom_passager              VARCHAR(50) NOT NULL,
  MODIFY Prenom_passager           VARCHAR(50) NOT NULL,
  MODIFY DateNaissance_passager    DATE        NOT NULL,
  MODIFY Nationalite_passager      VARCHAR(30) NOT NULL;

ALTER TABLE Baggage
  MODIFY Poids   DECIMAL(5,2) NOT NULL,
  MODIFY Type    VARCHAR(30)  NOT NULL,
  MODIFY IdPassager INT       NOT NULL;

ALTER TABLE Aeroport
  MODIFY Nom_Aero   VARCHAR(100) NOT NULL,
  MODIFY Pays_Aero  VARCHAR(50)  NOT NULL,
  MODIFY Ville_Aero VARCHAR(50)  NOT NULL;

ALTER TABLE Vol
  MODIFY Date_Depart   DATE NOT NULL,
  MODIFY Heure_Depart  TIME NOT NULL,
  MODIFY Heure_Arrivee TIME NOT NULL;

ALTER TABLE Reservation
  MODIFY DateReservation  DATE NOT NULL,
  MODIFY HeureReservation TIME NOT NULL,
  MODIFY EmailContact     VARCHAR(100) NOT NULL,
  MODIFY TelephoneContact VARCHAR(20)  NOT NULL,
  MODIFY IdPassager       INT NOT NULL,
  MODIFY NumVol           INT NOT NULL;

ALTER TABLE Paiement
  MODIFY DatePaiement   DATE NOT NULL,
  MODIFY Montant        DECIMAL(10,2) NOT NULL,
  MODIFY ModePaiement   VARCHAR(30) NOT NULL,
  MODIFY CodeReservation INT NOT NULL;

ALTER TABLE Reservation_Option
  MODIFY Libelle      VARCHAR(50)  NOT NULL,
  MODIFY PrixUnitaire DECIMAL(10,2) NOT NULL;

ALTER TABLE ReservationInclutOption
  MODIFY CodeReservation INT NOT NULL,
  MODIFY IdOption        INT NOT NULL;

ALTER TABLE Reservation_Vol
  MODIFY CodeReservation INT NOT NULL,
  MODIFY NumVol          INT NOT NULL;
