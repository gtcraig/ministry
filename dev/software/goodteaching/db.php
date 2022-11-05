<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Database Connectivity
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

global $cfg;
global $dbConn;

$dbConn = mysqli_connect(
  $cfg['Site']['Db']['Hostname'],
  $cfg['Site']['Db']['Username'],
  $cfg['Site']['Db']['Password'],
  $cfg['Site']['Db']['Database']
) or die ("Couldn't connect to server.");

mysqli_query($dbConn, "set names 'utf8'");
?>