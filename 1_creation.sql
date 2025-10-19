

CREATE TABLE Avion (
    Immatriculation VARCHAR(10) PRIMARY KEY,
    Modele VARCHAR(50),
    Capacite INT
);

CREATE TABLE Siege (
    NumSiege INT,
    Rangee VARCHAR(10),
    Immatriculation VARCHAR(10),
    PRIMARY KEY (NumSiege, Immatriculation),
    FOREIGN KEY (Immatriculation) REFERENCES Avion(Immatriculation)
);

CREATE TABLE Passager (
    IdPassager INT PRIMARY KEY,
    Nom_passager VARCHAR(50),
    Prenom_passager VARCHAR(50),
    DateNaissance_passager DATE,
    Nationalite_passager VARCHAR(30)
);

CREATE TABLE Baggage (
    IdBaggage INT PRIMARY KEY,
    Poids DECIMAL(5,2),
    Type VARCHAR(30),
    IdPassager INT,
    FOREIGN KEY (IdPassager) REFERENCES Passager(IdPassager)
);

CREATE TABLE Aeroport (
    Code_IATA CHAR(3) PRIMARY KEY,
    Nom_Aero VARCHAR(100),
    Pays_Aero VARCHAR(50),
    Ville_Aero VARCHAR(50)
);

CREATE TABLE Vol (
    NumVol INT PRIMARY KEY,
    Date_Depart DATE,
    Heure_Depart TIME,
    Heure_Arrivee TIME,
    Aeroport_Depart VARCHAR(50),
    Aeroport_Arrivee VARCHAR(50),
    Immatriculation VARCHAR(50),
    FOREIGN KEY (Aeroport_Depart) REFERENCES Aeroport(Code_IATA),
    FOREIGN KEY (Aeroport_Arrivee) REFERENCES Aeroport(Code_IATA),
    FOREIGN KEY (Immatriculation) REFERENCES Avion(Immatriculation)
);

CREATE TABLE Reservation (
    CodeReservation INT PRIMARY KEY,
    DateReservation DATE,
    HeureReservation TIME,
    EmailContact VARCHAR(100),
    TelephoneContact VARCHAR(20),
    IdPassager INT,
    NumVol INT,
    FOREIGN KEY (IdPassager) REFERENCES Passager(IdPassager),
    FOREIGN KEY (NumVol) REFERENCES Vol(NumVol)
);

CREATE TABLE Paiement (
    IdPaiement INT PRIMARY KEY,
    DatePaiement DATE,
    Montant DECIMAL(10),
    ModePaiement VARCHAR(30),
    CodeReservation INT,
    FOREIGN KEY (CodeReservation) REFERENCES Reservation(CodeReservation)
);

CREATE TABLE Reservation_Option (
    IdOption INT PRIMARY KEY,
    Libelle VARCHAR(50),
    PrixUnitaire DECIMAL(10)
);

CREATE TABLE ReservationInclutOption (
    CodeReservation INT,
    IdOption INT,
    PRIMARY KEY (CodeReservation, IdOption),
    FOREIGN KEY (CodeReservation) REFERENCES Reservation(CodeReservation),
    FOREIGN KEY (IdOption) REFERENCES Reservation_Option(IdOption)
);
CREATE TABLE Reservation_Vol (
  CodeReservation INT NOT NULL,
  NumVol INT NOT NULL,
  PRIMARY KEY (CodeReservation, NumVol),
  FOREIGN KEY (CodeReservation) REFERENCES Reservation(CodeReservation),
  FOREIGN KEY (NumVol) REFERENCES Vol(NumVol)
);

