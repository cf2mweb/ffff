SELECT * FROM auteur;
SELECT * FROM article;
SELECT lelogin,lemail FROM auteur;
/* pour renommer les champs de sorties, on utilisera as */
SELECT lelogin as nom, lemail as contact FROM auteur;
/* on veut compter le nombre de résultat et l'utiliser en php */
SELECT COUNT(id) as compte FROM auteur;
SELECT * FROM auteur WHERE id=1;
/* correspondance exacte */
SELECT id, lenom FROM auteur WHERE lelogin='ccc';
/* correspondance depuis le début de chaine, suivi par le % comme échapement */
SELECT id, lenom FROM auteur WHERE lelogin LIKE 'c%';
/* correspondance depuis dans la chaine avec le % comme échapement */
SELECT id, lenom FROM auteur WHERE lenom LIKE '%le%';

/* jointure interne INNER JOIN entre 2 tables*/
SELECT article.letitre,auteur.lenom FROM article INNER JOIN auteur ON article.auteur_id = auteur.id;

/* jointure externe de droite à gauche (article <- auteur) */

SELECT article.letitre,auteur.lenom FROM article RIGHT JOIN auteur ON article.auteur_id = auteur.id;

SELECT * FROM categorie ORDER BY lintitule ASC;
SELECT * FROM categorie ORDER BY lintitule DESC LIMIT 0, 3;

/* jointure interne INNER JOIN sur 3 tables many to many */ 

SELECT article.letitre, categorie.lintitule FROM article 
		INNER JOIN jointure ON article.id = jointure.article_id
		INNER JOIN categorie ON categorie.id = jointure.categorie_id;

/* même jointure avec raccourcis (alias pas pour la sortie) et le placement d'un where */

SELECT a.letitre, c.lintitule FROM article a
		INNER JOIN jointure j ON a.id = j.article_id
		INNER JOIN categorie c ON c.id = j.categorie_id
WHERE a.id=1;

/* on met une ligne par article (en groupant avec GROUP BY) et on concatène avec des , les différentes rubriques avec GROUP_CONCAT */

SELECT a.letitre, GROUP_CONCAT(c.lintitule) as rubriques FROM article a
		INNER JOIN jointure j ON a.id = j.article_id
		INNER JOIN categorie c ON c.id = j.categorie_id
GROUP BY a.letitre;

/* jointure 4 tables, comme c'est beau !!! */

SELECT a.letitre, GROUP_CONCAT(c.lintitule) as rubriques, u.lenom  FROM article a
		INNER JOIN auteur u ON u.id = a.auteur_id
		INNER JOIN jointure j ON a.id = j.article_id
		INNER JOIN categorie c ON c.id = j.categorie_id
GROUP BY a.letitre;

/* ici le distinct */

SELECT categorie_id FROM jointure;
SELECT DISTINCT(categorie_id) FROM jointure;
