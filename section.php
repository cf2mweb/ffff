<?php
$debut = microtime();
require'connect.php';

if (isset($_GET['idcateg']) && ctype_digit($_GET['idcateg'])) {
    $idcateg = $_GET['idcateg'];
} else {
    // si idcateg est absent ou invalide, on redirige vers l'accueil
    header("location: accueil.php");
}
$recup = mysqli_query($mysqli, "SELECT c.*,ar.*,ar.id AS les_categs,au.* FROM categorie c
    INNER JOIN jointure j ON c.id = j.categorie_id
    INNER JOIN article ar ON ar.id = j.article_id
    INNER JOIN auteur au ON au.id = ar.auteur_id
    WHERE c.id = $idcateg
    ORDER BY ar.ladate DESC
    ;");
$menu = mysqli_query($mysqli, "SELECT * FROM categorie ORDER BY lintitule ASC");
$compte = mysqli_num_rows($recup);
?><!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Section</title>
        <!-- bootstrap -->
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css">
        <!-- import jquery -->
        <script src='https://code.jquery.com/jquery.min.js'></script>
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//getbootstrap.com/examples/jumbotron-narrow/jumbotron-narrow.css">
        <!-- fin bootsrap -->
    </head>
    <body>
        <div class='container'>
            <div class='header'>
                <h2>Titre <small>suite petit</small></h2>  
                <p class="lead">Sous-titre</p>
            </div>
            <div id="menu">
                <ul class="nav nav-pills">
                    <li><a href="accueil.php" class="small">Accueil</a></li>
                    <?php
                    while ($result = mysqli_fetch_assoc($menu)) {
                        // on est dans la catégorie
                        if ($idcateg == $result['id']) {
                            $actif = " class='active'";
                        } else {
                            $actif = "";
                        }
                        echo "<li$actif>" . '<a href="section.php?idcateg=' . $result['id'] . '" class="small">' . $result['lintitule'] . '</a></li>';
                    }
                    ?>
                </ul>
            </div>
            <div style="clear:both; "></div>
            <div class='centre' style='padding-top: 20px;'>
                <?php
                // vaut vrai si ne vaut pas 0
                if ($compte) {
                    while ($mavar = mysqli_fetch_assoc($recup)) {
                    $tcategs = $mavar['les_categs']; 
                    $req = mysqli_query($mysqli, "SELECT c.* FROM categorie c 
            INNER JOIN jointure j ON c.id = j.categorie_id
            INNER JOIN article a ON a.id = j.article_id
                        WHERE a.id=$tcategs");
                        ?>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><?= $mavar['letitre'] ?> <small><?= $mavar['ladate'] ?></small></h3>
                            </div>
                            <div class="panel-body"> 
                                <h5>
                                    <?php
                                    while($rep= mysqli_fetch_assoc($req)){
                                     echo"<a href='section.php?idcateg=".$rep['id']."'>".$rep['lintitule']."</a> ";   
                                    }
                                    ?>
                                </h5>
                                <p><?= nl2br($mavar['letexte']) ?></p>
                                <h5>Par <a href="mailto:<?= $mavar['lemail'] ?>"><?= $mavar['lenom'] ?></a></h5>
                            </div>
                        </div>
                        <?php
                    }
                    // si pas d'articles
                } else {
                    echo"<h3 class='center'>Pas encore d'articles <small>dans cette rubrique</small></h3>";
                }
                ?>
                <?php
        $fin = microtime();
        echo ($fin-$debut)." secondes";
        ?>
            </div>
        </div>
    </body>
</html>