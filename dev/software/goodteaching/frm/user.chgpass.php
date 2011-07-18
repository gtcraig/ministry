<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Change Password Form
 *
 * $Id: user.chgpass.php 485 2007-07-29 19:59:18Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

?>

<form action="changepass.php" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Old Password</td>
      <td><input name="old_password" type="password" id="old_password"></td>
    </tr>
    <tr>
      <td class="fld">New Password</td>
      <td><input name="new_password1" type="password" id="new_password1"></td>
    </tr>
    <tr>
      <td class="fld">New Password (again)</td>
      <td><input name="new_password2" type="password" id="new_password2"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input class="button" type="submit" value="Change"><input type="hidden" name="retry" value="1"></td>
    </tr>
  </table>
</form>
