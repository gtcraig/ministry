<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2008,2009 Southesk.com
 *
 * 1962 Hymn Book Search CSS
 *
 * $Id: hymn_fn.php 1109 2009-12-30 13:02:57Z craig $
 *
 * Who  When         Why
 * CAM  29-Sep-2008  10302 : Moved to GoodTeaching.org
 * CAM  12-Apr-2009  10419 : Renamed CSS class to include module name.
 * CAM  30-Dec-2009  10520 : Add focus formatting for dropdowns.
 * RWM  01-Jan-2016  508026 : Begin v2 responsive.
 * 
 * @todo separate DB and UI
 * * * * * * * * * * * * * * * * * * * * * * * */
function get_select_option_template() {
	return '<option %3$s value="%1$s">%2$s</option>'."\n";
}

function select_meters($meter_id) {
	$fmt = get_select_option_template();
	$result = sprintf($fmt, "ALL", "All Meters", "");
	$sel = '';
	$sql = "SELECT m.id, m.meter, m.rhythm, m.chorus, m.disp_order ".
				"FROM hymn$language h ".
				"INNER JOIN hymn_meter m ON m.id = h.meter_id ".
				"GROUP BY disp_order, id, meter, rhythm, chorus ".
				"ORDER BY disp_order, meter, rhythm, chorus";
	$sqlres = mysql_query($sql); // or die("</select><h1>Query failed</h1><pre>$sql</pre>");
	if (!$sqlres) {
		$result .= sprintf($fmt, "", "SQL Error: ".mysql_error(), "");
	} else {
		while ($row = mysql_fetch_row($sqlres)) {
			$sel = "";
			if ($row[0] == $meter_id) {
				$sel = "SELECTED ";
			}
			$result .= sprintf($fmt, $row[0], trim("$row[1] $row[2] $row[3]"), $sel);
		}
	}
	mysql_free_result($sqlres);
	return $result;
}

function select_categories($category_id) {
	$fmt = get_select_option_template();
	$result = sprintf($fmt, "ALL", "All Categories", "");
	$sel = '';
    $sql = "SELECT c.id, s.code scheme_code, c.code category, c.name ".
                "FROM hymn_scheme_categories c ".
				"INNER JOIN hymn_schemes s ON s.id = c.scheme_id ".
                "ORDER BY c.disp_order, c.name";
	$sqlres = mysql_query($sql); // or die("</select><h1>Query failed</h1><pre>$sql</pre>");
	if (!$sqlres) {
		$result .= sprintf($fmt, "", "SQL Error: ".mysql_error(), "");
	} else {
		while ($row = mysql_fetch_row($sqlres)) {
			$sel = "";
			if ($row[0] == $category_id) {
				$sel = "SELECTED ";
			}
			$result .= sprintf($fmt, $row[0], trim("$row[1] $row[2] $row[3]"), $sel);
		}
	}
	mysql_free_result($sqlres);
	return $result;
}

function nbsp($value) {
  if ($value == "") {
    return "&nbsp;";
  }

  return $value;
}

function describe_search($searchType, $results_count = -9) {
?>
	<div class="center">
		<p><strong>
<?php
	  echo $searchType;
	  if ($results_count != -9) {
		  echo " &nbsp; <span class='counter'>$results_count</span>";
	  }
?>
		</strong></p>
	</div>
<?php
}

function output_hymn_table_start() {
?>
<table class="compact-table top-align highlight striped"><tbody>
<?php
}

function output_hymn_line($hymn_no, $hymn_line, $meter) {
?>
  <tr><td><a href="javascript:void();" onClick="view_hymn('<? echo $hymn_no; ?>');return false;">
	  <?php echo nbsp($hymn_no); ?></a></td><td title="<? echo $meter; ?>"><?php echo $hymn_line; ?></td></tr>
<?php
}

function output_hymn_table_end() {
?>
</tbody></table>
<?php
}

