<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2009 frontburner.co.uk
 *
 * Read Volumes
 *
 * $Id: index.php $
 *
 * Who  When         Why
 * RWM  01-Jan-2016  508026 : Initially just a placeholder for the "Read Volumes" page
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Read Volumes";
$root = "../";
$tabs = "READ";
$pageName = "pageRead";
$pageCss = "";
include $root.'tpl/top.php';

$preview_go = !empty($_GET['preview_go']) ? $_GET['preview_go'] : '';
$preview_author = !empty($_POST['preview_author']) ? $_POST['preview_author'] : (!empty($_SESSION['preview_author']) ? $_SESSION['preview_author']: '');
$preview_vol = !empty($_POST['preview_vol']) ? $_POST['preview_vol'] : (!empty($_SESSION['preview_vol']) ? $_SESSION['preview_vol'] : '');
$preview_page = !empty($_POST['preview_page']) ? $_POST['preview_page'] : (!empty($_SESSION['preview_page']) ? $_SESSION['preview_page'] : '');
$preview_page_odd = $preview_page;
$preview_page_even = $preview_page;

$_SESSION['preview_author'] = $preview_author;
$_SESSION['preview_vol'] = $preview_vol;
$_SESSION['preview_page'] = $preview_page;


//get the odd and even page numbers
if ( $preview_page & 1 ) {
	$preview_page_even += 1;
} else {
	$preview_page_odd -= 1;
}

?>
	<form action="index.php" method="post" name="searchForm" target="_top" id="searchForm">

	<div class="row card hoverable">
		<nav>
			<div class="nav-wrapper <?php echo $cfg['Site']['Scheme']['Heading']['Nav']['Class']; ?> <?php echo $cfg['Site']['Scheme']['Read']['Active']['Class']; ?>">
				<a href="#" class="heading">Read by Volume</a>
			</div>
		</nav>

    	<div id="test1" class="card-content col s12">
			
			<div class="">
				<div class="row">
					<div class="col s6 m4 l2 input-field">
						<input type="radio"  name="preview_author" id="preview_author_cac" value="CAC" tabindex="1" <?php if ($preview_author == "CAC") echo "CHECKED"; ?> />
						<label for="preview_author_cac">C.A.Coates</label>
					</div>
					<div class="col s6 m4 l2 input-field">
						<input type="radio"  name="preview_author" id="preview_author_fer" value="FER" tabindex="2" <?php if ($preview_author == "FER") echo "CHECKED"; ?> />
						<label for="preview_author_fer">F.E.Raven</label>
					</div>
					<div class="col s6 m4 l2 input-field">
						<input type="radio"  name="preview_author" id="preview_author_jbs" value="JBS" tabindex="3" <?php if ($preview_author == "JBS") echo "CHECKED"; ?> />
						<label for="preview_author_jbs">J.B.Stoney</label>
					</div>
					<div class="col s6 m4 l2 input-field">
						<input type="radio"  name="preview_author" id="preview_author_jnd" value="JND" tabindex="4" <?php if ($preview_author == "JND") echo "CHECKED"; ?> />
						<label for="preview_author_jnd">J.N.Darby</label>
					</div>
					<div class="col s6 m4 l4 input-field">
						<input type="radio"  name="preview_author" id="preview_author_jt" value="JT" tabindex="5"  <?php if ($preview_author == "JT") echo "CHECKED"; ?> >
						<label for="preview_author_jt">J.Taylor&nbsp;Snr</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s9 m5">
						<input type="text" name="preview_vol" value="<?php echo $preview_vol; ?>" tabindex="6" />
						<label for="preview_vol">Enter volume number</label>
					</div>
					<div class="input-field col s9 m5">
						<input type="text" name="preview_page" value="<?php echo $preview_page; ?>" tabindex="7" />
						<label for="preview_page">Enter page number</label>
					</div>
					<div class="col s3 m2 right-align">
					    <input type="hidden" name="op" value="search" />
						<?php echo ActionUtil::goButton('',8); ?>
					</div>
				</div>

			</div>
		
		</div>
 
	</div>

	</form>


<?php

if (!empty($_POST['op']) || $preview_go === 'go') {
?>

	<div class="row">
		<div class="">
			<div class="col s12 m6 l6 card-panel hoverable" tabindex="0" onClick='alert("prev pair <?php echo $preview_page_odd - 2; ?>");' >
				<ul class="pagination"><li class="left"><a href="#">&larr;</a></li></ul>
				<p class="center">
					<strong><?php echo $preview_author; ?></strong> Volume <strong><?php echo $preview_vol; ?></strong> Page <strong><?php echo $preview_page_odd; ?></strong>
				</p>
				<div class="divider"></div>
				<span class="">
						<p class="center">odd page</p>
<?php
/* php logic to read odd page goes here */
?>
				</span>

				<ul class="pagination"><li class="left"><a href="#">&larr;</a></li></ul>
				<p class="center">&emsp;</p>

			</div>  
		</div>
		<div class="">
			<div class="col s12 m6 l6 card-panel hoverable" tabindex="0" onClick='alert("next pair <?php echo $preview_page_even + 2; ?>");' >
				<ul class="pagination"><li class="right"><a href="#">&rarr;</a></li></ul>
				<p class="center">
					<strong><?php echo $preview_author; ?></strong> Volume <strong><?php echo $preview_vol; ?></strong> Page <strong><?php echo $preview_page_even; ?></strong>
				</p>
				<div class="divider"></div>
				<span class="">
					<p class="center">even page</p>
<?php
/* php logic to read even page goes here */
?>
				</span>
				<ul class="pagination"><li class="right"><a href="#">&rarr;</a></li></ul>
				<p class="center">&emsp;</p>
			</div>
		</div>
	</div>
<?php
}
?>



<?php
include $root.'tpl/bot.php';
?>