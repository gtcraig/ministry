<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2014 frontburner.co.uk
 *
 * Release History
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Oct-2014  File created.
 * RWM  01-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Volume Titles";
$tabs = "NONE";
include $root.'tpl/top.php';

?>


<div class="card">
	<div class="card-content">
		<span class="card-title activator">Volume Titles<span class="hide-on-small-and-down"> by Author and Volume</span><i class="right">?</i></span>
		<table class="compact-table top-align striped highlight table-responsive">
			<thead>
				<tr>
					<th style="width: 30%;">Author</th>
					<th class="right-align" style="width: 20%;">Vol</th>
					<th>Title</th>
				</tr>
			</thead>
			<tbody>
<?php

$sql = "SELECT author,vol,title ".
       "FROM mse_volume ".
       "ORDER BY author, vol";

$ssql = mysql_query($sql);
while ($row = mysql_fetch_array($ssql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if (empty($title)) {
    $title = $author . " V" . str_pad($vol, ($author == 'JT' ? 3 : 2), '0', STR_PAD_LEFT);
    $title .= " <a href=\"mailto:support@goodteaching.org?Subject=Volume%20Title%20Suggestion%20-%20" .
      str_replace(" ", "%20", $title) . "\">Make a suggestion for the title for this volume</a>";
  }
?>
				<tr>
					<td><? echo $author; ?></td>
					<td><? echo $vol; ?></td>
					<td><? echo $title; ?></td>
				</tr>
<?php
}
?>
			</tbody>
		</table>
	</div>
	<div class="card-reveal">
		<span class="card-title">Volume Titles<i class="right">&times;</i></span>
		<p>
			Would it be useful to be able to filter this by Servant / Author?
			If so, please <a href='mailto:support@goodteaching.org?Subject=I%20would%20like%20to%20filter%20Volume%20Titles%20by%20Servant!'>email us</a> to let us know.
		</p>
	</div>
</div>

<?php
include $root.'tpl/bot.php';
?>