/*						Test contraintes					*/

/*Consigne : Pour chaque contrainte exprimée en A2, donnez un exemple de requête d'insertion qui ne fonctionne pas car la contrainte en question n'est pas respectée. Incluez aussi en commentaire dans le testconfo_login.sql, le résultat de l'exécution de la requête et votre explication en français sur la raison pour laquelle elle ne fonctionne pas. A titre d'exemple, voir TP3 partie 1 test.sql*/

/*Contraintes Table PORT*/

INSERT INTO PORT VALUES('S', 'Southampton', 'Angleterre');
INSERT INTO PORT VALUES ('S', 'Stanley', 'Angleterre');
/*
INSERT 0 1
ERROR:  duplicate key value violates unique constraint "port_pkey"
DETAIL:  Key (portid)=(S) already exists.

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car la clé primaire doit être unique, il ne peut pas y avoir de doublon.
*/


INSERT INTO PORT VALUES('L', 'Southampton', 'Angleterre');
/*
ERROR:  new row for relation "port" violates check constraint "port_portid_check"
DETAIL:  Failing row contains (L, Southampton, Angleterre).

La requête ne peut pas fonctionner car PortId n'est pas 'C', 'Q' ou 'S', la contrainte n'est pas respectée.
*/


INSERT INTO PORT (PortId, Country) VALUES('Q', 'Angleterre');
/*
ERROR:  null value in column "portname" of relation "port" violates not-null constraint
DETAIL:  Failing row contains (Q, null, Angleterre).

La requête ne peut pas fonctionner car l'attribut PortName n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


INSERT INTO PORT (PortId, PortName) VALUES('Q', 'Southampton');
/*
ERROR:  null value in column "country" of relation "port" violates not-null constraint
DETAIL:  Failing row contains (Q, Southampton, null).

La requête ne peut pas fonctionner car l'attribut Country n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


/*Contraintes Table PASSENGER*/

INSERT INTO PASSENGER VALUES (47, 'Passager 47', 'masculin', 26, 1, 3);
INSERT INTO PASSENGER VALUES (47, 'Passager 48', 'masculin', 17, 1, 2);
/*
INSERT 0 1
ERROR:  duplicate key value violates unique constraint "passenger_pkey"
DETAIL:  Key (passengerid)=(47) already exists.

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car la clé primaire doit être unique, il ne peut pas y avoir de doublon.
*/


INSERT INTO PASSENGER (PassengerId, Sex, Age, Survived, PClass) VALUES(47, 'masculin', 26, 1, 3);
/*
ERROR:  null value in column "name" of relation "passenger" violates not-null constraint
DETAIL:  Failing row contains (47, null, masculin, 26, 1, 3, null).

La requête ne peut pas fonctionner car l'attribut Name n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


INSERT INTO PASSENGER (PassengerId, Name, Age, Survived, PClass) VALUES(47, 'Passager 47', 26, 1, 3);
/*
ERROR:  null value in column "sex" of relation "passenger" violates not-null constraint
DETAIL:  Failing row contains (47, Passager 47, null, 26, 1, 3, null).

La requête ne peut pas fonctionner car l'attribut Sex n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


INSERT INTO PASSENGER (PassengerId, Name, Sex, Age, Survived, PClass) VALUES(47, 'Passager 47', 'masculin', 26, 3, 3);
/*
ERROR:  new row for relation "passenger" violates check constraint "passenger_survived_check"
DETAIL:  Failing row contains (47, Passager 47, masculin, 26, 3, 3, null).

La requête ne peut pas fonctionner car l'attribut Survived n'est pas 0 ou 1, ici il est égal à 3.
*/


INSERT INTO PASSENGER VALUES(47, 'Passager 47', 'masculin', 26, 1);
/*
ERROR:  null value in column "pclass" of relation "passenger" violates not-null constraint
DETAIL:  Failing row contains (47, Passager 47, masculin, 26, 1, null, null).

La requête ne peut pas fonctionner car l'attribut PClass n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


INSERT INTO PASSENGER (PassengerId, Name, Sex, Age, Survived, PClass) VALUES(47, 'Passager 47', 'masculin', 26, 1, 14);
/*
ERROR:  new row for relation "passenger" violates check constraint "passenger_pclass_check"
DETAIL:  Failing row contains (47, Passager 47, masculin, 26, 1, 14, null).

La requête ne peut pas fonctionner car l'attribut PClass n'est pas compris entre 1 et 3, ici il est égal à 14.
*/


