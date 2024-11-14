/*A1.a Nombre de survivants, respectivement de victimes parmi les passagers, selon leur classe (une requête par classe)*/ 

/* Nombre de survivants et de victimes dans la classe 1*/

SELECT survived, count(passengerid) 
FROM PASSENGER 
WHERE pclass=1 
GROUP BY survived; 

/*
 survived | count   
----------+-------  
       1 |   200  
       0 |   123  
(2 rows) 
*/


/* Nombre de survivants et de victimes dans la classe 2*/

SELECT survived, count(passengerid) 
FROM PASSENGER 
WHERE pclass=2 
GROUP BY survived; 

/*
survived | count   
----------+-------  
       1 |   119  
       0 |   158  
(2 rows)  
*/

  
/* Nombre de survivants et de victimes dans la classe 3*/

SELECT survived, count(passengerid) 
FROM PASSENGER 
WHERE pclass=3
GROUP BY survived; 
 
/*
 survived | count   
----------+-------  
       1 |   181  
       0 |   528  
(2 rows) 
*/


/*------------------------------------------------------------------------------*/


/*A1.b*/
/*Nombre d'hommes victimes et ayant survécu*/
 
SELECT Survived, count(PassengerId)
FROM PASSENGER
WHERE Sex = 'male' and age>=12
GROUP BY Survived;

/*
 survived | count 
----------+-------
        0 |   501
        1 |   109
(2 rows)
*/


/*Nombre de femmes victimes et ayant survécu*/

SELECT Survived, count(PassengerId)
FROM PASSENGER
WHERE Sex = 'female' and age>=12
GROUP BY Survived;

/*
 survived | count 
----------+-------
        0 |    79
        1 |   267
(2 rows)
*/

/*Nombre d'enfants victimes et ayant survécu*/

SELECT Survived, count(PassengerId)
FROM PASSENGER
WHERE age<12
GROUP BY Survived;

/*
 survived | count 
----------+-------
        0 |    39
        1 |    51
(2 rows)
*/


/*Requête total de survivants*/

SELECT Count(PassengerId) as Survivants_Tot,
        (SELECT count(PassengerId) FROM PASSENGER WHERE Sex = 'male' and age>=12 and Survived = 1) as Survivants_hommes,
        (SELECT count(PassengerId) FROM PASSENGER WHERE Sex = 'female' and age>=12 and Survived = 1) as Survivants_femmes,
        (SELECT count(PassengerId) FROM PASSENGER WHERE age<12 and Survived = 1) as Survivants_enfants
FROM PASSENGER
WHERE Survived = 1;

/*
 survivants_tot | survivants_hommes | survivants_femmes | survivants_enfants 
----------------+-------------------+-------------------+--------------------
            500 |               109 |               267 |                 51
(1 row)
*/

/*Requête total de victimes*/

SELECT count(PassengerId) as Victimes_Tot,
	(SELECT count(PassengerId) FROM PASSENGER WHERE Sex = 'male' and age>=12 and Survived = 0) as Victimes_hommes,
        (SELECT count(PassengerId) FROM PASSENGER WHERE Sex='female' and age>=12 and Survived = 0) as Victimes_femmes,
        (SELECT count(PassengerId) FROM PASSENGER WHERE age<12 and Survived = 0) as Victimes_enfants
FROM PASSENGER
WHERE Survived = 0;

/*
 victimes_tot | victimes_hommes | victimes_femmes | victimes_enfants 
--------------+-----------------+-----------------+------------------
          809 |             501 |              79 |               39
(1 row)
*/


/*------------------------------------------------------------------------------------------------------------------------------*/


/*A2 - Réexécution des requêtes de A1.b*/

/*Nombre d'hommes victimes et ayant survécu:

 survived | count 
----------+-------
        0 |   653
        1 |   132
(2 rows)
*/

/*Nombre de femmes victimes et ayant survécu:

 survived | count 
----------+-------
        0 |   105
        1 |   314
(2 rows)
*/

/*Nombre d'enfants victimes et ayant survécu:

 survived | count 
----------+-------
        0 |    51
        1 |    54
(2 rows)
*/

/*Requête total de survivants:

 survivants_tot | survivants_hommes | survivants_femmes | survivants_enfants 
----------------+-------------------+-------------------+--------------------
            500 |               132 |               314 |                 54
(1 row)
*/

