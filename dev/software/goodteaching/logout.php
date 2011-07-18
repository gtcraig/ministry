<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Logout of the system
 *
 * $Id: logout.php 894 2008-09-29 21:22:54Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Log out";
include_once $root.'Main.php';

if(isset($_REQUEST['logmeout'])){
  session_destroy();
}

include $root.'tpl/top.php';

if(!isset($_REQUEST['logmeout'])){
  echo "<center>Are you sure you want to logout?</center><br />";
  echo "<center><a href=logout.php?logmeout>Yes</a> | <a href=index.php>No</a>";
} else {
  if(!session_is_registered('memberid')){
    Msg::error("You are now logged out!");
    include $root.'tpl/home.php';
  }
}
include $root.'tpl/bot.php';
?>
