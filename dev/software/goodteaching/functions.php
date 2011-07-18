<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2006,2009 Southesk.com
 *
 * $Id: functions.php 947 2009-04-12 12:46:53Z craig $
 *
 * Who  When         Why
 * CAM  15-Feb-2006  File created.
 * CAM  15-Oct-2007  10187 : Modified functions to work in new interface.
 * CAM  25-Oct-2007  10187 : Added Verse Start to search.
 * CAM  12-Nov-2007  10203 : Fixed onclick bug.
 * CAM  18-Nov-2007  10205 : Added f_search_parameter_string - will be used for favourites eventually but initially to determine new search.
 * CAM  29-Dec-2007  10211 : Improved the highlight function and removed redundant code.
 * CAM  18-Jun-2007  10274 : Changed highlight to hlght to prevent the word "light" causing problems.
 * CAM  28-Mar-2009  10407 : Correct PHP syntax.
 * CAM  12-Apr-2009  10419 : Changed session vars to include module name.
 * * * * * * * * * * * * * * * * * * * * * * * */

function f_neat_truncate($text, $backpoint) {
  $rval = $text;

  $midp = strlen($rval)*0.254;
  if (($backpoint > 0) && (($atpos = strpos($rval, " ")) !== FALSE) && $atpos < $midp) {
    $rval = trim(substr($rval, $atpos+1, strlen($rval)));
  }

  $midp = strlen($rval)*0.75;
  if ((substr($rval, strlen($rval)-1, 1) !== ".") &&
      (($atpos = strrpos($rval, " ")) !== FALSE) &&
      ($atpos > $midp)) {
    $rval = trim(substr($rval, 0, $atpos));
  }

  return $rval;
}

function f_url($a,$v,$b,$c,$s) {
  global $stext, $uauthor, $uvol, $upage, $upara,
         $ubookid, $uchapter, $uvstart, $bookname, $singlechap;

  $rval = "";

  if (!empty($stext))           $rval .= "&text=$stext";
  if ($a && !empty($uauthor))   $rval .= "&author=$uauthor";
  if ($v && !empty($uvol))      $rval .= "&vol=$uvol";
  if ($b && !empty($ubookid))   $rval .= "&bookid=$ubookid";
  if ($c && !empty($uchapter))  $rval .= "&chapter=$uchapter";

  return $rval;
}

if(!function_exists('stripos')) {
  function stripos($haystack, $needle, $offset=0) {
    $rval = 0;  // Return position
    if ($offset > 0) $haystack = substr($haystack, $offset);  // Adjust for offset
    if (($rval = strpos($haystack, stristr($haystack, $needle))) === FALSE) return FALSE;
    return ($rval + $offset); // If found, remember to include offset
  }
}

function beginning_of_sentence($text, $start) {
  for ($i=$start; $i>=0; $i--) {
    $ch = substr($text, $i, 1);

    if (($ch == '.') || ($ch == ',') || ($ch == ';') || ($ch == ':') || ($ch == '!') || ($ch == '?')) {
      return $i+1;
    }
  }
  return 0;
}

function neat_ending($text, $len) {
  $textlen = strlen($text);

  if ($textlen < ($len * 1.2)) return ($textlen-1);

  for ($i = $len; $i>=0; $i--) {
    $ch = substr($text, $i, 1);

    if ($ch == ' ') {
      return $i;
    }
  }

  return 0;
}

function f_highlight_text($text, &$sqlFactory, $abbrev=false) {

  $rval = trim($text);
  $start = 0;

  if ($sqlFactory->isSearchText()) {
    // Firstly, look for any matching keywords
    $atoms = $sqlFactory->getAtoms();
    $start = strlen($rval);

    for($i=0; $i<count($atoms); $i++) {
      $p = stripos($rval, $atoms[$i]);
      if ($p !== FALSE) $start = min($start, $p);
    }
  }

  if ($sqlFactory->isBookRef()) {
    // Find any matching Scripture refs
    // TODO 10212
  }

  if ($abbrev) {
    if ($start > 0) $start = beginning_of_sentence($rval, $start);
    $rval = substr($rval, $start, strlen($rval));
    $rval = trim(substr($rval, 0, neat_ending($rval, 140)));
  }

  // Finally, highlight search keywords and scriptures
  if ($sqlFactory->isSearchText()) {
    // Firstly, look for any matching keywords
    $atoms = $sqlFactory->getAtoms();

    for($i=0; $i<count($atoms); $i++) {
      $p = stripos($rval, $atoms[$i]);
      $cntr = 0;

      while ($p !== FALSE && ($cntr < 10)) {
        $len = strlen($atoms[$i]);
        $rlen = strlen($rval); // remember the current length
        $rval = substr($rval, 0, $p) . "<span class=\"hlght$i\">" . substr($rval, $p, $len) . "</span>" . substr($rval, $p+$len);
        $p = stripos($rval, $atoms[$i], $p+$len+(strlen($rval)-$rlen+1));
      }
    }
  }

  if ($sqlFactory->isBookRef()) {
    // Next, highlight matching scripture references
    // TODO 10212
  }

  // Remove remaining Scripture markup
  $rval = str_replace('@', '', $rval);

  return $rval;
}

