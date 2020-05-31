<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Tune Search
 *
 * Who  When         Why
 * CAM  30-May-2020  909743 : File Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

function select_books($dbConn, $book_name) {
?><select <? dropdownFocus(); ?> name="book_name" id="book_name" class="dropdown">
      <option value="ALL">All Books</option>
<?
  $sSql = "SELECT tune_book_name ".
              "FROM hymn_tune ".
              "WHERE tune_book_name IS NOT NULL ".
              "GROUP BY tune_book_name";
              "ORDER BY COUNT(*) DESC";
  $res = mysqli_query($dbConn, $sSql) or die("</select><h1>Query failed</h1><pre>$sSql</pre>");

  while ($row = mysqli_fetch_row($res)) {
    $sel = "";
    if ($row[0] == $book_name) {
      $sel = "SELECTED ";
    }
?>
    <option <?echo $sel; ?>value="<? echo $row[0]; ?>"><? echo $row[0]; ?></option>
<?
  }

  mysqli_free_result($res);

?></select><?
}

function output_tune_table_start() {
?>
<table border=0 cellspacing=0 cellpadding=4>
<?
}

function output_tune_line($tune_id, $tune_book, $tune_no, $tune_name, $meter, $author) {
  $book_name = str_replace("Book", "", $tune_book);
?>
  <tr><td><? echo $book_name; ?></td><td><a href="javascript:void();" onClick="view_tune('<? echo $tune_id; ?>');return false;"><? echo nbsp($tune_no); ?></a></td><td><b><? echo $tune_name; ?></b></td><td><? echo $meter; ?></td><td><? echo $author; ?></td></tr>
<?
}

function output_tune_table_end() {
?>
</table>
<?
}

function tune_search($dbConn, $book_name, $tune_no, $keywordsList, $authorList, $meter_id, $searchDesc) {
  global $database, $language, $meter_id;

  describe_search($searchDesc);

  $whereClause = "";

  if (!empty($tune_no)) {
    if ($whereClause != "") $whereClause .= "AND ";
    $whereClause .= "t.tune_no='$tune_no' ";
  }

  if (!empty($book_name) && $book_name != "ALL") {
    if ($whereClause != "") $whereClause .= "AND ";
    $whereClause .= "t.tune_book_name='$book_name' ";
  }

  foreach($keywordsList as $keyword) {
    if (!empty($keyword)) {
      if ($whereClause != "") $whereClause .= "AND ";
      $whereClause .= "t.tune_name LIKE '%".$keyword."%' ";
    }
  }

  foreach($authorList as $auth) {
    if (!empty($auth)) {
      if ($whereClause != "") $whereClause .= "AND ";
      $whereClause .= "t.tune_author LIKE '%".$auth."%' ";
    }
  }

  if (!empty($meter_id) && $meter_id != "ALL") {
    if ($whereClause != "") $whereClause .= "AND ";
    $whereClause .= "t.meter_id='$meter_id' ";
  }

  $verseSql = "SELECT t.tune_id, t.tune_book_name, t.tune_no, t.tune_name, m.meter, t.tune_author " . 
              "FROM hymn_tune t INNER JOIN hymn_meter m ON m.id=t.meter_id ".
              "WHERE $whereClause ".
              "ORDER BY t.tune_book_name, t.tune_no";
//echo "<pre>$verseSql</pre>";
  $res = mysqli_query($dbConn, $verseSql) or die("</select><h1>Query failed</h1><pre>$verseSql</pre>");
  output_tune_table_start();
  while ($row = mysqli_fetch_row($res)) {
    output_tune_line($row[0], $row[1], $row[2], $row[3], $row[4], $row[5]);
  }
  output_tune_table_end();
}



function show_tune($dbConn, $tune_id) {
  global $database;
  $verseCount = 0;
  $meterId = 0;
?>
  <table border=0 cellspacing=0 cellpadding=0 width="100%"><tr><td>
<?

$tuneSql = "SELECT t.tune_name, t.tune_url, ".
  "t.tune_book_name, t.tune_no, t.tune_author, ".
  "m.meter, m.rhythm, m.chorus ".
  "FROM hymn_tune t ".
  "INNER JOIN hymn_meter m ".
  "ON m.id=t.meter_id ".
  "WHERE t.tune_id=" . $tune_id . " " .
  "ORDER BY t.tune_name";

$res = mysqli_query($dbConn, $tuneSql) or die("<h1>Query failed</h1><pre>$tuneSql</pre>");
if ($row = mysqli_fetch_assoc($res)) {
  echo "<h2>" . $row["tune_book_name"] . " " . $row["tune_no"] . " &mdash; &ldquo;" . $row["tune_name"] .  "&rdquo;</h2>";
  echo "<h3>" . $row["meter"];
  if (!empty($row["rhythm"])) echo " <i>" . $row["rhythm"] ."</i>";
  if (!empty($row["chorus"])) echo " Chorus " . $row["chorus"];
  echo "</h3>";
	echo "<h4 style='text-align:right;'>" . $row["tune_author"] . "</h4>";
	echo "<iframe border=0 src='" . $row["tune_url"] . "' width=480 height=250></iframe>";
}
?>
  </td></tr></table>
<?
}
?>