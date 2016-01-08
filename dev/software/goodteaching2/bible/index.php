<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2009 frontburner.co.uk
 *
 * Bible Search
 *
 * $Id: index.php 1111 2009-12-30 13:45:32Z craig $
 *
 * Who  When         Why
 * CAM  29-Dec-2009  10515 : File created.
 * CAM  30-Dec-2009  10520 : Ensure keywords are formatted correctly for SQL.
 * CAM  30-Dec-2009  10522 : Added remove_mselinks - needs to be improved once links are clickable.
 * RWM  01-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Bible Search";
$root = "../";
$tabs = "BIBLE";
$pageName = "pageBible";
//$pageCss = "bible.css";
include $root.'tpl/top.php';

$searchType = NULL;     if (!empty($_POST['search_bible_type'])) $searchType = $_POST['search_bible_type'];
$searchContext = NULL;  if (!empty($_POST['search_bible_context'])) $searchContext = $_POST['search_bible_context'];
$searchVersion = NULL;  if (!empty($_POST['search_bible_version'])) $searchVersion = $_POST['search_bible_version'];
$keywords = NULL;       if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];

$keywords = trim(str_replace("\'", " ", $keywords));
$keywords = trim(str_replace("\"", " ", $keywords));
$keywords = trim(str_replace("\\", " ", $keywords));
$keywords = trim(str_replace("  ", " ", $keywords));

function remove_mselinks($text) {
  //$text = preg_replace("/\[(.*)\](.*)\[\/(.*)\]/is", "<span class=\"footnote\">$2</span>", $text, $count);

  $record=true;
  $newText="";

  for ($i=0; $i<strlen($text); $i++) {

    $ch = substr($text, $i, 1);

    if ($ch == "[") {
      $record = false;

      if (substr($text, $i+1, 1) == "/") {
        $newText .= "</span>";
      } else {
        $newText .= "<span class=\"footnote\">";
      }

    } else if ($ch == "]") {
      $record = true;
    } else {
      if ($record) {
        $newText .= $ch;
      }
    }
  }

  return $newText;
}

?>
  <?php /*<script language="Javascript" src="ajax.js"></script> */?>


	<div class="row card hoverable">
		<nav>
			<div class="nav-wrapper <?php echo $cfg['Site']['Scheme']['Heading']['Nav']['Class']; ?> <?php echo $cfg['Site']['Scheme']['Bible']['Active']['Class']; ?>">
				<a href="#" class="heading">Bible Footnotes</a>
			</div>
		</nav>

		<div class="card-content">
    	<div id="test1" class="col s12">
			<div class="">
				<form action="index.php" method="post" name="searchForm" target="_top" id="searchForm">  
				<div class="row">
					<div class="col s12 m4 input-field">
						<ul>
							<li>Search version:</li>
							<li><input <?php if ($searchVersion == "DARBY" || empty($searchVersion)) echo "CHECKED"; ?>  type=radio id=sv_darby name=search_bible_version value="DARBY" tabindex="0" /><label for="sv_darby">J.N.Darby</label></li>
							<li><input <?php if ($searchVersion == "KJV") echo "CHECKED"; ?> type=radio disabled id=sv_kjv name=search_bible_version value="KJV"><label for="sv_kjv" tabindex="0" />King James (Authorised)</label></li>
							<li><input <?php if ($searchVersion == "BOTH") echo "CHECKED"; ?> type=radio disabled id=sv_both name=search_bible_version value="BOTH" tabindex="0" /><label for="sv_both">Both</label></li>
						</ul>
					</div>
					<div class="col s12 m4 input-field">
						<ul>
							<li>Search for:</li>
						    <li><input <?php if ($searchType == "KEYWORDS" || empty($searchType)) echo "CHECKED"; ?> type=radio id=st_keywords name=search_bible_type value="KEYWORDS" tabindex="0" /><label for="st_keywords">Keywords</label></li>
						    <li><input <?php if ($searchType == "SCRIPTURE") echo "CHECKED"; ?> type=radio disabled id=st_scripture name=search_bible_type value="SCRIPTURE" tabindex="0" /><label for="st_scripture">Scripture</label></li>
						</ul>
					</div>
					<div class="col s12 m4 input-field">
						<ul>
							<li>Search in:</li>
						    <li><input <?php if ($searchContext == "FOOTNOTES" || empty($searchContext)) echo "CHECKED"; ?> type=radio id=sc_footnotes name=search_bible_context value="FOOTNOTES" tabindex="0" /><label for="sc_footnotes">Footnotes</label></li>
						    <li><input <?php if ($searchContext == "TEXT") echo "CHECKED"; ?> type=radio disabled id=sc_text name=search_bible_context value="TEXT" tabindex="0" /><label for="sc_text">Bible text</label></li>
						    <li><input <?php if ($searchContext == "BOTH") echo "CHECKED"; ?> type=radio disabled id=sc_both name=search_bible_context value="BOTH" tabindex="0" /><label for="sc_both">Both</label></li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s9">
						<input type="text" id="keywords" name="keywords" tabindex="1" autofocus="autofocus" value="<?php echo $keywords; ?>" />
						<label for="keywords" class="active">Enter text</label>
					</div>
					<div class="col s3 right-align">
						<input type="hidden" name="op" value="search" />
						<?php echo ActionUtil::goButton('',8); ?>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>