function body_search($keywordsList, $searchType) {
  global $database, $language, $meter_id, $category_id, $author;

  $whereClause = "";
  $extraTables = "";

  $i = 0;
  foreach($keywordsList as $keyword) {
    if ($keyword != "") {
      $whereClause .= "AND d.line_text like '%".$keyword."%' ";
      $i++;
    }
  }

  if (!empty($meter_id) && $meter_id != "ALL") {
    $whereClause .= "AND h.meter_id='$meter_id' ";
    if ($i == 0) {
      $whereClause .= "AND d.vers_no=1 and d.line_no=1 ";
    }
  }

  if (!empty($category_id) && $category_id != "ALL") {
    $whereClause .= "AND h.hymn_no = c.hymn_no AND c.category_id = '$category_id' ";
    $extraTables .= ", hymn_categories c ";
    if ($i == 0) {
      $whereClause .= "AND d.vers_no=1 and d.line_no=1 ";
    }
  }

  $verseSql = "SELECT DISTINCT d.hymn_no, d.line_text, h.meter " . //, d.vers_no, d.line_no, d.line_text, h.meter ".
              "FROM hymn_line$language d, hymn$language h $extraTables ".
              "WHERE d.hymn_no = h.hymn_no $whereClause ".
              "ORDER BY d.hymn_no,d.vers_no,d.line_no";

  $res = mysql_query($verseSql); // or die("</select><h1>Query failed</h1><pre>$verseSql</pre>");
  if (!$res) {
	$results_count = -1;
	$results_msg = mysql_error();
  } else {
	$results_msg = '';
	$results_count = mysql_num_rows($res);
	if(!$results_count) {
		$results_count = 0;
		$results_msg = 'No results';
	}
  }
  describe_search($searchType, $results_count);
  output_hymn_table_start();
  if (!$res) {
  	  output_hymn_line(-1, "Unfortunately we hit an error", "Sql Error: ".mysql_error());
  } else {
  	while ($row = mysql_fetch_row($res)) {
  	  output_hymn_line($row[0], $row[1], $row[2]);
  	}
  }
  output_hymn_table_end();
  mysql_free_result($res); 
}

function author_search($authorList, $searchType) {
  global $database, $language, $meter_id;

  $whereClause = "WHERE ";

  $i = 0;
  foreach($authorList as $auth) {
    if ($i > 0) {
      $whereClause .= "AND ";
    }
    $whereClause .= "fullname LIKE '%".$auth."%' ";
    $i++;
  }

  $verseSql = "SELECT id,fullname,surname,firstnames,author_life,bio_url ".
              "FROM authors $whereClause order by surname,fullname";
  $verseRes = mysql_query($verseSql); // or die("<h1>Query failed</h1><pre>$verseSql</pre>");

  if (!$verseRes) {
	$results_count = -1;
	$results_msg = mysql_error();
  } else {
	$results_msg = '';
	$results_count = mysql_num_rows($verseRes);
	if(!$results_count) {
		$results_count = 0;
		$results_msg = 'No results';
	}
  }
  describe_search($searchType, $results_count);
  output_hymn_table_start();

  for ($count = 1; $row = mysql_fetch_row($verseRes); ++$count) {
    $details = "$row[3] $row[2] $row[4]";

    if (!empty($row[5])) {
      $details = "<a target=\"_blank\" href=\"$row[5]\">$details</a>";
    }
?>
  <tr>
    <td><b><? echo $row[1]; ?></b><br>
      <? echo $details; ?></td>
  </tr>
<?
    $compSql = "SELECT h.hymn_no, d.line_text, h.meter " .
               "FROM hymn$language h, hymn_line$language d " .
               "WHERE h.hymn_no = d.hymn_no " .
               "AND d.line_no = 1 " .
               "AND d.vers_no = 1 " .
               "AND h.author_id = $row[0] " .
               "ORDER BY h.hymn_no";

?><tr><td colspan=4><?

  $res = mysql_query($compSql); // or die("</select><h1>Query failed</h1><pre>$compSql</pre>");
  output_hymn_table_start();
  while ($row = mysql_fetch_row($res)) {
    output_hymn_line($row[0], utf8_encode($row[1]), $row[2]);
  }
  output_hymn_table_end();

  ?></td></tr><?
  }

  mysql_free_result($verseRes);

  output_hymn_table_end();
}

