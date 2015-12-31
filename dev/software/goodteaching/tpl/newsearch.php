<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching
 * Copyright (c) 2012 Front Burner
 *
 * New Search Wizard
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Jul-2012  11129 : Updated goodteaching.org/ebook for Kindle Touch.
 * CAM  20-Oct-2012  11143 : Updated goodteaching.org/ebook for Kindle Paperwhite and Fire.
 * CAM  31-Dec-2015  886930 : Updated with images for current devices
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<table border=0 cellpadding=10 cellspacing=0>
<tr><td align=left colspan=2>
<?
  $q = "What would you like to do";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname();
  }

  Msg::question($q);

?></td></tr>
<tr>
  <td align="right"><? echo ActionUtil::linkButton('keyword.php', 'Search by Keyword', 'keywordbutton', 'keywordbuttonhover');?></td>
  <td class="toolTip">Interested in ministry relating to one or more specific words?</td>
</tr><tr>
  <td align="right" valign=middle><? echo ActionUtil::linkButton('scripture.php', 'Search by Scripture Reference', 'scripturebutton', 'scripturebuttonhover');?></td>
  <td class="toolTip">Looking for ministry on a particular passage of Scripture?</td>
</tr><tr>
  <td>&nbsp;</td>
  <td class="toolTip">Looking for a list of <a href="volumes.php">Volume Titles</a> (e.g. what does 'JND Volume 45' mean?)</td>
</tr>

<tr>
	<td>
		<table border="0" cellpadding=5 cellspacing=0>
			<tr>
				<td><a href="http://goodteaching.org/ebook"><img border="0" src="ebook/kindlepw4.png"></a></td>
				<td><a href="http://goodteaching.org/ebook"><img border="0" src="ebook/apple4.png"></a></td>
		  </tr>
			<tr>
				<td align="center">Kindle</td>

				<td align="center">Apple</td>
		  </tr>

		</table>
  </td>
  <td class="toolTip">
  	Want to read the ministry on your ereader?<br />
  	<a href="http://goodteaching.org/ebook">http://goodteaching.org/ebook</a>
  </td>
</tr>
</table>
