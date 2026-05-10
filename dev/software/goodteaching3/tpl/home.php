<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * KED  10-May-2026    Home page — redesigned 
 * * * * * * * * * * * * * * * * * * * * * * * */

// Pull latest articles with author names
$latestArticles = [];
$sql = "SELECT a.vol, a.page, a.article, au.name
        FROM mse_article a
        JOIN mse_author au ON a.author = au.author
        WHERE a.article IS NOT NULL AND a.article != ''
        ORDER BY a.vol DESC, a.page ASC
        LIMIT 8";
$res = mysqli_query($dbConn, $sql);
while ($row = mysqli_fetch_assoc($res)) {
  $latestArticles[] = $row;
}

// Pull 3 random ministry snippets for the search cards
$snippets = [];
// comment out starting here if you need to visually test the home page. Searching for ministry snippets slows the home page down
// $sql = "SELECT t.text, a.article, au.name
//         FROM mse_text t
//         JOIN mse_article a ON t.author = a.author AND t.vol = a.vol AND t.page = a.page
//         JOIN mse_author au ON t.author = au.author
//         WHERE LENGTH(t.text) > 120 AND LENGTH(t.text) < 400
//         AND t.text NOT LIKE '%?%'
//         ORDER BY RAND()
//         LIMIT 3";
// $res = mysqli_query($dbConn, $sql);
// while ($row = mysqli_fetch_assoc($res)) {
//   $snippets[] = $row;
// }
// end comment out here for faster home page loading for tests
// Pad with empty if not enough
while (count($snippets) < 3) {
  $snippets[] = ['text' => '', 'article' => '', 'name' => ''];
}
?>

<style>
/* ── Remove white bg from content area ── */
.gt-content {
  background: transparent !important;
}

/* ── Page grid ── */
.gt-home {
  display: grid;
  grid-template-columns: 1fr 280px;
  gap: 20px;
  padding: 4px 0 8px;
  align-items: start;
}

