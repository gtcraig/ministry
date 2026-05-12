<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * eBook Downloads Page
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * KED  11-May-2026  Redesigned layout, replaced short tags.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title    = "eBooks";
$root     = "../";
$tabs     = "NONE";
$pageName = "pageEbook";
$pageCss  = "hymn.css";
include $root.'tpl/top.php';
?>

<style>
.eb-page { padding: 4px 0; }

.eb-hero {
  background: var(--navy);
  border-radius: var(--radius-md);
  padding: 28px 32px;
  margin-bottom: 24px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
}

.eb-hero-text h1 {
  font-family: 'Playfair Display', serif;
  font-size: 18pt;
  color: var(--gold-light);
  margin-bottom: 8px;
}

.eb-hero-text p {
  font-size: 10pt;
  color: #7a9ab8;
  margin: 0;
  line-height: 1.6;
}

.eb-updated {
  font-size: 8pt;
  color: #4a6280;
  margin-top: 8px;
}

/* Two column layout */
.eb-layout {
  display: grid;
  grid-template-columns: 1fr 320px;
  gap: 24px;
  align-items: start;
}

/* Section cards */
.eb-section {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  overflow: hidden;
  margin-bottom: 16px;
}

.eb-section-header {
  background: var(--navy);
  padding: 10px 20px;
  font-family: 'Playfair Display', serif;
  font-size: 12pt;
  color: var(--gold-light);
}

.eb-section-body {
  padding: 16px 20px;
}

/* Download cards */
.eb-downloads {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.eb-download-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 14px;
  background: var(--cream);
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  gap: 12px;
}

.eb-download-item:hover { background: var(--gold-pale); }

.eb-download-name {
  font-size: 9.5pt;
  font-weight: 600;
  color: var(--navy);
  flex: 1;
}

.eb-download-sub {
  font-size: 8.5pt;
  color: var(--text-muted);
  margin-top: 2px;
}

.eb-download-links {
  display: flex;
  gap: 6px;
  flex-shrink: 0;
}

.eb-download-btn {
  padding: 4px 12px;
  background: var(--navy);
  color: var(--gold) !important;
  font-size: 8.5pt;
  font-weight: 600;
  border-radius: var(--radius-sm);
  text-decoration: none !important;
  transition: background 0.15s;
  white-space: nowrap;
}

.eb-download-btn:hover {
  background: var(--navy-light);
  text-decoration: none !important;
}

/* Steps */
.eb-steps ol {
  margin: 0;
  padding-left: 20px;
}

.eb-steps li {
  font-size: 9.5pt;
  color: var(--text-mid);
  line-height: 1.7;
  margin-bottom: 4px;
}

.eb-steps li b { color: var(--navy); }
.eb-steps li a { color: var(--navy-light); }
.eb-steps li a:hover { color: var(--gold); }

/* Device comparison table */
.eb-device-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 8.5pt;
}

.eb-device-table th {
  background: var(--navy);
  color: var(--gold-light);
  padding: 8px 10px;
  text-align: left;
  font-weight: 600;
}

.eb-device-table td {
  padding: 8px 10px;
  border-bottom: 1px solid var(--cream-dark);
  color: var(--text-mid);
  vertical-align: top;
}

.eb-device-table tr:last-child td { border-bottom: none; }
.eb-device-table tr:hover td { background: var(--cream); }
.eb-device-table a { color: var(--navy-light); }
.eb-device-table a:hover { color: var(--gold); }

.eb-device-img {
  width: 48px;
  height: auto;
  border-radius: 4px;
}

.eb-pros-cons { margin: 0; padding-left: 14px; }
.eb-pros-cons li { margin-bottom: 2px; }

/* FAQ */
.eb-faq-item {
  padding: 12px 0;
  border-bottom: 1px solid var(--cream-dark);
}
.eb-faq-item:last-child { border-bottom: none; }

.eb-faq-q {
  font-size: 10pt;
  font-weight: 600;
  color: var(--navy);
  margin-bottom: 6px;
}

.eb-faq-a {
  font-size: 9.5pt;
  color: var(--text-mid);
  line-height: 1.6;
}

.eb-faq-a ul { margin: 6px 0 0 16px; padding: 0; }
.eb-faq-a li { margin-bottom: 3px; }
.eb-faq-a a  { color: var(--navy-light); }
.eb-faq-a a:hover { color: var(--gold); }

