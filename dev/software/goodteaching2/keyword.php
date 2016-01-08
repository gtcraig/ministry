<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * New Search Wizard
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Attempt to send empty using NULL.
 * CAM  08-Nov-2007  10200 : Added results_pageno.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  28-Mar-2009  10407 : Added Search Type.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and changed session vars to include module name.
 * CAM  30-Dec-2009  10520 : Add focus formatting for textboxes.
 * CAM  04-Dec-2015  863707 : Added improved search options.
 * RWM  02-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Keyword Search";
$tab = "Keyword";
$tabs = "MINISTRY";
include $root.'tpl/top.php';

$keywords = $_SESSION['search_min_keywords'];  if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];
$searchType = $_SESSION['search_min_type'];  if (!empty($_POST['search_min_type'])) $searchType = $_POST['search_min_type'];

if ($keywords == "NULL") $keywords = "";
if (empty($searchType)) $searchType = "ALL";

$keywords = str_replace("\\\"", "", $keywords);
$keywords = str_replace("\\'", "", $keywords);
$keywords = str_replace("\\", "", $keywords);
$keywords = str_replace("  ", " ", $keywords);

if ($keywords == "") {
  // Ignore
} else if ($searchType == "ALL") {
  $keywords = SqlFactory::addAndOperators($keywords);
} else if (($searchType == "ANY") || ($searchType == "PHRASE")) {
  $keywords = SqlFactory::removeOperators($keywords);
}

$_SESSION['search_min_keywords'] = $keywords;
$_SESSION['search_min_type'] = $searchType;

?>

	<div class="row card hoverable">

		<nav>
			<div class="nav-wrapper <?php echo $cfg['Site']['Scheme']['Heading']['Nav']['Class']; ?> <?php echo $cfg['Site']['Scheme']['Keyword']['Active']['Class']; ?>">
				<a href="#" class="heading"><?php echo $tab; ?></a>
				<ul class="right">
					<li class="<?php echo $cfg['Site']['Scheme']['Scripture']['Inactive']['Class']; ?> linkitem"><a href="scripture.php">Scripture</a></li>
					<li class="<?php echo $cfg['Site']['Scheme']['Servant']['Inactive']['Class']; ?> linkitem"><a href="servant.php">Servant</a></li>
				</ul>
			</div>
		</nav>
		<div class="card-content">
			<div class="">
				<form method="post" name="searchText" id="searchText" >
<?php
if (FALSE) {
//bracket servant section for the moment
?>
					<div class="row">
						<div class="col s6 m4 l2 input-field">
							<input type="checkbox" CHECKED name="author_filter[ALL]" id="author_filter[ALL]" value="ALL" />
							<label for="author_filter[ALL]">All servants</label>
						</div>
						<div class="col s6 m4 l2 input-field">
							<input type="checkbox"  name="author_filter[CAC]" id="author_filter[CAC]" value="CAC" />
							<label for="author_filter[CAC]">C. A. Coates</label>
						</div>
						<div class="col s6 m4 l2 input-field">
							<input type="checkbox"  name="author_filter[FER]" id="author_filter[FER]" value="FER" />
							<label for="author_filter[FER]">F. E. Raven</label>
						</div>
						<div class="col s6 m4 l2 input-field">
							<input type="checkbox"  name="author_filter[JBS]" id="author_filter[JBS]" value="JBS" />
							<label for="author_filter[JBS]">J. B. Stoney</label>
						</div>
						<div class="col s6 m4 l2 input-field">
							<input type="checkbox"  name="author_filter[JND]" id="author_filter[JND]" value="JND" >
							<label for="author_filter[JND]">J. N. Darby</label>
						</div>
						<div class="col s6 m4 l2 input-field">
							<input type="checkbox"  name="author_filter[JT]" id="author_filter[JT]" value="JT" >
							<label for="author_filter[JT]">J. Taylor, Snr</label>
						</div>
						<div class="col s12 left hide">
							<small class="grey-text lighten-1">Select one or more servants</small>
						</div>
					</div>
<?php
}
?>
					<div class="row">
						<div class="col s6 m3 l2 input-field">
							<input name="search_min_type" id="st_all" type="radio" value="ALL" <?php if ($searchType == "ALL") echo "CHECKED"; ?> />
							<label for="st_all" 
								title="Returns only paragraphs where all the words you have entered appear, in any order. ">
								All words
							</label>
						</div>
						<div class="col s6 m3 l2 input-field">
							<input name="search_min_type" id="st_any" type="radio" value="ANY" <?php if ($searchType == "ANY") echo "CHECKED"; ?> />
							<label for="st_any"  
								title="Returns paragraphs where any of the words appear, and in any order.">
								Any words
							</label>
						</div>
						<div class="col s6 m3 l2 input-field">
							<input name="search_min_type" id="st_custom" type="radio" value="CUSTOM" <?php if ($searchType == "CUSTOM") echo "CHECKED"; ?> />
							<label for="st_custom" 
								title="This option allows you to use the custom search options, which you put at the beginning of a word:
+ (plus) means this word must appear (AND)
- (minus) means this word must not appear (NOT)
~ (tilde) means this word can appear, but it should sort towards the bottom of the list of results
(nothing) means this word can appear (OR)">
								Custom
							</label>
						</div>
						<div class="col s6 m3 l2 input-field">
							<input name="search_min_type" id="st_phrase" type="radio" value="PHRASE" <?php if ($searchType == "PHRASE") echo "CHECKED"; ?> />
							<label for="st_phrase" 
								title="Paragraphs are returned where all the words entered appear in the order you have typed them.  Punctuation in the paragraph is ignored.">
								Exact phrase
							</label>
						</div>
					</div>
					<div class="row hide">
						<div class="col s12 left">
							<small class="grey-text lighten-1">Select search method</small>
						</div>
					</div>
					<div class="row">
						<div class="col s8 m10">
							<div class="input-field">
								<input type="text" name="keywords" id="keywords" value="<?php echo $keywords; ?>" />
								<label for="search" class="active">Keywords</label>
							</div>
						</div>
						<div class="col s4 m2 right-align">
						    <input type=hidden name="results_pageno" id="results_pageno" value="0">
							<input type="hidden" name="op" value="search" />
							<?php echo ActionUtil::goButton(); ?>
						</div>
					</div>
				</form>
			</div>
		</div><!-- end card -->
	</div><!-- end row -->


<?php

if (!empty($_POST['op'])) {
	include $root.'tpl/results.php';
}
include $root.'tpl/bot.php';
?>