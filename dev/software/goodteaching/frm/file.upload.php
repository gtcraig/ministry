<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * File Upload
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once $root."db.php";
?>

<form enctype="multipart/form-data" action="fileupload.php" method="POST">
  <input type="hidden" name="MAX_FILE_SIZE" value="300000" />
<table border=0 cellspacing=0 cellpadding=5>
<tr><td class="<? echo (empty($documentdate)) ? "fldmand" : "fld" ?>">Document Date</td><td><input name="documentdate" size="12" value="<? echo $documentdate; ?>" onChange="checkDate(this);" /></td></tr>
<tr><td class="<? echo (empty($documenttype)) ? "fldmand" : "fld" ?>">Document Type</td><td><select name="documenttype" />
<option value="I" <? echo (empty($documenttype) || ($documenttype == "I")) ? "SELECTED" : "" ?>>Image</option>
<option value="P" <? echo ($documenttype == "P") ? "SELECTED" : "" ?>>PDF</option>
</select></td></tr>
<tr><td class="<? echo (empty($uplfilename)) ? "fldmand" : "fld" ?>">File</td><td><input name="uplfile" type="file" /></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Upload File">
  <input type=hidden name="retry" value="1">
</td></tr>

</table>
</form>
