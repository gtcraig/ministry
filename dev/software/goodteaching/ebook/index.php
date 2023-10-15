<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * 1962 Hymn Book Search
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10204 : Added calls to Servant checkbox functions.
 * CAM  29-Sep-2008  10302 : Moved to GoodTeaching.org.
 * CAM  12-Apr-2009  10419 : Added more flexibility to tabs, and use common database.
 * CAM  30-Dec-2009  10520 : Add focus formatting for dropdowns.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "1962 Hymn Search";
$root = "../";
$tabs = "HYMN";
$pageName = "pageEbook";
$pageCss = "hymn.css";
include $root.'tpl/top.php';
?>
<style>
  #updated p {
    font-size: 9pt;
    color: #999999;
    text-align: center;
  }

  #mainbody {
  	width: 1000px;
    display: block;
    margin-left: auto;
    margin-right: auto;
  }

  a {
  	color: #3366FF;
  	text-decoration: none;
  }

  a:hover {
  	color: white;
  	background-color: #3366FF;
  	text-decoration: none;
  }

  .r {
    text-align: right;
  }

  .c {
    text-align: center;
  }

  #favourite {
    background-color: #CCCCFF;
  }

  th {
    background-color: #666699;
  	color: white;
  }

  #comparison {
	  border-left: 1px solid grey;
	  border-top: 1px solid grey;
	  float: none;
  }

  #comparison td, #comparison th {
	  border-right: 1px solid grey;
	  border-bottom: 1px solid grey;
  }

  .cmpr {
    margin: 0 0 0 7;
    padding: 0;

  .hilight {
    color: #666699;
  }
</style>

    <div id="updated"><p>Updated <b>17-Sep-2023</b> with latest devices</p></div>

		<div id="mainbody">

<h1>How to download and install the e-books</h1>

<p>Welcome to the third release of the <span style="font-weight: bold;">ministry of the recovery</span> and <span style="font-weight: bold;">Hymns and
Spiritual Songs (1962)</span> <span style="color: #A9A9A9;">[English, Deutsch &amp; Dutch... Italiano in progress]</span> for e-readers.</p>

<h2><a id="downloads"></a>Downloads</h2>
<ul>
  <li>Ministry
    [<a href="https://bit.ly/3bvr2sl">EPUB</a>]
  </li>
  <li><span class="hilight">Ministry organised by Bible Book</span>
    [<a href="https://bit.ly/2vOn8eO">EPUB</a>]
  </li>
  <li>1962 Hymns
    [<a href="https://bit.ly/2WKlS7I">EPUB</a>]
  </li>
  <li>JND Bible
    [<a href="https://www.dropbox.com/s/82r2sb7qwdd3ip2/Bible_Darby_R04.epub?dl=0">EPUB</a>]
  </li>
  <li>Various Ministries
    [<a href="https://bit.ly/3dWJuMM">EPUB</a>]
	<ol>
		<li><b>&ldquo;The Love of the Truth&rdquo; and Other Ministry</b> by Brian M. Deck		[<a href="http://www.lulu.com/shop/brian-deck/the-love-of-the-truth/paperback/product-24452095.html">Order on Lulu</a>]</li>
		<li><b>Foundational Ministry</b> by Edward Dennett									      	    [<a href="http://www.lulu.com/shop/edward-dennett/foundational-ministry/paperback/product-24004795.html">Order on Lulu</a>]</li>
    
		<li><b>Collected Articles of Ministry</b> by Alfred J. Gardiner Volume 1				[<a href="https://www.lulu.com/en/gb/shop/alfred-j-gardiner/collected-articles-of-ministry-volume-1/paperback/product-1vgqjqdq.html">Order on Lulu</a>]</li>
		<li><b>Collected Articles of Ministry</b> by Alfred J. Gardiner Volume 2				[<a href="https://www.lulu.com/en/gb/shop/alfred-j-gardiner/collected-articles-of-ministry-volume-2/paperback/product-1gq929wv.html">Order on Lulu</a>]</li>
		<li><b>Collected Articles of Ministry</b> by Alfred J. Gardiner Volume 3				[<a href="https://www.lulu.com/en/gb/shop/alfred-j-gardiner/collected-articles-of-ministry-volume-3/paperback/product-vqme5y.html">Order on Lulu</a>]</li>
		<li><b>Collected Articles of Ministry</b> by Alfred J. Gardiner Volume 4				[<a href="https://www.lulu.com/en/gb/shop/alfred-j-gardiner/collected-articles-of-ministry-volume-4/paperback/product-qjgmvk.html">Order on Lulu</a>]</li>
		<li><b>Collected Articles of Ministry</b> by Alfred J. Gardiner Volume 5				[<a href="https://www.lulu.com/en/gb/shop/alfred-j-gardiner/collected-articles-of-ministry-volume-5/paperback/product-4j67q8.html">Order on Lulu</a>]</li>
		<li><b>Collected Articles of Ministry</b> by Alfred J. Gardiner Volume 6				[<a href="https://www.lulu.com/en/gb/shop/alfred-j-gardiner/collected-articles-of-ministry-volume-6/paperback/product-y99ve5.html">Order on Lulu</a>]</li>
		<li><b>Collected Articles of Ministry</b> by Alfred J. Gardiner Volume 7				[<a href="https://www.lulu.com/en/gb/shop/alfred-j-gardiner/collected-articles-of-ministry-volume-7/paperback/product-9jgnvg.html">Order on Lulu</a>]</li>

		<li><b>Addresses and Other Ministry</b> by William Johnson								[<a href="http://www.lulu.com/shop/william-johnson/addresses-and-other-ministry/paperback/product-24141837.html">Order on Lulu</a>]</li>
		<li><b>Christ as seen in the Offerings</b> by Robert F. Kingscote</li>
		<li><b>First Things and Other Ministry</b> by Jim Renton Volume 1						[<a href="http://www.lulu.com/shop/jim-renton/first-things-and-other-ministry-volume-1/paperback/product-24479699.html">Order on Lulu</a>]</li>
		<li><b>First Things and Other Ministry</b> by Jim Renton Volume 2						[<a href="http://www.lulu.com/shop/jim-renton/first-things-and-other-ministry-volume-2/paperback/product-24475940.html">Order on Lulu</a>]</li>
		<li><b>Fundamental Truths Series</b> (Various)</li>
		<li><b>Notes on &ldquo;The Breaking of Bread&rdquo;</b> (T. Willey)</li>
	</ol>
  </li>
</ul>


<h2>Don't have a reader and don't know which one to get?</h2>
<ul>
  <li><a href="http://www.youtube.com/watch?v=w1qjML1YO3s" target="_blank">Here's a (very out of date) comparison of the iPad 1 with the Kindle 3</a>.</li>
  <li>If you're regularly travelling or commuting and want to read the  ministry on the move, I recommend the <a href="https://www.amazon.co.uk/dp/B09TMP5Y2S/"
target="_blank">Kindle Paperwhite No Ads (&pound;149.99)</a>.</li>
</ul>

<table id="comparison" border="0" cellpadding="5" cellspacing="0">
  <tr>
    <th>&nbsp;</td>
    <th>Model</th>
    <th>Screen</td>
    <th>Price</th>
    <th>Comments</th>
    <th width="150">Pros</th>
    <th width="150">Cons</th>
  </tr>

  <tr>
    <td align="center"><a href="https://www.amazon.co.uk/dp/B09TMP5Y2S/" target="_blank"><img border="0" src="kindlepw4.png"></a></td>
    <td><b><a href="https://www.amazon.co.uk/dp/B09TMP5Y2S/"
target="_blank">Kindle Paperwhite Waterproof</a></b></td>
    <td>6.8&rdquo; backlit e-ink</td>
    <td class="r"><b>&pound;149.99</b></td>
    <td><p><b>Great e-reader</b></p>  <p>If you are mainly using it for reading the ministry, this is the one for you.</p></td>
	  <td><ul class="cmpr">
      <li class="cmpr">Cheap</li>
      <li class="cmpr">No distractions</li>
      <li class="cmpr">Easy to hold in one hand</li>
      <li class="cmpr">Weeks of battery life</li>
	  </ul></td>
	  <td><ul class="cmpr">
	    <li class="cmpr">Can <i>only</i> read books</li>
	  </ul></td>
  </tr>

  <tr>
    <td align="center"><a href="https://www.apple.com/uk/shop/buy-ipad/ipad-mini" target="_blank"><img border="0" src="applemini.png"></a></td>
    <td><b><a href="https://www.apple.com/uk/shop/buy-ipad/ipad-mini"
target="_blank">Apple iPad Mini</a></b></td>
    <td>8.3&rdquo; liquid retina</td>
    <td class="r"><b>&pound;569</b></td>
    <td><p><b>Apple tablet</b></p>  <p>Apple products are very well designed and intuitive to use.  The iBook reader is very good, offering bookmarking, highlighting and excellent navigation, and you'll be able to read email and browse the web too.</p></td>
	  <td><ul class="cmpr">
	    <li class="cmpr">Sharp, bright screen</li>
	    <li class="cmpr">Compact size</li>
	  </ul></td>
	  <td><ul class="cmpr">
	    <li class="cmpr">Expensive</li>
	  </ul></td>
  </tr>

</table>

<h2>So you've bought a reader and want to read the ministry on it?</h2>
<p>Easy!  Follow the simple steps below!</p>
<ul>
<li><a href="#kindle">Kindle</a></li>
<li><a href="#apple">Apple iPad, iPhone or iPod Touch</a></li>
<li><a href="#android">Android-based devices</a></li>
</ul>

<h3><a id="kindle"></a>Amazon Kindle</h3>
<ol type="1">

<li>Download the <a href="https://www.dropbox.com/s/o5bt0idersubg5t/epub_ministry.zip?dl=0">EPUB format</a> ministry (now available <a href="https://www.dropbox.com/s/6eq86w5z8qk2176/hymns-1962-epub.zip?dl=0">EPUB format Hymns</a> too!)</li>
<li>Unzip the file on your Desktop - it should create a single <span style="font-weight: bold;">"ministry"</span> folder with subfolders for servants</li>
<li>Attach your Kindle via the supplied USB cable</li>

<li>Drag the <span style="font-weight: bold;">ministry</span> folder that you created and drop it onto the <span style="font-weight: bold;">documents</span> folder on Kindle drive or device (the ministry has to sit underneath the documents folder)</li>
<li>Wait for the files to copy, then disconnect the Kindle</li>
<li>When it powers up, you should see all the ministry!  If not, <a href="mailto:support@goodteaching.org?Subject=Good%20Teaching%20-%20Kindle%20(MOBI)%20-%20Problem">email Support</a>!</li></ol>

<h3><a id="apple"></a>Apple iPad, iPhone or iPod Touch</h3>

<p>The great thing about iTunes is that once you have the Books on your computer, you can sync the whole lot to all three of these devices (if you own more than one) and it actually works pretty well on them all.</p>

<p>Pre-requisite: Download <a href="http://www.apple.com/itunes/download/" target="_blank">iTunes 12</a>.</p>

<p>Now you're ready to download and install the ebooks:</p>
<ol type="1">
<li>Download the <a href="https://www.dropbox.com/s/o5bt0idersubg5t/epub_ministry.zip?dl=0">EPUB format</a> ministry (now available <a href="https://www.dropbox.com/s/6eq86w5z8qk2176/hymns-1962-epub.zip?dl=0">EPUB format Hymns</a> too!)</li>
<li>Unzip the file on your Desktop  - it should create a single "ministry" folder with all the epub files inside</li>
<li>Fire up iTunes</li>
<li>Drag the "ministry" folder onto iTunes (you should see the progress bar at the top as it copies the books)</li>
<li>If you look under "Books" you will see all the ministry &mdash; which you can read within iBooks on the Mac/PC if you wish</li>
<li>Now attach your first device (e.g. iPad or iPhone) and wait for iTunes to recognise it</li>
<li>In the new version of iTunes, your device will appear at the top of the screen, top left, just left of the ellipsis (...) and if you have several devices attached (e.g. over Wifi), the dropdown list will contain each one, just click on the first device</li>
<li>Look down the left Summary, Apps... Books!  Click on <span style="font-weight: bold;">Books</span></li>

<li>Tick <b>Sync Books</b> checkbox and leave &ldquo;All books&rdquo; radio button selected</li>
<li>Click the <span style="font-weight: bold;">Sync</span> button at the bottom and wait!</li>
<li>After sync'ing, go to your device (disconnect if using a cable), push the iBooks app and you should see all the ministry!  If not, <a href="mailto:support@goodteaching.org?Subject=Good%20Teaching%20-%20Apple%20(EPUB)%20-%20Problem">email Support</a>!</li>
<li>(Repeat steps 7 - 12 if you have another Apple device sync'd with iTunes)</li></ol>

<h3><a id="android"></a>Android-based devices</h3>

<ol type="1">
<li>Download the <a href="https://www.dropbox.com/s/o5bt0idersubg5t/epub_ministry.zip?dl=0">EPUB format</a> ministry (now available <a href="https://www.dropbox.com/s/6eq86w5z8qk2176/hymns-1962-epub.zip?dl=0">EPUB format Hymns</a> too!)</li>
<li>Unzip the file on your Desktop &mdash; it should create a single "ministry"</li>
<li>Connect your Android device by USB cable and it will appear as a new drive</li>
<li>Drag the <b>ministry</b> folder from your Desktop to the new drive that appeared</li>
<li>While the files are copying, go to the Play store on your Android device and search for <b>Aldiko</b> (or <a href="https://www.google.co.uk/search?q=ebook+reader+software+for+android&oq=ebook+reader+software+for+android">find your own Android ereader app</a>).</li>
<li>Install Aldiko and Open</li>
<li>Once all the files have copied to the device, you can Import them into Aldiko by clicking on the menu at the top left, select Files</li>
<li>Browse to the ministry folder, then at the top right tap Select All</li>
<li>The menu option changes to Import, tap this</li>
<li>Aldiko will import all the volumes in two or three minutes</li>
</ol>

<h2><a id="faq"></a>Frequently Asked Questions</h2>
<ol type="1">
<li><b>Are the Indexes available as ebooks?</b>
<p>No.  Some of these volumes are still Copyrighted.</p></li>
<li><b>Can I get the Bible for my ereader?</b>
<p>Yes...

<ul>
<li><b>Kindle?</b> Try our new <a href="https://www.dropbox.com/s/82r2sb7qwdd3ip2/Bible_Darby_R04.epub?dl=0">JND Bible for Kindle</a>.
If you have a Paperwhite 2 or newer, Footnotes are not always working correctly... we're working on it.
<li><b>All other devices?</b> &mdash; We would recommend that you download Bible specific software - which works far better as a concordance and reader.  The best Bible software is definitely <a href="http://olivetree.com/bible-study-apps/" target="_blank">Olive Tree</a>, and you can run it on any of the above platforms.  Even better: it's free! (Software and Darby &amp; KJV Bibles)</li>
</ul>
</p></li>

<li><b>How can I relate the page numbers in the ebook to the physical page numbers?</b>
<p>There isn't currently a way of doing this.  I have thought about adding an index page to each volume with the links to the physical page numbers.</p></li>
<li><b>I have found mistakes in the text from the scanning process... how do I let you know?</b>
<p>Simple!  Send an email to <a href="mailto:support@goodteaching.org?Subject=Text%20Mistake%20-%20">support@goodteaching.org</a> and you will receive an automated reply with a ticket number.  Once the mistake has been corrected you will receive a reply.
<ul>
<li><b>Subject</b> &mdash; Please include the volume in the Subject line (e.g. JND V45)</li>
<li><b>Body</b> &mdash; Please re-type a portion of the incorrect text so that we can find it in the volume, and then add the correction.  We will confirm against the original printed volume.</li>
<li>It would be helpful if you would send an individual email for each mistake, even if they are in the same volume.  The automated ticket system assigns each one a number so it's easy to track.</li>
<li>We will release a new &ldquo;build&rdquo; of the ebooks once a year with the corrections.</li>
</ul>
</p></li>
</ol>



<?
include $root.'tpl/bot.php';
?>