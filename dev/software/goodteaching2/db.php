<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Database Connectivity
 *
 * $Id: db.php 485 2007-07-29 19:59:18Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * RWM  22-Dec-2015  508026 : Begin v2 responsive. try/catch so I can test without db (but try/catch doesn't work for this)
 * * * * * * * * * * * * * * * * * * * * * * * */

defined("GTORG") or die("error");

global $cfg;

try {
	$connection = mysql_pconnect($cfg['Site']['Db']['Hostname'],
							$cfg['Site']['Db']['Username'],
							$cfg['Site']['Db']['Password']);
		//or die("Couldn't connect to server.") ;

	$db = mysql_select_db($cfg['Site']['Db']['Database'], $connection); 
		//or die("Couldn't select database.");

} catch (Exception $e) {	
    echo '<pre>Caught exception: ', $e->getMessage(), "</pre>\n";
}

?>