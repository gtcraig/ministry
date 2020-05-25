<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * New User Form
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<form action="register.php" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="<? echo (!empty($retry) && empty($username)) ? "fldmand" : "fld" ?>">Username</td>
      <td><input name="username" type="text" id="username" size=6
      <? echo 'value="'. $username . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($first_name)) ? "fldmand" : "fld" ?>">First name</td>
      <td><input name="first_name" type="text" id="first_name" size=15
      <? echo 'value="'. $first_name . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($last_name)) ? "fldmand" : "fld" ?>">Surname</td>
      <td><input name="last_name" type="text" id="last_name" size=15
      <? echo 'value="'. $last_name . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($dob)) ? "fldmand" : "fld" ?>">Date of Birth</td>
      <td><input name="dob" type="text" id="dob" size=10 onChange="checkDate(this);"
      <? echo 'value="'. $dob . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($email_address)) ? "fldmand" : "fld" ?>">Email Address</td>
      <td><input name="email_address" type="text" id="email_address" size=30
      <? echo 'value="'. $email_address . '">';?></td>
    <tr>
      <td class="<? echo (!empty($retry) && empty($password1)) ? "fldmand" : "fld" ?>">Password</td>
      <td><input name="password1" type="password" id="password1" size=12></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($password2)) ? "fldmand" : "fld" ?>">Re-enter password</td>
      <td><input name="password2" type="password" id="password2" size=12></td>
    </tr>
      <td>&nbsp;</td>
      <td>
        <input name="retry" type="hidden" id="retry" value="1">
        <input class="button" type="submit" value="Register">
      </td>
    </tr>
  </table>
</form>
