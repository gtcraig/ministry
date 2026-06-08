<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2020 frontburner.co.uk
 *
 * Tune Search
 *
 * Who  When         Why
 * CAM  30-May-2020  909743 : File Created.
 * KED  11-May-2026             : Replaced short tags, cleaned up layout.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title    = "Tune Search";
$root     = "../";
$tabs     = "HYMN";
$pageName = "pageTune";
$pageCss  = "tune.css";
include $root.'tpl/top.php';
include $root.'hymn/hymn_fn.php';
include 'tune_fn.php';

$tune_id   = NULL;  if (!empty($_GET['tune_id']))   $tune_id   = $_GET['tune_id'];
$tune_no   = NULL;  if (!empty($_GET['tune_no']))   $tune_no   = $_GET['tune_no'];
$book_name = "ALL"; if (!empty($_GET['book_name'])) $book_name = $_GET['book_name'];
$keywords  = NULL;  if (!empty($_GET['keywords']))  $keywords  = $_GET['keywords'];
$author    = NULL;  if (!empty($_GET['author']))    $author    = $_GET['author'];
$meter_id  = "ALL"; if (!empty($_GET['meter_id']))  $meter_id  = $_GET['meter_id'];
$language  = NULL;  if (!empty($_GET['language']))  $language  = $_GET['language'];
?>

<script language="Javascript" src="ajax.js"></script>

<style>
.tune-wrap {
  display: grid;
  grid-template-columns: 320px 1fr;
  gap: 20px;
  align-items: start;
}

.tune-search-box {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  padding: 16px 20px;
  margin-bottom: 16px;
}

.tune-search-box h2 {
  font-family: 'Playfair Display', serif;
  font-size: 13pt;
  color: var(--navy);
  margin-bottom: 12px;
}

.tune-field-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8px;
  margin-bottom: 8px;
}

.tune-field-label {
  font-size: 8.5pt;
  font-weight: 600;
  color: var(--navy);
  margin-bottom: 3px;
}

.tune-field-input {
  width: 100%;
  padding: 6px 10px;
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  font-family: 'Inter', sans-serif;
  font-size: 9.5pt;
  color: var(--text-dark);
  background: var(--cream);
}

.tune-field-input:focus {
  outline: 2px solid var(--gold);
  background: var(--white);
}

.tune-field-select {
  width: 100%;
  padding: 6px 10px;
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  font-family: 'Inter', sans-serif;
  font-size: 9pt;
  color: var(--text-dark);
  background: var(--cream);
}

.tune-search-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 10px;
}

.tune-panel {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.tune-panel-header {
  background: var(--navy);
  padding: 8px 14px;
  font-family: 'Playfair Display', serif;
  font-size: 10.5pt;
  color: var(--gold-light);
}

.tune-panel-body {
  padding: 12px 14px;
  font-size: 9.5pt;
}

.tune-empty {
  padding: 20px;
  text-align: center;
  color: var(--text-muted);
  font-style: italic;
  font-size: 9.5pt;
}

@media (max-width: 900px) {
  .tune-wrap { grid-template-columns: 1fr; }
}
</style>

<div class="tune-wrap">

  <!-- ── Left: search form + tune player ── -->
  <div>
    <div class="tune-search-box">
      <h2>Tune Search</h2>
      <form action="." method="get" name="searchForm" id="searchForm">

        <div class="tune-field-row">
          <div>
            <div class="tune-field-label">Tune No.</div>
            <input type="text" name="tune_no" id="tune_no" class="tune-field-input"
                   value="<?php echo htmlspecialchars($tune_no ?? ''); ?>" />
          </div>
          <div>
            <div class="tune-field-label">Name of Tune</div>
            <input type="text" name="keywords" id="keywords" class="tune-field-input"
                   value="<?php echo htmlspecialchars($keywords ?? ''); ?>" />
          </div>
        </div>

        <div style="margin-bottom:8px;">
          <div class="tune-field-label">Author</div>
          <input type="text" name="author" id="author" class="tune-field-input"
                 value="<?php echo htmlspecialchars($author ?? ''); ?>" />
        </div>

        <div class="tune-field-row">
          <div>
            <div class="tune-field-label">Book</div>
            <?php select_books($dbConn, $book_name); ?>
          </div>
          <div>
            <div class="tune-field-label">Meter</div>
            <?php select_meters($dbConn, $meter_id, $language); ?>
          </div>
        </div>

        <input type="hidden" name="tune_id" id="tune_id"
               value="<?php echo htmlspecialchars($tune_id ?? ''); ?>" />

        <div class="tune-search-actions">
          <input type="submit" name="hymn_search" value="Search" class="button" />
        </div>

      </form>
    </div>

    <!-- Tune player -->
    <div class="tune-panel">
      <div class="tune-panel-header">Tune</div>
      <div class="tune-panel-body">
        <?php
        if (!empty($tune_id)) {
          show_tune($dbConn, $tune_id);
        } else {
          echo '<div class="tune-empty">Select a tune from the results to play it here.</div>';
        }
        ?>
      </div>
    </div>
  </div>

  <!-- ── Right: search results ── -->
  <div class="tune-panel">
    <div class="tune-panel-header">Tunes</div>
    <div class="tune-panel-body">
      <?php
      $keywordsList = explode(" ", $keywords ?? '');
      $authorList   = explode(" ", $author ?? '');
      $metdesc      = "";
      $doSearch     = false;
      $desc         = "Tunes";

      if (!empty($meter_id) && ($meter_id != "ALL")) {
        $sql = "SELECT meter, rhythm, chorus FROM hymn_meter WHERE id = '$meter_id'";
        $res = mysqli_query($dbConn, $sql) or die("<h1>Query failed</h1><pre>$sql</pre>");
        if ($row = mysqli_fetch_array($res)) {
          foreach ($row AS $key => $val) { $$key = stripslashes($val); }
          $metdesc = $meter;
          if (!empty($rhythm)) $metdesc .= "&nbsp;<i>" . $rhythm . "</i>";
        }
        $metdesc = " of meter \"$metdesc\"";
      } else {
        $meter_id = "ALL";
      }

      if (!empty($tune_no)) {
        $doSearch = true;
        $desc .= " #$tune_no";
      }
      if (!empty($book_name) && ($book_name != "ALL")) {
        $doSearch = true;
        $desc .= " in $book_name";
      }
      if (!empty($keywords)) {
        $doSearch = true;
        $desc .= " with names containing \"$keywords\"";
      }
      if (!empty($author)) {
        $doSearch = true;
        $desc .= " by Authors like \"$author\"";
      }
      if ($meter_id != "ALL") {
        $doSearch = true;
        $desc .= "$metdesc";
      }

      if ($doSearch) {
        tune_search($dbConn, $book_name, $tune_no, $keywordsList, $authorList, $meter_id, $desc);
      } else {
        echo '<div class="tune-empty">Search for tunes by number, name, author, book or meter.</div>';
      }
      ?>
    </div>
  </div>

</div>

<?php include $root.'tpl/bot.php'; ?>