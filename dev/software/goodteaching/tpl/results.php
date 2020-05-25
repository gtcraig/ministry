<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Results panes
 *
  * Who  When         Why
 * CAM  19-Aug-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * * * * * * * * * * * * * * * * * * * * * * * */

?>
</td></tr>
<tr>
  <th class="resultsheader">Results</th>
  <td class="resultsheader"><img src="img/f.gif" border=0 width=0></td>
  <th class="resultsheader">Preview Pane</th>
</tr>
<tr>
  <td height="100" class="searchresults" valign=top><? include $root.'tpl/search_results.php'; ?></td>
  <td class="resultsheader"><img src="<? echo $root; ?>img/f.gif" border=0 width=12></td>
  <td class="pageresults" valign=top><? include $root.'tpl/page.php'; ?></td>
</tr>
<?
