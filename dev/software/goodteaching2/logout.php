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
 * RWM  08-Jan-2016  508026 : Begin v2 responsive.
 * RWM  08-Jan-2016  508026 : Set root.
 * RWM  08-Jan-2016  508026 : session_is_registered(...) This function has been DEPRECATED as of PHP 5.3.0 and REMOVED as of PHP 5.4.0.
 * RWM  08-Jan-2016  508026 : replace with isset($_SESSION[...])
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Log out";
$root = "./";
include $root.'tpl/top.php';
//include_once $root.'Main.php';

if(isset($_REQUEST['logmeout'])){
  session_destroy();
}


if(!isset($_REQUEST['logmeout'])){
?>

<div class="card hoverable">
	<div class="card-content center">
		<span class="card-title">Log out</span>
		<p>Are you sure you want to log out?</p>
	</div>
	<div class="card-action center">
		<a class="btn-flat waves-effect red-text" href="<?php echo $root; ?>logout.php?logmeout">Yes</a>  
		<a class="btn-flat waves-effect green-text" href="<?php echo $root; ?>index.php">No </a>
	</div>
</div>

<?php
} else {
	if (!isset($_SESSION['memberid'])) {
		Msg::error("You are now logged out!");
		include $root.'tpl/home.php';
	}
}
include $root.'tpl/bot.php';
?>
