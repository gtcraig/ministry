<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2008 frontburner.co.uk
 *
 * Table of Latest Volumes
 *
 * $Id: latestvols.php 838 2008-06-04 06:46:18Z craig $
 *
 * Who  When         Why
 * CAM  04-Jun-2008  10268 : File created.
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
  $sql = mysql_query($ssql);
  while ($row = mysql_fetch_array($sql)) {
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
