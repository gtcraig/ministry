<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
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
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once($root.'functions.php');

global $cfg, $dbConn;

$keywords = isset($_SESSION['search_min_keywords']) ? $_SESSION['search_min_keywords']: "";
$searchType = isset($_SESSION['search_min_type']) ? $_SESSION['search_min_type']: "";
$author = isset($_SESSION['search_min_author']) ? $_SESSION['search_min_author']: "";
$bookid = isset($_SESSION['search_min_bookid']) ? $_SESSION['search_min_bookid']: "";
$chapter = isset($_SESSION['search_min_chapter']) ? $_SESSION['search_min_chapter']: "";
$vstart = isset($_SESSION['search_min_vstart']) ? $_SESSION['search_min_vstart']: "";
$primary = isset($_SESSION['search_min_primary']) ? $_SESSION['search_min_primary']: "";

$prevQuery  = isset($_SESSION['search_previous']) ? $_SESSION['search_previous']: "";
$thisQuery  = f_search_parameter_string();
$newQuery   = ($prevQuery != $thisQuery);
$_SESSION['search_previous'] = $thisQuery;

if ($newQuery && $cfg['Site']['Status'] == "Production") {
 //$em = new EmailMsg();
 //$em->sendNewQuery($thisQuery);
}

$pageNo = isset($_SESSION['results_pageno'])?$_SESSION['results_pageno']:0;  // Retrieve PageNo from Session
if (isset($_POST['results_pageno'])) $pageNo = $_POST['results_pageno'];

if (($pageNo == "") || ($pageNo == "0") || $newQuery) $pageNo = 1; $_SESSION['results_pageno'] = $pageNo;

$sqlFactory = new SqlFactory("mse_text", "t.author, t.vol, t.page, t.para, t.inits, t.text", "t.author, t.vol, t.page");

$showBibleRef = false;

if (!empty($keywords)) {
  $sqlFactory->setSearchText($keywords);
}

if (!empty($searchType)) {
  $sqlFactory->setSearchType($searchType);
}

if ((count($author)>0) && (empty($author['ALL']))) {
  $sqlFactory->setAuthors($author);
}

if (!empty($bookid) && (!empty($chapter) || !empty($vstart))) {
  $sqlFactory->setBookRef($bookid, $primary, $chapter, $vstart);
  if (empty($keywords)) $showBibleRef = true;
}

if ($sqlFactory->isSearch()) {
  $rowCount = 0;

  $ssql = mysqli_query($dbConn, $sqlFactory->getSql(true)) or die(mysql_error());
  if ($row = mysqli_fetch_array($ssql)) {
    $rowCount = $row[0];
  }

  $maxRows = 10;

  if ($rowCount > $maxRows) {
    $sqlFactory->setLimit($maxRows, $pageNo);
  ?>
  <table align=center border=0 cellpadding=4 cellspacing=0><tr><td class="pageannot">Pages</td>
  <?php
    $j = 0;
    $maxPages = 7;
    $eitherSide = 2;
    $lastPageToShow = round($rowCount / $maxRows)- ($eitherSide - 1);  // a page back from the end - i.e. show the last two in a long list

    if ($pageNo == 1) $eitherSide = 5;

    $resultsPage = "";

    $middleStart = $pageNo-$eitherSide;
    $middleEnd = $pageNo+$eitherSide;
    if ($pageNo < $maxPages) {
      $middleStart = 0;
      $middleEnd = $maxPages;
    }

    for ($i = 0; $i < $rowCount; $i += $maxRows) {
      $j++;

      if (($j <= 2) || (($j >= ($middleStart)) && ($j <= ($middleEnd))) || ($j >= $lastPageToShow)) {
        // Display up to the max pages, or the last few pages

        if ($j == $pageNo) {
          $resultsPage = "<td class=\"pagesel\">$j</td>";
        } else {
          $resultsPage = "<td><input type=hidden name=results_pageno value=\"$j\">".
             ActionUtil::submitButton($j, "pagebutton", "pagebuttonhover")."</td>";
        }

        ?><form method="post"><?php echo "$resultsPage"; ?></form><?php

      } else if (($j == ($middleStart-1)) || ($j == ($middleEnd+1))) {
        // In between just show an ellipsis
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
<? if ($primary) { ?>
    <th class="rh">Title</th>
    <th class="rh">Scriptures</th>
<? } else { ?>
    <th class="rh" width="50">Inits</th>
    <th class="rh">Text</th>
<? } ?>
  </tr>
<?php
if ($sqlFactory->isSearch()) {
  $ssql = mysqli_query($dbConn, $sqlFactory->getSql()) or die(mysql_error());
  while ($row = mysqli_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if (empty($inits)) $inits = "&nbsp;";

    $preview = "<input type=hidden name=preview_author value=\"$author\">".
               "<input type=hidden name=preview_vol value=\"$vol\">".
               "<input type=hidden name=preview_page value=\"$page\">".
               ActionUtil::submitButton($page, "previewbutton", "previewbuttonhover");

?><form method="post"><tr>
  <td class="rd"><b><?=$author?></b>&nbsp;<?=$vol?></td>
  <td class="rd"><?=$preview?></td>
<? if ($primary) { ?>
    <td class="rd red"><?=$article?></td>
    <td class="rd"><?=f_highlight_text($text, $sqlFactory, true)?></td>
<? } else { ?>
    <td class="rd"><b><?=$inits?></b></td>
    <td class="rd"><?=f_highlight_text($text, $sqlFactory, true)?></td>
<? } ?>

</tr></form><?php
  }
}
?>
</table>