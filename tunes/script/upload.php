<?php
// Connecting, selecting database
$link = mysql_connect('localhost', 'itnotio_itnotio', 'cheviot')
   or die('Could not connect: ' . mysql_error());
mysql_select_db('itnotio_hymn') or die('Could not select database');

//Open csv file for processing
$f=fopen("tbl_tune.csv", "r") or die("Can't open csv");

//Get the first line, which contains column names, matched to db field names.
$keys=fgetcsv($f,4096);
$numcols=count($keys); 

//Empty table
mysql_query("TRUNCATE TABLE tbl_tune;");
    
//Start processing through each line of the CSV...
while($data=fgetcsv($f, 4096)) { 
    
    //Pad the array since Excel doesn't always output empty cells correctly.
    $data=array_pad($data,$numcols,"");

    //Put the data into an array with keys
    $data=array_rekey($data, $keys); 

    //Create MySQL query
    $q="INSERT INTO tbl_tune (".implode(",",$keys).") VALUES (".implode(",",$data).");";
    //echo $q;
    mysql_query($q)or die(mysql_error());
    echo "Tune {$data['tune_no']} ENTERED \n\<br>";
}
//Done

//Some functions.
function array_rekey($array, $new_keys) {
    $r = array();
    foreach($array as $a) {
        list(,$newkey) = each($new_keys);
        $a=trim($a); //trim extra spaces
        $r[$newkey] = "\"{$a}\""; //wrap with quotes for insert
        }
    return $r; 
} 

?>
