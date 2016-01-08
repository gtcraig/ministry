<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009,2016 frontburner.co.uk
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Include form.js.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  12-Nov-2007  10203 : Removed whitespace.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs.
 * CAM  29-Dec-2009  10515 : Added Bible.
 * CAM  30-Dec-2009  10523 : Added Favicon.
 * RWM  22-Dec-2015  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

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

?><!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><?php echo $title;?></title>

  <!--css-->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="<?php echo $root;?>css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="<?php echo $root;?>css/gtsite.css" type="text/css" rel="stylesheet" media="screen,projection"/>

  <?php /*<link href="<?php echo $root;?>mse.css" rel="stylesheet" type="text/css" />*/ ?>
  <?php if (!empty($pageCss)) { ?><link href="<?php echo $pageCss;?>" rel="stylesheet" type="text/css" /><?php } ?>

  <link rel="icon" type="image/vnd.microsoft.icon" href="<?php echo $cfg['Site']['URL']; ?>/favicon.ico">
</head>

<body id="<?php echo $pageName;?>" class="<?php echo $cfg['Site']['Scheme']['Body']['Class']; ?>">

<?php
	//use to set class="active" on active nav item
	$class_active = 'active';
	$search_active = ($pageName == 'pageGt' ? $class_active : '');
	$read_active = ($pageName == 'pageRead' ? $class_active : '');
	$bible_active = ($pageName == 'pageBible' ? $class_active : '');
	$hymn_active = ($pageName == 'pageHymn' ? $class_active : '');
?>

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="<?php echo $root; ?>">Search</a></li>
  <li class='divider'></li>
  <li><a href="<?php echo $root; ?>keyword.php">by Keyword</a></li>
  <li><a href="<?php echo $root; ?>scripture.php">by Scripture</a></li>
  <li><a href="<?php echo $root; ?>servant.php">by Servant</a></li>
</ul>
<div class="<?php echo $cfg['Site']['Scheme']['NavWrapper']['Class'];?>" >
	<nav class="<?php echo $cfg['Site']['Scheme']['Nav']['Class'];?> ">
		<div class="container">
			<div class="nav-wrapper"> 
				<a href="<?php echo $root; ?>index.php" class="brand-logo"><?php echo str_replace(" ", "&nbsp;", $cfg['Site']['Shortname']); ?><span class="hide-on-small-and-down"> <?php echo str_replace(" ", "&nbsp;", $cfg['Site']['Shortdesc']); ?></span></a>
				<a href="#" data-activates="mobile-demo" class="button-collapse"><span class="hamburger"></span></a>
				<ul class="right hide-on-med-and-down">
					<li class="<?php echo $search_active; ?>"><a class="dropdown-button" href="<?php echo $cfg['Site']['URL']; ?>" data-activates="dropdown1" title="Search across ministry volumes" >Search<i class="material-icons right">arrow_drop_down</i></a></li>


					<li class="<?php echo $bible_active; ?>"><a href="<?php echo $root; ?>bible/" title="Search Bible Footnotes">Bible</a></li> 
					<li class="<?php echo $hymn_active; ?>"><a href="<?php echo $root; ?>hymn/" title="Search Little Flock Hymn Book (1962)">Hymns</a></li> 
				   	<li class="<?php echo $read_active; ?>"><a href="<?php echo $root; ?>read/" title="Read Ministry volumes page-by-page">Read</a></li>
			   </ul>
			   <ul class="side-nav" id="mobile-demo">
					<li class="<?php echo $search_active; ?>"><a href="<?php echo $root; ?>" title="Search across ministry volumes" >Search</a></li>
					<li class="<?php echo $search_active; ?>"><a href="<?php echo $root; ?>keyword.php" title="Search by keyword across volumes" >&gt; by Keyword</a></li>
					<li class="<?php echo $search_active; ?>"><a href="<?php echo $root; ?>scripture.php" title="Search by scripture across volumes" >&gt; by Scripture</a></li>
					<li class="<?php echo $search_active; ?>"><a href="<?php echo $root; ?>servant.php" title="Filter search by servant across volumes" >&gt; by Servant</a></li>
					<li class="<?php echo $bible_active; ?>"><a href="<?php echo $root; ?>bible/" title="Search Bible Footnotes">Bible</a></li> 
					<li class="<?php echo $hymn_active; ?>"><a href="<?php echo $root; ?>hymn/"  title="Search Little Flock Hymn Book (1962)">Hymns</a></li> 
				   	<li class="<?php echo $read_active; ?>"><a href="<?php echo $root; ?>read/" title="Read Materialinistry volumes page-by-page">Read</a></li>
					<li><a href="<?php echo $root; ?>volumes.php">Volume Titles</a></li> 
					<li><a href="<?php echo $root; ?>ebook/">Ebooks</a></li>
			</ul>
			</div>
		</div> 
	</nav>
</div> 

<main>
	<div class="container">
<!--start main/container -->
