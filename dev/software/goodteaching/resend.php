<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Resend Email Verification
 *
 * $Id: resend.php 894 2008-09-29 21:22:54Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Resend Email Verification";
include_once $root.'Main.php';
include $root.'tpl/top.php';

$username = NULL;         if (!empty($_POST['username'])) $username = strtoupper($_POST['username']);
$email_address = NULL;    if (!empty($_POST['first_name'])) $first_name = $_POST['first_name'];
$verify_code = NULL;      if (!empty($_POST['verify_code'])) $verify_code = $_POST['verify_code'];

$ssql = "UPDATE member SET email_address='$email_address' ".
        "WHERE memberid='$username'";
$sql = mysql_query($ssql);

Msg::statement("Thank you.  Please check your email to verify your email address.");

$e = new EmailMsg('V', $username);
$e->sendVerify($verify_code);

?>

