<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Page Preview Pane
 *
 * Who  When         Why
 * CAM  19-Aug-2007  File created.
 * CAM  24-Nov-2007  10210 : Indicate in the Preview Pane where a new page occurs in the physical volume.
 * CAM  29-Dec-2007  10211 : Call the highlight function with SqlFactory.
 * CAM  02-Jan-2008  10206 : Added Page Controls.
 * CAM  15-Jun-2008  10272 : Added footnote class.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  28-Mar-2009  10407 : Added Search Type.
 * CAM  12-Apr-2009  10419 : Changed session vars to include module name.
 * CAM  05-Sep-2015  159308 : Pass new primary flag to SqlFactory.
 * CAM  04-Dec-2015  863707 : Check session variables before setting to remove log errors.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once($root.'functions.php');

$volPages = 0;

function count_vol_pages($dbConn, $author, $vol) {
  global $volPages;

  if ($volPages == 0) {
    $sql = "SELECT MAX(page) vol_pages  ".
           "FROM mse_text ".
           "WHERE author='$author' ".
           "AND vol=$vol ";

    $ssql = mysqli_query($dbConn, $sql);
    if ($row = mysqli_fetch_array($ssql)) {
      $volPages = $row[0];
    }
  }

  return $volPages;
}

function store_session_var($varname) {
  $rval = "";

  if (!empty($_SESSION[$varname])) {
    $rval = $_SESSION[$varname];
  }

  if (!empty($_POST[$varname])) {
    $rval = $_POST[$varname];
    $_SESSION[$varname] = $rval;
  }

  return $rval;
}

$preview_author = store_session_var('preview_author');
$preview_vol    = store_session_var('preview_vol');
$preview_page   = store_session_var('preview_page');

$pagechanged  = isset($_POST["pagechanged"]) ? TRUE : FALSE;
$gotopage     = isset($_POST["gotopage"]) ? $_POST["gotopage"] : "";

if ($pagechanged && !empty($gotopage)) {
  $preview_page = ($gotopage * 1);
}

$keywords = isset($_SESSION['search_min_keywords']) ? $_SESSION['search_min_keywords']: "";
$searchType = isset($_SESSION['search_min_type']) ? $_SESSION['search_min_type']: "";
$author = isset($_SESSION['search_min_author']) ? $_SESSION['search_min_author']: "";
$bookid = isset($_SESSION['search_min_bookid']) ? $_SESSION['search_min_bookid']: "";
$chapter = isset($_SESSION['search_min_chapter']) ? $_SESSION['search_min_chapter']: "";
$vstart = isset($_SESSION['search_min_vstart']) ? $_SESSION['search_min_vstart']: "";
$primary = isset($_SESSION['search_min_primary']) ? $_SESSION['search_min_primary']: "";

$sqlFactory = new SqlFactory();
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
}

if (!empty($preview_author)) {
  count_vol_pages($dbConn, $preview_author, $preview_vol);

  echo "<p align=center><b>$preview_author</b> Volume <b>$preview_vol</b> Page <b>$preview_page</b></p>";

?><table border=0 cellpadding=0 cellspacing=4><?php

  $sql = "SELECT inits, text, page, newpages ".
         "FROM mse_text ".
         "WHERE author='$preview_author' ".
         "AND vol=$preview_vol ".
         "AND page=$preview_page ".
         "ORDER BY para";

  $ssql = mysqli_query($dbConn, $sql);
  while ($row = mysqli_fetch_array($ssql)) {

    $newtext = $row[1];

    if (!empty($row[3])) {
      $charpos = explode(",", $row[3]);
      $newtext = "";
      $prevchar = 0;

      for($i = 0; $i < count($charpos); $i++) {
        $pageNo = ($row[2] + $i + 1);
        $newtext .= trim(substr($row[1], $prevchar, ($charpos[$i] - $prevchar))) . "&nbsp;<span title=\"This paragraph continues on physical Page $pageNo in the printed volume.\" class=\"contNewPage\">$pageNo</span>&nbsp;";
        $prevchar = $charpos[$i];
      }

      $newtext .= trim(substr($row[1], $prevchar));
    }

    $newtext = f_highlight_text($newtext, $sqlFactory);

    if (empty($row[0])) $row[0] = "<img src=\"img/f.gif\" border=0 width=0 height=0>";

    $className = "";
    if (substr($row[1],0,5) === "<span") {
      $className = "fn";
    }
?><tr><td valign=top><b><?php echo $row[0];  ?></b></td><td<?php
  if (!empty($className)) echo " class=\"$className\"";
?>><?php echo $newtext; ?></td></tr><?php
  }

?></table><div align="center" style="padding-top:10px;">
  <form method="POST" id="pageSelector" name="pageSelector">
    <input type=hidden id="pagechanged" name="pagechanged" value="1">
    <table border=0 cellpadding=5 cellspacing=0><tr>
      <td><img width="16" height="16" class="imagebutton" title="Goto first page" src="img/page_first.png" onclick="ChangePageNo(pageSelector, gotopage, 1);"></td>
      <td><img width="16" height="16" class="imagebutton" title="Goto previous page" src="img/page_prev.png" onclick="ChangePageNo(pageSelector, gotopage, <?php echo max(1, ($preview_page-1)); ?>);"></td>
      <td><input class="volpage" id="gotopage" name="gotopage" size=4 value="<?php echo $preview_page; ?>" onKeyUp="ValidationPageNo(this);" onChange="ValidationPageNo(this, <?php echo $volPages; ?>);" onclick="this.className='volpageedit';" onBlur="this.className='volpage';"></td>
      <td><img width="16" height="16" class="imagebutton" title="Goto next page" src="img/page_next.png" onclick="ChangePageNo(pageSelector, gotopage, <?php echo min($volPages, ($preview_page+1)); ?>);"></td>
      <td><img width="16" height="16" class="imagebutton" title="Goto last page (<?php echo $volPages; ?>)" src="img/page_last.png" onclick="ChangePageNo(pageSelector, gotopage, <?php echo $volPages; ?>);"></td>
    </td></table>
  </form>
</div><?php

} else {
  echo "&nbsp;";
}

?>
