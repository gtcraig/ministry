<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007,2015 frontburner.co.uk
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Reworked to use BibleBook.
 * CAM  25-Oct-2007  10187 : Added Verse Start to search.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and changed session vars to include module name.
 * CAM  05-Sep-2015  159308 : Added new checkbox and logic to reset (moved form from bot).
 * RWM  06-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Scripture Search";
$tab = "Scripture";
$tabs = "MINISTRY";
include $root.'tpl/top.php';
include_once $root.'functions.php';

$bookid = $_SESSION['search_min_bookid'];    if (!empty($_POST['bookid'])) $bookid = $_POST['bookid'];
$chapter = $_SESSION['search_min_chapter'];  if (!empty($_POST['chapter'])) $chapter = $_POST['chapter'];
$vstart = $_SESSION['search_min_vstart'];    if (!empty($_POST['chapter']) && ($_POST['vstart']!="")) $vstart = $_POST['vstart'];
$primary = $_SESSION['search_min_primary'];  if (isset($_POST['primary'])) $primary = $_POST['primary'];

if ($bookid == "NULL") {
  $bookid = "";
  $chapter = "";
  $vstart = 0;
} else if ($chapter == "NULL") {
  $chapter = "";
  $vstart = 0;
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
  $bibleBook = new BibleBook($bookid);

  if (empty($chapter) && !$bibleBook->isSingleChap()) {
    $entity = "Chapter";
  } else {
    $entity = "Verse(s)";
  }
}
?>
	<div class="row card hoverable">

		<nav>
			<div class="nav-wrapper <?php echo $cfg['Site']['Scheme']['Heading']['Nav']['Class']; ?> <?php echo $cfg['Site']['Scheme']['Scripture']['Active']['Class']; ?>">
				<a href="#" class="heading"><?php echo $tab; ?></a>
				<ul class="right">
					<li class="<?php echo $cfg['Site']['Scheme']['Servant']['Inactive']['Class']; ?> linkitem"><a href="servant.php">Servant</a></li>
					<li class="<?php echo $cfg['Site']['Scheme']['Keyword']['Inactive']['Class']; ?> linkitem"><a href="keyword.php">Keyword</a></li>
				</ul>
			</div>
		</nav>
		<div class="card-content">
			<div class="">
				<form method="post" name="books" id="books" >
					<input type='hidden' name='bookid' id='bookid'>
					<input type='hidden' name='chapter' id='chapter'>
					<input type='hidden' name='vstart' id='vstart'>
					<input type='hidden' name='vend' id='vend'>
					<input type='hidden' name='primary' id='primary' value="<?php echo $primary; ?>">
					<input type="hidden" name="op" value="search" />

					<span class="input-field">
						<input type="checkbox" name='onlyread' id='onlyread' onclick="getObjRef('primary').value=(this.checked)?1:0;" <?php echo ($primary)?" CHECKED":""; ?> />
						<label for="onlyread">Search only Scriptures referenced at the beginning of an article?</label>
					</span>
				</form>


<?php
/**** START ****/
    if (empty($bookid)) {
      f_show_books();
    } else if (empty($chapter) && !$bibleBook->isSingleChap()) {
      f_show_chapters();
    } else {
      f_show_verses();
    }
/**** END ****/
?>
			</div>
		</div>
	</div>


<?php
if (!empty($_POST['op'])) {
	include $root.'tpl/results.php';
}
include $root.'tpl/bot.php';
?>