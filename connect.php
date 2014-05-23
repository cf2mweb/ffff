<?php
$mysqli=@mysqli_connect('localhost','root','','mesnews'); 

if(mysqli_connect_error($mysqli)){
    echo 'Erreur de connexion num&eacute;ro '.mysqli_connect_errno($mysqli).' qui signifie: '.mysqli_connect_error($mysqli);
    exit();
}
mysqli_set_charset($mysqli, "utf8");
?>