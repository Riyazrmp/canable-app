<?php
try{

$connection = new PDO('mysql:host=localhost;dbname=bellbird_Medusa','bellbird_Medusa','rampur123');
$connection -> setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
echo "connected";
}
catch(PDOExeption $exc){
    echo $exc -> getMessage();
    die ("could not connect");

}

?>