<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * Author Filter
 *
 * $Id: servant.php 947 2009-04-12 12:46:53Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10204 : Added calls to Servant checkbox functions.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and changed session vars to include module name.
 * RWM  06-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Servant Filter";
$tab = "author";
$tabs = "MINISTRY";
include $root.'tpl/top.php';


$author_filter = $_SESSION['search_min_author'];  if (!empty($_POST['author_filter'])) $author_filter = $_POST['author_filter'];
$_SESSION['search_min_author'] = $author_filter;

?>

	<div class="row card hoverable">

		<nav>
			<div class="nav-wrapper <?php echo $cfg['Site']['Scheme']['Heading']['Nav']['Class']; ?> <?php echo $cfg['Site']['Scheme']['Servant']['Active']['Class']; ?>">
				<a href="#" class="heading">Servant</a>
				<ul class="right">
					<li class="<?php echo $cfg['Site']['Scheme']['Keyword']['Inactive']['Class']; ?> linkitem"><a href="keyword.php">Keyword</a></li>
					<li class="<?php echo $cfg['Site']['Scheme']['Scripture']['Inactive']['Class']; ?> linkitem"><a href="scripture.php">Scripture</a></li>
				</ul>
			</div>
		</nav>

		<div class="card-content">
			<form action="servant.php" method="post">
<?php
	$q='';
/*
  $q .= "Select one or more Servants";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname() . ",";
  }
  $q .= " and click Search:";
*/

  if (empty($_SESSION['search_min_bookid']) && empty($_SESSION['search_min_keywords'])) {
	  $q .= "<p>(Note: Please select <a href='".$root."keyword.php'>Keyword(s)</a> and/or a <a href='".$root."scripture.php'>Scripture</a> first)</p>";
  }


  Msg::statement($q);

  $checked = "";
  if (!empty($author_filter['ALL'])) $checked = "CHECKED";

?>


				<div class="row">
					<div class="col s6 m4 l2 input-field">
						<input type="checkbox" <?php echo $checked; ?> name="author_filter[ALL]" id="author_filter[ALL]" value="ALL" onclick="toggleServants(this);return true;">
						<label for="author_filter[ALL]">All</label>
					</div>
					
<?php

$sql = "SELECT author, name FROM mse_author ORDER BY author";

$ssql = mysql_query($sql);
while ($row = mysql_fetch_array($ssql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $checked = "";
  if (!empty($author_filter[$author]) && empty($author_filter['ALL'])) {
    $checked = "CHECKED";
  }

?>
					<div class="col s6 m4 l2 input-field">
						<input type="checkbox" <?php echo $checked; ?>  name="author_filter[<?php echo $author; ?>]" id="author_filter[<?php echo $author; ?>]" value="<?php echo $author; ?>"  onclick="uncheckAll();return true;" />
						<label for="author_filter[<?php echo $author; ?>]"><?php echo $name; ?></label>
					</div>


<?php
}

?>
					<div class="right-align">
						<input type="hidden" name="op" value="search" />
						<?php echo ActionUtil::goButton(); ?>
					</div>

				</div>

			</form>
		</div>
	</div>
<?php
if (!empty($_POST['op'])) {
	include $root.'tpl/results.php';
}
include $root.'tpl/bot.php';
?>