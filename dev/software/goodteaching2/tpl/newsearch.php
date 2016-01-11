<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching
 * Copyright (c) 2012 Front Burner
 *
 * New Search Wizard
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Jul-2012  11129 : Updated goodteaching.org/ebook for Kindle Touch.
 * CAM  20-Oct-2012  11143 : Updated goodteaching.org/ebook for Kindle Paperwhite and Fire.
 * RWM  01-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<div class="row card-panel hoverable">
	<div class="col s12">
		<h5>
<?php
	$q = "What would you like to do";

	if ($loggedin) {
		$q .= ", " . $member->getFirstname();
	}

	Msg::question($q);

?>
		</h5>
		<ul class="collection">
			<li class="collection-item avatar">
				<a href="keyword.php">
					<i class="material-icons circle red">&#xE0DA;</i>
					<span class="title">Keyword</span>
					<p class="black-text">
						Interested in ministry relating to one or more specific words?
					</p>
				</a>
			</li>
			<li class="collection-item avatar">
				<a href="scripture.php">
					<i class="material-icons circle orange">&#xe02F;</i>
					<span class="title">Scripture</span>
					<p class="black-text">
						Looking for ministry on a particular passage of Scripture?
					</p>
				</a>
			</li>
			<li class="collection-item avatar">
				<a href="servant.php">
					<i class="material-icons circle green">&#xE7FD;</i>
					<span class="title">Servant</span>
					<p class="black-text">
						Looking for ministry by a particular servant?
					</p>
				</a>
			</li>
			<li class="collection-item avatar">
				<a href="volumes.php">
					<i class="material-icons circle blue">&#xE8EF;</i>
					<span class="title">Volume Titles</span>
					<p class="black-text">
						Looking for a list of Volume Titles (e.g. what does 'JND Volume 45' mean?)
					</p>
				</a>
			</li>
			<li class="collection-item avatar">
				<a href="ebook/">
					<i class="material-icons circle purple">&#xE331;</i>
					<span class="title">Ebooks</span>
					<p class="black-text">
						Want to read the ministry on your e-reader, tablet or mobile? <br />
						<span class="grey-text hide-on-small-only">Ebook versions for Apple, Kindle and Android are available for downloading,
							with instructions on how to install them. <br />
							There are some helpful pointers too, if you are in the valley of decision!
						</span>
					</p>
				</a>
			</li>
			<li class="collection-item avatar">
				<a href="ebook/index.html#faq">
					<i class="material-icons circle blue-grey">&#xE887;</i>
					<span class="title">Help</span>
					<p class="black-text">
						Answers to some frequently asked questions.
					</p>
				</a>
			</li>
		</ul>
	</div>
</div>

