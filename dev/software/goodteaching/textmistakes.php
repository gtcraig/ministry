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
 * CAM  12-Dec-2015  476204 : Correct query and use non-deprecated MySQL functions.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Text Mistakes";
$tabs = "NONE";
include $root.'tpl/top.php';

$connection = mysqli_connect('127.0.0.1', 'gt_support', 'psalm45', 'gt_support')
              or die ("Couldn't connect to server.");

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
       "  ts.name AS status, " .
       "  t.created, " .
       "  t.updated, " .
       "  tt.poster, " .
       "  IFNULL(tcd.subject, tt.title) title, " .
       "  tt.body " .
       "FROM ost_ticket t, ost_ticket_thread tt, ost_ticket__cdata tcd, ost_ticket_status ts ".
       "WHERE tt.ticket_id = t.ticket_id " .
       "AND tcd.ticket_id = t.ticket_id " .
       "AND ts.id = t.status_id " .
       "AND t.topic_id = 12 " .
       "AND tt.id = (SELECT MIN(id) FROM ost_ticket_thread WHERE ticket_id = t.ticket_id) ".
       "ORDER BY IFNULL(tcd.subject, tt.title), t.created";
              
$ssql = mysqli_query($connection, $sql) or die(mysqli_error());
while ($row = mysqli_fetch_array($ssql, MYSQLI_ASSOC)) {
?>
<tr>
  <td><a href="http://support.goodteaching.org/scp/tickets.php?id=<?=$row["ticket_id"]?>"><? echo $row["number"]; ?></a></td>
  <td><?=$row["created"]?></td>
  <td><?=$row["status"]?></td>
  <td><?=empty($row["title"]) ? "&nbsp;": $row["title"] ?></td>
  <td><?=empty($row["body"]) ? "&nbsp;": $row["body"] ?></td>
</tr>
<?
}
?>
</table>
<?
include $root.'tpl/bot.php';
?>