/*Requête total de victimes:

 victimes_tot | victimes_hommes | victimes_femmes | victimes_enfants 
--------------+-----------------+-----------------+------------------
          809 |             653 |             105 |               51
(1 row)
*/
/* Il y a des différences dans les résultats par rapport à la partie A1.b, cette fois-ci, la somme des passagers correspond au total des passagers.*/


/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*A3 - Taux de survivants dans les différentes catégories de passagers selon leur classe*/

/*A3.a - Taux de survivants par classe, toutes catégories confondues (enfants, femmes ou hommes)*/ 

/*Taux de survivants de la classe 1*/

SELECT pclass, (SELECT count(*) * 100 / (SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass) 
		FROM PASSENGER 
		WHERE survived=1 AND pclass=p.pclass) as Taux_survivants_class
FROM PASSENGER p
GROUP BY pclass
ORDER BY pclass;

/*
 pclass | taux_survivants_class 
--------+-----------------------
      1 |                    61
      2 |                    42
      3 |                    25
(3 rows)
*/


/*Requête de vérification*/

SELECT pclass, (SELECT count(*) FROM PASSENGER WHERE survived=1 AND pclass=p.pclass) as Survivants_Class,
		(SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass) as Passagers_Class
FROM PASSENGER p
GROUP BY pclass
ORDER BY pclass;
/*
 pclass | survivants_class | passagers_class 
--------+------------------+-----------------
      1 |              200 |             323
      2 |              119 |             277
      3 |              181 |             709
(3 rows)

Le taux se calcule avec (survivants_class*100) / passagers_class
*/

/*--------------------------------------------------------------------------*/


/*A3.b - Taux de survivants par classe dans la catégorie enfants*/ 

SELECT pClass, (SELECT count(*) * 100 / (SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass AND age<12) 
	FROM PASSENGER 
	WHERE survived=1 AND pclass=p.pclass AND age<12) as Taux_survivants_enfants
FROM PASSENGER p
GROUP BY pclass
ORDER BY pclass;

/*
 pclass | taux_survivants_enfants 
--------+-------------------------
      1 |                      80
      2 |                     100
      3 |                      35
(3 rows)
*/


/*Requête de vérification*/

SELECT pClass, (SELECT count(*) FROM PASSENGER WHERE survived=1 AND pclass=p.pclass AND age<12) as nb_enfants_survivants,
	(SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass AND age<12) as nb_enfants_class
FROM PASSENGER p
GROUP BY pclass
ORDER BY pclass;

/*
 pclass | nb_enfants_survivants | nb_enfants_class 
--------+-----------------------+------------------
      1 |                     4 |                5
      2 |                    22 |               22
      3 |                    28 |               78
(3 rows)

Le taux se calcule avec (nb_enfants_survivants*100) / nb_enfants_class
*/


/*-------------------------------------------------------------------------*/


/*A3.c - Taux de survivants par classe dans la catégorie femmes*/ 

SELECT pClass, (SELECT count(*) * 100 / (SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass AND age>=12 AND sex='female')
	FROM PASSENGER 
	WHERE survived=1 AND pclass=p.pclass AND age>=12 AND sex='female') as Taux_survivants_femmes
FROM PASSENGER p
GROUP BY pclass
ORDER BY pclass;

/*
 pclass | taux_survivants_femmes 
--------+------------------------
      1 |                     97
      2 |                     87
      3 |                     50
(3 rows)
*/


/*Requête de vérification*/

SELECT pClass, (SELECT count(*) FROM PASSENGER WHERE survived=1 AND pclass=p.pclass AND age>=12 AND sex='female') as nb_femmes_survivants,
	(SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass AND age>=12 AND sex='female') as nb_femmes_class
FROM PASSENGER p
GROUP BY pclass
ORDER BY pclass;

/*
 pclass | nb_femmes_survivants | nb_femmes_class 
--------+----------------------+-----------------
      1 |                  139 |             143
      2 |                   83 |              95
      3 |                   92 |             181
(3 rows)


Le taux se calcule avec (nb_femmes_survivants*100) / nb_femmes_class
*/


/*----------------------------------------------------------------------------*/


/*A3.d - Taux de survivants par classe dans la catégorie hommes*/ 