/* Sidebar */
.eb-sidebar { display: flex; flex-direction: column; gap: 16px; }

.eb-widget {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.eb-widget-header {
  background: var(--navy);
  padding: 9px 16px;
  font-family: 'Playfair Display', serif;
  font-size: 10.5pt;
  color: var(--gold-light);
}

.eb-widget-body {
  padding: 14px 16px;
  font-size: 9pt;
  color: var(--text-mid);
  line-height: 1.7;
}

.eb-widget-body a { color: var(--navy-light); font-weight: 500; }
.eb-widget-body a:hover { color: var(--gold); }

.eb-device-pill {
  display: inline-block;
  background: var(--cream);
  border: 1px solid var(--border);
  border-radius: 20px;
  padding: 3px 10px;
  font-size: 8pt;
  color: var(--navy);
  font-weight: 500;
  margin: 2px;
}

@media (max-width: 750px) {
  .eb-layout { grid-template-columns: 1fr; }
  .eb-hero   { flex-direction: column; }
}
</style>

<div class="eb-page">

  <!-- Hero -->
  <div class="eb-hero">
    <div class="eb-hero-text">
      <h1>Ministry eBooks</h1>
      <p>Download the ministry of the recovery and Hymns &amp; Spiritual Songs (1962) for your e-reader.<br>
         Available in EPUB format for Kindle, Apple Books, Android and more.</p>
      <div class="eb-updated">Last updated: <strong>17 Sep 2023</strong> with latest devices</div>
    </div>
  </div>

  <div class="eb-layout">

    <!-- ── Left column ── -->
    <div>

      <!-- Downloads -->
      <div class="eb-section">
        <div class="eb-section-header">Downloads</div>
        <div class="eb-section-body">
          <div class="eb-downloads">

            <div class="eb-download-item">
              <div>
                <div class="eb-download-name">Ministry of the Recovery</div>
                <div class="eb-download-sub">Complete collected writings</div>
              </div>
              <div class="eb-download-links">
                <a href="https://bit.ly/3bvr2sl" class="eb-download-btn">EPUB</a>
              </div>
            </div>

            <div class="eb-download-item">
              <div>
                <div class="eb-download-name">Ministry organised by Bible Book</div>
                <div class="eb-download-sub">Arranged by Scripture reference</div>
              </div>
              <div class="eb-download-links">
                <a href="https://bit.ly/2vOn8eO" class="eb-download-btn">EPUB</a>
              </div>
            </div>

            <div class="eb-download-item">
              <div>
                <div class="eb-download-name">1962 Hymns &amp; Spiritual Songs</div>
                <div class="eb-download-sub">English, Deutsch &amp; Dutch</div>
              </div>
              <div class="eb-download-links">
                <a href="https://bit.ly/2WKlS7I" class="eb-download-btn">EPUB</a>
              </div>
            </div>

            <div class="eb-download-item">
              <div>
                <div class="eb-download-name">JND Bible (Darby Translation)</div>
                <div class="eb-download-sub">With footnotes</div>
              </div>
              <div class="eb-download-links">
                <a href="https://www.dropbox.com/s/82r2sb7qwdd3ip2/Bible_Darby_R04.epub?dl=0" class="eb-download-btn">EPUB</a>
              </div>
            </div>

            <div class="eb-download-item">
              <div>
                <div class="eb-download-name">Various Ministries</div>
                <div class="eb-download-sub">Deck, Dennett, Gardiner, Johnson, Kingscote, Renton &amp; others</div>
              </div>
              <div class="eb-download-links">
                <a href="https://bit.ly/3dWJuMM" class="eb-download-btn">EPUB</a>
              </div>
            </div>

          </div>
        </div>
      </div>

      <!-- Device comparison -->
      <div class="eb-section">
        <div class="eb-section-header">Which Device Should I Get?</div>
        <div class="eb-section-body">
          <table class="eb-device-table">
            <tr>
              <th>Device</th>
              <th>Screen</th>
              <th>Price</th>
              <th>Pros</th>
              <th>Cons</th>
            </tr>
            <tr>
              <td>
                <a href="https://www.amazon.co.uk/dp/B09TMP5Y2S/" target="_blank">
                  <img src="kindlepw4.png" class="eb-device-img" alt="Kindle"><br>
                  <strong>Kindle Paperwhite</strong>
                </a>
              </td>
              <td>6.8&rdquo; backlit e-ink</td>
              <td><strong>&pound;149.99</strong></td>
              <td>
                <ul class="eb-pros-cons">
                  <li>Affordable</li>
                  <li>No distractions</li>
                  <li>One-handed reading</li>
                  <li>Weeks of battery</li>
                </ul>
              </td>
              <td>
                <ul class="eb-pros-cons">
                  <li>Books only</li>
                </ul>
              </td>
            </tr>
            <tr>
              <td>
                <a href="https://www.apple.com/uk/shop/buy-ipad/ipad-mini" target="_blank">
                  <img src="applemini.png" class="eb-device-img" alt="iPad Mini"><br>
                  <strong>Apple iPad Mini</strong>
                </a>
              </td>
              <td>8.3&rdquo; liquid retina</td>
              <td><strong>&pound;569</strong></td>
              <td>
                <ul class="eb-pros-cons">
                  <li>Sharp screen</li>
                  <li>Compact</li>
                  <li>Multi-purpose</li>
                </ul>
              </td>
              <td>
                <ul class="eb-pros-cons">
                  <li>Expensive</li>
                </ul>
              </td>
            </tr>
          </table>
        </div>
      </div>

      <!-- Installation guides -->
      <div class="eb-section">
        <div class="eb-section-header" id="kindle">Installing on Kindle</div>
        <div class="eb-section-body eb-steps">
          <ol>
            <li>Download the <a href="https://www.dropbox.com/s/o5bt0idersubg5t/epub_ministry.zip?dl=0">EPUB format</a> ministry</li>
            <li>Unzip the file on your Desktop — creates a single <b>ministry</b> folder with subfolders per servant</li>
            <li>Attach your Kindle via USB cable</li>
            <li>Drag the <b>ministry</b> folder onto the <b>documents</b> folder on the Kindle drive</li>
            <li>Wait for files to copy, then disconnect</li>
            <li>Power up — you should see all the ministry. Problems? <a href="mailto:support@goodteaching.org">Email Support</a></li>
          </ol>
        </div>
      </div>

      <div class="eb-section">
        <div class="eb-section-header" id="apple">Installing on Apple iPad / iPhone</div>
        <div class="eb-section-body eb-steps">
          <p style="font-size:9pt; color:var(--text-muted); margin-bottom:10px;">Pre-requisite: Download <a href="http://www.apple.com/itunes/download/" target="_blank">iTunes 12</a>.</p>
          <ol>
            <li>Download the <a href="https://www.dropbox.com/s/o5bt0idersubg5t/epub_ministry.zip?dl=0">EPUB format</a> ministry</li>
            <li>Unzip on your Desktop — creates a <b>ministry</b> folder with all epub files inside</li>
            <li>Open iTunes and drag the <b>ministry</b> folder into it</li>
            <li>Under <b>Books</b> you will see all the ministry</li>
            <li>Attach your device and click on it in iTunes</li>
            <li>Click <b>Books</b> → tick <b>Sync Books</b> → leave <b>All books</b> selected</li>
            <li>Click <b>Sync</b> and wait</li>
            <li>Open iBooks on your device — all the ministry should appear. Problems? <a href="mailto:support@goodteaching.org">Email Support</a></li>
          </ol>
        </div>
      </div>

      <div class="eb-section">
        <div class="eb-section-header" id="android">Installing on Android</div>
        <div class="eb-section-body eb-steps">
          <ol>
            <li>Download the <a href="https://www.dropbox.com/s/o5bt0idersubg5t/epub_ministry.zip?dl=0">EPUB format</a> ministry</li>
            <li>Unzip on your Desktop — creates a single <b>ministry</b> folder</li>
            <li>Connect your Android device by USB — it appears as a new drive</li>
            <li>Drag the <b>ministry</b> folder to the device drive</li>
            <li>While copying, install <a href="https://play.google.com/store/apps/details?id=com.aldiko.android">Aldiko</a> from the Play Store</li>
            <li>Once copied, open Aldiko → menu top left → <b>Files</b></li>
            <li>Browse to the ministry folder → tap <b>Select All</b> → tap <b>Import</b></li>
            <li>Aldiko imports all volumes in a few minutes</li>
          </ol>
        </div>
      </div>

      <!-- FAQ -->
      <div class="eb-section">
        <div class="eb-section-header" id="faq">Frequently Asked Questions</div>
        <div class="eb-section-body">

          <div class="eb-faq-item">
            <div class="eb-faq-q">Are the Indexes available as eBooks?</div>
            <div class="eb-faq-a">No — some of these volumes are still copyrighted.</div>
          </div>

          <div class="eb-faq-item">
            <div class="eb-faq-q">Can I get the Bible for my e-reader?</div>
            <div class="eb-faq-a">
              Yes!
              <ul>
                <li><b>Kindle:</b> Try our <a href="https://www.dropbox.com/s/82r2sb7qwdd3ip2/Bible_Darby_R04.epub?dl=0">JND Bible for Kindle</a>. Note: footnotes may not display correctly on Paperwhite 2 or newer.</li>
                <li><b>All other devices:</b> We recommend <a href="http://olivetree.com/bible-study-apps/" target="_blank">Olive Tree</a> — the best Bible software, available on all platforms and free.</li>
              </ul>
            </div>
          </div>

          <div class="eb-faq-item">
            <div class="eb-faq-q">How can I relate eBook page numbers to physical page numbers?</div>
            <div class="eb-faq-a">There isn't currently a way to do this. An index page linking to physical page numbers is being considered for a future release.</div>
          </div>

          <div class="eb-faq-item">
            <div class="eb-faq-q">I've found a mistake in the text — how do I report it?</div>
            <div class="eb-faq-a">
              Email <a href="mailto:support@goodteaching.org?Subject=Text%20Mistake%20-%20">support@goodteaching.org</a>. You'll receive an automated reply with a ticket number.
              <ul>
                <li><b>Subject:</b> include the volume (e.g. JND V45)</li>
                <li><b>Body:</b> retype a portion of the incorrect text and add the correction</li>
                <li>Send a separate email per mistake — the ticket system tracks each one individually</li>
                <li>A new build of eBooks is released once a year with all corrections</li>
              </ul>
            </div>
          </div>

        </div>
      </div>

    </div>

    <!-- ── Sidebar ── -->
    <div class="eb-sidebar">

      <div class="eb-widget">
        <div class="eb-widget-header">Quick Downloads</div>
        <div class="eb-widget-body">
          <a href="https://bit.ly/3bvr2sl">&#128214; Ministry EPUB</a><br>
          <a href="https://bit.ly/2WKlS7I">&#127925; Hymns EPUB</a><br>
          <a href="https://www.dropbox.com/s/82r2sb7qwdd3ip2/Bible_Darby_R04.epub?dl=0">&#10013; JND Bible EPUB</a><br>
          <a href="https://bit.ly/3dWJuMM">&#128218; Various Ministries EPUB</a>
        </div>
      </div>

      <div class="eb-widget">
        <div class="eb-widget-header">Compatible Devices</div>
        <div class="eb-widget-body">
          <span class="eb-device-pill">Kindle Paperwhite</span>
          <span class="eb-device-pill">iPad / iPhone</span>
          <span class="eb-device-pill">Android</span>
          <span class="eb-device-pill">Apple Books</span>
          <span class="eb-device-pill">Aldiko</span>
          <span class="eb-device-pill">Calibre (PC/Mac)</span>
        </div>
      </div>

      <div class="eb-widget">
        <div class="eb-widget-header">Installation Guides</div>
        <div class="eb-widget-body">
          <a href="#kindle">&#128279; Kindle setup</a><br>
          <a href="#apple">&#128279; Apple iPad / iPhone</a><br>
          <a href="#android">&#128279; Android devices</a><br>
          <a href="#faq">&#128279; FAQ</a>
        </div>
      </div>

      <div class="eb-widget">
        <div class="eb-widget-header">Need Help?</div>
        <div class="eb-widget-body">
          Having trouble installing or downloading?<br><br>
          <a href="mailto:support@goodteaching.org">&#9993; Email Support</a>
        </div>
      </div>

    </div>

  </div>
</div>

<?php include $root.'tpl/bot.php'; ?>