INSERT INTO PASSENGER VALUES (48, 'Passager 48', 'masculin', 17, 1, 2, 'Q');
/*
ERROR:  insert or update on table "passenger" violates foreign key constraint "passenger_portid_fkey"
DETAIL:  Key (portid)=(Q) is not present in table "port".

La requête ne peut pas fonctionner car 'Q' n'est pas dans la table PORT en tant que PortId, or l'attribut PortId de PASENGER fait référence à PortId de PORT.
*/


/*Contrantes Table OCCUPATION*/

INSERT INTO OCCUPATION VALUES(1522, 'C12');
/*
ERROR:  insert or update on table "occupation" violates foreign key constraint "occupation_passengerid_fkey"
DETAIL:  Key (passengerid)=(1522) is not present in table "passenger".

La requête ne peut pas fonctionner car 1522 n'est pas dans la table PASSENGER en tant que PassengerId, or l'attribut PassengerId de la table OCCUPATION fait référence à PassengerId de la table PASSENGER.
*/


INSERT INTO OCCUPATION VALUES(47, 'C12');
INSERT INTO OCCUPATION VALUES(47, 'C12');
/*
INSERT 0 1
ERROR:  duplicate key value violates unique constraint "occupation_pkey"
DETAIL:  Key (passengerid, cabincode)=(47, C12) already exists.

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car la clé primaire doit être unique, il ne peut pas y avoir de doublon.
*/


/*Contrantes Table SERVICE*/

INSERT INTO SERVICE VALUES(15, 47, 'nurse');
/*
ERROR:  insert or update on table "service" violates foreign key constraint "service_passengerid_dom_fkey"
DETAIL:  Key (passengerid_dom)=(15) is not present in table "passenger".

La requête ne peut pas fonctionner car 15 n'est pas présent en tant que PassengerId dans la table PASSENGER, or ici PassengerId_Dom doit faire références à l'attribut PassengerId de PASSENGER.
*/


INSERT INTO PASSENGER VALUES(15, 'Passager 15', 'feminin', 24, 0, 3);
INSERT INTO SERVICE VALUES(15, 42, 'nurse');
/*
INSERT 0 1
ERROR:  insert or update on table "service" violates foreign key constraint "service_passengerid_emp_fkey"
DETAIL:  Key (passengerid_emp)=(42) is not present in table "passenger".

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car l'attribut PassengerId_Emp doit faire référence à l'attribut PassengerId de la table PASSENGER, or 42 n'est pas présent en tant que PassengerId.
*/


INSERT INTO SERVICE VALUES(15, 47, 'nurse');
INSERT INTO SERVICE VALUES(15, 42, 'nurse');
/*
INSERT 0 1
ERROR:  duplicate key value violates unique constraint "service_pkey"
DETAIL:  Key (passengerid_dom)=(15) already exists.

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car la clé primaire doit être unique, il ne peut pas y avoir de doublon.
*/


INSERT INTO SERVICE(PassengerId_Dom, Role) VALUES(15, 'nurse');
/*
ERROR:  null value in column "passengerid_emp" of relation "service" violates not-null constraint
DETAIL:  Failing row contains (15, null, nurse).

La requête ne peut pas fonctionner car l'attribut PassengerId_Emp n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


INSERT INTO SERVICE(PassengerId_Dom, PassengerId_Emp) VALUES(15, 47);
/*
ERROR:  null value in column "role" of relation "service" violates not-null constraint
DETAIL:  Failing row contains (15, 47, null).

La requête ne peut pas fonctionner car l'attribut Role n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


/*Contraintes Table CATEGORY*/

INSERT INTO CATEGORY VALUES('standard', 'bois','47');
INSERT INTO CATEGORY VALUES('standard', 'bois et toile','47');
/*
INSERT 0 1
ERROR:  duplicate key value violates unique constraint "category_pkey"
DETAIL:  Key (lifeboatcat)=(standard) already exists.

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car la clé primaire doit être unique, il ne peut pas y avoir de doublon.
*/


