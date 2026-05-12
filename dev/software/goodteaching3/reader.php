<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Ministry Reader — 2026
 * KED  11-May-2026  Added Start button, fixed duplicate Library link.
 * KED  11-May-2026  Added scripture @ link conversion.
 * KED  11-May-2026  Fixed blockquote styling, added br support.
 * KED  11-May-2026  Moved all CSS to mse.css section 18.
 * * * * * * * * * * * * * * * * * * * * * * * */

$root = "./";
include_once $root.'Main.php';

$author = isset($_GET['author']) ? mysqli_real_escape_string($dbConn, $_GET['author']) : '';
$vol    = isset($_GET['vol'])    ? (int)$_GET['vol']  : 1;
$page   = isset($_GET['page'])   ? (int)$_GET['page'] : 1;

if (empty($author)) {
  header("Location: volumes.php");
  exit;
}

// Get author info
$auRow = null;
$res = mysqli_query($dbConn, "SELECT name, fullname FROM mse_author WHERE author='$author' LIMIT 1");
if ($row = mysqli_fetch_assoc($res)) $auRow = $row;

// Get volume title from mse_volume
$volTitle = 'Volume ' . $vol;
$res = mysqli_query($dbConn, "SELECT title FROM mse_volume WHERE author='$author' AND vol=$vol LIMIT 1");
if ($row = mysqli_fetch_assoc($res)) {
  $volTitle = preg_replace('/^V\d+\s+/i', '', $row['title']);
}

// Get total pages
$totalPages = 1;
$res = mysqli_query($dbConn, "SELECT MAX(page) as mp FROM mse_text WHERE author='$author' AND vol=$vol");
if ($row = mysqli_fetch_assoc($res)) $totalPages = max(1, (int)$row['mp']);

// Clamp page
if ($page < 1) $page = 1;
if ($page > $totalPages) $page = $totalPages;

