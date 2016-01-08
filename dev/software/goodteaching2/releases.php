<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2008,2009 frontburner.co.uk
 *
 * Release History
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Oct-2014  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Volume Titles";
$tabs = "NONE";
include $root.'tpl/top.php';

?>
<table border=1 cellpadding=5 cellspacing=0 width="100%">
<tr>
  <th>Release</th>
  <th>Task</th>
  <th>Description</th>
  <th>Completion Date</th>
</tr>
<?
$sql = "SELECT release_no, task_id, description, completion_date ".
       "FROM mse_release_history ".
       "ORDER BY 4 DESC, 1 DESC, 2";

$prev_release_no = "";
$ssql = mysql_query($sql);
while ($row = mysql_fetch_array($ssql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
?>
<tr>
  <td><b><? echo ($prev_release_no != $release_no) ? $release_no: "&nbsp;"; ?></b></td>
  <td><? echo $task_id; ?></td>
  <td><? echo $description; ?></td>
  <td><? echo $completion_date; ?></td>
</tr>
<?
  $prev_release_no = $release_no;
}
?>
</table>
<?
include $root.'tpl/bot.php';
?>