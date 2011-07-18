<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * New Search Wizard
 *
 * $Id: newsearch.php 520 2007-09-09 21:19:56Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
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
  <td><? echo ActionUtil::linkButton('keyword.php', 'Search by Keyword', 'keywordbutton', 'keywordbuttonhover');?></td>
  <td class="toolTip">Interested in ministry relating to one or more specific words?</td>
</tr><tr>
  <td valign=middle><? echo ActionUtil::linkButton('scripture.php', 'Search by Scripture Reference', 'scripturebutton', 'scripturebuttonhover');?></td>
  <td class="toolTip">Looking for ministry on a particular passage of Scripture?</td>
</tr>

</table>