// Get paragraphs for this page
$paragraphs = [];
$res = mysqli_query($dbConn,
  "SELECT para, inits, text FROM mse_text
   WHERE author='$author' AND vol=$vol AND page=$page
   ORDER BY para ASC");
while ($row = mysqli_fetch_assoc($res)) {
  $paragraphs[] = $row;
}

// Get table of contents
$toc = [];
$res = mysqli_query($dbConn,
  "SELECT a.page, a.article
   FROM mse_article a
   WHERE a.author='$author' AND a.vol=$vol
   AND a.article IS NOT NULL AND a.article != ''
   ORDER BY a.page ASC");
while ($row = mysqli_fetch_assoc($res)) {
  $toc[] = $row;
}

$progressPct = $totalPages > 1 ? round(($page / $totalPages) * 100) : 100;
$pageTitle   = ($auRow ? $auRow['name'] . ' — ' : '') . $volTitle . ' (Vol ' . $vol . ')';

// Bible book name to ID map
$bibleBooks = [
  'genesis'=>1,'exodus'=>2,'leviticus'=>3,'numbers'=>4,'deuteronomy'=>5,
  'joshua'=>6,'judges'=>7,'ruth'=>8,'1 samuel'=>9,'2 samuel'=>10,
  '1 kings'=>11,'2 kings'=>12,'1 chronicles'=>13,'2 chronicles'=>14,
  'ezra'=>15,'nehemiah'=>16,'esther'=>17,'job'=>18,'psalms'=>19,'psalm'=>19,
  'proverbs'=>20,'ecclesiastes'=>21,'song of solomon'=>22,'song of songs'=>22,
  'isaiah'=>23,'isaih'=>23,'isiah'=>23,'jeremiah'=>24,'lamentations'=>25,
  'ezekiel'=>26,'daniel'=>27,'hosea'=>28,'joel'=>29,'amos'=>30,
  'obadiah'=>31,'jonah'=>32,'micah'=>33,'nahum'=>34,'habakkuk'=>35,
  'habakuk'=>35,'zephaniah'=>36,'haggai'=>37,'zechariah'=>38,'malachi'=>39,
  'matthew'=>40,'mark'=>41,'luke'=>42,'john'=>43,'acts'=>44,
  'romans'=>45,'1 corinthians'=>46,'2 corinthians'=>47,'galatians'=>48,
  'ephesians'=>49,'philippians'=>50,'colossians'=>51,'1 thessalonians'=>52,
  '2 thessalonians'=>53,'1 timothy'=>54,'2 timothy'=>55,'titus'=>56,
  'philemon'=>57,'hebrews'=>58,'james'=>59,'1 peter'=>60,'2 peter'=>61,
  '1 john'=>62,'2 john'=>63,'3 john'=>64,'jude'=>65,'revelation'=>66,'revelations'=>66,
];

function cleanText($text, $bibleBooks, $root) {
  $text = html_entity_decode($text, ENT_QUOTES | ENT_HTML5, 'UTF-8');
  $text = strip_tags($text, '<blockquote><br>');
  $text = preg_replace('/\[\/?\w+\]/', '', $text);
  $text = preg_replace('/[ \t]+/', ' ', $text);
  $text = trim($text);

  $text = preg_replace_callback(
    '/@([1-3]?\s?[A-Za-z][a-zA-Z]*(?:\s+(?:of\s+)?[A-Za-z]+)*?)\s+(\d+)(?::(\d+)(?:-(\d+))?)?(?=[\s,;.()\[\]]|$)/u',
    function($matches) use ($bibleBooks, $root) {
      $bookName   = trim($matches[1]);
      $chapter    = $matches[2];
      $verseStart = isset($matches[3]) && $matches[3] !== '' ? $matches[3] : '';
      $verseEnd   = isset($matches[4]) && $matches[4] !== '' ? $matches[4] : '';

      $bookKey = strtolower($bookName);
      $bookId  = isset($bibleBooks[$bookKey]) ? $bibleBooks[$bookKey] : null;

      if (!$bookId) {
        $bestScore = 0;
        foreach ($bibleBooks as $name => $id) {
          similar_text($bookKey, $name, $pct);
          if ($pct > $bestScore && $pct > 70) {
            $bestScore = $pct;
            $bookId    = $id;
          }
        }
      }

      $display = $bookName . ' ' . $chapter;
      if ($verseStart !== '') {
        $display .= ':' . $verseStart;
        if ($verseEnd !== '') $display .= '-' . $verseEnd;
      }

      if ($bookId) {
        $url = $root . 'scripture.php?bookid=' . $bookId .
               '&chapter=' . urlencode($chapter) .
               ($verseStart !== '' ? '&vstart=' . urlencode($verseStart) : '');
        return '<a href="' . $url . '" class="rd-scripture-link" title="Search ministry on ' .
               htmlspecialchars($display) . '">' . htmlspecialchars($display) . '</a>';
      }

      return htmlspecialchars($display);
    },
    $text
  );

  return $text;
}

function hasBlockquote($text) {
  return stripos($text, '<blockquote') !== false;
}

header("Content-Type: text/html;charset=UTF-8");
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?> — Good Teaching</title>
  <link rel="icon" type="image/vnd.microsoft.icon" href="<?php echo $root; ?>favicon.ico">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;1,400&family=Lora:ital,wght@0,400;0,500;1,400&display=swap" rel="stylesheet">
  <link href="<?php echo $root; ?>mse.css" rel="stylesheet" type="text/css">
  <style>
    /* Progress bar width is dynamic — set inline only */
    .rd-progress-bar { width: <?php echo $progressPct; ?>%; }
  </style>
</head>
<body>

  <div class="rd-progress-wrap">
    <div class="rd-progress-bar"></div>
  </div>

  <div class="rd-topbar">
    <div class="rd-topbar-left">
      <a href="<?php echo $root; ?>volumes.php" class="rd-back">&larr; Library</a>
      <?php if ($page > 1): ?>
        <span class="rd-divider">|</span>
        <a href="?author=<?php echo urlencode($author); ?>&vol=<?php echo $vol; ?>&page=1"
           class="rd-start-btn">&#8676; Start</a>
      <?php endif; ?>
      <span class="rd-divider">|</span>
      <span class="rd-title"><?php echo htmlspecialchars($volTitle); ?> &mdash; <?php echo htmlspecialchars($auRow['name'] ?? ''); ?></span>
    </div>
    <div class="rd-topbar-right">
      <span class="rd-progress-label">Page <?php echo $page; ?> of <?php echo $totalPages; ?> &nbsp;&bull;&nbsp; <?php echo $progressPct; ?>%</span>
      <?php if (!empty($toc)): ?>
      <button class="rd-toc-btn" onclick="toggleToc()">Contents</button>
      <?php endif; ?>
    </div>
  </div>

  <?php if (!empty($toc)): ?>
  <div class="rd-toc-drawer" id="tocDrawer">
    <div class="rd-toc-heading">Table of Contents</div>
    <?php
    $currentChapter = 0;
    foreach ($toc as $t) {
      if ((int)$t['page'] <= $page) $currentChapter = (int)$t['page'];
    }
    foreach ($toc as $t):
      $isActive = ((int)$t['page'] === $currentChapter);
    ?>
    <a href="?author=<?php echo urlencode($author); ?>&vol=<?php echo $vol; ?>&page=<?php echo (int)$t['page']; ?>"
       class="rd-toc-item <?php echo $isActive ? 'active' : ''; ?>"
       onclick="closeToc()">
      <?php echo htmlspecialchars(ucwords(strtolower($t['article']))); ?>
      <span class="rd-toc-page">p.<?php echo (int)$t['page']; ?></span>
    </a>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>

  <div class="rd-body">

    <div class="rd-page">
      <div class="rd-page-header">
        <span class="rd-page-author"><?php echo htmlspecialchars($auRow['name'] ?? ''); ?> &mdash; Vol. <?php echo $vol; ?></span>
        <span class="rd-page-num">Page <?php echo $page; ?></span>
      </div>

      <?php if ($page === 1): ?>
        <div class="rd-vol-title"><?php echo htmlspecialchars($volTitle); ?></div>
      <?php endif; ?>

      <?php if (empty($paragraphs)): ?>
        <div class="rd-empty">No content found for this page.</div>
      <?php else: ?>
        <?php foreach ($paragraphs as $i => $para):
          $text = cleanText($para['text'], $bibleBooks, $root);
          if (empty(strip_tags($text))) continue;
          $isQuote = hasBlockquote($text);
        ?>
        <?php if ($isQuote): ?>
          <div class="rd-blockquote">
            <?php
            $inner = preg_replace('/<\/?blockquote[^>]*>/i', '', $text);
            echo trim($inner);
            ?>
          </div>
        <?php else: ?>
          <p class="rd-paragraph">
            <?php if ($i === 0 && !empty($para['inits'])): ?>
              <span class="rd-inits"><?php echo htmlspecialchars($para['inits']); ?></span>
            <?php endif; ?>
            <?php echo $text; ?>
          </p>
        <?php endif; ?>
        <?php endforeach; ?>
      <?php endif; ?>
    </div>

    <div class="rd-nav">
      <?php if ($page > 1): ?>
        <a href="?author=<?php echo urlencode($author); ?>&vol=<?php echo $vol; ?>&page=<?php echo $page - 1; ?>" class="rd-nav-btn">&larr; Previous</a>
      <?php else: ?>
        <span class="rd-nav-btn disabled">&larr; Previous</span>
      <?php endif; ?>

      <div class="rd-page-indicator">
        <strong><?php echo $page; ?></strong> / <?php echo $totalPages; ?>
        <div class="rd-jump">
          <input type="number" class="rd-jump-input" id="jumpInput"
                 min="1" max="<?php echo $totalPages; ?>"
                 placeholder="<?php echo $page; ?>">
          <button class="rd-jump-btn" onclick="jumpToPage()">Go</button>
        </div>
      </div>

      <?php if ($page < $totalPages): ?>
        <a href="?author=<?php echo urlencode($author); ?>&vol=<?php echo $vol; ?>&page=<?php echo $page + 1; ?>" class="rd-nav-btn">Next &rarr;</a>
      <?php else: ?>
        <span class="rd-nav-btn disabled">Next &rarr;</span>
      <?php endif; ?>
    </div>

  </div>

  <script>
    const author = <?php echo json_encode($author); ?>;
    const vol    = <?php echo json_encode($vol); ?>;
    const page   = <?php echo json_encode($page); ?>;
    const total  = <?php echo json_encode($totalPages); ?>;

    localStorage.setItem('gt_reader_' + author + '_' + vol, page);

    function toggleToc() {
      document.getElementById('tocDrawer').classList.toggle('open');
    }
    function closeToc() {
      document.getElementById('tocDrawer').classList.remove('open');
    }
    document.addEventListener('click', function(e) {
      const drawer = document.getElementById('tocDrawer');
      if (drawer && !drawer.contains(e.target) && !e.target.closest('.rd-toc-btn')) {
        drawer.classList.remove('open');
      }
    });

    function jumpToPage() {
      const val = parseInt(document.getElementById('jumpInput').value);
      if (val >= 1 && val <= total) {
        window.location.href = '?author=' + encodeURIComponent(author) + '&vol=' + vol + '&page=' + val;
      }
    }
    document.getElementById('jumpInput').addEventListener('keydown', function(e) {
      if (e.key === 'Enter') jumpToPage();
    });

    document.addEventListener('keydown', function(e) {
      if (e.key === 'ArrowLeft'  && page > 1)    window.location.href = '?author=' + encodeURIComponent(author) + '&vol=' + vol + '&page=' + (page - 1);
      if (e.key === 'ArrowRight' && page < total) window.location.href = '?author=' + encodeURIComponent(author) + '&vol=' + vol + '&page=' + (page + 1);
    });

    let touchStartX = 0;
    let touchStartY = 0;

    document.addEventListener('touchstart', function(e) {
      touchStartX = e.touches[0].clientX;
      touchStartY = e.touches[0].clientY;
    }, { passive: true });

    document.addEventListener('touchend', function(e) {
      const dx = e.changedTouches[0].clientX - touchStartX;
      const dy = e.changedTouches[0].clientY - touchStartY;
      if (Math.abs(dx) < 40 || Math.abs(dy) > Math.abs(dx)) return;
      if (dx < 0 && page < total) {
        window.location.href = '?author=' + encodeURIComponent(author) + '&vol=' + vol + '&page=' + (page + 1);
      } else if (dx > 0 && page > 1) {
        window.location.href = '?author=' + encodeURIComponent(author) + '&vol=' + vol + '&page=' + (page - 1);
      }
    }, { passive: true });
  </script>

</body>
</html>