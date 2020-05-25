<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Table of Latest Volumes
 *
 * Who  When         Why
 * CAM  04-Jun-2008  10268 : File created.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<div id="latestvols">
<h3>Recently added volumes</h3>
<table border=1 cellpadding=5 cellspacing=0>
<tr>
  <th>Servant</th>
  <th>Vol</th>
  <th>Title</th>
  <th>Added</th>
</tr>
<?
  $ssql = "SELECT author, vol, title, added ".
          "FROM mse_volume ".
          "ORDER BY added DESC ".
          "LIMIT 6 ";
  $sql = mysqli_query($dbConn, $ssql);
  while ($row = mysqli_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
<tr>
  <td><? echo $author; ?></td>
  <td><? echo $vol; ?></td>
  <td><? echo (empty($title)) ? "&nbsp;" : $title; ?></td>
  <td><? echo $added; ?></td>
</tr>
<?    
  }
?>
</table>
</div>
