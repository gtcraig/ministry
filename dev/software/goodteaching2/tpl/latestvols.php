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


<div class="card-panel hoverable" id="latestvols">
	<div class="card-content">
		<span class="card-tile">Recently added volumes</span>
		
		
		
<table class="compact-table top-align striped highlight">
<thead>
<tr>
  <th>Servant</th>
  <th>Vol</th>
  <th>Title</th>
  <th>Added</th>
</tr>
</thead>
<tbody>
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
  <td class="right-align"><? echo $vol; ?></td>
  <td><? echo (empty($title)) ? "&nbsp;" : $title; ?></td>
  <td><? echo $added; ?></td>
</tr>
<?    
  }
?>
</tbody>
</table>

	</div>
</div>