INSERT INTO CATEGORY VALUES('paquebot', 'bois', 2000);
/*
ERROR:  new row for relation "category" violates check constraint "category_lifeboatcat_check"
DETAIL:  Failing row contains (paquebot, bois, 2000).

La requête ne peut pas fonctionner car l'attribut LifeBoatCat doit être 'standard', 'secours', ou 'radeau', ici il est égal à 'paquebot'.
*/


INSERT INTO CATEGORY (LifeBoatCat, Places) VALUES('standard', 47);
/*
ERROR:  null value in column "structure" of relation "category" violates not-null constraint
DETAIL:  Failing row contains (standard, null, 47).

La requête ne peut pas fonctionner car l'attribut Structure n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


INSERT INTO CATEGORY VALUES('standard', 'metal', 47);
/*
ERROR:  new row for relation "category" violates check constraint "category_structure_check"
DETAIL:  Failing row contains (standard, metal, 47).

La requête ne peut pas fonctionner car l'attribut Structure doit être 'bois' ou 'bois et toile', or ici il est égal à 'metal'.
*/


INSERT INTO CATEGORY VALUES('standard', 'bois');
/*
ERROR:  null value in column "places" of relation "category" violates not-null constraint
DETAIL:  Failing row contains (standard, bois, null).

La requête ne peut pas fonctionner car l'attribut Places n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


/*Contraintes Table LIFEBOAT*/

INSERT INTO LIFEBOAT VALUES(15, 'secours', 'babord', 'avant','pont','1:47:00');
/*
ERROR:  insert or update on table "lifeboat" violates foreign key constraint "lifeboat_lifeboatcat_fkey"
DETAIL:  Key (lifeboatcat)=(secours) is not present in table "category".

La requête ne peut pas marcher car l'attribut LifeBoatCat de LIFEBOAT doit faire référence à l'attribut LifeBoatCat de CATEGORY, or 'secours' n'est pas présent en tant que LifeBoatCat dans CATEGORY.
*/

INSERT INTO LIFEBOAT VALUES(15, 'standard', 'babord', 'avant','pont','1:47:00');
INSERT INTO LIFEBOAT VALUES(15, 'secours', 'babord', 'arriere','pont','1:47:00');
/*

INSERT 0 1
ERROR:  duplicate key value violates unique constraint "lifeboat_pkey"
DETAIL:  Key (lifeboatid)=(15) already exists.

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car la clé primaire doit être unique, il ne peut pas y avoir de doublon.
*/


INSERT INTO LIFEBOAT (LifeBoatId, Position, Location, Launching_Time) VALUES('15','avant', 'pont', '1:47:00');
/*
ERROR:  null value in column "side" of relation "lifeboat" violates not-null constraint
DETAIL:  Failing row contains (15, null, null, avant, pont, 01:47:00).

La requête ne peut pas fonctionner car l'attribut Side n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


INSERT INTO LIFEBOAT (LifeBoatId, Side, Position, Location, Launching_Time) VALUES('15','droite','avant', 'pont', '1:47:00');
/*
ERROR:  new row for relation "lifeboat" violates check constraint "lifeboat_side_check"
DETAIL:  Failing row contains (15, null, droite, avant, pont, 01:47:00).

La requête ne peut pas fonctionner car l'attribut Side doit être 'babord' ou 'tribord', or ici il est égal à 'droite'.
*/


INSERT INTO LIFEBOAT (LifeBoatId, Side, Location, Launching_Time) VALUES('15','babord', 'pont', '1:47:00');
/*
ERROR:  null value in column "position" of relation "lifeboat" violates not-null constraint
DETAIL:  Failing row contains (15, null, babord, null, pont, 01:47:00).

La requête ne peut pas fonctionner car l'attribut Position n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


INSERT INTO LIFEBOAT (LifeBoatId, Side, Position, Location, Launching_Time) VALUES('15','babord', 'milieu', 'pont', '1:47:00');
/*
ERROR:  new row for relation "lifeboat" violates check constraint "lifeboat_position_check"
DETAIL:  Failing row contains (15, null, babord, milieu, pont, 01:47:00).

La requête ne peut pas fonctionner car l'attribut Position doit être 'avant' ou 'arriere', or ici il est égal à 'milieu'.
*/


