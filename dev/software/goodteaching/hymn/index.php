<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * 1962 Hymn Book Search
 *
 * $Id: index.php 1109 2009-12-30 13:02:57Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10204 : Added calls to Servant checkbox functions.
 * CAM  29-Sep-2008  10302 : Moved to GoodTeaching.org.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and use common database.
 * CAM  30-Dec-2009  10520 : Add focus formatting for dropdowns.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "1962 Hymn Search";
$root = "../";
$tabs = "HYMN";
$pageName = "pageHymn";
$pageCss = "hymn.css";
include $root.'tpl/top.php';
include 'hymn_fn.php';

$hymn_no = NULL;     if (!empty($_POST['hymn_no'])) $hymn_no = $_POST['hymn_no'];
$keywords = NULL;    if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];
$author = NULL;      if (!empty($_POST['author'])) $author = $_POST['author'];
$meter_id = NULL;    if (!empty($_POST['meter_id'])) $meter_id = $_POST['meter_id'];
$category_id = NULL; if (!empty($_POST['category_id'])) $category_id = $_POST['category_id'];
$language = NULL;    if (!empty($_POST['language'])) $language = $_POST['language'];
$sitename = NULL;    if (!empty($_POST['sitename'])) $sitename = $_POST['sitename'];


?>
  <script language="Javascript" src="ajax.js"></script>

  <form action="index.php" method="post" name="searchForm" target="_top" id="searchForm">
  <table border=0>
    <tr>
      <td class="fld">Hymn No.</th>
      <td class="fld">Text</th>
      <td colspan=2 class="fld">Author</td>
    </tr>

    <tr>
      <td><input <? fieldFocus(); ?> type="text" name="hymn_no" size="10" class="inputbox" value="<?php echo $hymn_no;?>" /></td>
      <td><input <? fieldFocus(); ?> type="text" name="keywords" size="40" class="inputbox" value="<?php echo $keywords;?>" /></td>
      <td colspan=2><input <? fieldFocus(); ?> type="text" name="author" size="20" class="inputbox" value="<?php echo $author;?>" /></td>
    </tr>

    <tr>
      <td><select <? dropdownFocus(); ?> name="language" id="language" class="dropdown" onchange="toggle_language();">
      <option value="" <? echo ($language == "" ? "SELECTED" : ""); ?>>English</option>
      <option value="_de" <? echo ($language == "_de" ? "SELECTED" : ""); ?>>Deutsch</option>
      <option value="_nl" <? echo ($language == "_nl" ? "SELECTED" : ""); ?>>Netherlands</option>
      </select></td>

      <td><? select_categories($category_id); ?></td>

      <td><? select_meters($meter_id, $language); ?></td>
      <td align=right>
        <input type="submit" name="hymn_search" value="Search" class="button" />
        <!--<a href="index.php?option=com_content&task=view&id=34&Itemid=2">Need help?</a>-->
      </td>
    </tr>
  </table>
  <input type="hidden" name="sitename" value="<?php echo $sitename; ?>" />
  <input type="hidden" name="op" value="search" />
  </form>

  </td></tr>
  <tr>
    <th class="resultsheader">Hymn</th>
    <td class="resultsheader"><img src="img/f.gif" border=0 width=0></td>
    <th class="resultsheader">Results</th>
  </tr>
  <tr><td colspan=3>

<tr>
  <td class="pageresults" valign=top><?
  if (!empty($hymn_no)) {
    show_hymn($hymn_no, $language);
  } else {
    echo "&nbsp;";
  }
?>
  </td>
  <td class="resultsheader"><img src="<? echo $root; ?>img/f.gif" border=0 width=12></td>
  <td height="100" class="searchresults" valign=top><?
  $keywordsList = explode(" ", $keywords);
  $authorList = explode(" ", $author);

  $metdesc = "";
  $catdesc = "";

  if (!empty($meter_id) && ($meter_id != "ALL")) {
    $sql = "SELECT meter, rhythm, chorus ".
           "FROM hymn_meter ".
           "WHERE id = '$meter_id'";

    $res = mysql_query($sql) or die("<h1>Query failed</h1><pre>$sql</pre>");
    if ($row = mysql_fetch_array($res)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      $metdesc = $meter;
      if (!empty($rhythm)) $metdesc .= "&nbsp;<i>" . $rhythm ."</i>";
    }
    $metdesc = "of meter \"$metdesc\"";
  } else {
    $meter_id = "ALL";
  }

  if (!empty($category_id) && ($category_id != "ALL")) {
    $sql = "SELECT name ".
           "FROM hymn_scheme_categories ".
           "WHERE id = '$category_id'";

    $res = mysql_query($sql) or die("<h1>Query failed</h1><pre>$sql</pre>");
    if ($row = mysql_fetch_array($res)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      $catdesc = "in category \"" . $name . "\"";
    }
  } else {
    $category_id = "ALL";
  }

  if (!empty($keywords) > 0) {
    body_search($keywordsList, "Hymns $metdesc $catdesc containing \"$keywords\"");
  } else if (!empty($author) > 0) {
    author_search($authorList, "Authors like \"$author\" and their hymns");
  } else if ($meter_id != "ALL" || $category_id != "ALL") {
    body_search($keywordsList, "Hymns $metdesc $catdesc");
  } else {
    echo "&nbsp;";
  }
?>
</td>
</tr>
<?
include $root.'tpl/bot.php';
?>