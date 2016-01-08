<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009,2016 frontburner.co.uk
 *
 * 1962 Hymn Book Search
 *
 * $Id: index.php 1109 2009-12-30 13:02:57Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10204 : Added calls to Servant checkbox functions.
 * CAM  29-Sep-2008  10302 : Moved to GoodTeaching.org.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and use common database.
 * CAM  30-Dec-2009  10520 : Add focus formatting for dropdowns.
 * RWM  01-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "1962 Hymn Search";
$root = "../";
$tabs = "HYMN";
$pageName = "pageHymn";
//$pageCss = "hymn.css";
include $root.'tpl/top.php';
include 'hymn_fn.php';

$hymn_no = NULL;     if (!empty($_POST['hymn_no'])) $hymn_no = $_POST['hymn_no'];
$keywords = NULL;    if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];
$author = NULL;      if (!empty($_POST['author'])) $author = $_POST['author'];
$meter_id = NULL;    if (!empty($_POST['meter_id'])) $meter_id = $_POST['meter_id'];
$category_id = NULL; if (!empty($_POST['category_id'])) $category_id = $_POST['category_id'];
$language = NULL;    if (!empty($_POST['language'])) $language = $_POST['language'];


?>
<?php

  /*


  <form action="index.php" method="post" name="searchForm" target="_top" id="searchForm">
  <table border=0>
    <tr>
      <td class="fld">Hymn No.</th>
      <td class="fld">Text</th>
      <td colspan=2 class="fld">Author</td>
    </tr>

    <tr>
      <td><input <? fieldFocus(); ?> type="text" name="hymn_no" size="10" class="inputbox" value="<?php echo $hymn_no;?>" /></td>
      <td><input <? fieldFocus(); ?> type="text" name="keywords" size="40" class="inputbox" value="<?php echo $keywords;?>" /></td>
      <td colspan=2><input <? fieldFocus(); ?> type="text" name="author" size="20" class="inputbox" value="<?php echo $author;?>" /></td>
    </tr>

    <tr>
      <td><select <? dropdownFocus(); ?> name="language" id="language" class="dropdown" onchange="toggle_language();">
      <option value="" <? echo ($language == "" ? "SELECTED" : ""); ?>>English</option>
      <option value="_de" <? echo ($language == "_de" ? "SELECTED" : ""); ?>>Deutsch</option>
      <option value="_nl" <? echo ($language == "_nl" ? "SELECTED" : ""); ?>>Nederland</option>
      </select></td>

      <td><? select_categories($category_id); ?></td>

      <td><? select_meters($meter_id); ?></td>
      <td align=right>
        <input type="submit" name="hymn_search" value="Search" class="button" />
        <!--<a href="index.php?option=com_content&task=view&id=34&Itemid=2">Need help?</a>-->
      </td>
    </tr>
  </table>
  <input type="hidden" name="sitename" value="<?php echo $sitename; ?>" />
  <input type="hidden" name="op" value="search" />
  </form>

  
 */
?>
  

	<div class="row card hoverable">
		<nav>
			<div class="nav-wrapper <?php echo $cfg['Site']['Scheme']['Heading']['Nav']['Class']; ?> <?php echo $cfg['Site']['Scheme']['Hymn']['Active']['Class']; ?>">
				<a href="#" class="heading">Hymns</a>
			</div>
		</nav>
		
    	<div id="test1" class="card-content col s12">
			<div class="">

				<form action="index.php" method="post" name="searchForm" target="_top" id="searchForm">
					
					<div class="row">
						<div class="col s12 m2 input-field">
							<input type="number" name="hymn_no" id="hymn_no" class="validate" value="<?php echo $hymn_no;?>" min="1" max="456" placeholder=" " />
							<label for="hymn_no">Hymn No.</label>
						</div>
						<div class="col s12 m4 input-field">
							<input type="text" name="keywords" id="keywords" value="<?php echo $keywords;?>" />
							<label for="keywords">Text</label>
						</div>
						<div class="col s12 m3 input-field">
							<input type="text" name="author" id="author" value="<?php echo $author;?>" />
							<label for="author">Author</label>
						</div>
					</div>
					<div class="row">
						<div class="col s12 m2 input-field">
							<select name="language" id="language" >
								<option value="" <? echo ($language == "" ? "SELECTED" : ""); ?> >English</option>
								<option value="_de" <? echo ($language == "_de" ? "SELECTED" : ""); ?> >Deutsch</option>
								<option value="_nl" <? echo ($language == "_nl" ? "SELECTED" : ""); ?> >Nederland</option>
							</select>
							<label for="language">Language</label>			
						</div>
						<div class="col s12 m4 input-field">
							<select name="category_id" id="category_id" >
