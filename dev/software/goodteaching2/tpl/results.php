<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Results panes
 *
 * $Id: results.php 894 2008-09-29 21:22:54Z craig $
 *
 * Who  When         Why
 * CAM  19-Aug-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * RWM  05-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

?>

<div class="row">
	<div class="col s12 m6 l6">
		<div class="card-panel hoverable">
			<p class="center">Results</p>
			<div><?php include $root.'tpl/search_results.php'; ?></div>
		</div>
	</div>
	<div class="col s12 m6 l6">
		<div class="card-panel hoverable">
			<p class="center">Preview Panel</p>
			<div><?php include $root.'tpl/page.php'; ?></div>
		</div>
	</div>
</div>
