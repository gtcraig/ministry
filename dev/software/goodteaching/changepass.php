<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Change Password
 *
 * $Id: changepass.php 894 2008-09-29 21:22:54Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Change Password";
include_once $root.'Main.php';
include $root.'tpl/top.php';

function retry_chgpass($msg) {
  if (!empty($_POST['retry'])) {
    Msg::error("Enter your old password, and the new one twice.");
  } else {
    Msg::error($msg);
  }

  include $root.'frm/user.chgpass.php';
  include $root.'tpl/bot.php';
  exit();
}

$memberid = $member->getID();

$old_pwd = NULL;     if (!empty($_POST['old_password'])) $old_pwd = $_POST['old_password'];
$new_pwd1 = NULL;    if (!empty($_POST['new_password1'])) $new_pwd1 = $_POST['new_password1'];
$new_pwd2 = NULL;    if (!empty($_POST['new_password2'])) $new_pwd2 = $_POST['new_password2'];

if(!$old_pwd || !$new_pwd1 || !$new_pwd2){
  retry_chgpass("Enter your old password, and the new one twice.");
} else if ($new_pwd1 != $new_pwd2) {
  retry_chgpass("The new passwords do not match.");
} else {

  $old_pwd = md5($old_pwd);
  $new_pwd1 = md5($new_pwd1);

  // Retrieve the member details
  $sql = mysql_query("SELECT * FROM member WHERE memberid='$memberid' AND password='$old_pwd'");
  $login_check = mysql_num_rows($sql);

  if ($login_check > 0) {
    mysql_query("UPDATE member SET password='$new_pwd1' WHERE memberid='$memberid'");
    Msg::error("Password changed.");
  } else {
    retry_chgpass("Your old password is incorrect.&nbsp;&nbsp;Please check and try again!");
  }
}

include $root.'tpl/bot.php';
?>