<?php
if (!empty($keywords)) {

    $keywords = "%$keywords%";
    $keywords = str_replace(" ", "%", $keywords);
    $keywords = str_replace(",", "%", $keywords);
    $keywords = str_replace(";", "%", $keywords);
    $keywords = str_replace(":", "%", $keywords);
    $keywords = str_replace(".", "%", $keywords);
    $keywords = str_replace("-", "%", $keywords);
    $keywords = str_replace("\'", "%", $keywords);
    $keywords = str_replace("\"", "%", $keywords);
    $keywords = str_replace("%%", "%", $keywords);
    $keywords = str_replace("%%", "%", $keywords);
	
    $sql = "SELECT b.bookname, f.chapter, f.verse, f.footnoteid, f.symbol, f.text, fr.phrase ".
           "FROM mse_bible_footnote f, mse_bible_footnote_ref fr, mse_bible_version v, mse_bible_book b ".
           "WHERE v.verid = f.verid ".
           "AND b.bookid = f.bookid ".
           "AND fr.footnoteid = f.footnoteid ".
           "AND (f.text LIKE '" . $keywords . "' ".
                "OR fr.phrase LIKE '" . $keywords . "') ".
           "ORDER BY b.bookid, f.chapter, f.verse, f.footnoteid ";


    $ssql = mysql_query($sql); // or die(mysql_error());
	if (!$ssql) {
		$results_count = -1;
		$results_msg = "Sql Error: ".mysql_error();
	} else {
		$results_msg = '';
		$results_count = mysql_num_rows($ssql);
		if(!$results_count) {
			$results_count = 0;
			$results_msg = 'No results';
		}
	}
	
    $prevFootnoteId = 0;
    $refs="";
	

?>
  <div class="row card hoverable">
		  <div class="card-content" id="mydiv">
			  <?php /*
			  <ul class="pagination"><li class="left"><a href="">&larr;</a></li><li class="right"><a href="">&rarr;</a></li></ul>
			  */ ?>
			  <p class="center">
				  <strong>Results</strong> <span class="counter"><?php echo $results_count; ?></span>
			  </p>


			      <table class="compact-table top-align highlight striped">
					  <thead>
			      <tr>
			        <th class="rh">Book</th>
			        <th class="rh">Chapter</th>
			        <th class="rh">Verse</th>
			        <th class="rh">Note</th>
			        <th class="rh">Text</th>
			      </tr>
				  </thead>
				  <tbody>
<?php

if($results_msg) {
?>
		<tr><td colspan="5"><?php echo $results_msg; ?></td></tr>
<?php
}


    while ($row = mysql_fetch_array($ssql)) {
		foreach($row AS $key => $val) {
    		$$key = stripslashes($val);
    	}

		$text = remove_mselinks($text);

		if (!empty($refs)) $refs .= ", ";
		$refs .= "<span class=\"phrase\">$phrase</span>";

?>
	  			<tr>
<?php
		if ($footnoteid <> $prevFootnoteId) {
?>
					<td class="rd"><? echo "$bookname"; ?></td>
					<td class="rd"><? echo "$chapter"; ?></td>
					<td class="rd"><? echo "$verse"; ?></td>
					<td class="rd"><? echo "<strong>$symbol</strong>"; ?></td>
					<td class="rd"><? echo "$refs<br />$text"; ?></td>
<?php
			$refs="";
		}
?>
  </tr>
<?php
		$prevFootnoteId = $footnoteid;
	}
?>


			  </tbody>
		  </table>


		  <?php /* <ul class="pagination"><li class="left"><a href="">&larr;</a></li><li class="right"><a href="">&rarr;</a></li></ul> */ ?>
		  <p class="center">&emsp;</p>


		</div>  
  </div>
<?php
}
?>

<?php
include $root.'tpl/bot.php';
?>