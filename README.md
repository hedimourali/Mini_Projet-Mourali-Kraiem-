# Prompt_Conception_Base

## [📌 Introduction du projet](./docs/rapport_complet.pdf)
Ce mini-projet a pour objectif de mettre en pratique, de manière concrète et progressive, l’ensemble des étapes de la méthode MERISE, telle qu’elle est enseignée dans ce module et largement utilisée dans l’industrie pour la conception et le développement de bases de données.  
MERISE est une méthode structurée qui permet de passer des besoins métiers exprimés en langage naturel, vers un modèle logique puis un schéma technique exploitable dans un système d’information réel. Elle offre une démarche rigoureuse, claire et communicable entre les différents acteurs d’un projet (métiers, analystes, développeurs, administrateurs de bases de données).  

Le travail consiste à analyser le fonctionnement d’une entreprise du domaine du transport aérien (ici, une compagnie similaire à EasyJet) afin d’identifier ses règles de gestion, des flux d’information, ses contraintes réglementaires et ses besoins opérationnels. L’accent est mis sur la modélisation de la base de données qui doit soutenir les activités essentielles de l’entreprise : planification et suivi des vols, gestion de la flotte et des équipages, réservation et paiement, services additionnels, gestion des passagers, conformité réglementaire et communication avec les clients.  

Le choix de ce sujet ne relève pas du hasard. En effet, nous avons tous été un jour confrontés à des retards de vols, à des problèmes de réservation ou encore à des surcoûts inattendus liés aux bagages ou aux sièges. Ces situations, bien que fréquentes, soulèvent une question essentielle : comment fonctionnent réellement les systèmes internes des compagnies aériennes et quels sont les éléments qui justifient ces contraintes vécues par les passagers ?  

Notre objectif est donc double :  
- d’une part, modéliser et analyser les processus de gestion d’une compagnie aérienne low-cost, depuis la réservation en ligne jusqu’à l’embarquement, en passant par la gestion des vols et des options payantes ;  
- d’autre part, envisager des pistes d’optimisation en comprenant mieux l’organisation des données et les flux d’information.  

Ainsi, ce projet ne se limite pas à une simple construction de base de données : il constitue également un exercice de compréhension des enjeux réels du transport aérien, et une première étape vers une réflexion sur l’amélioration de l’expérience client.  

---

<img src="./docs/etape1.jpg" alt="MCD" width="1500"/>




## [📄 Notre Prompt](./docs/prompt.pdf)

Tu travailles dans le domaine du transport aérien. Ton entreprise exerce une activité de transport aérien comparable à celle d’EasyJet. EasyJet est une compagnie aérienne britannique fondée en 1995, spécialisée dans le transport aérien à bas coût. Basée principalement à l’aéroport de Londres-Luton, elle dessert aujourd’hui plus de 150 destinations. Son modèle économique repose sur la simplification des services afin de proposer des tarifs attractifs, avec des billets vendus exclusivement en ligne, 
l’absence de services superflus inclus, et la possibilité pour le client de choisir des options payantes comme les bagages ou la sélection de sièges. EasyJet s’adresse principalement aux voyageurs recherchant des déplacements rapides et économiques, que ce soit pour le tourisme ou les voyages d’affaires.

Ton entreprise souhaite appliquer la méthode MERISE pour concevoir un système d’information. Dans ce cadre, tu es chargé de la partie analyse, qui consiste à collecter et formaliser les besoins métiers de l’entreprise. Le travail de conception et de développement de la base de données sera ensuite confié à un étudiant en ingénierie informatique. Pour accomplir cette mission, tu dois d’abord établir les règles de gestion des données de l’entreprise et les présenter sous la forme d’un texte clair et compréhensible. 
Ces règles doivent être rédigées comme si elles étaient expliquées à une personne connaissant bien le fonctionnement de l’entreprise mais ne maîtrisant pas la méthode MERISE. Elles doivent couvrir l’ensemble des aspects liés à l’activité, à savoir la gestion des vols, des avions et des aéroports, les réservations et leurs modalités, les options payantes qui reflètent le modèle économique low-cost, ainsi que les informations relatives aux passagers et aux paiements. Chaque règle doit être rédigée de manière précise, factuelle et sans ambiguïté afin de refléter fidèlement le fonctionnement de l’entreprise.

À partir de ces règles de gestion, tu dois ensuite construire un dictionnaire de données brutes qui prendra la forme d’un tableau clair et lisible. Ce dictionnaire doit contenir entre 25 et 35 données distinctes et pour chacune d’elles, tu devras indiquer la signification en langage simple, le type de donnée (texte, numérique, date, heure, booléen, décimal, etc.) ainsi que la taille maximale en nombre de caractères ou de chiffres. Les données doivent être cohérentes avec la réalité métier, par exemple un code IATA limité à trois caractères, un numéro de vol sur six caractères, une adresse email pouvant contenir jusqu’à cinquante caractères, ou encore un montant payé exprimé en numérique avec deux décimales. Il est important d’intégrer également les données relatives aux options additionnelles comme les bagages en soute ou la sélection de sièges, 
afin de bien représenter le modèle économique low-cost adopté par l’entreprise.

Enfin, la présentation du travail doit être soignée et professionnelle. Le texte des règles de gestion doit être rédigé de manière structurée et numérotée afin de pouvoir être facilement réutilisé par la suite. Le dictionnaire de données, quant à lui, doit être présenté sous forme de tableau aligné et lisible, sans redondance, de façon à ce qu’il constitue un support de travail directement exploitable pour la phase suivante de conception. Chaque donnée décrite dans le dictionnaire doit pouvoir être reliée à au moins 
une règle de gestion.



## [🤖 Résultat IAG](./results/ia_result.md)
Ce fichier regroupe les résultats produits par l’IA à partir du prompt initial.  
