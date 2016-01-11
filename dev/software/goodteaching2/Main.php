<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * Main page setup
 *
 * $Id: Main.php 1109 2009-12-30 13:02:57Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  12-Nov-2007  10203 : Removed getObjRef as its in form.js.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  28-Mar-2009  10407 : Added $cfg['Site']['Status'].
 * CAM  12-Apr-2009  10419 : Removed override database option.
 * CAM  30-Dec-2009  10520 : Improved fieldFocus style, and added dropdownFocus.
 * CAM  01-Nov-2014  576402 : Added Admin Email/Name and changed Site Email to support.
 * CAM  06-Nov-2014  823080 : Removed deprecated functions.
 * RWM  01-Jan-2016  508026 : Begin v2 responsive - added $cfg['Site']['Shortname'], ['Shortdesc'] & ['Version'], alter dev mode url
 * * * * * * * * * * * * * * * * * * * * * * * */

define("GTORG", TRUE);

$cfg['Site']['VersionNo'] = "2.0.00ß";
$cfg['Site']['VersionDate'] = "01 Jan 2016";

$cfg['Site']['Name']  = "Good Teaching Search Engine";
$cfg['Site']['Shortname']  = "Good Teaching";
$cfg['Site']['Shortdesc']  = "Search Engine";
$cfg['Site']['URL']   = "http://v2.goodteaching.org"; // no trailing slash
$cfg['Site']['Email'] = "support@goodteaching.org";
$cfg['Site']['Status'] = "Production";

$cfg['Site']['Admin']['Email'] = "craig@goodteaching.org";
$cfg['Site']['Admin']['Name'] = "Craig McKay";

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "goodteaching";
$cfg['Site']['Db']['Password'] = "psalm45";
$cfg['Site']['Db']['Database'] = "goodteaching_org_min";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "localhost") !== FALSE) {
	/* This works on Mac OS X for /~craig or /~remcclean */
  $cfg['Site']['URL'] = "http://localhost". (!empty($_SERVER['CONTEXT_PREFIX']) ? $_SERVER['CONTEXT_PREFIX'] : "/~craig")."/ministry/dev/software/goodteaching2";
  $cfg['Site']['Status'] = "Development";
  $cfg['Site']['Version'] .= "/dev";
}

//site colour scheme
$cfg['Site']['Scheme']['Body']['Class'] = 'light-blue lighten-5';
$cfg['Site']['Scheme']['Nav']['Class'] = 'light-blue lighten-1';
$cfg['Site']['Scheme']['NavWrapper']['Class'] = ''; // change to 'navbar-fixed' to fix navbar to top of page;
$cfg['Site']['Scheme']['Footer']['Class'] = 'light-blue lighten-1 white-text';
$cfg['Site']['Scheme']['Footer']['Text']['Class'] = 'grey-text text-lighten-3';
$cfg['Site']['Scheme']['Footer']['Compact'] = TRUE;
$cfg['Site']['Scheme']['FooterCopyright']['Text']['Class'] = 'grey-text text-lighten-3';
$cfg['Site']['Scheme']['Heading']['Nav']['Class'] = '';
$cfg['Site']['Scheme']['Keyword']['Active']['Class'] = 'red darken-1';
$cfg['Site']['Scheme']['Keyword']['Inactive']['Class'] = 'red darken-3';
$cfg['Site']['Scheme']['Scripture']['Active']['Class'] = 'orange darken-1';
$cfg['Site']['Scheme']['Scripture']['Inactive']['Class'] = 'orange darken-3';
$cfg['Site']['Scheme']['Servant']['Active']['Class'] = 'green darken-1';
$cfg['Site']['Scheme']['Servant']['Inactive']['Class'] = 'green darken-3';
$cfg['Site']['Scheme']['Bible']['Active']['Class'] = 'light-green darken-1';
$cfg['Site']['Scheme']['Hymn']['Active']['Class'] = 'deep-orange darken-1';
$cfg['Site']['Scheme']['Read']['Active']['Class'] = 'light-blue darken-1';


//RWM: moved up here so session started before any db etc errors occur
session_start();
//error_reporting(E_ALL);
error_reporting(0);

include_once $root.'WEB-INF/inc.php';
include_once $root.'db.php';

function mdate($datein) {
  return date("Y-m-d", strtotime($datein));
}

function fldmand($value) {
  global $retry;
  echo (!empty($retry) && empty($value)) ? "fldmand" : "fld";
}

function fieldFocus() {
  echo "style=\"border:solid 1px #666666;padding:4px;\" onFocus=\"this.style.backgroundColor='#f6a2c0';\" onBlur=\"this.style.backgroundColor='#fff';\" ";
}

function dropdownFocus() {
  echo "style=\"border:solid 1px #666666;padding:2px;\" onFocus=\"this.style.backgroundColor='#f6a2c0';\" onBlur=\"this.style.backgroundColor='#fff';\" ";
}

include_once $root.'task.php';

?>