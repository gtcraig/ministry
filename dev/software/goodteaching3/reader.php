<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Ministry Reader — 2026
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
  // Strip leading "V01 " style prefix
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

// Helper: clean raw text from database
function cleanText($text) {
  // Decode any HTML entities first
  $text = html_entity_decode($text, ENT_QUOTES | ENT_HTML5, 'UTF-8');
  // Strip any HTML tags
  $text = strip_tags($text);
  // Clean up MSE link markup e.g. [linktext][/link]
  $text = preg_replace('/\[\/?\w+\]/', '', $text);
  // Normalise whitespace
  $text = preg_replace('/\s+/', ' ', $text);
  return trim($text);
}

header("Content-Type: text/html;charset=UTF-8");
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?> — Good Teaching</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;1,400&family=Lora:ital,wght@0,400;0,500;1,400&display=swap" rel="stylesheet">
  <style>
    :root {
      --navy:       #0d1f3c;
      --navy-mid:   #152d4e;
      --navy-light: #1e3f6e;
      --gold:       #c9a84c;
      --gold-light: #e8c97a;
      --cream:      #f8f5ef;
      --cream-dark: #ede8df;
      --border:     #ddd8cc;
      --text:       #2c2c2c;
      --text-muted: #7a8a9a;
      --radius-sm:  6px;
      --radius-md:  10px;
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html, body {
      height: 100%;
      background: var(--cream);
      font-family: 'Inter', sans-serif;
      color: var(--text);
    }

    /* ── Progress bar ── */
    .rd-progress-wrap {
      position: fixed;
      top: 0; left: 0; right: 0;
      height: 4px;
      background: var(--cream-dark);
      z-index: 100;
    }

    .rd-progress-bar {
      height: 100%;
      background: var(--navy);
      transition: width 0.4s ease;
      width: <?php echo $progressPct; ?>%;
    }

    /* ── Top bar ── */
    .rd-topbar {
      position: fixed;
      top: 4px; left: 0; right: 0;
      height: 52px;
      background: var(--navy);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 20px;
      z-index: 99;
      gap: 12px;
    }

    .rd-topbar-left {
      display: flex;
      align-items: center;
      gap: 12px;
      min-width: 0;
    }

    .rd-back {
      color: var(--gold);
      text-decoration: none;
      font-size: 9pt;
      font-weight: 600;
      white-space: nowrap;
      opacity: 0.85;
      transition: opacity 0.15s;
    }
    .rd-back:hover { opacity: 1; text-decoration: none; color: var(--gold); }

    .rd-title {
      font-family: 'Playfair Display', serif;
      font-size: 11pt;
      color: var(--gold-light);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .rd-topbar-right {
      display: flex;
      align-items: center;
      gap: 8px;
      flex-shrink: 0;
    }

    .rd-progress-label {
      font-size: 8.5pt;
      color: #4a6280;
      white-space: nowrap;
    }

    .rd-toc-btn {
      background: var(--navy-mid);
      border: 1px solid #2a4a6e;
      color: var(--gold);
      font-size: 8.5pt;
      font-weight: 600;
      padding: 5px 12px;
      border-radius: var(--radius-sm);
      cursor: pointer;
      transition: background 0.15s;
    }
    .rd-toc-btn:hover { background: var(--navy-light); }

    /* ── TOC drawer ── */
    .rd-toc-drawer {
      position: fixed;
      top: 56px; right: -320px;
      width: 300px;
      height: calc(100vh - 56px);
      background: var(--navy);
      z-index: 98;
      overflow-y: auto;
      transition: right 0.25s ease;
      padding: 16px 0;
    }

    .rd-toc-drawer.open { right: 0; }

    .rd-toc-heading {
      font-family: 'Playfair Display', serif;
      font-size: 11pt;
      color: var(--gold);
      padding: 0 20px 12px;
      border-bottom: 1px solid #1e3f6e;
      margin-bottom: 8px;
    }

    .rd-toc-item {
      display: block;
      padding: 9px 20px;
      font-size: 9pt;
      color: #a0b4cc;
      text-decoration: none;
      transition: background 0.12s, color 0.12s;
      border-left: 3px solid transparent;
    }

    .rd-toc-item:hover {
      background: var(--navy-mid);
      color: var(--gold-light);
      text-decoration: none;
    }

    .rd-toc-item.active {
      color: var(--gold);
      border-left-color: var(--gold);
      background: var(--navy-mid);
    }

    .rd-toc-page {
      font-size: 7.5pt;
      color: #4a6280;
      margin-left: 6px;
    }

    /* ── Main content ── */
    .rd-body {
      padding-top: 72px;
      padding-bottom: 80px;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .rd-page {
      width: 100%;
      max-width: 680px;
      padding: 40px 40px 48px;
      background: #fffef9;
      border-left: 1px solid var(--border);
      border-right: 1px solid var(--border);
      min-height: calc(100vh - 152px);
    }

    .rd-page-header {
      display: flex;
      align-items: baseline;
      justify-content: space-between;
      margin-bottom: 28px;
      padding-bottom: 12px;
      border-bottom: 1px solid var(--cream-dark);
    }

    .rd-page-author {
      font-size: 8.5pt;
      color: var(--text-muted);
      font-style: italic;
    }

    .rd-page-num {
      font-size: 8.5pt;
      color: var(--text-muted);
    }

    .rd-vol-title {
      font-family: 'Playfair Display', serif;
      font-size: 13pt;
      color: var(--navy);
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 2px solid var(--gold);
    }

    /* Text content */
    .rd-paragraph {
      font-family: 'Lora', serif;
      font-size: 12pt;
      line-height: 1.85;
      color: var(--text);
      margin-bottom: 1.2em;
      text-align: justify;
      hyphens: auto;
    }

    .rd-paragraph:last-child { margin-bottom: 0; }

    .rd-inits {
      font-family: 'Playfair Display', serif;
      font-size: 24pt;
      font-weight: 600;
      color: var(--navy);
      float: left;
      line-height: 0.85;
      margin: 6px 6px 0 0;
    }

    /* ── Navigation ── */
    .rd-nav {
      width: 100%;
      max-width: 680px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 16px 40px;
      gap: 12px;
    }

    .rd-nav-btn {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 10px 20px;
      background: var(--navy);
      color: var(--gold) !important;
      font-family: 'Inter', sans-serif;
      font-size: 9.5pt;
      font-weight: 600;
      border-radius: var(--radius-md);
      text-decoration: none !important;
      transition: background 0.15s;
    }

    .rd-nav-btn:hover {
      background: var(--navy-light);
      text-decoration: none !important;
    }

    .rd-nav-btn.disabled {
      background: var(--cream-dark);
      color: var(--text-muted) !important;
      pointer-events: none;
    }

    .rd-page-indicator {
      font-size: 9pt;
      color: var(--text-muted);
      text-align: center;
      flex: 1;
    }

    .rd-page-indicator strong { color: var(--navy); font-weight: 600; }

    .rd-jump {
      display: flex;
      align-items: center;
      gap: 6px;
      justify-content: center;
      margin-top: 6px;
    }

    .rd-jump-input {
      width: 52px;
      padding: 5px 8px;
      border: 1px solid var(--border);
      border-radius: var(--radius-sm);
      font-size: 9pt;
      text-align: center;
      background: var(--cream);
      color: var(--navy);
    }

    .rd-jump-btn {
      padding: 5px 10px;
      background: var(--gold);
      color: var(--navy);
      font-size: 8.5pt;
      font-weight: 600;
      border: none;
      border-radius: var(--radius-sm);
      cursor: pointer;
      transition: background 0.15s;
    }
    .rd-jump-btn:hover { background: var(--gold-light); }

    .rd-empty {
      text-align: center;
      padding: 60px 20px;
      color: var(--text-muted);
      font-style: italic;
      font-family: 'Lora', serif;
      font-size: 11pt;
    }

    @media (max-width: 720px) {
      .rd-page { padding: 24px 20px 36px; }
      .rd-nav  { padding: 12px 16px; }
      .rd-paragraph { font-size: 11pt; }
      .rd-title { display: none; }
    }
  </style>
</head>
<body>

  <!-- Progress bar -->
  <div class="rd-progress-wrap">
    <div class="rd-progress-bar"></div>
  </div>

  <!-- Top bar -->
  <div class="rd-topbar">
    <div class="rd-topbar-left">
      <a href="<?php echo $root; ?>volumes.php" class="rd-back">&larr; Library</a>
      <span class="rd-title"><?php echo htmlspecialchars($volTitle); ?> &mdash; <?php echo htmlspecialchars($auRow['name'] ?? ''); ?></span>
    </div>
    <div class="rd-topbar-right">
      <span class="rd-progress-label">Page <?php echo $page; ?> of <?php echo $totalPages; ?> &nbsp;&bull;&nbsp; <?php echo $progressPct; ?>%</span>
      <?php if (!empty($toc)): ?>
      <button class="rd-toc-btn" onclick="toggleToc()">Contents</button>
      <?php endif; ?>
    </div>
  </div>

  <!-- TOC Drawer -->
  <?php if (!empty($toc)): ?>
  <div class="rd-toc-drawer" id="tocDrawer">
    <div class="rd-toc-heading">Table of Contents</div>
    <?php
    // Find the current chapter for active highlighting
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

  <!-- Main content -->
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
          $text = cleanText($para['text']);
          if (empty($text)) continue;
        ?>
        <p class="rd-paragraph">
          <?php if ($i === 0 && !empty($para['inits'])): ?>
            <span class="rd-inits"><?php echo htmlspecialchars($para['inits']); ?></span>
          <?php endif; ?>
          <?php echo htmlspecialchars($text); ?>
        </p>
        <?php endforeach; ?>
      <?php endif; ?>
    </div>

    <!-- Navigation -->
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

    // Save position to localStorage
    localStorage.setItem('gt_reader_' + author + '_' + vol, page);

    // TOC toggle
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

    // Page jump
    function jumpToPage() {
      const val = parseInt(document.getElementById('jumpInput').value);
      if (val >= 1 && val <= total) {
        window.location.href = '?author=' + encodeURIComponent(author) + '&vol=' + vol + '&page=' + val;
      }
    }
    document.getElementById('jumpInput').addEventListener('keydown', function(e) {
      if (e.key === 'Enter') jumpToPage();
    });

    // Keyboard navigation
    document.addEventListener('keydown', function(e) {
      if (e.key === 'ArrowLeft'  && page > 1)     window.location.href = '?author=' + encodeURIComponent(author) + '&vol=' + vol + '&page=' + (page - 1);
      if (e.key === 'ArrowRight' && page < total)  window.location.href = '?author=' + encodeURIComponent(author) + '&vol=' + vol + '&page=' + (page + 1);
    });

    // Swipe support for iPad / touch
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