<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Tune Search Functions
 *
 * Who  When         Why
 * CAM  30-May-2020  909743 : File Created.
 * KED  11-May-2026  Replaced short tags, cleaned up layout.
 * * * * * * * * * * * * * * * * * * * * * * * */

function select_books($dbConn, $book_name) {
?><select <?php dropdownFocus(); ?> name="book_name" id="book_name" class="dropdown">
      <option value="ALL">All Books</option>
<?php
  $sSql = "SELECT tune_book_name ".
          "FROM hymn_tune ".
          "WHERE tune_book_name IS NOT NULL ".
          "GROUP BY tune_book_name ".
          "ORDER BY COUNT(*) DESC";
  $res = mysqli_query($dbConn, $sSql) or die("</select><h1>Query failed</h1><pre>$sSql</pre>");

  while ($row = mysqli_fetch_row($res)) {
    $sel = "";
    if ($row[0] == $book_name) {
      $sel = "selected ";
    }
?>
    <option <?php echo $sel; ?>value="<?php echo $row[0]; ?>"><?php echo $row[0]; ?></option>
<?php
  }

  mysqli_free_result($res);
?></select><?php
}

function output_tune_table_start() {
?>
<table border=0 cellspacing=0 cellpadding=4>
<?php
}

function output_tune_line($tune_id, $tune_book, $tune_no, $tune_name, $meter, $author) {
  $book_name = str_replace("Book", "", $tune_book);
?>
  <tr>
    <td><?php echo $book_name; ?></td>
    <td><a href="javascript:void();" onClick="view_tune('<?php echo $tune_id; ?>');return false;"><?php echo nbsp($tune_no); ?></a></td>
    <td><b><?php echo $tune_name; ?></b></td>
    <td><?php echo $meter; ?></td>
    <td><?php echo $author; ?></td>
  </tr>
<?php
}

function output_tune_table_end() {
?>
</table>
<?php
}

function tune_search($dbConn, $book_name, $tune_no, $keywordsList, $authorList, $meter_id, $searchDesc) {
  global $database, $language;

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

  foreach ($keywordsList as $keyword) {
    if (!empty($keyword)) {
      if ($whereClause != "") $whereClause .= "AND ";
      $whereClause .= "t.tune_name LIKE '%" . $keyword . "%' ";
    }
  }

  foreach ($authorList as $auth) {
    if (!empty($auth)) {
      if ($whereClause != "") $whereClause .= "AND ";
      $whereClause .= "t.tune_author LIKE '%" . $auth . "%' ";
    }
  }

  if (!empty($meter_id) && $meter_id != "ALL") {
    if ($whereClause != "") $whereClause .= "AND ";
    $whereClause .= "t.meter_id='$meter_id' ";
  }

  // Ensure we have something to search on
  if (empty($whereClause)) $whereClause = "1 ";

  $verseSql = "SELECT t.tune_id, t.tune_book_name, t.tune_no, t.tune_name, m.meter, t.tune_author ".
              "FROM hymn_tune t INNER JOIN hymn_meter m ON m.id=t.meter_id ".
              "WHERE $whereClause ".
              "ORDER BY t.tune_book_name, t.tune_no";

  $res = mysqli_query($dbConn, $verseSql) or die("</select><h1>Query failed</h1><pre>$verseSql</pre>");
  output_tune_table_start();
  while ($row = mysqli_fetch_row($res)) {
    output_tune_line($row[0], $row[1], $row[2], $row[3], $row[4], $row[5]);
  }
  output_tune_table_end();
}

function show_tune($dbConn, $tune_id) {
?>
  <table border=0 cellspacing=0 cellpadding=0 width="100%"><tr><td>
<?php
  $tuneSql = "SELECT t.tune_name, t.tune_url, ".
    "t.tune_book_name, t.tune_no, t.tune_author, ".
    "m.meter, m.rhythm, m.chorus ".
    "FROM hymn_tune t ".
    "INNER JOIN hymn_meter m ON m.id=t.meter_id ".
    "WHERE t.tune_id=" . $tune_id . " ".
    "ORDER BY t.tune_name";

  $res = mysqli_query($dbConn, $tuneSql) or die("<h1>Query failed</h1><pre>$tuneSql</pre>");
  if ($row = mysqli_fetch_assoc($res)) {
    echo "<h2>" . $row["tune_book_name"] . " " . $row["tune_no"] . " &mdash; &ldquo;" . $row["tune_name"] . "&rdquo;</h2>";
    echo "<h3>" . $row["meter"];
    if (!empty($row["rhythm"])) echo " <i>" . $row["rhythm"] . "</i>";
    if (!empty($row["chorus"])) echo " Chorus " . $row["chorus"];
    echo "</h3>";
    echo "<h4 style='text-align:right;'>" . $row["tune_author"] . "</h4>";
    echo "<audio autoplay controls src='" . $row["tune_url"] . "' type='audio/mp3'>";
    echo "Your browser does not support the audio element.";
    echo "</audio>";
  }
?>
  </td></tr></table>
<?php
}
?>