<?php
echo select_categories($category_id);
//hard coded options will go once db connected
?>
								<option value="ALL">--All Categories--</option>
								<option value="1">Service of God - Lord Jesus - 1st Hymn</option>
								<option value="2">Service of God - Lord Jesus - Worship</option>
								<option value="3">Service of God - Lord Jesus - Brethren</option>
								<option value="4">Service of God - Lord Jesus - Marital</option>
								<option value="5">Service of God - Holy Spirit</option>
								<option value="6">Service of God - Father</option>
								<option value="7">Service of God - Trinity</option>
								<option value="8">Service of God - God</option>
								<option value="12">Burial</option>
								<option value="11">Care Meeting</option>
								<option value="14">Gospel</option>
								<option value="9">Ministry Meeting</option>
								<option value="13">Prayer Meeting</option>
								<option value="10">Reading</option>
							</select>
							<label for="category_id">Category</label>			
						</div>
						<div class="col s8 m3 input-field">
							<select name="meter_id" id="meter_id">
<?php
echo select_meters($meter_id);
//hard coded options will go once db connected
?>
								<option value="ALL">--All Meters--</option>
								<option value="19">C.M.</option>
								<option value="61">C.M.D.</option>
								<option value="16">L.M.</option>
								<option value="84">L.M.D.</option>
								<option value="22">S.M.</option>
								<option value="70">S.M.D.</option>
								<option value="74">4.6.8.8.4.</option>
								<option value="28">4.8.4.8.8.</option>
								<option value="86">5.4.5.4.5.4.5.4.</option>
								<option value="40">5.5.4.5.5.4.</option>
								<option value="62">6.4.6.4.</option>
								<option value="32">6.4.6.4.6.4.6.4.</option>
								<option value="44">6.4.6.4.6.6.6.4.</option>
								<option value="27">6.5.11.6.5.11.</option>
								<option value="93">6.6.4.6.6.6.4.</option>
								<option value="43">6.6.6.5.6.6.6.5.</option>
								<option value="90">6.6.6.6.6.6.6.6.</option>
								<option value="51">6.6.6.6.8.8.</option>
								<option value="42">6.6.8.4.</option>
								<option value="23">6.6.8.4.6.6.8.4.</option>
								<option value="73">6.6.8.6.6.8.</option>
								<option value="41">7.6.7.6.</option>
								<option value="34">7.6.7.6.7.6.7.6.</option>
								<option value="81">7.6.7.6.8.8.</option>
								<option value="29">7.7.7.7.</option>
								<option value="83">7.7.7.7.7.7.</option>
								<option value="92">7.7.7.7.8.8.</option>
								<option value="88">7.7.7.8.</option>
								<option value="82">7.7.8.7.7.7.8.7.</option>
								<option value="47">8.4.8.4.8.8.8.4.</option>
								<option value="53">8.5.8.3.</option>
								<option value="56">8.5.8.5.</option>
								<option value="37">8.5.8.5.8.5.8.5.</option>
								<option value="72">8.6.8.4.</option>
								<option value="96">8.6.8.6.8.6.</option>
								<option value="55">8.6.8.6.8.8.</option>
								<option value="36">8.6.8.8.6.8.8.</option>
								<option value="95">8.7.8.5.</option>
								<option value="24">8.7.8.7.</option>
								<option value="80">8.7.8.7. Dactylic</option>
								<option value="54">8.7.8.7. Dactylic 5.7.8.7.</option>
								<option value="94">8.7.8.7. Iambic</option>
								<option value="76">8.7.8.7.4.4.7. Iambic</option>
								<option value="50">8.7.8.7.4.7.</option>
								<option value="77">8.7.8.7.7.7.</option>
								<option value="49">8.7.8.7.8.7.7.</option>
								<option value="25">8.7.8.7.8.7.8.7.</option>
								<option value="66">8.7.8.7.8.7.8.7. Iambic</option>
								<option value="68">8.7.8.7.8.7.8.7.7.7.</option>
								<option value="46">8.8.11.8.</option>
								<option value="65">8.8.4.8.8.4.</option>
								<option value="20">8.8.6.8.8.6.</option>
								<option value="79">8.8.7.7.</option>
								<option value="39">8.8.8.6.</option>
								<option value="30">8.8.8.8.</option>
								<option value="75">8.8.8.8.4.4.6.</option>
								<option value="58">8.8.8.8.6.</option>
								<option value="26">8.8.8.8.8.8.</option>
								<option value="35">9.8.9.8.</option>
								<option value="59">9.8.9.8.9.8.9.8.</option>
								<option value="69">9.9.6.6.6.4.</option>
								<option value="60">9.9.9.9.</option>
								<option value="21">10.10.10.10.</option>
								<option value="63">10.10.10.10. Dactylic</option>
								<option value="87">10.10.10.2.</option>
								<option value="89">10.10.10.6.</option>
								<option value="18">10.10.4.10.10.4.</option>
								<option value="45">10.4.10.4.10.10.</option>
								<option value="91">10.7.10.7.  11.7.11.7.</option>
								<option value="52">11.10.11.10.</option>
								<option value="17">11.10.11.10. Dactylic</option>
								<option value="67">11.10.11.10.9.11.</option>
								<option value="31">11.11.11.11.</option>
								<option value="64">11.11.11.11. Trochaic</option>
								<option value="71">11.8.11.9.</option>
								<option value="33">12.11.12.11.</option>
								<option value="48">12.13.12.10.</option>
								<option value="85">14.14.14.14.</option>
								<option value="78">14.14.4.7.8.</option>
							</select>
							<label for="meter_id">Meter</label>			
						</div>
						<div class="col s4 m3 right-align">
							<input type="hidden" name="sitename" value="" />
							<input type="hidden" name="op" value="search" />
							<?php echo ActionUtil::goButton(); ?>
						</div>
						</div>
					
				</form>

			</div>
		</div>
	</div>
 	<!-- end select -->