function show_hymn($hymn, $language) {
  global $database;
  $verseCount = 0;

  if ($hymn < 0 || $hymn > 456) {
    echo "<p class=\"center red white-text\">Hymn number out of range. Please enter a number between 1 and 456.</p>";
    return;
  }

  $hymnSql = "SELECT m.meter, m.rhythm, m.chorus ".
             "FROM hymn$language h, hymn_meter m ".
             "WHERE h.meter_id=m.id ".
             "AND hymn_no=$hymn";

  $metdesc = "";
  $res = mysql_query($hymnSql); // or die("<h1>Query failed</h1><pre>$hymnSql</pre>");
  if ($row = mysql_fetch_row($res)) {
    $metdesc = $row[0];
    if (!empty($row[1])) $metdesc .= "&nbsp;<i>" . $row[1] ."</i>";
    if (!empty($row[2])) $metdesc .= "<br>Chorus ". $row[2];
  }

?>
<div class="left">
	<p>
		<strong><?php echo $hymn; ?></strong>
	</p>
</div>
<div class="right">
	<p>
		<strong><?php echo $metdesc; ?></strong>
	</p>
</div>

<?php
  output_hymn_table_start();

  $hymnSql = "SELECT vers_no, COUNT(*) line_count ".
             "FROM hymn_line$language ".
             "WHERE hymn_no=$hymn ".
             "GROUP BY vers_no ".
             "ORDER BY if(vers_no=1,0,if(vers_no=99,1,vers_no)) ";

  $res = mysql_query($hymnSql); // or die("<h1>Query failed</h1><pre>$hymnSql</pre>");
  if (!$res) {
	  echo "<tr><td colspan='2'>Sql Error: ".mysql_error()."</td></tr>\n";
	  echo missing_hymn();
  }
  while ($row = mysql_fetch_row($res)) {
    $verseSql = "SELECT line_no,line_text FROM hymn_line$language ".
          "where hymn_no=$hymn and vers_no=".$row[0]." ".
            "order by vers_no,line_no";
    //mysql_query("set names 'utf8';");
    $res2 = mysql_query($verseSql); // or die("<h1>Query failed</h1><pre>$verseSql</pre>");
    while ($row2 = mysql_fetch_row($res2)) {
?>
  <tr>
<?php
      $verse_desc = "&nbsp;";
      $verse_class = "lines";
      if ($row[0]==99) {
        $verse_class = "chorus";
      } else {
        if ($row2[0] == 1) {
          echo "<td valign=top rowspan=" . $row[1] . "><span class='verse'>" . $row[0] . "</span></td>\n";
        }
      }

      echo "<td class='$verse_class'>" . $row2[1] . "</td></tr>\n";
    }

?>
  </tr><tr><td colspan=2>&nbsp;</td></tr>
<?php
  }

  $hymnSql = "SELECT a.fullname FROM hymn$language h, authors a where h.author_id = a.id and h.hymn_no=$hymn";
  $res = mysql_query($hymnSql); // or die("<h1>Query failed</h1><pre>$hymnSql</pre>");
  if ($row = mysql_fetch_row($res)) {
    echo "<tr><td colspan=2 class=\"author\"><a href=\"javascript:void();\" onclick=\"view_author('" . $row[0] . "');\">" . $row[0] . "</a></td></tr>\n";
  }
  output_hymn_table_end();
}

function missing_hymn() {
	return "<tr><td class='verse' rowspan='4'>1</td><td class='lines'>We could not find this hymn for you,</td></tr>\n".
		"<tr><td class='lines' colspan='2'>It seems it's missing from our file.</td></tr>\n".
	    "<tr><td class='lines' colspan='2'>But if you'll pour yourself a brew,</td></tr>\n".
		"<tr><td class='lines' colspan='2'>We'll have it sorted in a while!</td></tr>";
}

?>