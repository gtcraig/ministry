<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007,2015 frontburner.co.uk
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
 * RWM  05-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once($root.'functions.php');

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

$pageNo = $_SESSION['results_pageno'];  if (isset($_POST['results_pageno'])) $pageNo = $_POST['results_pageno'];

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

if (!empty($bookid) && !empty($chapter)) {
  $sqlFactory->setBookRef($bookid, $primary, $chapter, $vstart);

  if (empty($keywords)) $showBibleRef = true;
}

if ($sqlFactory->isSearch()) {
  $rowCount = 0;
  $ssql = mysql_query($sqlFactory->getSql(true)) ; //or die(mysql_error());
  if ($row = mysql_fetch_array($ssql)) {
    $rowCount = $row[0];
  }

  $maxRows = 10;

  if ($rowCount > $maxRows) {
    $sqlFactory->setLimit($maxRows, $pageNo);
	
  ?>
  <p>Pages <ul class="center pagination">
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
          $resultsPage = "<li>$j</li>";
        } else {
          $resultsPage = "<li><input type=hidden name=results_pageno value=\"$j\">".
             ActionUtil::submitButton($j, "pagebutton", "pagebuttonhover")."</li>";
        }

        ?><form method="post"><?php echo "$resultsPage"; ?></form><?php

      } else if (($j == ($middleStart-1)) || ($j == ($middleEnd+1))) {
        // In between just show an ellipsis
        ?><li>...</li><?php

      }
    }
?>
</ul> &emsp; <span class="counter"><?php echo "(" . number_format($rowCount); ?></span></p>
<?php
  }
}
?>

<table class="striped highlight compact-table"><thead>
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
  </tr></thead><tbody>
<?php
if ($sqlFactory->isSearch()) {
  $ssql = mysql_query($sqlFactory->getSql()) ; //or die(mysql_error());
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if (empty($inits)) $inits = "&nbsp;";

    $preview = "<input type=hidden name=preview_author value=\"$author\">".
               "<input type=hidden name=preview_vol value=\"$vol\">".
               "<input type=hidden name=preview_page value=\"$page\">".
               ActionUtil::submitButton($page, "previewbutton", "previewbuttonhover");

?><tr><form method="post">
  <td class="rd"><b><?=$author?></b>&nbsp;<?=$vol?></td>
  <td class="rd"><?=$preview?></td>
<? if ($primary) { ?>
    <td class="rd red"><?=$article?></td>
    <td class="rd"><?=f_highlight_text($text, $sqlFactory, true)?></td>
<? } else { ?>
    <td class="rd"><b><?=$inits?></b></td>
    <td class="rd"><?=f_highlight_text($text, $sqlFactory, true)?></td>
<? } ?>

</form></tr><?php
  }
}
?>
</tbody></table>