INSERT INTO LIFEBOAT (LifeBoatId, Side, Position, Launching_Time) VALUES('15','babord', 'avant', '1:47:00');
/*
INSERT 0 1

SELECT * FROM LIFEBOAT;
 lifeboatid | lifeboatcat |  side  | position | location | launching_time 
------------+-------------+--------+----------+----------+----------------
 15         |             | babord | avant    | pont     | 01:47:00

La requête fonctionne car l'attribut Location est forcément renseigné et prend par défault la valeur 'pont'. Il ne sera jamais NULL donc la contrainte sera toujours respectée.
*/


INSERT INTO LIFEBOAT (LifeBoatId, Side, Position, Location) VALUES('15','babord', 'avant', 'pont');
/*
ERROR:  null value in column "launching_time" of relation "lifeboat" violates not-null constraint
DETAIL:  Failing row contains (15, null, babord, avant, pont, null).

La requête ne peut pas fonctionner car l'attribut Launching_Time n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/


/*Contraintes Table RECOVERY*/

INSERT INTO RECOVERY VALUES('14', '5:04:00');
/*
ERROR:  insert or update on table "recovery" violates foreign key constraint "recovery_lifeboatid_fkey"
DETAIL:  Key (lifeboatid)=(14) is not present in table "lifeboat".

La requête ne peut pas fonctionner car 14 n'est pas présent en tant que LifeBoatId dans LIFEBOAT, or l'attribut LifeBoatId de RECOVERY doit faire référence à l'attribut LifeBoatId de LIFEBOAT.
*/


INSERT INTO RECOVERY VALUES('15', '5:04:00');
INSERT INTO RECOVERY VALUES('15', '7:24:00');
/*
INSERT 0 1
ERROR:  duplicate key value violates unique constraint "recovery_pkey"
DETAIL:  Key (lifeboatid)=(15) already exists.

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car la clé primaire doit être unique, il ne peut pas y avoir de doublon.
*/


INSERT INTO RECOVERY VALUES('15');
/*
ERROR:  null value in column "recovery_time" of relation "recovery" violates not-null constraint
DETAIL:  Failing row contains (15, null).

La requête ne peut pas fonctionner car l'attribut Recovery_Time n'est pas renseigné alors qu'il ne doit pas être NULL.
*/


/*Contraintes Table RESCUE*/

INSERT INTO RESCUE VALUES(3, '15');
/*
ERROR:  insert or update on table "rescue" violates foreign key constraint "rescue_passengerid_fkey"
DETAIL:  Key (passengerid)=(3) is not present in table "passenger".

La requpete ne peut pas fonctionner car 3 n'est pas présent en tant que PassengerId dans la table PASSENGER, or l'attribut PassengerId de RESCUE fait référence à l'attribut PassengerId de PASSENGER.
*/


INSERT INTO RESCUE VALUES(47, '10');
/*ERROR:  insert or update on table "rescue" violates foreign key constraint "rescue_lifeboatid_fkey"
DETAIL:  Key (lifeboatid)=(10) is not present in table "lifeboat".

La requête ne peut pas fonctionner car '10' n'est pas présent en tant que LifeBoatId dans la table LIFEBOAT, or l'attribut LifeBoatId de RESCUE fait référence à l'attribut LifeBoatId de LIFEBOAT.
*/


INSERT INTO RESCUE VALUES(47, '15');
INSERT INTO RESCUE VALUES(47, '15');
/*
INSERT 0 1
ERROR:  duplicate key value violates unique constraint "rescue_pkey"
DETAIL:  Key (passengerid)=(47) already exists.

La première requête fonctionne, mais la deuxième ne peut pas fonctionner car la clé primaire doit être unique, il ne peut pas y avoir de doublon.
*/


INSERT INTO RESCUE VALUES(47);

/*
ERROR:  null value in column "lifeboatid" of relation "rescue" violates not-null constraint
DETAIL:  Failing row contains (47, null).

La requête ne peut pas fonctionner car l'attribut LifeBoatId n'est pas renseigné, alors qu'il ne doit pas être NULL.
*/
