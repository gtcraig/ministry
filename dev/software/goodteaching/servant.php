<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * Author Filter
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10204 : Added calls to Servant checkbox functions.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and changed session vars to include module name.
 * CAM  12-Dec-2015  476204 : Check session variables are set before referencing.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Servant Filter";
$tab = "author";
$tabs = "MINISTRY";
include $root.'tpl/top.php';

$author_filter = isset($_SESSION['search_min_author'])?$_SESSION['search_min_author']:"";  if (!empty($_POST['author_filter'])) $author_filter = $_POST['author_filter'];
$_SESSION['search_min_author'] = $author_filter;

?>
<form action="servant.php" method="post">
<table border=0 cellpadding=10>
<tr><td align=left colspan=2>
<?
  $q = "Select one or more Servants";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname() . ",";
  }
  $q .= " and click Search:";

  Msg::statement($q);

  $checked = "";
  if (!empty($author_filter['ALL'])) $checked = "CHECKED";

?></td></tr>
<tr>
  <td width="100%"><input type="checkbox" <? echo $checked; ?> name="author_filter[ALL]" id="author_filter[ALL]" value="ALL" onclick="toggleServants(this);return true;">All&nbsp;<?

$sql = "SELECT author, name FROM mse_author ORDER BY author";

$ssql = mysql_query($sql);
while ($row = mysql_fetch_array($ssql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $checked = "";
  if (!empty($author_filter[$author]) && empty($author_filter['ALL'])) {
    $checked = "CHECKED";
  }

?>
<input type="checkbox" <? echo $checked; ?> name="author_filter[<? echo $author; ?>]" id="author_filter[<? echo $author; ?>]" value="<? echo $author; ?>" onclick="uncheckAll();return true;"><? echo $name; ?>&nbsp;
<?
}

  ?></td>
  <td width="100%"><? echo ActionUtil::submitButton("Search"); ?></td>
</tr>
</table>
</form>
<?
include $root.'tpl/results.php';
include $root.'tpl/bot.php';
?>