function f_url_ref($a,$v,$pg,$pa) {
  return "&raut=$a&rvol=$v&rpag=$pg&rpar=$pa";
}

function f_show_books() {
  global $stext, $uauthor, $uvol, $ubookid, $uchapter, $uvstart, $bookname, $singlechap;
  $prevtest = "";

  $sql = "SELECT DISTINCT b.testament, r.bookid, b.bookname ".
         "FROM mse_bible_ref r, mse_bible_book b ".
         "WHERE r.bookid = b.bookid ";

  if (!empty($uauthor)) {
    $sql .= "AND r.author = '$uauthor' ";
  }
  if (!empty($uvol)) {
    $sql .= "AND r.vol = $uvol ";
  }
  $sql .= "ORDER BY 1 DESC,2";

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($testament <> $prevtest) {
?>
<h3><?php echo $testament; ?></h3>
<?php
      $prevtest = $testament;
    }
?><a href="javascript:void();" onclick="submitBookRef(<?php echo $bookid; ?>);return false;"><?php
echo str_replace(" ", "&nbsp;", $bookname); ?></a>
<?php
  }
}

function f_show_chapters() {
  global $bibleBook;

  $sql = "SELECT DISTINCT chapter \n".
         "FROM mse_bible_ref \n".
         "WHERE bookid = " . $bibleBook->getBookId() . "\n";
/** // TODO put back
  if (!empty($uauthor)) {
    $sql .= "AND author = '$uauthor' ";
  }
*/
  /** // TODO implement this
  if (!empty($uvol)) {
    $sql .= "AND vol = $uvol ";
  }
*/
  $sql .= "ORDER BY chapter \n";
?>
<a href="javascript:void" onclick="submitBookRef('NULL');return false;">Books</a>&nbsp;|&nbsp;<?php echo $bibleBook->getBookName(); ?></td></tr><tr><td>Chapters
<?php

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?><a href="javascript:void();" onclick="submitBookRef(<?php echo $bibleBook->getBookId(); ?>, <?php echo $chapter; ?>);return false;"><?php
echo $chapter; ?></a>
<?php
  }
}

function f_show_verses() {
  global $bibleBook, $chapter;

  $sql = "SELECT DISTINCT vstart ".
         "FROM mse_bible_ref \n".
         "WHERE bookid = " . $bibleBook->getBookId() . "\n";

  if (!$bibleBook->isSingleChap()) {
    $sql .= "AND chapter = $chapter ";
  }

/** // TODO
  if (!empty($uauthor)) {
    $sql .= "AND author = '$uauthor' ";
  }
  if (!empty($uvol)) {
    $sql .= "AND vol = $uvol ";
  }
*/
  $sql .= "ORDER BY vstart";

  //echo "<pre>$sql</pre>";
?>
<a href="javascript:void" onclick="submitBookRef('NULL');return false;">Books</a>&nbsp;|
<a href="javascript:void();" onclick="submitBookRef(<?php echo $bibleBook->getBookId(); ?>, 'NULL'); return false;"><?php echo $bibleBook->getBookName(); ?></a>
<?php
if (!$bibleBook->isSingleChap()) {
  echo "&nbsp;|&nbsp;Chapter $chapter";
}
?></td></tr><tr><td>Verses
<?php
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?><a href="javascript:void();" onclick="submitBookRef(<?php echo $bibleBook->getBookId(); ?>, <?php echo $chapter; ?>, <?php echo $vstart; ?>); return false;"><?php echo ($vstart==0) ? "All": $vstart; ?></a>&nbsp;<?php
  }
}

function f_search_parameter_string(){
  $list = array();
  $i = 0;
  $rval = "";

  if (!empty($_SESSION['search_min_keywords'])) $list[$i++] = new Tuple("keywords", $_SESSION['search_min_keywords']);
  if (!empty($_SESSION['search_min_author'])) $list[$i++] = new Tuple("author", $_SESSION['search_min_author']);
  if (!empty($_SESSION['search_min_bookid'])) $list[$i++] = new Tuple("bookid", $_SESSION['search_min_bookid']);
  if (!empty($_SESSION['search_min_chapter'])) $list[$i++] = new Tuple("chapter", $_SESSION['search_min_chapter']);
  if (!empty($_SESSION['search_min_vstart'])) $list[$i++] = new Tuple("vstart", $_SESSION['search_min_vstart']);

  for ($i=0; $i<count($list); $i++) {
    if ($i > 0) $rval .= "|";
    $rval .= $list[$i]->getID() . "=";

    if ($list[$i]->getID() == "author") {
      $rval .= implode(",", $list[$i]->getDesc());
    } else {
      $rval .= $list[$i]->getDesc();
    }
  }

  return $rval;
}