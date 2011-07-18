<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * Easton's Search
 *
 * $Id: index.php 947 2009-04-12 12:46:53Z craig $
 *
 * Who  When         Why
 * CAM  29-Sep-2008  10302 : File created.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and changed session vars to include module name.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Easton's Bible Dictionary";
$root = "../";
$tabs = "EASTON";
$pageName = "pageEaston";
include $root.'tpl/top.php';

$author_filter = $_SESSION['search_min_author'];  if (!empty($_POST['author_filter'])) $author_filter = $_POST['author_filter'];
$_SESSION['search_min_author'] = $author_filter;

?>
<h2>Coming soon...</h2>
<?
include $root.'tpl/bot.php';
?>