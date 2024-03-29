<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Login to the system (including first-time)
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  28-Mar-2009  10407 : Added root.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Login";
$root = "./";
include_once $root.'Main.php';
include $root.'tpl/top.php';

function retry_login($error='') {
  global $memberid, $root;
  if (!empty($error)) Msg::error($error);
  include $root.'frm/user.login.php';
  include $root.'tpl/bot.php';
  exit();
}

$memberid = NULL;     if (!empty($_POST['memberid'])) $memberid = $_POST['memberid'];
$pwd = NULL;          if (!empty($_POST['password'])) $pwd = $_POST['password'];

if(!$memberid){
  retry_login();
}

// Convert password to md5 hash
$pwd = md5($pwd);

// Retrieve the member details
$sql = mysqli_query($dbConn, "SELECT * FROM member WHERE memberid='$memberid'");
$login_check = mysqli_num_rows($sql);

if ($login_check > 0) {
  if ($row = mysqli_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if($pwd == $password) {
      if($active != 1) {
        Msg::error("You must verify your account to continue.<br>");
        include $root.'frm/user.verify.php';
        exit();
      } else if ($member_type == "N") {
        Msg::error("Your details are being reviewed and you will be contacted shortly.<br>");
        exit();
      }

      include 'session_reg.php';
    } else {

      retry_login("Your password is incorrect.&nbsp;&nbsp;Please check and try again!");
    }
  }
} else {
  retry_login("The Username " . $memberid . " could not be found.&nbsp;&nbsp;Please check and try again!");
}

include $root.'tpl/bot.php';
?>

