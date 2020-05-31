<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
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
 * CAM  12-Dec-2015  476204 : Remove pointless login and register links.
 * CAM  30-May-2020  909743 : Updated table structure of page, added /tunes, removed New Search, Help and other redundant login/membership code.
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

?><head>
  <title><? echo $title;?></title>
  <link href="<? echo $root;?>mse.css" rel="stylesheet" type="text/css" />
  <? if (!empty($pageCss)) { ?><link href="<? echo $pageCss;?>" rel="stylesheet" type="text/css" /><? } ?>
  <script language="Javascript" src="<? echo $root;?>date.js"></script>
  <script language="Javascript" src="<? echo $root;?>form.js"></script>
  <link rel="icon" type="image/vnd.microsoft.icon" href="<? echo $cfg['Site']['URL']; ?>/favicon.ico">
</head>

<body topmargin=2 leftmargin=0 id="<? echo $pageName;?>">

<table border=0 cellpadding=0 cellspacing=0 class=outerBox width="900" align=center cols=3>
  <tr>
    <td class="topnav"><img src="<? echo $root;?>img/f.gif" border=0 width=500 height=10></td>
    <td class="topnav"><img src="<? echo $root;?>img/f.gif" border=0 width=20 height=0></td>
    <td class="topnav"><img src="<? echo $root;?>img/f.gif" border=0 width=460 height=0></td>
  </tr>
  <tr>
  <td valign=top colspan=3><table border=0 cellpadding=0 cellspacing=0 width="100%" height="100%" class="topnav">
    <tr><td><a id="linkGt" href="<? echo $cfg['Site']['URL']; ?>"><? echo
      str_replace(" ", "&nbsp;", $cfg['Site']['Name']); ?></a><span class="topsep">|</span><a id="linkBible" href="<? echo
      $cfg['Site']['URL']; ?>/bible/">Bible</a><span class="topsep">|</span><a id="linkHymn" href="<? echo
      $cfg['Site']['URL']; ?>/hymn/">Hymns</a><span class="topsep">|</span><a id="linkTune" href="<? echo
      $cfg['Site']['URL']; ?>/tune/">Tunes</a></td>
      </tr><tr><td><img src="<? echo $root; ?>img/f.gif" height=10></td></tr>

<?
    if ($tabs == "MINISTRY") {
      $className = $tab . "border";
?>
    <tr><td colspan=3><? include $root.'tpl/tabs.php'; ?></td></tr>
<?
    } else {

      if ($tabs == "NONE") {
        $className = "mainborder";
      } else {
        $className = "KEYWORDborder";
      }
    }
?>
    </table></td></tr>

    <tr><td colspan=3 width="100%" height="100%" valign=top class="<? echo $className; ?>">