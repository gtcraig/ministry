<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007,2015 frontburner.co.uk
 *
 * Home Page Context
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Reset the Scripture vars.
 * CAM  25-Oct-2007  10187 : Added Verse Start to search.
 * CAM  08-Nov-2007  10200 : Added results_pageno.
 * CAM  18-Nov-2007  10205 : Added search_previous.
 * CAM  04-Jun-2008  10268 : Added Latest Volumes.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  28-Mar-2009  10407 : Added $_SESSION['search_min_type'].
 * CAM  12-Apr-2009  10419 : Changed session vars to include module name.
 * CAM  05-Sep-2015  159308 : Reset new primary flag.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Home";
$tabs = "NONE";

include $root.'tpl/top.php';

$_SESSION['search_min_keywords'] = "";
$_SESSION['search_min_type'] = "";
$_SESSION['search_min_author'] = array('ALL'=>'ALL');

$_SESSION['search_min_bookid'] = "";
$_SESSION['search_min_chapter'] = "";
$_SESSION['search_min_vstart'] = "";
$_SESSION['search_min_primary'] = false;

$_SESSION['search_previous'] = "";

$_SESSION['preview_author'] = "";
$_SESSION['preview_vol'] = "";
$_SESSION['preview_page'] = "";

$_SESSION['results_pageno'] = "";

include $root.'tpl/newsearch.php';
//include $root.'tpl/latestvols.php';
include $root.'tpl/bot.php';
?>