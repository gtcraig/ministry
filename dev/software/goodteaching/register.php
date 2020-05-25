<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * New User Creation
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  28-Mar-2009  10407 : Added root correctly.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Register";
$root = "./";
include_once $root.'Main.php';
include $root.'tpl/top.php';

function retry_create($error) {
  global $username, $first_name, $last_name, $email_address, $dob, $password1, $password2, $retry, $root;
  Msg::error($error);
  include $root.'frm/user.register.php';
  include $root.'tpl/bot.php';
  exit();
}

$username = NULL;         if (!empty($_POST['username'])) $username = strtoupper($_POST['username']);
$first_name = NULL;       if (!empty($_POST['first_name'])) $first_name = $_POST['first_name'];
$last_name = NULL;        if (!empty($_POST['last_name'])) $last_name = $_POST['last_name'];
$email_address = NULL;    if (!empty($_POST['email_address'])) $email_address = $_POST['email_address'];
$dob = NULL;              if (!empty($_POST['dob'])) $dob = $_POST['dob'];
$password1 = NULL;        if (!empty($_POST['password1'])) $password1 = $_POST['password1'];
$password2 = NULL;        if (!empty($_POST['password2'])) $password2 = $_POST['password2'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if (!$retry) {
  retry_create("Please enter your details.");
} else if (!$username) {
  retry_create("You must enter your new Username.");
} else if (!$first_name || !$last_name) {
  retry_create("You must enter your first and last names.");
} else if (!$dob) {
  retry_create("You must enter your correct Date of Birth.");
} else if (!$email_address) {
  retry_create("You must enter your Email address.");
} else if (!$password1 || !$password2) {
  $password1 = NULL;
  $password2 = NULL;
  retry_create("You must enter your password twice.");
} else if ($password1 != $password2) {
  $password1 = NULL;
  $password2 = NULL;
  retry_create("Your passwords must match.");
} else {
  $dob = Util::displayToSqlDate($dob);

  $password1 = md5($password1);
  $verify_code = md5(date('l dS \of F Y h:i:s A'));

  $ssql = "INSERT INTO member (".
      "memberid,password,first_name,last_name,".
      "email_address,member_type,dob,verify_code".
    ") VALUES (".
      "'$username','$password1','$first_name','$last_name',".
      "'$email_address','U','$dob', '$verify_code'".
    ")";

  $sql = mysqli_query($dbConn, $ssql);

  if (mysql_errno() == 1062) {
    $username = NULL;
    retry_create("Someone has already taken this username - please try another.");
  }

  Msg::statement("Thank you.  You will be contacted shortly regarding your account.<br>".
                 "In the meantime please check your email to verify your email address.");

  $e = new EmailMsg('V', $username);
  $e->sendVerify($verify_code);
}

?>