SELECT pClass, (SELECT count(*) * 100 / (SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass AND age>=12 AND sex='male')
	FROM PASSENGER 
	WHERE survived=1 AND pclass=p.pclass AND age>=12 AND sex='male') as Taux_survivants_hommes
FROM PASSENGER p
GROUP BY pclass
ORDER BY pclass;

/*
 pclass | taux_survivants_hommes 
--------+------------------------
      1 |                     32
      2 |                      8
      3 |                     13
(3 rows)
*/


/*Requête de vérification*/

SELECT pClass, (SELECT count(*) FROM PASSENGER WHERE survived=1 AND pclass=p.pclass AND age>=12 AND sex='male') as nb_hommes_survivants,
	(SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass AND age>=12 AND sex='male') as nb_hommes_class
FROM PASSENGER p
GROUP BY pclass
ORDER BY pclass;

/*
 pclass | nb_hommes_survivants | nb_hommes_class 
--------+----------------------+-----------------
      1 |                   57 |             175
      2 |                   14 |             160
      3 |                   61 |             450
(3 rows)


Le taux se calcule avec (nb_hommes_survivants*100) / nb_hommes_class
*/


/*----------------------------------------------------------------------------------------------------------------------*/


/*A4 - Taux de survivants parmi les rescapés (passagers ayant pu monter dans une embarcation de sauvetage)*/

/*A4.a Nombre total d'enfants et nombre d'enfants rescapés*/ 

SELECT count(*) as nb_enfants, (SELECT count(*) as nb_enfants_rescapés  
                                FROM PASSENGER 
                                WHERE age<12 
                                AND passengerid IN (SELECT passengerid 
                                                        FROM RESCUE)) 
FROM PASSENGER 
WHERE age<12; 

/*
 nb_enfants | nb_enfants_rescapés   
------------+---------------------  
       105  |                  53  
(1 row) 
*/


/*-----------------------------------------------------------------------------------------------------------------------*/


/*A4.b Nombre d'enfants qui ont survécu parmi les enfants qui ont été rescapés*/ 

SELECT count(*) as nb_enfants_rescapés, (SELECT count(*) as nb_enfants_survivants  
                                        FROM PASSENGER
                                        WHERE age<12 
                                	AND survived=1 AND passengerid IN (SELECT passengerid 
                       								FROM RESCUE)) 
FROM PASSENGER
WHERE age<12 
AND passengerid IN (SELECT passengerid 
                       FROM RESCUE);

/*
 nb_enfants_rescapés | nb_enfants_survivants 
---------------------+-----------------------
                  53 |                    53
(1 row)
*/


/*-----------------------------------------------------------------------------------------------------------------------*/


/*A4.c Pour chaque classe de passagers : nombre d'enfants qui ont survécu parmi les enfants rescapés*/ 

SELECT (SELECT count(*) as class_1  
FROM PASSENGER 
WHERE age<12 
AND survived=1 
AND passengerid IN (SELECT passengerid 
                        		FROM RESCUE) 
AND pclass=1), 
(SELECT count(*) as class_2  
FROM PASSENGER 
WHERE age<12 
AND survived=1 
AND passengerid IN (SELECT passengerid 
                        		FROM RESCUE) 
AND pclass=2), 
(SELECT count(*) as class_3  
FROM PASSENGER 
WHERE age<12 
AND survived=1 
AND passengerid IN (SELECT passengerid 
                        		FROM RESCUE)
AND pclass=3); 

/*
class_1 | class_2 | class_3   
---------+---------+---------  
      4 |      22 |      27  
(1 row) 
*/


/*-----------------------------------------------------------------------------------------------------------------------*/


/*A4.d Taux de rescapés parmi les passagers*/

SELECT count(*) *100 / (SELECT count(*) FROM PASSENGER) as taux_rescap
FROM RESCUE;

/*
 taux_rescap 
-------------
          37
(1 row)
*/


/*-----------------------------------------------------------------------------------------------------------------------*/


/*A4.e - Nombre de rescapés par catégorie de passager (enfant, femme ou homme)*/

SELECT DISTINCT (SELECT count(*) as enfants   
FROM PASSENGER  
WHERE age<12  
AND passengerid IN (SELECT passengerid   
                        		FROM RESCUE)),  
