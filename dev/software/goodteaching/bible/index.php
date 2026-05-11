<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Bible Search — cleaned up 2026
 * 
 * 
 * KED 11-May-2026  Update Bible search page to new design, and clean up code.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title    = "Bible Search";
$root     = "../";
$tabs     = "BIBLE";
$pageName = "pageBible";
$pageCss  = "bible.css";
include $root.'tpl/top.php';

$keywords = '';
if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];

$keywords = trim(str_replace("\'", " ", $keywords));
$keywords = trim(str_replace("\"", " ", $keywords));
$keywords = trim(str_replace("\\", " ", $keywords));
$keywords = trim(str_replace("  ",  " ", $keywords));

function remove_mselinks($text) {
  $record  = true;
  $newText = "";
  for ($i = 0; $i < strlen($text); $i++) {
    $ch = substr($text, $i, 1);
    if ($ch == "[") {
      $record = false;
      $newText .= (substr($text, $i+1, 1) == "/") ? "</span>" : "<span class=\"footnote\">";
    } else if ($ch == "]") {
      $record = true;
    } else {
      if ($record) $newText .= $ch;
    }
  }
  return $newText;
}
?>

<style>
.bible-wrap {
  display: grid;
  grid-template-columns: 1fr 280px;
  gap: 20px;
  align-items: start;
}

.bible-search-box {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  padding: 16px 20px;
  margin-bottom: 16px;
}

.bible-search-box h2 {
  font-family: 'Playfair Display', serif;
  font-size: 13pt;
  color: var(--navy);
  margin-bottom: 6px;
}

.bible-search-box p {
  font-size: 9pt;
  color: var(--text-muted);
  margin-bottom: 12px;
}

.bible-search-row {
  display: flex;
  gap: 8px;
  align-items: center;
}

.bible-search-input {
  flex: 1;
  padding: 7px 12px;
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  font-family: 'Inter', sans-serif;
  font-size: 10pt;
  color: var(--text-dark);
  background: var(--cream);
}

.bible-search-input:focus {
  outline: 2px solid var(--gold);
  background: var(--white);
}

