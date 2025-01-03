<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * 1962 Hymn Book Search
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10204 : Added calls to Servant checkbox functions.
 * CAM  29-Sep-2008  10302 : Moved to GoodTeaching.org.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and use common database.
 * CAM  30-Dec-2009  10520 : Add focus formatting for dropdowns.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "1962 Hymn Search";
$root = "../";
$tabs = "HYMN";
$pageName = "pageHymn";
$pageCss = "hymn.css";
include $root.'tpl/top.php';
include 'hymn_fn.php';

$hymn_no = NULL;     if (!empty($_GET['hymn_no'])) $hymn_no = $_GET['hymn_no'];
$keywords = NULL;    if (!empty($_GET['keywords'])) $keywords = $_GET['keywords'];
$author = NULL;      if (!empty($_GET['author'])) $author = $_GET['author'];
$meter_id = NULL;    if (!empty($_GET['meter_id'])) $meter_id = $_GET['meter_id'];
$category_id = NULL; if (!empty($_GET['category_id'])) $category_id = $_GET['category_id'];
$language = NULL;    if (!empty($_GET['language'])) $language = $_GET['language'];

?>
  <script language="Javascript" src="ajax.js"></script>

  <form action="." method="get" name="searchForm" target="_top" id="searchForm">
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

      <td><? select_categories($dbConn, $category_id); ?></td>

      <td><? select_meters($dbConn, $meter_id, $language); ?></td>
      <td align=right>
        <input type="submit" name="hymn_search" value="Search" class="button" />
        <!--<a href="index.php?option=com_content&task=view&id=34&Itemid=2">Need help?</a>-->
      </td>
    </tr>
  </table>
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
    show_hymn($dbConn, $hymn_no, $language);
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

    $res = mysqli_query($dbConn, $sql) or die("<h1>Query failed</h1><pre>$sql</pre>");
    if ($row = mysqli_fetch_array($res)) {
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

    $res = mysqli_query($dbConn, $sql) or die("<h1>Query failed</h1><pre>$sql</pre>");
    if ($row = mysqli_fetch_array($res)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      $catdesc = "in category \"" . $name . "\"";
    }
  } else {
    $category_id = "ALL";
  }

  if (!empty($keywords) > 0) {
    body_search($dbConn, $keywordsList, "Hymns $metdesc $catdesc containing \"$keywords\"");
  } else if (!empty($author) > 0) {
    author_search($dbConn, $authorList, "Authors like \"$author\" and their hymns");
  } else if ($meter_id != "ALL" || $category_id != "ALL") {
    body_search($dbConn, $keywordsList, "Hymns $metdesc $catdesc");
  } else {
    echo "&nbsp;";
  }
?>
</td>
</tr>
<?
include $root.'tpl/bot.php';
?>