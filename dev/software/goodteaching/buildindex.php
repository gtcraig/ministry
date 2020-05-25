<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2008,2009 frontburner.co.uk
 *
 * Release History
 *
 * Who  When         Why
 * CAM  19-Oct-2014  File created.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Index by Bible Book and Chapter";
$tabs = "NONE";

if (empty($root)) {
  $root = "./";
}

if (empty($pageName)) {
  $pageName = "pageGt";
}

include_once $root.'Main.php';
$member = NULL;  if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];
$loggedin = (isset($_SESSION['memberid']) && isset($_SESSION['Good Teaching Search Engine']));
global $tab,$tabs;

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}

?><head>
  <title><? echo $title;?></title>
</head>

<body topmargin=2 leftmargin=0 id="<? echo $pageName;?>">
<?

function f_open_table() {
?>
<table border=1 cellpadding=5 cellspacing=0 width="100%">
<tr>
  <th>Author</th>
  <th>Vol</th>
  <th>Page</th>
  <th>Title</th>
  <th>Scriptures</th>
</tr>
<?
}

function f_close_table() {
  echo "</table>";
}


$prevbookid = 0;
$prevchap = 0;

$sql = "SELECT br.bookid, bb.bookname, br.chapter, br.author, br.vol, br.page, a.article, ".
         "MIN(a.scriptures) scriptures ".
       "FROM mse_bible_ref br, mse_bible_book bb, mse_article a ".
       "WHERE bb.bookid = br.bookid ".
       "AND a.author = br.author ".
       "AND a.vol = br.vol ".
       "AND a.page = br.article_page ".
       "AND br.article_primary=1 ".
       "GROUP BY br.bookid, bb.bookname, br.chapter, br.author, br.vol, br.page, a.article ".
       "ORDER BY 1,3,4,5,6;";

$ssql = mysqli_query($dbConn, $sql);
while ($row = mysqli_fetch_array($ssql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if ($bookid <> $prevbookid) {
    f_close_table();
    echo "<h1>$bookname</h1>";
  }

  if ($chapter <> $prevchap) {
    if ($bookid == $prevbookid) f_close_table();
    echo "<h2>$bookname $chapter</h2>";
    f_open_table();
  }

?>
<tr>
  <td><?= $author ?></td>
  <td><?= $vol ?></td>
  <td><?= $page ?></td>
  <td><?= $article ?></td>
  <td><?= str_replace("@", "", $scriptures) ?></td>
</tr>
<?
  $prevbookid = $bookid;
  $prevchap = $chapter;
}

f_close_table();

?>