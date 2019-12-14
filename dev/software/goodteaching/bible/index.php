<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2009 frontburner.co.uk
 *
 * Bible Search
 *
 * $Id: index.php 1111 2009-12-30 13:45:32Z craig $
 *
 * Who  When         Why
 * CAM  29-Dec-2009  10515 : File created.
 * CAM  30-Dec-2009  10520 : Ensure keywords are formatted correctly for SQL.
 * CAM  30-Dec-2009  10522 : Added remove_mselinks - needs to be improved once links are clickable.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Bible Search";
$root = "../";
$tabs = "BIBLE";
$pageName = "pageBible";
$pageCss = "bible.css";
include $root.'tpl/top.php';

$keywords = NULL;       if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];

$keywords = trim(str_replace("\'", " ", $keywords));
$keywords = trim(str_replace("\"", " ", $keywords));
$keywords = trim(str_replace("\\", " ", $keywords));
$keywords = trim(str_replace("  ", " ", $keywords));

function remove_mselinks($text) {
  //$text = preg_replace("/\[(.*)\](.*)\[\/(.*)\]/is", "<span class=\"footnote\">$2</span>", $text, $count);

  $record=true;
  $newText="";

  for ($i=0; $i<strlen($text); $i++) {

    $ch = substr($text, $i, 1);

    if ($ch == "[") {
      $record = false;

      if (substr($text, $i+1, 1) == "/") {
        $newText .= "</span>";
      } else {
        $newText .= "<span class=\"footnote\">";
      }

    } else if ($ch == "]") {
      $record = true;
    } else {
      if ($record) {
        $newText .= $ch;
      }
    }
  }

  return $newText;
}

?>
  <script language="Javascript" src="ajax.js"></script>

  <form action="index.php" method="post" name="searchForm" target="_top" id="searchForm">
  <table border=0 cellpadding=3 cellpadding=0>
		<tr>
			<td colspan=2 class="fld">Search Darby Translation Footnotes</td>
		</tr>
		<tr>
			<td colspan=2>(if you would like to search the Bible text, please use <a href="https://www.biblegateway.com/quicksearch/?qs_version=DARBY">BibleGateway</a> or <a href="https://www.olivetree.com/bible-study-apps/">Olive Tree</a>)</td>
		</tr>

    <tr>
      <td><input <? fieldFocus(); ?> type="text" name="keywords" size="50" class="inputbox" value="<?php echo $keywords;?>" /></td>
      <td align="left"><input type="submit" name="hymn_search" value="Search" class="button" /></td>
    </tr>
  </table>
  <input type="hidden" name="op" value="search" />
  </form>

  </td></tr>
  <tr>
    <th class="resultsheader">Results</th>
    <td class="resultsheader"><img src="img/f.gif" border=0 width=0></td>
    <th class="resultsheader">Preview Pane</th>
  </tr>
  <tr><td colspan=3>

<tr>
  <td class="searchresults" valign=top>
    <table border=0 cellpadding=3 cellspacing=0 width="100%">
<?
  if (empty($keywords)) {
?>
    <tr><td>&nbsp;</td></tr>
<?
  } else {
?>
    <tr>
      <th class="rh">Book</th>
      <th class="rh">Chap.</th>
      <th class="rh">V.</th>
      <th class="rh">Sym</th>
      <th class="rh"><span class="phrase">Phrase</span> &amp; Text</th>
    </tr>
  <?
    $keywords = "%$keywords%";
    $keywords = str_replace(" ", "%", $keywords);
    $keywords = str_replace(",", "%", $keywords);
    $keywords = str_replace(";", "%", $keywords);
    $keywords = str_replace(":", "%", $keywords);
    $keywords = str_replace(".", "%", $keywords);
    $keywords = str_replace("-", "%", $keywords);
    $keywords = str_replace("\'", "%", $keywords);
    $keywords = str_replace("\"", "%", $keywords);
    $keywords = str_replace("%%", "%", $keywords);
    $keywords = str_replace("%%", "%", $keywords);

    $sql = "SELECT b.bookname, f.chapter, f.verse, f.footnoteid, f.symbol, f.text, fr.phrase ".
           "FROM mse_bible_footnote f, mse_bible_footnote_ref fr, mse_bible_version v, mse_bible_book b ".
           "WHERE v.verid = f.verid ".
           "AND b.bookid = f.bookid ".
           "AND fr.footnoteid = f.footnoteid ".
           "AND (f.text LIKE '" . $keywords . "' ".
                "OR fr.phrase LIKE '" . $keywords . "') ".
           "ORDER BY b.bookid, f.chapter, f.verse, f.footnoteid ";

    $ssql = mysql_query($sql) or die(mysql_error());
    $prevFootnoteId = 0;
    $refs="";

    while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $text = remove_mselinks($text);

    if (!empty($refs)) $refs .= ", ";
    $refs .= "<span class=\"phrase\">$phrase</span>";

  ?><tr>
<?
      if ($footnoteid <> $prevFootnoteId) {
?>
        <td class="rd"><? echo "$bookname"; ?></td>
        <td class="rd"><? echo "$chapter"; ?></td>
        <td class="rd"><? echo "$verse"; ?></td>
        <td class="rd"><? echo "<b>$symbol</b>"; ?></td>
        <td class="rd"><? echo "$refs<br>$text"; ?></td>
<?
        $refs="";
      }
?>
  </tr><?
      $prevFootnoteId = $footnoteid;
    }
  ?>
<?
  }
?>
    </table>
  </td>
  <td class="resultsheader"><img src="<? echo $root; ?>img/f.gif" border=0 width=12></td>
  <td height="100" class="pageresults" valign=top>
  &nbsp;
  </td>
</tr>
<?
include $root.'tpl/bot.php';
?>