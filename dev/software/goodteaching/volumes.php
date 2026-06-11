<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Volume Picker — redesigned 2026
 *
 * KEK 11-May-2026  Update volumes page to new design.
 * KED 11-May-2026  Increased card and font sizes for accessibility.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title    = "Ministry Library";
$tabs     = "NONE";
$pageName = "pageMinistry";
$root     = "./";
include $root.'tpl/top.php';

$volumes = [];
$sql = "SELECT v.author, v.vol, v.title,
               au.name, au.fullname, au.orgname,
               MAX(t.page) as page_count
        FROM mse_volume v
        JOIN mse_author au ON v.author = au.author
        JOIN mse_text t    ON t.author = v.author AND t.vol = v.vol
        GROUP BY v.author, v.vol, v.title, au.name, au.fullname, au.orgname
        ORDER BY au.fullname ASC, v.vol ASC";
$res = mysqli_query($dbConn, $sql);
while ($row = mysqli_fetch_assoc($res)) {
  $cleanTitle = preg_replace('/^V\d+\s+/i', '', $row['title']);
  $row['clean_title'] = $cleanTitle;
  $volumes[$row['author']][] = $row;
}

uasort($volumes, function($a, $b) {
  return strcmp($a[0]['fullname'], $b[0]['fullname']);
});
?>

<style>
.vp-page { padding: 8px 0; }

.vp-heading {
  font-family: 'Playfair Display', serif;
  font-size: 20pt;
  color: var(--navy);
  margin-bottom: 8px;
}

.vp-subheading {
  font-size: 11pt;
  color: var(--text-muted);
  margin-bottom: 28px;
}

.vp-author {
  margin-bottom: 40px;
}

.vp-author-header {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 16px;
  padding-bottom: 10px;
  border-bottom: 2px solid var(--gold);
}

.vp-author-initial {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background: var(--navy);
  color: var(--gold);
  font-family: 'Playfair Display', serif;
  font-size: 20pt;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.vp-author-name {
  font-family: 'Playfair Display', serif;
  font-size: 15pt;
  color: var(--navy);
}

.vp-author-fullname {
  font-size: 11pt;
  color: var(--text-muted);
}

.vp-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 14px;
}

.vp-vol {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  padding: 18px 20px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  transition: box-shadow 0.15s, transform 0.15s;
}

.vp-vol:hover {
  box-shadow: 0 4px 14px rgba(13,31,60,0.10);
  transform: translateY(-1px);
}

.vp-vol-num {
  font-size: 10pt;
  font-weight: 600;
  color: var(--gold);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.vp-vol-title {
  font-size: 11pt;
  font-weight: 600;
  color: var(--navy);
  line-height: 1.4;
  flex: 1;
}

.vp-vol-pages {
  font-size: 10pt;
  color: var(--text-muted);
}

.vp-read-btn {
  display: inline-block;
  margin-top: 6px;
  padding: 8px 16px;
  background: var(--navy);
  color: var(--gold) !important;
  font-size: 11pt;
  font-weight: 600;
  border-radius: var(--radius-sm);
  text-decoration: none !important;
  text-align: center;
  transition: background 0.15s;
}

.vp-read-btn:hover {
  background: var(--navy-light);
  text-decoration: none !important;
}

@media (max-width: 600px) {
  .vp-grid { grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); }
}
</style>

<div class="vp-page">
  <h1 class="vp-heading">Ministry Library</h1>
  <p class="vp-subheading">Browse all available volumes by author. Click Read to open a volume in the reader.</p>

  <?php if (empty($volumes)): ?>
    <p style="color:var(--text-muted); font-style:italic;">No volumes found.</p>
  <?php endif; ?>

  <?php foreach ($volumes as $authorKey => $vols): ?>
  <?php $au = $vols[0]; ?>
  <div class="vp-author">

    <div class="vp-author-header">
      <div class="vp-author-initial"><?php echo htmlspecialchars(substr($au['fullname'], 0, 1)); ?></div>
      <div>
        <div class="vp-author-name"><?php echo htmlspecialchars($au['name']); ?></div>
        <div class="vp-author-fullname"><?php echo htmlspecialchars($au['fullname']); ?></div>
      </div>
    </div>

    <div class="vp-grid">
      <?php foreach ($vols as $v): ?>
      <div class="vp-vol">
        <div class="vp-vol-num">Vol <?php echo (int)$v['vol']; ?></div>
        <div class="vp-vol-title"><?php echo htmlspecialchars($v['clean_title'] ?: 'Volume ' . (int)$v['vol']); ?></div>
        <div class="vp-vol-pages"><?php echo (int)$v['page_count']; ?> pages</div>
        <a href="<?php echo $root; ?>reader.php?author=<?php echo urlencode($v['author']); ?>&vol=<?php echo (int)$v['vol']; ?>"
           class="vp-read-btn">Read &rarr;</a>
      </div>
      <?php endforeach; ?>
    </div>

  </div>
  <?php endforeach; ?>
</div>

<?php include $root.'tpl/bot.php'; ?>