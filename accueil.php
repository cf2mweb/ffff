<?php
$debut = microtime();
require'connect.php';
// requête simple ne sélectionnant que des éléments de la table article
//$requete = mysqli_query($mysqli, "SELECT letitre,letexte,ladate FROM article ORDER BY ladate DESC;");
$requete = mysqli_query($mysqli, "
/* On sélectionne des champs se trouvant dans la table article, auteur et catégorie */    
SELECT article.letitre,article.letexte,article.ladate,auteur.lenom, auteur.lemail, GROUP_CONCAT(CONCAT(categorie.id,'-!-',categorie.lintitule) SEPARATOR '*-*') AS categ

/* On commence en sélectionnant la table principale qui apelle la jointure*/
FROM article

    /* On lie la table auteur en comparant auteur_id de la table article avec l'id de la table auteur */
    INNER JOIN auteur ON article.auteur_id = auteur.id
    
    /* On va utiliser la table jointure pour faire le lien entre la table article et la table categorie */
    INNER JOIN jointure ON article.id = jointure.article_id
    
    /* On joint enfin la table categorie */
    INNER JOIN categorie ON categorie.id = jointure.categorie_id
    
    /* on regroupe par article */
    GROUP BY article.id 
    
    /* on ordonne par date de l'article descendant */
    ORDER BY article.ladate DESC;");
$menu = mysqli_query($mysqli, "SELECT * FROM categorie ORDER BY lintitule ASC");
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mes news</title>
        <?php include'../bases-php/bootstrap.php' ?>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h2>Mes news</h2>
                <p class="lead">Les dernières News</p>
                <div id="menu">
                <ul class="nav nav-pills">
                    <li><a href="accueil.php">Accueil</a></li>
                    <?php
                    while($row= mysqli_fetch_assoc($menu)){

                    echo'<li><a href="section.php?idcateg='.$row['id'].'">'.$row['lintitule'].'</a></li>';
                    
                    }
                    ?>
                </ul>
            </div>
            <div style="clear:both; "></div>
            </div>
            <div class="centre">
                <p>Affichage de toutes les news classées par 'ladate' descendant<br/><br/></p>
                <?php
                while($result = mysqli_fetch_assoc($requete)){
                    echo"<div>";
                    echo'<h4>'.$result['letitre']." <small>  ".
                            $result['ladate']."</small></h4>";
                    echo '<h5>';
                    $categ = explode('*-*',$result['categ']);
                    foreach ($categ as $chaine) {
                        $coupe = explode('-!-',$chaine);
                        $id = $coupe[0];
                        $lintitule = $coupe[1];
                        echo"<a href='section.php?idcateg=$id'>$lintitule</a> ";
                    }
                     echo '</h5>';
                    echo'<p class="small">'.nl2br($result['letexte']).'</p>';
                    echo'<h5>Par <a href="mailto:'.$result['lemail'].'">'.$result['lenom'].'</a></h5>';
                    echo"<hr/></div>";
                }
                ?>
            </div>
            <?php
        $fin = microtime();
        echo ($fin-$debut)." secondes";
        ?>
        </div>
    </div>
</body>
</html>
