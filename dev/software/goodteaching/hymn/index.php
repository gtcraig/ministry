<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * 1962 Hymn Book Search
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10204 : Added calls to Servant checkbox functions.
 * CAM  29-Sep-2008  10302 : Moved to GoodTeaching.org.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and use common database.
 * CAM  30-Dec-2009  10520 : Add focus formatting for dropdowns.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * KED  11-May-2026  Replaced short tags, cleaned up layout.
 * KED  11-May-2026  Fixed dropdown layout, increased font sizes.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title    = "1962 Hymn Search";
$root     = "../";
$tabs     = "HYMN";
$pageName = "pageHymn";
$pageCss  = "hymn.css";
include $root.'tpl/top.php';
include 'hymn_fn.php';

$hymn_no     = NULL; if (!empty($_GET['hymn_no']))      $hymn_no     = $_GET['hymn_no'];
$keywords    = NULL; if (!empty($_GET['keywords']))     $keywords    = $_GET['keywords'];
$author      = NULL; if (!empty($_GET['author']))       $author      = $_GET['author'];
$meter_id    = NULL; if (!empty($_GET['meter_id']))     $meter_id    = $_GET['meter_id'];
$category_id = NULL; if (!empty($_GET['category_id'])) $category_id = $_GET['category_id'];
$language    = NULL; if (!empty($_GET['language']))     $language    = $_GET['language'];
?>

<script language="Javascript" src="ajax.js"></script>

<style>
.hymn-wrap {
  display: grid;
  grid-template-columns: 340px 1fr;
  gap: 20px;
  align-items: start;
}

.hymn-search-box {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  padding: 20px 22px;
  margin-bottom: 16px;
}

.hymn-search-box h2 {
  font-family: 'Playfair Display', serif;
  font-size: 15pt;
  color: var(--navy);
  margin-bottom: 14px;
}

.hymn-field-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px;
  margin-bottom: 10px;
}

.hymn-field-full {
  margin-bottom: 10px;
}

.hymn-field-label {
  font-size: 10pt;
  font-weight: 600;
  color: var(--navy);
  margin-bottom: 4px;
}

.hymn-field-input {
  width: 100%;
  padding: 8px 12px;
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  font-family: 'Inter', sans-serif;
  font-size: 11pt;
  color: var(--text-dark);
  background: var(--cream);
}

.hymn-field-input:focus {
  outline: 2px solid var(--gold);
  background: var(--white);
}

.hymn-field-select {
  width: 100%;
  padding: 8px 12px;
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  font-family: 'Inter', sans-serif;
  font-size: 11pt;
  color: var(--text-dark);
  background: var(--cream);
}

.hymn-search-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 12px;
}

