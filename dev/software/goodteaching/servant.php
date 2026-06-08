<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * Author Filter
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10204 : Added calls to Servant checkbox functions.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and changed session vars to include module name.
 * CAM  12-Dec-2015  476204 : Check session variables are set before referencing.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * CAM  30-May-2020  909743 : Added root.
 * KED  11-May-2026  Replaced short tags, cleaned up layout.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Servant Filter";
$tab   = "author";
$tabs  = "MINISTRY";
$root  = "./";
include $root.'tpl/top.php';

$author_filter = isset($_SESSION['search_min_author']) ? $_SESSION['search_min_author'] : "";
if (!empty($_POST['author_filter'])) $author_filter = $_POST['author_filter'];
$_SESSION['search_min_author'] = $author_filter;
?>

<style>
.servant-wrap {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  padding: 20px 24px;
  margin-bottom: 16px;
}

.servant-heading {
  margin-bottom: 16px;
}

.servant-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 16px;
}

.servant-label {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 6px 12px;
  background: var(--cream);
  border: 1px solid var(--border);
  border-radius: 20px;
  font-size: 9pt;
  color: var(--navy);
  font-weight: 500;
  cursor: pointer;
  transition: background 0.12s, border-color 0.12s;
}

.servant-label:hover {
  background: var(--gold-pale);
  border-color: var(--gold);
}

.servant-label input[type="checkbox"] {
  accent-color: var(--navy);
  width: 14px;
  height: 14px;
  cursor: pointer;
}

.servant-label.all-label {
  background: var(--navy);
  color: var(--gold);
  border-color: var(--navy);
  font-weight: 600;
}

.servant-label.all-label:hover {
  background: var(--navy-light);
}

.servant-label.all-label input[type="checkbox"] {
  accent-color: var(--gold);
}

.servant-actions {
  display: flex;
  justify-content: flex-end;
  padding-top: 8px;
  border-top: 1px solid var(--cream-dark);
}
</style>

<form action="keyword.php" method="post">
<div class="servant-wrap">

  <div class="servant-heading">
    <?php
    $q = "Select one or more Servants";
    if ($loggedin) {
      $q .= ", " . $member->getFirstname() . ",";
    }
    $q .= " and click Search:";
    Msg::statement($q);
    ?>
  </div>

  <div class="servant-list">

    <?php $checked = (!empty($author_filter['ALL'])) ? "checked" : ""; ?>
    <label class="servant-label all-label">
      <input type="checkbox" <?php echo $checked; ?>
             name="author_filter[ALL]" id="author_filter[ALL]"
             value="ALL" onclick="toggleServants(this);return true;">
      All Servants
    </label>

    <?php
    $sql  = "SELECT author, name FROM mse_author ORDER BY name";
    $ssql = mysqli_query($dbConn, $sql);
    while ($row = mysqli_fetch_array($ssql)) {
      foreach ($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      $checked = (!empty($author_filter[$author]) && empty($author_filter['ALL'])) ? "checked" : "";
    ?>
    <label class="servant-label">
      <input type="checkbox" <?php echo $checked; ?>
             name="author_filter[<?php echo $author; ?>]"
             id="author_filter[<?php echo $author; ?>]"
             value="<?php echo $author; ?>"
             onclick="uncheckAll();return true;">
      <?php echo $name; ?>
    </label>
    <?php } ?>

  </div>

  <div class="servant-actions">
    <?php echo ActionUtil::submitButton("Search"); ?>
  </div>

</div>
</form>

<?php
include $root.'tpl/results.php';
include $root.'tpl/bot.php';
?>