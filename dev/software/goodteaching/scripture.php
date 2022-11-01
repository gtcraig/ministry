<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2015 frontburner.co.uk
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Reworked to use BibleBook.
 * CAM  25-Oct-2007  10187 : Added Verse Start to search.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and changed session vars to include module name.
 * CAM  05-Sep-2015  159308 : Added new checkbox and logic to reset (moved form from bot).
 * CAM  12-Dec-2015  476204 : Check session variables are set before referencing.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Scripture Search";
$tab = "scripture";
$tabs = "MINISTRY";
$root = "./";
include $root.'tpl/top.php';
include_once $root.'functions.php';

$bookid = isset($_SESSION['search_min_bookid'])?$_SESSION['search_min_bookid']:"";     if (!empty($_POST['bookid'])) $bookid = $_POST['bookid'];
$chapter = isset($_SESSION['search_min_chapter'])?$_SESSION['search_min_chapter']:"";  if (!empty($_POST['chapter'])) $chapter = $_POST['chapter'];
$vstart = isset($_SESSION['search_min_vstart'])?$_SESSION['search_min_vstart']:"";     if (!empty($_POST['vstart'])) $vstart = $_POST['vstart']; 
$primary = isset($_SESSION['search_min_primary'])?$_SESSION['search_min_primary']:"";  if (isset($_POST['primary'])) $primary = $_POST['primary'];

if ($bookid == "NULL") {
  $bookid = "";
  $chapter = "";
  $vstart = 0;
} else if (($chapter == "NULL") && (empty($vstart))) {
  $chapter = "";
  $vstart = 0;
}

if (!empty($vstart) && empty($chapter)) {
  $chapter = 0;
}

$_SESSION['search_min_bookid'] = $bookid;
$_SESSION['search_min_chapter'] = $chapter;
$_SESSION['search_min_vstart'] = $vstart;
$_SESSION['search_min_primary'] = $primary;

$entity = "";
$bibleBook = "";

if (empty($bookid)) {
  $entity = "Book";
} else {
  $bibleBook = new BibleBook($dbConn, $bookid);

  if (empty($chapter) && !$bibleBook->isSingleChap()) {
    $entity = "Chapter";
  } else {
    $entity = "Verse(s)";
  }
}
?>
<table border=0 cellpadding=10 cellspacing=0 width="100%">
<tr><td align=left>
<?
  $q = "Select your $entity";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname();
  }

  $q .= ":";

  Msg::statement($q);
?></td><td align="right">
<form method=post name=books id=books><input
type=hidden name=bookid id=bookid><input
type=hidden name=chapter id=chapter><input
type=hidden name=vstart id=vstart><input
type=hidden name=vend id=vend><input type=hidden name=primary id=primary value="<?=$primary?>">
<input type="checkbox" onclick="getObjRef('primary').value=(this.checked)?1:0;" <?=($primary)?" CHECKED":""?>>&nbsp;Search only Scriptures referenced at the beginning of an article?</form></td></tr>
<tr><td colspan="2"><?
/**** START ****/
    if (empty($bookid)) {
      f_show_books($dbConn);
    } else if (empty($chapter) && !$bibleBook->isSingleChap()) {
      f_show_chapters($dbConn);
    } else {
      f_show_verses($dbConn);
    }
/**** END ****/
?>
</td></tr>
</table>
<?
include $root.'tpl/results.php';
include $root.'tpl/bot.php';
?>