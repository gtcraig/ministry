<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * New Search Wizard
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Attempt to send empty using NULL.
 * CAM  08-Nov-2007  10200 : Added results_pageno.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  28-Mar-2009  10407 : Added Search Type.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and changed session vars to include module name.
 * CAM  30-Dec-2009  10520 : Add focus formatting for textboxes.
 * CAM  04-Dec-2015  863707 : Added improved search options.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Keyword Search";
$tab = "KEYWORD";
$tabs = "MINISTRY";
include $root.'tpl/top.php';

$keywords = $_SESSION['search_min_keywords'];  if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];
$searchType = $_SESSION['search_min_type'];  if (!empty($_POST['search_min_type'])) $searchType = $_POST['search_min_type'];

if ($keywords == "NULL") $keywords = "";
if (empty($searchType)) $searchType = "ALL";

$keywords = str_replace("\\\"", "", $keywords);
$keywords = str_replace("\\'", "", $keywords);
$keywords = str_replace("\\", "", $keywords);
$keywords = str_replace("  ", " ", $keywords);

if ($keywords == "") {
  // Ignore
} else if ($searchType == "ALL") {
  $keywords = SqlFactory::addAndOperators($keywords);
} else if (($searchType == "ANY") || ($searchType == "PHRASE")) {
  $keywords = SqlFactory::removeOperators($keywords);
}

$_SESSION['search_min_keywords'] = $keywords;
$_SESSION['search_min_type'] = $searchType;

?>
<form action="keyword.php" method="post" name=searchText id=searchText>
<table border=0 cellpadding=10>
<tr><td align=left colspan=3>
<?php
  $q = "Type one or more keywords";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname() . ",";
  }
  $q .= " and click Search:";

  Msg::statement($q);

?></td></tr>
<tr>
  <td>
    <input <? fieldFocus(); ?> name="keywords" id="keywords" size=50 value="<?php echo $keywords; ?>">
    <input type=hidden name="results_pageno" id="results_pageno" value="0">
  </td>
  <td><?php echo ActionUtil::submitButton("Search", "button", "buttonhover", "submitSearchText();"); ?></td>
  <td width="100%"><div id=searchType><ul>
    <li><input <?php if ($searchType == "ALL") echo "CHECKED"; ?> type=radio id=st_all name=search_min_type value="ALL"><label for="st_all">All Words</label></li>
    <li><input <?php if ($searchType == "ANY") echo "CHECKED"; ?> type=radio id=st_any name=search_min_type value="ANY"><label for="st_any">Any Words</label></li>
    <li><input <?php if ($searchType == "CUSTOM") echo "CHECKED"; ?> type=radio id=st_custom name=search_min_type value="CUSTOM"><label for="st_custom">Custom</label></li>
    <li><input <?php if ($searchType == "PHRASE") echo "CHECKED"; ?> type=radio id=st_phrase name=search_min_type value="PHRASE"><label for="st_phrase">Exact Phrase</label></li>
  </ul></div></td>
</tr>
</table>
</form>
<?php
include $root.'tpl/results.php';
include $root.'tpl/bot.php';
?>