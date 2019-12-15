<? 
$level="../";
include("{$level}_dbconnect.inc");
include("{$level}_header.inc");

//Now do tunes
$query="SELECT * FROM tbl_hymn GROUP BY hymn_meter ORDER BY hymn_meter";
$result = mysql_query($query) or die("Query failed : " . mysql_error());
echo "<h3 class=\"pad\">Tunes from Little Flock Tunebook</h3>";
echo "<table class=\"pad\">";
while($row=mysql_fetch_array($result)){
$query2="SELECT * FROM tbl_tune WHERE tune_meter='".$row['hymn_meter']."'";
$result2 = mysql_query($query2) or die("Query failed : " . mysql_error());
	echo "<tr id=\"{$row['hymn_meter']}\">";
		echo "<td><a href=\"../hymnbymeter.php?meter={$row['hymn_meter']}\">{$row['hymn_meter']}</a></td>";
		echo "<td>";  while($row2=mysql_fetch_array($result2)){echo "<a href='{$row2['file_name']}'>{$row2['tune_name']}</a>, ";} echo "</td>";
	echo "</tr>";
}
echo "</table>";
include("{$level}_footer.inc");
?>
