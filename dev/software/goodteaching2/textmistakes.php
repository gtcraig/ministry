<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2015 frontburner.co.uk
 *
 * Release History
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Jan-2015  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Text Mistakes";
$tabs = "NONE";
include $root.'tpl/top.php';

$connection = mysql_pconnect('localhost', 'gt_support', 'psalm45')
              or die ("Couldn't connect to server.");

$db = mysql_select_db('gt_support', $connection)
      or die("Couldn't select database.");

?>
<table border=1 cellpadding=5 cellspacing=0 width="100%">
<tr>
  <th>Number</th>
  <th>Created</th>
  <th>Status</th>
  <th>Title</th>
  <th>Mistake Detail</th>
</tr>
<?

$sql = "SELECT " .
       "  t.ticket_id, " .
       "  t.number, " .
       "  t.status, " .
       "  t.created, " .
       "  t.updated, " .
       "  tt.poster, " .
       "  IFNULL(tcd.subject, tt.title) title, " .
       "  tt.body " .
       "FROM ost_ticket t, ost_ticket_thread tt, ost_ticket__cdata tcd ".
       "WHERE tt.ticket_id = t.ticket_id " .
       "AND tcd.ticket_id = t.ticket_id " .
       "AND t.topic_id = 12 " .
       "AND tt.id = (SELECT MIN(id) FROM ost_ticket_thread WHERE ticket_id = t.ticket_id) ".
       "ORDER BY IFNULL(tcd.subject, tt.title), t.created";

$ssql = mysql_query($sql);
while ($row = mysql_fetch_array($ssql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
?>
<tr>
  <td><a href="http://support.goodteaching.org/scp/tickets.php?id=<?=$ticket_id?>"><? echo $number; ?></a></td>
  <td><?=$created?></td>
  <td><?=$status?></td>
  <td><?=empty($title) ? "&nbsp;": $title ?></td>
  <td><?=empty($body) ? "&nbsp;": $body ?></td>
</tr>
<?
}
?>
</table>
<?
include $root.'tpl/bot.php';
?>