<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2020 frontburner.co.uk
 *
 * Tune Search
 *
 * Who  When         Why
 * CAM  30-May-2020  909743 : File Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Tune Search";
$root = "../";
$tabs = "HYMN";
$pageName = "pageTune";
$pageCss = "tune.css";
include $root.'tpl/top.php';
include $root.'hymn/hymn_fn.php';
include 'tune_fn.php';

$tune_id = NULL;     if (!empty($_POST['tune_id'])) $tune_id = $_POST['tune_id'];
$tune_no = NULL;     if (!empty($_POST['tune_no'])) $tune_no = $_POST['tune_no'];
$book_name = "ALL";  if (!empty($_POST['book_name'])) $book_name = $_POST['book_name'];
$keywords = NULL;    if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];
$author = NULL;      if (!empty($_POST['author'])) $author = $_POST['author'];
$meter_id = "ALL";   if (!empty($_POST['meter_id'])) $meter_id = $_POST['meter_id'];
$language = NULL;    if (!empty($_POST['language'])) $language = $_POST['language'];
$sitename = NULL;    if (!empty($_POST['sitename'])) $sitename = $_POST['sitename'];


?>
  <script language="Javascript" src="ajax.js"></script>

  <form action="." method="post" name="searchForm" target="_top" id="searchForm">
  <table border=0>
    <tr>
      <td class="fld"><label for="tune_no">Tune No.</label></th>
      <td class="fld"><label for="keywords">Name of Tune</label></th>
      <td colspan=2 class="fld"><label for="author">Author</label></td>
    </tr>

    <tr>
      <td><input <? fieldFocus(); ?> type="text" name="tune_no" id="tune_no" size="10" class="inputbox" value="<?php echo $tune_no;?>" /></td>
      <td><input <? fieldFocus(); ?> type="text" name="keywords" id="keywords" size="20" class="inputbox" value="<?php echo $keywords;?>" /></td>
      <td colspan=2><input <? fieldFocus(); ?> type="text" name="author" id="author" size="20" class="inputbox" value="<?php echo $author;?>" /></td>
    </tr>

    <tr>
      <td><? select_books($dbConn, $book_name); ?></td>
      <td><input <? fieldFocus(); ?> type="hidden" name="tune_id" id="tune_id" size="10" class="inputbox" value="<?php echo $tune_id;?>" /></td>
      <td><? select_meters($dbConn, $meter_id, $language); ?></td>
      <td align=right>
        <input type="submit" name="hymn_search" value="Search" class="button" />
      </td>
    </tr>
  </table>
  <input type="hidden" name="sitename" value="<?php echo $sitename; ?>" />
  <input type="hidden" name="op" value="search" />
  </form>

  </td></tr>
  <tr>
    <th class="resultsheader">Tune</th>
    <td class="resultsheader"><img src="img/f.gif" border=0 width=0></td>
    <th class="resultsheader">Tunes</th>
  </tr>
  <tr><td colspan=3>

<tr>
  <td class="pageresults" valign=top><?
  if (!empty($tune_id)) {
    show_tune($dbConn, $tune_id);
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
    $metdesc = " of meter \"$metdesc\"";
  } else {
    $meter_id = "ALL";
  }

  $desc = "Tunes"; 
  $doSearch = false;

  if (!empty($tune_no)) {
    $doSearch = true;
    $desc .= " #$tune_no";  
  }
  if (!empty($book_name) && ($book_name != "ALL")) {
    $doSearch = true;
    $desc .= " in $book_name";  
  }
  if (!empty($keywords)) {
    $doSearch = true;
    $desc .= " with names containing \"$keywords\"";
  }
  if (!empty($author)) {
    $doSearch = true;    
    $desc .= " by Authors like \"$author\"";
  }
  if ($meter_id != "ALL") {
    $doSearch = true;
    $desc .= "$metdesc";
  }
  if ($doSearch) tune_search($dbConn, $book_name, $tune_no, $keywordsList, $authorList, $meter_id, $desc);
?>
</td>
</tr>
<?
include $root.'tpl/bot.php';
?>