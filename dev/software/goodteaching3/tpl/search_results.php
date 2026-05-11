<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Search Results Pane
 *
 * Who  When         Why
 * CAM  19-Aug-2007  File created.
 * CAM  15-Oct-2007  10187 : Pass Book reference to SqlFactory.
 * CAM  25-Oct-2007  10187 : Added Verse Start to search.
 * CAM  08-Nov-2007  10200 : Added Results Pagination.
 * CAM  12-Nov-2007  10201 : Fixed bug.
 * CAM  18-Nov-2007  10205 : Reset PageNo to 1 if new query (and send email).
 * CAM  29-Dec-2007  10211 : Call the highlight function with SqlFactory.
 * CAM  28-Mar-2009  10407 : Added Search Type.
 * CAM  12-Apr-2009  10419 : Changed session vars to include module name.
 * CAM  05-Sep-2015  159308 : Pass new primary flag to SqlFactory and show article title in place of initials.
 * CAM  06-Dec-2015  863707 : Check session variables before setting to remove log errors.
 * CAM  12-Dec-2015  476204 : Check session variables are set before referencing.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * KED  11-May-2026  Replaced short tags, replaced deprecated mysql_error() with mysqli_error().
 * KED 11-May-2026   Replaced page button to go to the reader view instead
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once($root.'functions.php');

global $cfg, $dbConn;

$keywords   = isset($_SESSION['search_min_keywords']) ? $_SESSION['search_min_keywords'] : "";
$searchType = isset($_SESSION['search_min_type'])     ? $_SESSION['search_min_type']     : "";
$author     = isset($_SESSION['search_min_author'])   ? $_SESSION['search_min_author']   : "";
$bookid     = isset($_SESSION['search_min_bookid'])   ? $_SESSION['search_min_bookid']   : "";
$chapter    = isset($_SESSION['search_min_chapter'])  ? $_SESSION['search_min_chapter']  : "";
$vstart     = isset($_SESSION['search_min_vstart'])   ? $_SESSION['search_min_vstart']   : "";
$primary    = isset($_SESSION['search_min_primary'])  ? $_SESSION['search_min_primary']  : "";

$prevQuery = isset($_SESSION['search_previous']) ? $_SESSION['search_previous'] : "";
$thisQuery = f_search_parameter_string();
$newQuery  = ($prevQuery != $thisQuery);
$_SESSION['search_previous'] = $thisQuery;

if ($newQuery && $cfg['Site']['Status'] == "Production") {
  //$em = new EmailMsg();
  //$em->sendNewQuery($thisQuery);
}

$pageNo = isset($_SESSION['results_pageno']) ? $_SESSION['results_pageno'] : 0;
if (isset($_POST['results_pageno'])) $pageNo = $_POST['results_pageno'];
if (($pageNo == "") || ($pageNo == "0") || $newQuery) $pageNo = 1;
$_SESSION['results_pageno'] = $pageNo;

$sqlFactory = new SqlFactory("mse_text", "t.author, t.vol, t.page, t.para, t.inits, t.text", "t.author, t.vol, t.page");

$showBibleRef = false;

if (!empty($keywords)) {
  $sqlFactory->setSearchText($keywords);
}
if (!empty($searchType)) {
  $sqlFactory->setSearchType($searchType);
}
if ((count((array)$author) > 0) && (empty($author['ALL']))) {
  $sqlFactory->setAuthors($author);
}
if (!empty($bookid) && (!empty($chapter) || !empty($vstart))) {
  $sqlFactory->setBookRef($bookid, $primary, $chapter, $vstart);
  if (empty($keywords)) $showBibleRef = true;
}

if ($sqlFactory->isSearch()) {
  $rowCount = 0;

  $ssql = mysqli_query($dbConn, $sqlFactory->getSql(true)) or die(mysqli_error($dbConn));
  if ($row = mysqli_fetch_array($ssql)) {
    $rowCount = $row[0];
  }

  $maxRows = 10;

  if ($rowCount > $maxRows) {
    $sqlFactory->setLimit($maxRows, $pageNo);
?>
<table align=center border=0 cellpadding=4 cellspacing=0><tr><td class="pageannot">Pages</td>
<?php
    $j            = 0;
    $maxPages     = 7;
    $eitherSide   = 2;
    $lastPageToShow = round($rowCount / $maxRows) - ($eitherSide - 1);

    if ($pageNo == 1) $eitherSide = 5;

    $resultsPage  = "";
    $middleStart  = $pageNo - $eitherSide;
    $middleEnd    = $pageNo + $eitherSide;

    if ($pageNo < $maxPages) {
      $middleStart = 0;
      $middleEnd   = $maxPages;
    }

    for ($i = 0; $i < $rowCount; $i += $maxRows) {
      $j++;

      if (($j <= 2) || (($j >= $middleStart) && ($j <= $middleEnd)) || ($j >= $lastPageToShow)) {
        if ($j == $pageNo) {
          $resultsPage = "<td class=\"pagesel\">$j</td>";
        } else {
          $resultsPage = "<td><input type=hidden name=results_pageno value=\"$j\">".
            ActionUtil::submitButton($j, "pagebutton", "pagebuttonhover")."</td>";
        }
        ?><form method="post"><?php echo $resultsPage; ?></form><?php

      } else if (($j == ($middleStart - 1)) || ($j == ($middleEnd + 1))) {
        ?><td>...</td><?php
      }
    }
?>
<td class="pageannot"><?php echo "(" . number_format($rowCount) . " results)"; ?></td></tr></table>
<?php
  }
}
?>

<table border=0 cellpadding=3 cellspacing=0 width="100%">
  <tr>
    <th class="rh" width="50">Servant<br>Vol</th>
    <th class="rh" width="40">Page</th>
    <?php if ($primary): ?>
      <th class="rh">Title</th>
      <th class="rh">Scriptures</th>
    <?php else: ?>
      <th class="rh" width="50">Inits</th>
      <th class="rh">Text</th>
    <?php endif; ?>
  </tr>

<?php
if ($sqlFactory->isSearch()) {
  $ssql = mysqli_query($dbConn, $sqlFactory->getSql()) or die(mysqli_error($dbConn));
  while ($row = mysqli_fetch_array($ssql)) {
    foreach ($row AS $key => $val) {
      $$key = stripslashes($val ?? '');
    }

    if (empty($inits)) $inits = "&nbsp;";

    $preview = "<a href=\"reader.php?author=" . urlencode($author) . 
           "&vol=" . $vol . 
           "&page=" . $page . 
           "\" class=\"previewbutton\" style=\"display:inline-block;padding:3px 8px;\">$page</a>";
?>
<form method="post">
<tr>
  <td class="rd"><b><?php echo $author; ?></b>&nbsp;<?php echo $vol; ?></td>
  <td class="rd"><?php echo $preview; ?></td>
  <?php if ($primary): ?>
    <td class="rd red"><?php echo $article; ?></td>
    <td class="rd"><?php echo f_highlight_text($text, $sqlFactory, true); ?></td>
  <?php else: ?>
    <td class="rd"><b><?php echo $inits; ?></b></td>
    <td class="rd"><?php echo f_highlight_text($text, $sqlFactory, true); ?></td>
  <?php endif; ?>
</tr>
</form>
<?php
  }
}
?>
</table>