(SELECT count(*) as femmes   
FROM PASSENGER  
WHERE age>=12  
AND sex='female' 
AND passengerid IN (SELECT passengerid  
                        		FROM RESCUE)),  
(SELECT count(*) as hommes   
FROM PASSENGER  
WHERE age>=12  
AND sex='male' 
AND passengerid IN (SELECT passengerid  
                        		FROM RESCUE))
FROM PASSENGER;

/*
 enfants | femmes | hommes 
---------+--------+--------
      53 |    294 |    143
*/


/*-----------------------------------------------------------------------------------------------------------------------*/


/*A4.f - Nombre de survivants par catégorie de rescapés (enfant, femme ou homme)*/

SELECT DISTINCT (SELECT count(*) FROM RESCUE r, PASSENGER p WHERE r.Passengerid = p.passengerid and survived=1 and sex='female' and age>=12) as survivants_femmes,
	(SELECT count(*) FROM RESCUE r, PASSENGER p WHERE r.Passengerid = p.passengerid and survived=1 and sex='male' and age>=12) as survivants_hommes,
	(SELECT count(*) FROM RESCUE r, PASSENGER p WHERE r.Passengerid = p.passengerid and survived=1 and age<12) as survivants_enfants
FROM RESCUE;

/*
 survivants_femmes | survivants_hommes | survivants_enfants 
-------------------+-------------------+--------------------
               292 |               128 |                 53
(1 row)
*/


/*-----------------------------------------------------------------------------------------------------------------------*/


/*A4.g - Nombre total de rescapés et taux de survivants par embarcation - résultat ordonné sur le code de l'embarcation*/

SELECT lifeboatid, (SELECT count(*) FROM RESCUE WHERE lifeboatid = l.lifeboatid) as nb_rescap,
			(SELECT count(*)*100/(SELECT count (*) FROM RESCUE WHERE lifeboatid = l.lifeboatid)
			 	FROM RESCUE r, PASSENGER p WHERE r.passengerid=p.passengerid and r.lifeboatid = l.lifeboatid and survived =1) as taux_survivants
FROM LIFEBOAT l
GROUP BY lifeboatid
ORDER BY lifeboatid;

/*
 lifeboatid | nb_rescap | taux_survivants 
------------+-----------+-----------------
 1          |         5 |             100
 10         |        30 |             100
 11         |        25 |              92
 12         |        18 |              94
 13         |        41 |              97
 14         |        35 |              97
 15         |        39 |             100
 16         |        25 |             100
 2          |        14 |             100
 3          |        26 |              96
 4          |        32 |              93
 5          |        28 |             100
 6          |        21 |              95
 7          |        25 |             100
 8          |        23 |             100
 9          |        26 |              92
 A          |        11 |              63
 B          |        10 |              90
 C          |        37 |             100
 D          |        19 |              94
(20 rows)
*/


/*-----------------------------------------------------------------------------------------------------------------------*/


/* A4.h - Pour chaque classe de passager, nombre d'enfants, nombre de femmes et nombre d'hommes qui ont survécu parmi les rescapés*/

SELECT pclass, (SELECT count(*) FROM PASSENGER WHERE pClass = p.pClass  and survived=1 and age<12 and passengerid in(SELECT passengerid FROM RESCUE)) as nb_survivants_enfants,
	(SELECT count(*) FROM PASSENGER WHERE PClass = p.pclass and survived=1 and sex='female' and age>=12 and passengerid in(SELECT passengerid FROM RESCUE)) as nb_survivants_femmes,
	(SELECT count(*) FROM PASSENGER WHERE pclass = p.pclass and survived=1 and sex='male' and age>=12 and passengerid in(SELECT passengerid FROM RESCUE)) as nb_survivants_hommes
FROM PASSENGER p
GROUP BY pclass
ORDER BY pClass;

/*
 pclass | nb_survivants_enfants | nb_survivants_femmes | nb_survivants_hommes 
--------+-----------------------+----------------------+----------------------
      1 |                     4 |                  135 |                   56
      2 |                    22 |                   75 |                   14
      3 |                    27 |                   82 |                   58
(3 rows)
*/


/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*B*/

/* Les domestiques ont ils tous été rescapés*/

SELECT count(passengerid_dom) as tot_dom, (SELECT count(*) passengerid_dom FROM SERVICE s, RESCUE r WHERE s.passengerid_dom=r.passengerid) as dom_rescapes
FROM SERVICE;

