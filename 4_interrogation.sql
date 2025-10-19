


SET @IATA_DEP = 'CDG';
SET @IATA_ARR = 'LHR';
SET @DATE_J   = '2025-06-01';





-- Routes desservies
SELECT DISTINCT CONCAT(Aeroport_Depart,'→',Aeroport_Arrivee) AS Route
FROM Vol
ORDER BY Route;

--  Vols “nuit” 
SELECT NumVol, Date_Depart, Heure_Depart, Heure_Arrivee,
       Aeroport_Depart, Aeroport_Arrivee
FROM Vol
WHERE Heure_Arrivee < Heure_Depart
ORDER BY Date_Depart, Heure_Depart;



--  Vols par jour
SELECT Date_Depart, COUNT(*) AS NbVols
FROM Vol
GROUP BY Date_Depart
ORDER BY Date_Depart;

--  Réservations par vol --------------------------------------------------------------------------------------------------
SELECT v.NumVol, COUNT(r.CodeReservation) AS NbReservations
FROM Vol v
LEFT JOIN Reservation r ON r.NumVol = v.NumVol
GROUP BY v.NumVol
ORDER BY NbReservations DESC;

--  CA mensuel par mode de paiement 
SELECT DATE_FORMAT(DatePaiement,'%Y-%m') AS Mois, ModePaiement,
       SUM(Montant) AS CA_EUR, COUNT(*) AS NbPaiements
FROM Paiement
WHERE YEAR(DatePaiement)=2025
GROUP BY DATE_FORMAT(DatePaiement,'%Y-%m'), ModePaiement
ORDER BY Mois, ModePaiement;



--  Réservation + passager + vol + aéroports
SELECT r.CodeReservation,
       p.Nom_passager, p.Prenom_passager,
       v.NumVol, v.Date_Depart, v.Heure_Depart, v.Heure_Arrivee,
       dep.Code_IATA AS Dep_IATA, dep.Ville_Aero AS Dep_Ville, dep.Pays_Aero AS Dep_Pays,
       arr.Code_IATA AS Arr_IATA, arr.Ville_Aero AS Arr_Ville, arr.Pays_Aero AS Arr_Pays
FROM Reservation r
JOIN Passager p   ON p.IdPassager   = r.IdPassager
JOIN Vol v        ON v.NumVol       = r.NumVol
JOIN Aeroport dep ON dep.Code_IATA  = v.Aeroport_Depart
JOIN Aeroport arr ON arr.Code_IATA  = v.Aeroport_Arrivee
ORDER BY r.CodeReservation
LIMIT 50;

--  Vols avec modèle et capacité
SELECT v.NumVol, v.Date_Depart, v.Heure_Depart,
       a.Immatriculation, a.Modele, a.Capacite
FROM Vol v
JOIN Avion a ON a.Immatriculation = v.Immatriculation
ORDER BY v.Date_Depart, v.Heure_Depart;

--  Somme des paiements de ses réservations-------------------------------------------------------
SELECT v.NumVol, SUM(pai.Montant) AS CA_vol
FROM Vol v
JOIN Reservation r ON r.NumVol = v.NumVol
JOIN Paiement pai  ON pai.CodeReservation = r.CodeReservation
GROUP BY v.NumVol
ORDER BY CA_vol DESC;

--  Top 10 routes par nb de vols 
SELECT CONCAT(dep.Code_IATA,'→',arr.Code_IATA) AS Route,
       CONCAT(dep.Ville_Aero,' (',dep.Pays_Aero,')') AS Depart,
       CONCAT(arr.Ville_Aero,' (',arr.Pays_Aero,')') AS Arrivee,
       COUNT(*) AS NbVols
FROM Vol v
JOIN Aeroport dep ON dep.Code_IATA = v.Aeroport_Depart
JOIN Aeroport arr ON arr.Code_IATA = v.Aeroport_Arrivee
GROUP BY dep.Code_IATA, arr.Code_IATA, Depart, Arrivee
ORDER BY NbVols DESC
LIMIT 10;


--  Passagers avec bagage > 20 kg 
SELECT DISTINCT p.IdPassager, p.Nom_passager, p.Prenom_passager
FROM Passager p
WHERE EXISTS (
  SELECT 1 FROM Baggage b
  WHERE b.IdPassager = p.IdPassager AND b.Poids > 20.00
)
ORDER BY p.Nom_passager, p.Prenom_passager;

-- Aéroports sans vols au départ 
SELECT a.Code_IATA, a.Nom_Aero, a.Ville_Aero, a.Pays_Aero
FROM Aeroport a
WHERE NOT EXISTS (
  SELECT 1 FROM Vol v WHERE v.Aeroport_Depart = a.Code_IATA
)
ORDER BY a.Code_IATA;

--  Vols opérés par avions > capacité moyenne 
SELECT v.NumVol, v.Date_Depart, a.Immatriculation, a.Modele, a.Capacite
FROM Vol v
JOIN Avion a ON a.Immatriculation = v.Immatriculation
WHERE a.Capacite > (SELECT AVG(Capacite) FROM Avion)
ORDER BY a.Capacite DESC, v.Date_Depart;

--  Routes avec remplissage moyen > moyenne réseau 
WITH taux_vol AS (
  SELECT v.NumVol,
         CONCAT(v.Aeroport_Depart,'→',v.Aeroport_Arrivee) AS Route,
         COUNT(r.CodeReservation)/a.Capacite AS Taux
  FROM Vol v
  JOIN Avion a            ON a.Immatriculation = v.Immatriculation
  LEFT JOIN Reservation r ON r.NumVol = v.NumVol
  GROUP BY v.NumVol, Route, a.Capacite
),
moy_reseau AS (
  SELECT AVG(Taux) AS avg_taux FROM taux_vol
)
SELECT Route, AVG(Taux) AS TauxMoyen
FROM taux_vol
WHERE Taux > (SELECT avg_taux FROM moy_reseau)
GROUP BY Route
ORDER BY TauxMoyen DESC;



--  Vols sous-utilisés (<40%) ou saturés (>90%)
SELECT v.NumVol, v.Date_Depart,
       CONCAT(v.Aeroport_Depart,'→',v.Aeroport_Arrivee) AS Route,
       a.Modele, a.Capacite,
       COUNT(r.CodeReservation) AS NbResa,
       ROUND(COUNT(r.CodeReservation)/a.Capacite, 3) AS Taux,
       CASE
         WHEN COUNT(r.CodeReservation)/a.Capacite > 0.90 THEN 'Augmenter capacité/fréquence'
         WHEN COUNT(r.CodeReservation)/a.Capacite < 0.40 THEN 'Réduire capacité/fréquence'
         ELSE 'OK'
       END AS Recommandation
FROM Vol v
JOIN Avion a ON a.Immatriculation = v.Immatriculation
LEFT JOIN Reservation r ON r.NumVol = v.NumVol
GROUP BY v.NumVol, v.Date_Depart, Route, a.Modele, a.Capacite
ORDER BY Taux DESC;
