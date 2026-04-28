<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * 1962 Hymn Book Player
 *
 * Who  When         Why
 * CAM  23-Dec-2019  Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$root = "../";
include_once $root.'Main.php';

$hymn_no = NULL;     if (!empty($_GET['hymn_no'])) $hymn_no = $_GET['hymn_no'];
$tune_id = NULL;     if (!empty($_GET['tune_id'])) $tune_id = $_GET['tune_id'];

$tuneSql = "SELECT s.hymn_no, s.title, a.fullname hymn_author_name, s.sing_url, s.recorded_by, ".
  "t.tune_name, t.tune_book_name, t.tune_no, t.tune_author, ".
  "m.meter, m.rhythm, m.chorus ".
  "FROM hymn_sing s ".
  "INNER JOIN hymn_tune t ON t.tune_id=s.tune_id ".
  "INNER JOIN hymn_meter m ON m.id=t.meter_id ".
  "INNER JOIN hymn h ON h.hymn_no=s.hymn_no ".
  "INNER JOIN authors a ON a.id=h.author_id ".
  "WHERE s.hymn_no=" . $hymn_no . " AND s.tune_id=" . $tune_id . " " .
  "ORDER BY t.tune_name";

$res = mysqli_query($dbConn, $tuneSql) or die("<h1>Query failed</h1><pre>$tuneSql</pre>");
if ($row = mysqli_fetch_assoc($res)) {
?>
	<html><head><title><? echo "Hymn " . $row["hymn_no"] . " &mdash; &ldquo;" . $row["title"] .  "&rdquo;";?></title>
	<style>
	  body {
      background-color: black;
    }
	  * {
	  padding: 1px;
    margin: 1px;
    color: white;
    font-family: "Georgia";
	 }
	</style>
	</head>
	<body>
<?
  echo "<h2>Hymn " . $row["hymn_no"] . " &mdash; &ldquo;" . $row["title"] .  "&rdquo;</h2>";
	echo "<h4>" . $row["hymn_author_name"] . "</h4>";
  echo "<h3 style='text-align:right;'>" . $row["tune_book_name"] . " " . $row["tune_no"] . " &mdash; &ldquo;" . $row["tune_name"] .  "&rdquo;</h3>";
  echo "<h3 style='text-align:right;'>" . $row["meter"];
  if (!empty($row["rhythm"])) echo " <i>" . $row["rhythm"] ."</i>";
  if (!empty($row["chorus"])) echo " Chorus " . $row["chorus"];
  echo "</h3>";
	echo "<h4 style='text-align:right;'>" . $row["tune_author"] . "</h4>";
	echo "<center>";
	echo "<audio autoplay controls src='" . $row["sing_url"] . "'>Audio not supported by your browser</audio>";
	echo "<h5 style='padding-top:10px; text-align:center;'>Recorded by " . $row["recorded_by"] . "</h5>";
	echo "</center>";
}
?>
	</body>
	</html>
<?

