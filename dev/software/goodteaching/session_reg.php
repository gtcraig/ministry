<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Session Registration
 *
 * $Id: session_reg.php 894 2008-09-29 21:22:54Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  29-Sep-2008  10302 : Added root.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once $root.'Main.php';

$_SESSION['memberid'] = $memberid;
$_SESSION['first_name'] = $first_name;
$_SESSION['last_name'] = $last_name;
$_SESSION['email_address'] = $email_address;
$_SESSION['Good Teaching Search Engine'] = "Good Teaching Search Engine";

$p = Person::getPerson($memberid);
$_SESSION['member_person'] = $p;

mysql_query("UPDATE member SET last_login=now() WHERE memberid='$memberid'");

?>
<script language="javascript">top.location.href="index.php";</script>
<?