/*
 tot_dom | dom_rescapes 
---------+--------------
      40 |           29
(1 row)
*/


/*S'ils ont été rescapés, en est-il de même de leurs employeurs (si oui, dans des embarcations identiques ou différentes) */

SELECT passengerid_dom as dom_rescapes, (SELECT passengerid_emp FROM RESCUE WHERE s.passengerid_emp=passengerid) as emp_rescapes,
					(SELECT lifeboatid FROM RESCUE WHERE s.passengerid_dom=passengerid) as dom_boat,
					(SELECT lifeboatid FROM RESCUE WHERE s.passengerid_emp=passengerid) as emp_boat
FROM SERVICE s, RESCUE r
WHERE s.passengerid_dom=r.passengerid
GROUP BY dom_rescapes;

/*
 dom_rescapes | emp_rescapes | dom_boat | emp_boat 
--------------+--------------+----------+----------
           62 |          830 | 6        | 6
          196 |           32 | 6        | 6
          219 |          940 | 8        | 8
          259 |         1235 | 3        | 3
          270 |         1206 | 8        | 8
          291 |          988 | 6        | 6
          307 |          582 | 4        | 4
          310 |          557 | 1        | 1
          338 |         1088 | 3        | 3
          346 |              | 11       | 
          381 |          701 | 4        | 4
          505 |          760 | 8        | 8
          521 |          821 | 3        | 3
          538 |         1131 | 2        | 2
          610 |          888 | 3        | 3
          642 |          370 | 9        | 9
          682 |          646 | 3        | 3
          709 |          306 | 11       | 11
          717 |          701 | 4        | 4
          738 |          680 | 3        | 3
          843 |          764 | 4        | 4
          951 |              | 4        | 
          966 |              | 4        | 
         1033 |              | 8        | 
         1048 |              | 8        | 
         1216 |          780 | 2        | 2
         1263 |          320 | 3        | 3
         1267 |          956 | 4        | 4
         1306 |          308 | 8        | 8
(29 rows)
*/


/*Influence de l'emplacement des embarcations de sauvetage (side et/ou position) sur le taux de survie des passagers qui y ont pris place ?*/

SELECT DISTINCT (SELECT count(*)*100/(SELECT count(*) FROM RESCUE re, LIFEBOAT li WHERE re.lifeboatid=li.lifeboatid and li.side='tribord')
		FROM RESCUE r, PASSENGER p, LIFEBOAT l
		WHERE r.passengerid=p.passengerid and survived=1 and l.lifeboatid=r.lifeboatid and l.side='tribord') as taux_survivants_tribord,
		(SELECT count(*)*100/(SELECT count(*) FROM RESCUE re, LIFEBOAT li WHERE re.lifeboatid=li.lifeboatid and li.side='babord')
		FROM RESCUE r, PASSENGER p, LIFEBOAT l
		WHERE r.passengerid=p.passengerid and survived=1 and l.lifeboatid=r.lifeboatid and l.side='babord') as taux_survivants_babord,
		(SELECT count(*)*100/(SELECT count(*) FROM RESCUE re, LIFEBOAT li WHERE re.lifeboatid=li.lifeboatid and li.position='avant')
		FROM RESCUE r, PASSENGER p, LIFEBOAT l
		WHERE r.passengerid=p.passengerid and survived=1 and l.lifeboatid=r.lifeboatid and l.position='avant') as taux_survivants_avant,
		(SELECT count(*)*100/(SELECT count(*) FROM RESCUE re, LIFEBOAT li WHERE re.lifeboatid=li.lifeboatid and li.position='arriere')
		FROM RESCUE r, PASSENGER p, LIFEBOAT l
		WHERE r.passengerid=p.passengerid and survived=1 and l.lifeboatid=r.lifeboatid and l.position='arriere') as taux_survivants_arriere
FROM LIFEBOAT;

/*
 taux_survivants_tribord | taux_survivants_babord | taux_survivants_avant | taux_survivants_arriere 
-------------------------+------------------------+-----------------------+-------------------------
                      96 |                     96 |                    96 |                      97
(1 row)
*/

/*tribord: 253/263
babord: 220/227
avant: 241/251
arriere: 232/237
*/


