<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2019 Southesk.com
 *
 * 1962 Hymn Book Search CSS
 *
 * Who  When         Why
 * CAM  23-Dec-2009  xxxx : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$root = "../";
include_once $root.'Main.php';

$tune_id = NULL;     if (!empty($_GET['tune_id'])) $tune_id = $_GET['tune_id'];

$tuneSql = "SELECT t.tune_name, t.tune_url, ".
  "t.tune_book_name, t.tune_no, t.tune_author, ".
  "m.meter, m.rhythm, m.chorus ".
  "FROM hymn_tune t ".
  "INNER JOIN hymn_meter m ".
  "ON m.id=t.meter_id ".
  "WHERE t.tune_id=" . $tune_id . " " .
  "ORDER BY t.tune_name";

$res = mysql_query($tuneSql) or die("<h1>Query failed</h1><pre>$tuneSql</pre>");
if ($row = mysql_fetch_assoc($res)) {
?>
	<html><head><title><? echo $row["tune_book_name"] . " " . $row["tune_no"] . " &mdash; &ldquo;" . $row["tune_name"] .  "&rdquo;";?></title>
	<style>
	  body {
      background-color: black;
    }
	  * {
	  padding: 1px;
    margin: 1px;
    color: white;
    font-family: "Verdana";
	 }
	</style>
	</head>
	<body>
<?
  echo "<h2>" . $row["tune_book_name"] . " " . $row["tune_no"] . " &mdash; &ldquo;" . $row["tune_name"] .  "&rdquo;</h2>";
  echo "<h3>" . $row["meter"];
  if (!empty($row["rhythm"])) echo " <i>" . $row["rhythm"] ."</i>";
  if (!empty($row["chorus"])) echo " Chorus " . $row["chorus"];
  echo "</h3>";
	echo "<h4 style='text-align:right;'>" . $row["tune_author"] . "</h4>";
	echo "<iframe src='" . $row["tune_url"] . "' width=500 height=80></frame>";
}
?>
	</body>
	</html>
<?