/* Results */
.bible-results {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.bible-results-header {
  background: var(--navy);
  padding: 9px 16px;
  font-family: 'Playfair Display', serif;
  font-size: 10.5pt;
  color: var(--gold-light);
}

.bible-result-row {
  display: grid;
  grid-template-columns: 120px 50px 40px 40px 1fr;
  gap: 8px;
  padding: 8px 16px;
  border-bottom: 1px solid var(--cream-dark);
  font-size: 9pt;
  align-items: start;
}

.bible-result-row:last-child { border-bottom: none; }
.bible-result-row:hover { background: var(--cream); }

.bible-result-header {
  background: var(--cream);
  font-weight: 600;
  color: var(--navy);
}

.bible-result-book  { color: var(--navy);       font-weight: 600; }
.bible-result-chap  { color: var(--text-mid);   text-align: center; }
.bible-result-verse { color: var(--text-mid);   text-align: center; }
.bible-result-sym   { color: var(--gold);       font-weight: 700; text-align: center; }
.bible-result-text  { color: var(--text-dark);  line-height: 1.5; }

.phrase { color: var(--red); font-weight: 600; }
.footnote { color: var(--text-muted); font-style: italic; }

.bible-empty {
  padding: 32px 16px;
  text-align: center;
  color: var(--text-muted);
  font-style: italic;
  font-size: 10pt;
}

/* Sidebar info */
.bible-sidebar {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.bible-info-widget {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.bible-info-header {
  background: var(--navy);
  padding: 9px 16px;
  font-family: 'Playfair Display', serif;
  font-size: 10.5pt;
  color: var(--gold-light);
}

.bible-info-body {
  padding: 14px 16px;
  font-size: 9pt;
  color: var(--text-mid);
  line-height: 1.7;
}

.bible-info-body a {
  color: var(--navy-light);
  font-weight: 500;
}

.bible-info-body a:hover { color: var(--gold); }

@media (max-width: 750px) {
  .bible-wrap { grid-template-columns: 1fr; }
  .bible-result-row { grid-template-columns: 1fr 1fr; }
}
</style>

<div class="bible-wrap">

  <!-- ── Left: search + results ── -->
  <div>
    <div class="bible-search-box">
      <h2>Search Darby Translation Footnotes</h2>
      <p>Search the footnotes of the Darby Bible translation. To search the Bible text itself, use
        <a href="https://www.biblegateway.com/quicksearch/?qs_version=DARBY">BibleGateway</a> or
        <a href="https://www.olivetree.com/bible-study-apps/">Olive Tree</a>.
      </p>
      <form action="." method="post" name="searchForm" id="searchForm">
        <div class="bible-search-row">
          <input type="text" name="keywords" class="bible-search-input"
                 placeholder="Enter keyword..."
                 value="<?php echo htmlspecialchars($keywords ?? ''); ?>" />
          <input type="submit" value="Search" class="button" />
        </div>
        <input type="hidden" name="op" value="search" />
      </form>
    </div>

    <div class="bible-results">
      <div class="bible-results-header">Results</div>

      <?php if (empty($keywords)): ?>
        <div class="bible-empty">Enter a keyword above to search the Darby footnotes.</div>

      <?php else:
        $kw = $keywords;
        $kw = "%$kw%";
        foreach ([" ",",",";",":",".","-","\'","\""] as $ch) {
          $kw = str_replace($ch, "%", $kw);
        }
        $kw = str_replace("%%", "%", $kw);
        $kw = mysqli_real_escape_string($dbConn, $kw);

        $sql = "SELECT b.bookname, f.chapter, f.verse, f.footnoteid, f.symbol, f.text, fr.phrase
                FROM mse_bible_footnote f
                JOIN mse_bible_footnote_ref fr ON fr.footnoteid = f.footnoteid
                JOIN mse_bible_version v        ON v.verid = f.verid
                JOIN mse_bible_book b           ON b.bookid = f.bookid
                WHERE (f.text LIKE '$kw' OR fr.phrase LIKE '$kw')
                ORDER BY b.bookid, f.chapter, f.verse, f.footnoteid";

        $ssql = mysqli_query($dbConn, $sql) or die(mysqli_error($dbConn));
        $count = mysqli_num_rows($ssql);

        if ($count === 0): ?>
          <div class="bible-empty">No results found for that keyword.</div>

        <?php else: ?>
          <div class="bible-result-row bible-result-header">
            <span>Book</span>
            <span style="text-align:center">Chap.</span>
            <span style="text-align:center">V.</span>
            <span style="text-align:center">Sym</span>
            <span>Phrase &amp; Text</span>
          </div>

          <?php
          $prevFootnoteId = 0;
          $refs = "";
          while ($row = mysqli_fetch_assoc($ssql)):
            $bookname   = htmlspecialchars($row['bookname']);
            $chapter    = htmlspecialchars($row['chapter']);
            $verse      = htmlspecialchars($row['verse']);
            $footnoteid = $row['footnoteid'];
            $symbol     = htmlspecialchars($row['symbol']);
            $text       = remove_mselinks(htmlspecialchars($row['text']));
            $phrase     = htmlspecialchars($row['phrase']);

            if (!empty($refs)) $refs .= ", ";
            $refs .= "<span class=\"phrase\">$phrase</span>";

            if ($footnoteid != $prevFootnoteId && $prevFootnoteId != 0) {
              $refs = "<span class=\"phrase\">$phrase</span>";
            }

            if ($footnoteid != $prevFootnoteId):
          ?>
          <div class="bible-result-row">
            <span class="bible-result-book"><?php echo $bookname; ?></span>
            <span class="bible-result-chap"><?php echo $chapter; ?></span>
            <span class="bible-result-verse"><?php echo $verse; ?></span>
            <span class="bible-result-sym"><?php echo $symbol; ?></span>
            <span class="bible-result-text"><?php echo "$refs<br>$text"; ?></span>
          </div>
          <?php
            endif;
            $prevFootnoteId = $footnoteid;
          endwhile;
          ?>

        <?php endif; ?>
      <?php endif; ?>
    </div>
  </div>

  <!-- ── Sidebar ── -->
  <div class="bible-sidebar">

    <div class="bible-info-widget">
      <div class="bible-info-header">About This Search</div>
      <div class="bible-info-body">
        This tool searches the footnotes of the <strong>Darby Bible Translation</strong> —
        notes written by J.N. Darby alongside his translation of the Scriptures.<br><br>
        For full Bible text search, use:
        <ul style="margin: 8px 0 0 16px; padding:0;">
          <li><a href="https://www.biblegateway.com/quicksearch/?qs_version=DARBY">BibleGateway</a></li>
          <li><a href="https://www.olivetree.com/bible-study-apps/">Olive Tree</a></li>
        </ul>
      </div>
    </div>

    <div class="bible-info-widget">
      <div class="bible-info-header">Quick Links</div>
      <div class="bible-info-body">
        <a href="<?php echo $root; ?>">Ministry Search</a><br>
        <a href="<?php echo $root; ?>hymn/">Hymn Search</a><br>
        <a href="<?php echo $root; ?>tune/">Tune Player</a><br>
        <a href="<?php echo $root; ?>volumes.php">Ministry Library</a>
      </div>
    </div>

  </div>

</div>

<?php include $root.'tpl/bot.php'; ?>