/*Influence de l'heure de mise à l'eau des embarcations de sauvetage sur le taux de survie des passagers qui y ont pris place (ou encore, influence de l'heure de récupération de ces embarcations par le Carpathia)?*/

/*Taux de survivants selon l'heure de mise à l'eau*/

SELECT launching_time, (SELECT count(*)*100/(SELECT count(*) FROM RESCUE re, LIFEBOAT lif WHERE re.lifeboatid=lif.lifeboatid and lif.launching_time=l.launching_time)
			FROM RESCUE r, PASSENGER p, LIFEBOAT li
			WHERE r.passengerid=p.passengerid and survived=1 and li.lifeboatid=r.lifeboatid and li.launching_time=l.launching_time) as taux_survie_heure_lancée
FROM LIFEBOAT l
GROUP BY launching_time
ORDER BY launching_time;

/*
 launching_time | taux_survie_heure_lancée 
----------------+--------------------------
 01:05:00       |                       96
 01:10:00       |                      100
 01:20:00       |                       96
 01:25:00       |                       93
 01:30:00       |                       97
 01:35:00       |                       99
 01:40:00       |                      100
 01:45:00       |                      100
 01:55:00       |                       96
 02:05:00       |                       94
 02:15:00       |                       76
*/


/*Taux de survivants selon l'heure de récupération par le Carpathia*/

SELECT recovery_time, (SELECT count(*)*100/(SELECT count(*) FROM RESCUE re, RECOVERY rec WHERE re.lifeboatid=rec.lifeboatid and rec.recovery_time=reco.recovery_time)
			FROM RESCUE r, PASSENGER p, RECOVERY recov
			WHERE r.passengerid=p.passengerid and survived=1 and recov.lifeboatid=r.lifeboatid and recov.recovery_time=reco.recovery_time) as taux_survie_heure_retour
FROM RECOVERY reco
GROUP BY recovery_time
ORDER BY recovery_time;

/*
 recovery_time | taux_survie_heure_retour 
---------------+--------------------------
 04:10:00      |                      100
 05:45:00      |                      100
 06:00:00      |                      100
 06:15:00      |                       96
 06:30:00      |                       97
 06:45:00      |                      100
 07:00:00      |                       92
 07:15:00      |                       96
 07:30:00      |                       98
 08:00:00      |                       96
 08:15:00      |                       94
(11 rows)
*/


/*Taux de survie par tranche d'âge parmi les passagers ayant au moins 12 ans lors du naufrage */

SELECT DISTINCT (SELECT count(*)*100/(SELECT count(*) FROM PASSENGER WHERE age>=12 and age<=20)
		FROM PASSENGER
		WHERE survived=1 and age>=12 and age<=20) as taux_survivants_12_20ans,
		(SELECT count(*)*100/(SELECT count(*) FROM PASSENGER WHERE age>20 and age<=40)
		FROM PASSENGER
		WHERE survived=1 and age>20 and age<=40) as taux_survivants_21_40ans,
		(SELECT count(*)*100/(SELECT count(*) FROM PASSENGER WHERE age>40 and age<=60)
		FROM PASSENGER
		WHERE survived=1 and age>40 and age<=60) as taux_survivants_41_60ans,
		(SELECT count(*)*100/(SELECT count(*) FROM PASSENGER WHERE age>60)
		FROM PASSENGER
		WHERE survived=1 and age>60) as taux_survivants_plus_60ans
FROM PASSENGER;

/*
 taux_survivants_12_20ans | taux_survivants_21_40ans | taux_survivants_41_60ans | taux_survivants_plus_60ans 
--------------------------+--------------------------+--------------------------+----------------------------
                       34 |                       37 |                       40 |                         20
(1 row)

*/

/*
12-20: 73/209
21-40: 271/722
41-60: 94/234
60+: 8/39
*/

/*Combien de passagers supplémentaires auraient pu être rescapés (et peut-être survivre) si le taux maximum de remplissage des embarcations de sauvetage avait été respecté */

SELECT sum(places) - (SELECT count(*) FROM RESCUE) as nb_places_dispo
FROM CATEGORY c, LIFEBOAT l
WHERE l.lifeboatcat=c.lifeboatcat;

/*
 nb_places_dispo 
-----------------
             688
(1 row)
*/

