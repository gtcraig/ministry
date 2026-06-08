<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * KED   10-May-2026    Top of the page — redesigned 2026
 * KED   11-May-2026    Replaced all short tags.
 * * * * * * * * * * * * * * * * * * * * * * * */

if (empty($root)) {
  $root = "./";
}

if (empty($pageName)) {
  $pageName = "pageGt";
}

header("Content-Type: text/html;charset=UTF-8");

include_once $root.'Main.php';
$member   = NULL; if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];
$loggedin = (isset($_SESSION['memberid']) && isset($_SESSION['Good Teaching Search Engine']));
global $tab, $tabs;

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}
?>
<head>
  <title><?php echo $title; ?></title>
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
  <link href="<?php echo $root; ?>mse.css" rel="stylesheet" type="text/css" />
  <?php if (!empty($pageCss)) { ?><link href="<?php echo $pageCss; ?>" rel="stylesheet" type="text/css" /><?php } ?>
  <script language="Javascript" src="<?php echo $root; ?>date.js"></script>
  <script language="Javascript" src="<?php echo $root; ?>form.js"></script>
  <link rel="icon" type="image/vnd.microsoft.icon" href="<?php echo $root; ?>favicon.ico">
</head>
<?php if ($cfg['Site']['Status'] == "Production") { ?>
<script async src="https://www.googletagmanager.com/gtag/js?id=G-ML4G845784"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-ML4G845784');
</script>
<?php } ?>

<body topmargin=0 leftmargin=0 id="<?php echo $pageName; ?>">

<div class="outerBox">

  <!-- ── Header ── -->
  <div class="gt-header">
    <div class="gt-header-inner">
      <a class="gt-logo" href="<?php echo $cfg['Site']['URL']; ?>"><?php echo str_replace(" ", "&nbsp;", $cfg['Site']['Name']); ?></a>
      <nav class="gt-nav">
        <a id="linkGt"       href="<?php echo $cfg['Site']['URL']; ?>">Search</a>
        <a id="linkEbook"    href="<?php echo $cfg['Site']['URL']; ?>/ebook/">eBooks</a>
        <a id="linkBible"    href="<?php echo $cfg['Site']['URL']; ?>/bible/">Bible</a>
        <a id="linkMinistry" href="<?php echo $cfg['Site']['URL']; ?>/volumes.php">Ministry</a>
        <a id="linkHymn"     href="<?php echo $cfg['Site']['URL']; ?>/hymn/">Hymns</a>
        <a id="linkTune"     href="<?php echo $cfg['Site']['URL']; ?>/tune/">Tunes</a>
      </nav>
    </div>
  </div>

  <!-- ── Gold divider bar ── -->
  <div class="gt-goldbar"></div>

  <!-- ── Tabs (ministry search only) ── -->
  <?php if ($tabs == "MINISTRY") {
    $className = $tab . "border"; ?>
    <div class="gt-tabs">
      <?php include $root.'tpl/tabs.php'; ?>
    </div>
  <?php } else {
    $className = ($tabs == "NONE") ? "mainborder" : "KEYWORDborder";
  } ?>

  <!-- ── Page content ── -->
  <div class="<?php echo $className; ?> gt-content">