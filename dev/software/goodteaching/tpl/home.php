<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * KED  10-May-2026    Home page — redesigned
 * KED  11-May-2026    Added device table from newsearch.php
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
$sql = "SELECT t.text, a.article, au.name
        FROM mse_text t
        JOIN mse_article a ON t.author = a.author AND t.vol = a.vol AND t.page = a.page
        JOIN mse_author au ON t.author = au.author
        WHERE LENGTH(t.text) > 120 AND LENGTH(t.text) < 400
        AND t.text NOT LIKE '%?%'
        ORDER BY RAND()
        LIMIT 3";
$res = mysqli_query($dbConn, $sql);
while ($row = mysqli_fetch_assoc($res)) {
  $snippets[] = $row;
}
while (count($snippets) < 3) {
  $snippets[] = ['text' => '', 'article' => '', 'name' => ''];
}
?>

<style>
.gt-content { background: transparent !important; }

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
  font-size: 9pt;
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

.gt-card-quote {
  border-left: 3px solid var(--cream-dark);
  padding: 8px 12px;
  margin-top: 4px;
  background: var(--cream);
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
}

.gt-card-quote-text {
  font-size: 9pt;
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
  font-size: 8pt;
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
  font-size: 11pt;
  color: var(--gold-light);
}

.gt-widget-row {
  display: flex;
  align-items: baseline;
  gap: 8px;
  padding: 8px 16px;
  border-bottom: 1px solid var(--cream-dark);
  font-size: 10pt;
}

.gt-widget-row:last-child { border-bottom: none; }
.gt-widget-row:hover { background: var(--cream); }

.gt-widget-vol {
  color: var(--gold);
  font-weight: 600;
  font-size: 9pt;
  white-space: nowrap;
  flex-shrink: 0;
}

.gt-widget-title {
  color: var(--navy-light);
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 10pt;
}

.gt-widget-author {
  color: var(--text-muted);
  font-size: 8.5pt;
  white-space: nowrap;
  flex-shrink: 0;
}

.gt-widget-link {
  display: block;
  padding: 9px 16px;
  font-size: 10pt;
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
  font-size: 10pt;
  color: #7a9ab8;
  margin: 0;
  line-height: 1.6;
}

.gt-ebook-banner-btn {
  background: var(--gold);
  color: var(--navy);
  font-family: 'Inter', sans-serif;
  font-size: 10pt;
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

/* ── Device table ── */
.gt-device-section {
  grid-column: 1 / -1;
}

.gt-device-section-title {
  font-family: 'Playfair Display', serif;
  font-size: 13pt;
  color: var(--navy);
  margin-bottom: 12px;
  padding-bottom: 8px;
  border-bottom: 2px solid var(--gold);
  display: inline-block;
}

.gt-device-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 10pt;
  background: var(--white);
  border-radius: var(--radius-md);
  overflow: hidden;
  border: 1px solid var(--border);
}

.gt-device-table th {
  background: var(--navy);
  color: var(--gold-light);
  padding: 10px 12px;
  text-align: center;
  font-weight: 600;
  font-size: 10pt;
  font-family: 'Inter', sans-serif;
  border: 1px solid var(--navy-light);
}

.gt-device-table th:first-child { text-align: left; }

.gt-device-table td {
  padding: 9px 12px;
  border: 1px solid var(--cream-dark);
  color: var(--text-mid);
  text-align: center;
  vertical-align: middle;
  font-family: 'Inter', sans-serif;
  font-size: 10pt;
}

.gt-device-table td:first-child { text-align: left; font-weight: 500; color: var(--navy); }
.gt-device-table tr:last-child td { border-bottom: none; }
.gt-device-table tr:hover td { background: var(--cream); }
.gt-device-table a { color: var(--navy-light); font-weight: 500; }
.gt-device-table a:hover { color: var(--gold); }

/* ── Responsive ── */
@media (max-width: 750px) {
  .gt-home         { grid-template-columns: 1fr; }
  .gt-ebook-banner { flex-direction: column; text-align: center; }
  .gt-device-table { font-size: 9pt; }
  .gt-device-table td, .gt-device-table th { padding: 7px 8px; }
}
</style>