.hymn-panel {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.hymn-panel-header {
  background: var(--navy);
  padding: 10px 16px;
  font-family: 'Playfair Display', serif;
  font-size: 12pt;
  color: var(--gold-light);
}

.hymn-panel-body {
  padding: 14px 16px;
  font-size: 11pt;
}

.hymn-empty {
  padding: 24px;
  text-align: center;
  color: var(--text-muted);
  font-style: italic;
  font-size: 11pt;
}

.hymn-field-row-lc {
  grid-template-columns: 110px 1fr;
}

@media (max-width: 900px) {
  .hymn-wrap { grid-template-columns: 1fr; }
}
</style>

<div class="hymn-wrap">

  <!-- ── Left: search form + hymn viewer ── -->
  <div>
    <div class="hymn-search-box">
      <h2>Hymn Search</h2>
      <form action="." method="get" name="searchForm" id="searchForm">

        <!-- Hymn No + Author -->
        <div class="hymn-field-row hymn-field-row-lc">
          <div>
            <div class="hymn-field-label">Hymn No.</div>
            <input type="text" name="hymn_no" class="hymn-field-input"
                   value="<?php echo htmlspecialchars($hymn_no ?? ''); ?>" />
          </div>
          <div>
            <div class="hymn-field-label">Author</div>
            <input type="text" name="author" class="hymn-field-input"
                   value="<?php echo htmlspecialchars($author ?? ''); ?>" />
          </div>
        </div>

        <!-- Keywords full width -->
        <div class="hymn-field-full">
          <div class="hymn-field-label">Text / Keywords</div>
          <input type="text" name="keywords" class="hymn-field-input"
                 value="<?php echo htmlspecialchars($keywords ?? ''); ?>" />
        </div>

       <!-- Language full width -->
       <div class="hymn-field-full">
         <div class="hymn-field-label">Language</div>
         <select name="language" id="language" class="hymn-field-select" onchange="toggle_language();">
           <option value=""    <?php echo ($language == ""    ? "selected" : ""); ?>>English</option>
           <option value="_de" <?php echo ($language == "_de" ? "selected" : ""); ?>>Deutsch</option>
           <option value="_in" <?php echo ($language == "_in" ? "selected" : ""); ?>>Italian</option>
           <option value="_nl" <?php echo ($language == "_nl" ? "selected" : ""); ?>>Netherlands</option>
         </select>
       </div>

      <!-- Category full width -->
      <div class="hymn-field-full">
        <div class="hymn-field-label">Category</div>
        <?php select_categories($dbConn, $category_id); ?>
      </div>

        <!-- Meter full width so it has room to breathe -->
        <div class="hymn-field-full">
          <div class="hymn-field-label">Meter</div>
          <?php select_meters($dbConn, $meter_id, $language); ?>
        </div>

        <div class="hymn-search-actions">
          <input type="submit" name="hymn_search" value="Search" class="button" />
        </div>

      </form>
    </div>

    <!-- Hymn viewer -->
    <div class="hymn-panel">
      <div class="hymn-panel-header">Hymn</div>
      <div class="hymn-panel-body">
        <?php
        if (!empty($hymn_no)) {
          show_hymn($dbConn, $hymn_no, $language);
        } else {
          echo '<div class="hymn-empty">Enter a hymn number above to view it here.</div>';
        }
        ?>
      </div>
    </div>
  </div>

  <!-- ── Right: search results ── -->
  <div class="hymn-panel">
    <div class="hymn-panel-header">Results</div>
    <div class="hymn-panel-body">
      <?php
      $keywordsList = explode(" ", $keywords ?? '');
      $authorList   = explode(" ", $author ?? '');
      $metdesc      = "";
      $catdesc      = "";

      if (!empty($meter_id) && ($meter_id != "ALL")) {
        $sql = "SELECT meter, rhythm, chorus FROM hymn_meter WHERE id = '$meter_id'";
        $res = mysqli_query($dbConn, $sql) or die("<h1>Query failed</h1><pre>$sql</pre>");
        if ($row = mysqli_fetch_array($res)) {
          foreach ($row AS $key => $val) { $$key = stripslashes($val); }
          $metdesc = $meter;
          if (!empty($rhythm)) $metdesc .= "&nbsp;<i>" . $rhythm . "</i>";
        }
        $metdesc = "of meter \"$metdesc\"";
      } else {
        $meter_id = "ALL";
      }

      if (!empty($category_id) && ($category_id != "ALL")) {
        $sql = "SELECT name FROM hymn_scheme_categories WHERE id = '$category_id'";
        $res = mysqli_query($dbConn, $sql) or die("<h1>Query failed</h1><pre>$sql</pre>");
        if ($row = mysqli_fetch_array($res)) {
          foreach ($row AS $key => $val) { $$key = stripslashes($val); }
          $catdesc = "in category \"" . $name . "\"";
        }
      } else {
        $category_id = "ALL";
      }

      if (!empty($keywords)) {
        body_search($dbConn, $keywordsList, "Hymns $metdesc $catdesc containing \"$keywords\"");
      } elseif (!empty($author)) {
        author_search($dbConn, $authorList, "Authors like \"$author\" and their hymns");
      } elseif ($meter_id != "ALL" || $category_id != "ALL") {
        body_search($dbConn, $keywordsList, "Hymns $metdesc $catdesc");
      } else {
        echo '<div class="hymn-empty">Search for hymns by keyword, author, meter or category.</div>';
      }
      ?>
    </div>
  </div>

</div>

<?php include $root.'tpl/bot.php'; ?>