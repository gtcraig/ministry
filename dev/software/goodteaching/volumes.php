<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2014 frontburner.co.uk
 *
 * Volume Information
 *
 * Who  When         Why
 * CAM  19-Oct-2014  File created.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Volume Titles";
$tabs = "NONE";
$root = "./";
include $root.'tpl/top.php';

?>
<table border=1 cellpadding=5 cellspacing=0 width="100%">
<tr>
  <th>Author</th>
  <th>Vol</th>
  <th>Title</th>
</tr>
<?

$sql = "SELECT author,vol,title ".
       "FROM mse_volume ".
       "ORDER BY author, vol";

$ssql = mysqli_query($dbConn, $sql);
while ($row = mysqli_fetch_array($ssql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if (empty($title)) {
    $title = $author . " V" . str_pad($vol, ($author == 'JT' ? 3 : 2), '0', STR_PAD_LEFT);
    $title .= " <a href=\"mailto:support@goodteaching.org?Subject=Volume%20Title%20Suggestion%20-%20" .
      str_replace(" ", "%20", $title) . "\">Make a suggestion for the title for this volume</a>";
  }
?>
<tr>
  <td><? echo $author; ?></td>
  <td><? echo $vol; ?></td>
  <td><? echo $title; ?></td>
</tr>
<?
}
?>
</table>
<?
include $root.'tpl/bot.php';
?>