<?php
if (!empty($_POST['op'])) {
?>

	<!-- results -->
	<div class="row">
		<!-- left panel -->
		<div class="col s12 m6">
			 <div class="card-panel hoverable">

<?php
//results

  $keywordsList = explode(" ", $keywords);
  $authorList = explode(" ", $author);

  $metdesc = "";
  $catdesc = "";

  if (!empty($meter_id) && ($meter_id != "ALL")) {
    $sql = "SELECT meter, rhythm, chorus ".
           "FROM hymn_meter ".
           "WHERE id = '$meter_id'";

    $res = mysql_query($sql); // or die("<h1>Query failed</h1><pre>$sql</pre>");
    if ($row = mysql_fetch_array($res)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      $metdesc = $meter;
      if (!empty($rhythm)) $metdesc .= "&nbsp;<i>" . $rhythm ."</i>";
    }
    $metdesc = "of meter \"$metdesc\"";
  } else {
    $meter_id = "ALL";
  }

  if (!empty($category_id) && ($category_id != "ALL")) {
    $sql = "SELECT name ".
           "FROM hymn_scheme_categories ".
           "WHERE id = '$category_id'";

    $res = mysql_query($sql); //or die("<h1>Query failed</h1><pre>$sql</pre>");
    if ($row = mysql_fetch_array($res)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      $catdesc = "in category \"" . $name . "\"";
    }
  } else {
    $category_id = "ALL";
  }
  
  if (!empty($author)) {
	  $authdesc = " by author:\"$author\"";
  } else {
	  $authdesc = "";
  }

  if (!empty($keywords) > 0) {
    body_search($keywordsList, "Hymns $metdesc $catdesc containing \"$keywords\" ");
  } else if (!empty($author) > 0) {
    author_search($authorList, "Authors like \"$author\" and their hymns");
  } else if ($meter_id != "ALL" || $category_id != "ALL") {
    body_search($keywordsList, "Hymns $metdesc $catdesc");
  } else {
    echo "&nbsp;";
  }
?>
			 </div>  
		</div>
		<!-- right panel -->
		<div class="col s12 m6">
			<div class="card-panel hoverable">

<?php
  if (empty($hymn_no)) {
?>
      <p class="center grey-text">Select a hymn on the left to show it here.</p>
<?php
  } else {
    show_hymn($hymn_no, $language);
}
?>
			</div>
		</div>
	</div>
	<!-- end results -->
<?php
} 
?>


<script src="ajax.js"></script>
<?php
include $root.'tpl/bot.php';
?>