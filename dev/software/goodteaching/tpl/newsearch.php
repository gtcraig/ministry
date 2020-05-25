<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * New Search Wizard
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Jul-2012  11129 : Updated goodteaching.org/ebook for Kindle Touch.
 * CAM  20-Oct-2012  11143 : Updated goodteaching.org/ebook for Kindle Paperwhite and Fire.
 * CAM  31-Dec-2015  886930 : Updated with images for current devices
 * CAM  24-May-2020  481548 : Updated to include links to Rob's MSE copy. 
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<table border=0 cellpadding=10 cellspacing=0 width="100%">
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
  <td class="toolTip" width="100%">Interested in ministry relating to one or more specific words?</td>
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
<tr>
  <td colspan=2><table border=1 cellpadding=10 cellspacing=0 width="100%">
    <tr>
      <th colspan="2">Task \ Device</th>
      <th width="120">PC</th>
      <th width="120">Mac</th>
      <th width="120">iOS (iPhone/iPad)</th>
      <th width="120">Android</th>
      <th width="120">Kindle</th>
    </tr>
    <tr>
      <td colspan="2">Reading/Searching the Bible</td>
      <td colspan="4" align="center">Relevant <a href="https://www.olivetree.com/bible-study-apps/">Olive Tree</a> app</td>
      <td align="center"><a href="ebook/">JND eBook</a></td>
    </tr>
    <tr>
      <td rowspan="2">Reading the Ministry</td><td><a href="ebook/">eBooks</a></td>
      <td align="center"><a href="https://calibre-ebook.com/download">Calibre</a></td>
      <td align="center"><a href="https://calibre-ebook.com/download">Calibre</a> or<br />
        <a href="https://itunes.apple.com/gb/app/ibooks/id364709193?mt=8">Apple Books</a></td>
      <td align="center"><a href="https://itunes.apple.com/gb/app/ibooks/id364709193?mt=8">Apple Books</a></td>
      <td align="center"><a href="https://play.google.com/store/apps/details?id=com.aldiko.android">Aldiko</a></td>
      <td align="center"><a href="ebook/">eBooks</a></td>
    </tr>
    <tr>
      <td>Online</td>
      <td colspan="4" align="center"><a href="http://www.mcclean.me.uk/mse/">R.W.McClean</a></td>
      <td align="center"><i>Not Available</i></td>
    </tr>
		<tr>
      <td colspan="2">Searching the Ministry</td>
      <td colspan="2" align="center"><a href="http://mse.0mpurdy.com/">Ministry Search Engine</a></td>
      <td align="center"><a href="http://goodteaching.org">GoodTeaching.org</a></td>
      <td align="center"><a href="https://play.google.com/store/apps/details?id=mse.mse_android&hl=en">MSE</a> (Google Play)</td>
      <td align="center"><a href="ebook/">eBooks</a></td>
    </tr>
  </table></td>
</td>
</table>
