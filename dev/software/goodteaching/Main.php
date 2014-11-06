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
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Good Teaching Search Engine";
$cfg['Site']['URL']   = "http://goodteaching.org"; // no trailing slash
$cfg['Site']['Email'] = "support@goodteaching.org";
$cfg['Site']['Status'] = "Production";

$cfg['Site']['Admin']['Email'] = "craig@goodteaching.org";
$cfg['Site']['Admin']['Name'] = "Craig McKay";

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "goodteaching";
$cfg['Site']['Db']['Password'] = "psalm45";
$cfg['Site']['Db']['Database'] = "goodteaching_org_min";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "localhost") !== FALSE) {
  $cfg['Site']['URL'] = "http://localhost:90/ministry";
  $cfg['Site']['Status'] = "Development";
}

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

session_start();
error_reporting(E_ALL);

include_once $root.'task.php';

?>