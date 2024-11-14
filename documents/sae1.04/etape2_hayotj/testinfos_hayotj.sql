/*						Les requêtes						*/

/*Les informations relatives au passager n°916 : son nom, son âge, sa classe, sa ou ses cabines, le nom du port où il a embarqué, numéro et catégorie de l'embarcation de sauvetage qui l'a éventuellement secouru*/

SELECT pa.name, pa.age, pa.pclass, o.cabincode, po.portname, l.lifeboatid, l.lifeboatcat 
FROM PASSENGER pa, OCCUPATION o, PORT po, LIFEBOAT l, RESCUE r 
WHERE pa.passengerid = 916 
AND pa.passengerid = o.passengerid 
AND pa.portid = po.portid 
AND o.passengerid = r.passengerid 
AND r.lifeboatid = l.lifeboatid;

/*Résultat*/
                      name                       | age | pclass | cabincode | portname  | lifeboatid | lifeboatcat 
-------------------------------------------------+-----+--------+-----------+-----------+------------+-------------
 Ryerson, Mrs. Arthur Larned (Emily Maria Borie) |  48 |      1 | B57       | Cherbourg | 4          | standard
 Ryerson, Mrs. Arthur Larned (Emily Maria Borie) |  48 |      1 | B59       | Cherbourg | 4          | standard
 Ryerson, Mrs. Arthur Larned (Emily Maria Borie) |  48 |      1 | B63       | Cherbourg | 4          | standard
 Ryerson, Mrs. Arthur Larned (Emily Maria Borie) |  48 |      1 | B66       | Cherbourg | 4          | standard
(4 rows)



/*Le nom et le rôle des domestiques du passager n°1264*/

SELECT Name, Role
FROM PASSENGER p, SERVICE s
WHERE s.PassengerId_Dom = p.PassengerId and PassengerId_Emp = 1264;

/*Résultat (vérifié avec le fichier Data_Titanic_S1_04.ods)*/

         name          |    role    
-----------------------+------------
 Fry, Mr. Richard      | valet
 Harrison, Mr. William | secretaire
(2 rows)



/*La liste des passagers ayant été secourus par le canot n°7*/

SELECT p.PassengerId, Name
FROM RESCUE r, PASSENGER p
WHERE r.PassengerId = p.PassengerId and LifeBoatId = '7';

/*Résultat (vérifié avec le fichier Data_Titanic_S1_04.ods)*/

 passengerid |                            name                            
-------------+------------------------------------------------------------
         485 | Bishop, Mr. Dickinson H
         292 | Bishop, Mrs. Dickinson H (Helen Walton)
         210 | Blank, Mr. Henry
         938 | Chevre, Mr. Paul Romain
         541 | Crosby, Miss. Harriet R
        1197 | Crosby, Mrs. Edward Gifford (Catherine Elizabeth Halstead)
        1042 | Earnshaw, Mrs. Boulton (Olive Potter)
         914 | Flegenheimer, Mrs. Alfred (Antoinette)
        1294 | Gibson, Miss. Dorothy Winifred
        1260 | Gibson, Mrs. Leonard (Pauline C Boeson)
          98 | Greenfield, Mr. William Bertram
        1242 | Greenfield, Mrs. Leo David (Blanche Strouse)
         311 | Hays, Miss. Margaret Bechstein
         840 | Marechal, Mr. Pierre
         513 | McGough, Mr. James Robert
        1297 | Nourney, Mr. Alfred (Baron von Drachstedt")"
        1097 | Omont, Mr. Alfred Fernand
         880 | Potter, Mrs. Thomas Jr (Lily Alexenia Wilson)
         448 | Seward, Mr. Frederic Kimber
          24 | Sloper, Mr. William Thompson
        1179 | Snyder, Mr. John Pillsbury
         904 | Snyder, Mrs. John Pillsbury (Nelle Stevenson)
         713 | Taylor, Mr. Elmer Zebley
         670 | Taylor, Mrs. Elmer Zebley (Juliet Cummins Wright)
         960 | Tucker, Mr. Gilbert Milligan Jr
(25 rows)