/* ── Search cards ── */
.gt-cards {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.gt-card {
  display: flex;
  flex-direction: column;
  padding: 20px 22px;
  border-radius: var(--radius-md);
  border: 1px solid var(--border);
  background: var(--white);
  text-decoration: none !important;
  transition: box-shadow 0.15s, transform 0.15s;
  flex: 1;
}

.gt-card:hover {
  box-shadow: 0 6px 20px rgba(13,31,60,0.10);
  transform: translateY(-1px);
  text-decoration: none !important;
}

.gt-card.keyword   { border-left: 5px solid var(--red); }
.gt-card.scripture { border-left: 5px solid var(--gold); }
.gt-card.author    { border-left: 5px solid var(--green); }

.gt-card-top {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 12px;
}

.gt-card-icon {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  flex-shrink: 0;
}

.keyword   .gt-card-icon { background: var(--red-light);   color: var(--red); }
.scripture .gt-card-icon { background: var(--gold-pale);   color: var(--amber); }
.author    .gt-card-icon { background: var(--green-light); color: var(--green); }

.gt-card-heading { flex: 1; }

.gt-card-title {
  display: block;
  font-family: 'Playfair Display', serif;
  font-size: 12pt;
  color: var(--navy);
  margin-bottom: 2px;
  font-weight: 600;
}

.gt-card-desc {
  font-size: 8.5pt;
  color: var(--text-muted);
  margin: 0;
}

.gt-card-arrow {
  font-size: 22px;
  color: var(--border);
  flex-shrink: 0;
  transition: color 0.15s;
  align-self: flex-start;
}

.gt-card:hover .gt-card-arrow { color: var(--gold); }

/* Quote snippet */
.gt-card-quote {
  border-left: 3px solid var(--cream-dark);
  padding: 8px 12px;
  margin-top: 4px;
  background: var(--cream);
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
}

.gt-card-quote-text {
  font-size: 8.5pt;
  color: var(--text-mid);
  line-height: 1.6;
  font-style: italic;
  margin: 0 0 5px 0;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.gt-card-quote-source {
  font-size: 7.5pt;
  color: var(--text-muted);
  font-weight: 500;
  font-style: normal;
}

.keyword   .gt-card-quote { border-left-color: var(--red-light); }
.scripture .gt-card-quote { border-left-color: var(--gold-pale); }
.author    .gt-card-quote { border-left-color: var(--green-light); }

/* ── Sidebar ── */
.gt-sidebar {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.gt-widget {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.gt-widget-header {
  background: var(--navy);
  padding: 9px 16px;
  font-family: 'Playfair Display', serif;
  font-size: 10.5pt;
  color: var(--gold-light);
}

.gt-widget-row {
  display: flex;
  align-items: baseline;
  gap: 8px;
  padding: 7px 16px;
  border-bottom: 1px solid var(--cream-dark);
  font-size: 8.5pt;
}

.gt-widget-row:last-child { border-bottom: none; }
.gt-widget-row:hover { background: var(--cream); }

.gt-widget-vol {
  color: var(--gold);
  font-weight: 600;
  font-size: 8pt;
  white-space: nowrap;
  flex-shrink: 0;
}

.gt-widget-title {
  color: var(--navy-light);
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.gt-widget-author {
  color: var(--text-muted);
  font-size: 7.5pt;
  white-space: nowrap;
  flex-shrink: 0;
}

.gt-widget-link {
  display: block;
  padding: 8px 16px;
  font-size: 9pt;
  color: var(--navy-light);
  font-weight: 500;
  border-bottom: 1px solid var(--cream-dark);
  text-decoration: none !important;
  transition: background 0.12s, color 0.12s;
}

.gt-widget-link:last-child { border-bottom: none; }
.gt-widget-link:hover { background: var(--cream); color: var(--gold); text-decoration: none !important; }

/* ── eBooks banner ── */
.gt-ebook-banner {
  grid-column: 1 / -1;
  background: var(--navy);
  border-radius: var(--radius-md);
  padding: 22px 28px;
  display: flex;
  align-items: center;
  gap: 24px;
}

.gt-ebook-banner-text { flex: 1; }

.gt-ebook-banner-title {
  font-family: 'Playfair Display', serif;
  font-size: 13pt;
  color: var(--gold-light);
  margin-bottom: 6px;
}

.gt-ebook-banner-desc {
  font-size: 9pt;
  color: #7a9ab8;
  margin: 0;
  line-height: 1.6;
}

.gt-ebook-banner-btn {
  background: var(--gold);
  color: var(--navy);
  font-family: 'Inter', sans-serif;
  font-size: 9.5pt;
  font-weight: 600;
  padding: 10px 22px;
  border-radius: var(--radius-sm);
  text-decoration: none !important;
  white-space: nowrap;
  flex-shrink: 0;
  transition: background 0.15s;
}

.gt-ebook-banner-btn:hover {
  background: var(--gold-light);
  text-decoration: none !important;
}

/* ── Responsive ── */
@media (max-width: 750px) {
  .gt-home { grid-template-columns: 1fr; }
  .gt-ebook-banner { flex-direction: column; text-align: center; }
}
</style>

<div class="gt-home">

  <!-- ── Search cards ── -->
  <div class="gt-cards">

    <a href="<?= $root ?>keyword.php" class="gt-card keyword">
      <div class="gt-card-top">
        <div class="gt-card-icon">&#128269;</div>
        <div class="gt-card-heading">
          <span class="gt-card-title">Search by Keyword</span>
          <p class="gt-card-desc">Find ministry relating to one or more specific words across all volumes</p>
        </div>
        <span class="gt-card-arrow">&#8250;</span>
      </div>
      <?php if (!empty($snippets[0]['text'])): ?>
      <div class="gt-card-quote">
        <p class="gt-card-quote-text"><?= htmlspecialchars(substr($snippets[0]['text'], 0, 280)) ?>...</p>
        <span class="gt-card-quote-source">
          — <?= htmlspecialchars(ucwords(strtolower($snippets[0]['article']))) ?>, <?= htmlspecialchars($snippets[0]['name']) ?>
        </span>
      </div>
      <?php endif; ?>
    </a>

    <a href="<?= $root ?>scripture.php" class="gt-card scripture">
      <div class="gt-card-top">
        <div class="gt-card-icon">&#128214;</div>
        <div class="gt-card-heading">
          <span class="gt-card-title">Search by Scripture</span>
          <p class="gt-card-desc">Find ministry on a particular passage of Scripture</p>
        </div>
        <span class="gt-card-arrow">&#8250;</span>
      </div>
      <?php if (!empty($snippets[1]['text'])): ?>
      <div class="gt-card-quote">
        <p class="gt-card-quote-text"><?= htmlspecialchars(substr($snippets[1]['text'], 0, 280)) ?>...</p>
        <span class="gt-card-quote-source">
          — <?= htmlspecialchars(ucwords(strtolower($snippets[1]['article']))) ?>, <?= htmlspecialchars($snippets[1]['name']) ?>
        </span>
      </div>
      <?php endif; ?>
    </a>

    <a href="<?= $root ?>author.php" class="gt-card author">
      <div class="gt-card-top">
        <div class="gt-card-icon">&#9997;&#65039;</div>
        <div class="gt-card-heading">
          <span class="gt-card-title">Search by Author</span>
          <p class="gt-card-desc">Browse ministry from a specific servant of the Lord</p>
        </div>
        <span class="gt-card-arrow">&#8250;</span>
      </div>
      <?php if (!empty($snippets[2]['text'])): ?>
      <div class="gt-card-quote">
        <p class="gt-card-quote-text"><?= htmlspecialchars(substr($snippets[2]['text'], 0, 280)) ?>...</p>
        <span class="gt-card-quote-source">
          — <?= htmlspecialchars(ucwords(strtolower($snippets[2]['article']))) ?>, <?= htmlspecialchars($snippets[2]['name']) ?>
        </span>
      </div>
      <?php endif; ?>
    </a>

  </div>

  <!-- ── Sidebar ── -->
  <div class="gt-sidebar">

    <div class="gt-widget">
      <div class="gt-widget-header">Latest Volumes</div>
      <?php if (empty($latestArticles)): ?>
        <div class="gt-widget-row"><span class="gt-widget-title">No articles found</span></div>
      <?php else: foreach ($latestArticles as $a): ?>
        <div class="gt-widget-row">
          <span class="gt-widget-vol">Vol&nbsp;<?= (int)$a['vol'] ?></span>
          <span class="gt-widget-title" title="<?= htmlspecialchars($a['article']) ?>">
            <?= htmlspecialchars(ucwords(strtolower($a['article']))) ?>
          </span>
          <span class="gt-widget-author"><?= htmlspecialchars($a['name']) ?></span>
        </div>
      <?php endforeach; endif; ?>
    </div>

    <div class="gt-widget">
      <div class="gt-widget-header">Quick Links</div>
      <a href="<?= $root ?>ebook/"     class="gt-widget-link">&#128241;&nbsp; Download eBooks</a>
      <a href="<?= $root ?>hymn/"      class="gt-widget-link">&#127925;&nbsp; Hymn Search</a>
      <a href="<?= $root ?>tune/"      class="gt-widget-link">&#127926;&nbsp; Tune Player</a>
      <a href="<?= $root ?>volumes.php" class="gt-widget-link">&#128218;&nbsp; Volume Titles</a>
      <a href="<?= $root ?>bible/"     class="gt-widget-link">&#10013;&nbsp; Bible Search</a>
    </div>

  </div>

  <!-- ── eBooks banner ── */-->
  <div class="gt-ebook-banner">
    <div class="gt-ebook-banner-text">
      <div class="gt-ebook-banner-title">Read the Ministry on Your Device</div>
      <p class="gt-ebook-banner-desc">Download eBooks for Kindle, Apple Books, or any reader — updated regularly with the latest volumes and corrections.</p>
    </div>
    <a href="<?= $cfg['Site']['URL'] ?>/ebook/" class="gt-ebook-banner-btn">Download eBooks &rarr;</a>
  </div>

</div>

<?php include $root.'tpl/bot.php'; ?>