<div class="gt-home">

  <!-- ── Search cards ── -->
  <div class="gt-cards">
    <a href="<?php echo $root; ?>keyword.php" class="gt-card keyword">
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
        <p class="gt-card-quote-text"><?php echo htmlspecialchars(substr($snippets[0]['text'], 0, 280)); ?>...</p>
        <span class="gt-card-quote-source">— <?php echo htmlspecialchars(ucwords(strtolower($snippets[0]['article']))); ?>, <?php echo htmlspecialchars($snippets[0]['name']); ?></span>
      </div>
      <?php endif; ?>
    </a>

    <a href="<?php echo $root; ?>scripture.php" class="gt-card scripture">
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
        <p class="gt-card-quote-text"><?php echo htmlspecialchars(substr($snippets[1]['text'], 0, 280)); ?>...</p>
        <span class="gt-card-quote-source">— <?php echo htmlspecialchars(ucwords(strtolower($snippets[1]['article']))); ?>, <?php echo htmlspecialchars($snippets[1]['name']); ?></span>
      </div>
      <?php endif; ?>
    </a>

    <a href="<?php echo $root; ?>servant.php" class="gt-card author">
      <div class="gt-card-top">
        <div class="gt-card-icon">&#9997;&#65039;</div>
        <div class="gt-card-heading">
          <span class="gt-card-title">Search by Servant</span>
          <p class="gt-card-desc">Filter ministry by a specific servant of the Lord</p>
        </div>
        <span class="gt-card-arrow">&#8250;</span>
      </div>
      <?php if (!empty($snippets[2]['text'])): ?>
      <div class="gt-card-quote">
        <p class="gt-card-quote-text"><?php echo htmlspecialchars(substr($snippets[2]['text'], 0, 280)); ?>...</p>
        <span class="gt-card-quote-source">— <?php echo htmlspecialchars(ucwords(strtolower($snippets[2]['article']))); ?>, <?php echo htmlspecialchars($snippets[2]['name']); ?></span>
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
          <span class="gt-widget-vol">Vol&nbsp;<?php echo (int)$a['vol']; ?></span>
          <span class="gt-widget-title" title="<?php echo htmlspecialchars($a['article']); ?>">
            <?php echo htmlspecialchars(ucwords(strtolower($a['article']))); ?>
          </span>
          <span class="gt-widget-author"><?php echo htmlspecialchars($a['name']); ?></span>
        </div>
      <?php endforeach; endif; ?>
    </div>

    <div class="gt-widget">
      <div class="gt-widget-header">Quick Links</div>
      <a href="<?php echo $root; ?>ebook/"      class="gt-widget-link">&#128241;&nbsp; Download eBooks</a>
      <a href="<?php echo $root; ?>hymn/"       class="gt-widget-link">&#127925;&nbsp; Hymn Search</a>
      <a href="<?php echo $root; ?>tune/"       class="gt-widget-link">&#127926;&nbsp; Tune Player</a>
      <a href="<?php echo $root; ?>volumes.php" class="gt-widget-link">&#128218;&nbsp; Ministry Library</a>
      <a href="<?php echo $root; ?>bible/"      class="gt-widget-link">&#10013;&nbsp; Bible Search</a>
    </div>

  </div>

  <!-- ── eBooks banner ── -->
  <div class="gt-ebook-banner">
    <div class="gt-ebook-banner-text">
      <div class="gt-ebook-banner-title">Read the Ministry on Your Device</div>
      <p class="gt-ebook-banner-desc">Download eBooks for Kindle, Apple Books, or any reader — updated regularly with the latest volumes and corrections.</p>
    </div>
    <a href="<?php echo $cfg['Site']['URL']; ?>/ebook/" class="gt-ebook-banner-btn">Download eBooks &rarr;</a>
  </div>

  <!-- ── Device compatibility table ── -->
  <div class="gt-device-section">
    <div class="gt-device-section-title">How to Access the Ministry</div>
    <table class="gt-device-table">
      <tr>
        <th colspan="2">Task / Device</th>
        <th>PC</th>
        <th>Mac</th>
        <th>iOS</th>
        <th>Android</th>
        <th>Kindle</th>
      </tr>
      <tr>
        <td colspan="2">Reading / Searching the Bible</td>
        <td colspan="4"><a href="https://www.olivetree.com/bible-study-apps/">Olive Tree</a> app</td>
        <td><a href="<?php echo $root; ?>ebook/">JND eBook</a></td>
      </tr>
      <tr>
        <td rowspan="2">Reading the Ministry</td>
        <td><a href="<?php echo $root; ?>ebook/">eBooks</a></td>
        <td><a href="https://calibre-ebook.com/download">Calibre</a></td>
        <td><a href="https://calibre-ebook.com/download">Calibre</a> / <a href="https://itunes.apple.com/gb/app/ibooks/id364709193?mt=8">Apple Books</a></td>
        <td><a href="https://itunes.apple.com/gb/app/ibooks/id364709193?mt=8">Apple Books</a></td>
        <td><a href="https://play.google.com/store/apps/details?id=com.aldiko.android">Aldiko</a></td>
        <td><a href="<?php echo $root; ?>ebook/">eBooks</a></td>
      </tr>
      <tr>
        <td>Online</td>
        <td colspan="4"><a href="http://www.mcclean.me.uk/mse/">R.W.McClean</a></td>
        <td><i>Not available</i></td>
      </tr>
      <tr>
        <td colspan="2">Searching the Ministry</td>
        <td colspan="2"><a href="http://mse.0mpurdy.com/">Ministry Search Engine</a></td>
        <td><a href="https://goodteaching.org">GoodTeaching.org</a></td>
        <td><a href="https://play.google.com/store/apps/details?id=mse.mse_android&hl=en">MSE (Google Play)</a></td>
        <td><a href="<?php echo $root; ?>ebook/">eBooks</a></td>
      </tr>
    </table>
  </div>

</div>

<?php include $root.'tpl/bot.php'; ?>