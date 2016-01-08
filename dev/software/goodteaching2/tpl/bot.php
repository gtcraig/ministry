<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2015 frontburner.co.uk
 *
 * Bottom of the page
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Always include books form.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  12-Nov-2007  10204 : Version V0.05A.
 * CAM  18-Nov-2007  10205 : Version V0.06A.
 * CAM  24-Nov-2007  10213 : Version V0.06A.
 * CAM  29-Dec-2007  10211 : Version V0.07A.
 * CAM  02-Jan-2008  10206 : Version V0.08A.
 * CAM  18-May-2008  10267 : Version V0.09A.
 * CAM  04-Jun-2008  10268 : Version V0.10A.
 * CAM  15-Jun-2008  10272 : Version V0.11A.
 * CAM  18-Jun-2008  10274 : Version V0.12A.
 * CAM  28-Mar-2009  10412 : Version V0.0.13.
 * CAM  29-Dec-2009  10519 : Version V0.0.14.
 * CAM  30-Dec-2009  10523 : Version V0.0.15.
 * CAM  05-Sep-2015  159308 : Version V0.0.16. Moved form to scriptures page.
 * RWM  22-Dec-2015  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>
  </div>
</main>
<!--end container/main-->
<!--ftr-->

<?php

if ($cfg['Site']['Scheme']['Footer']['Compact']) {

?>

<footer class="page-footer <?php echo $cfg['Site']['Scheme']['Footer']['Class']; ?>">
	<div class="container">
		<div class="row">
			<div class="col s12 m6 <?php echo $cfg['Site']['Scheme']['Footer']['Text']['Class']; ?>">
				<p class="center-on-small-otherwise-left-align">
					<a class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>" href="<?php echo $root; ?>releases.php"><?php echo $cfg['Site']['Version']; ?> :: </a> 
					<a class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>" href="//www.frontburner.co.uk">
						<span class="hide-on-small-and-down">System designed and maintained </span>by frontburner.co.uk
					</a>
				</p>
			</div>
			<div class="col s12 m6 <?php echo $cfg['Site']['Scheme']['Footer']['Text']['Class']; ?>">
				<p class="center-on-small-otherwise-right-align">
<?php
	if ($loggedin) {
?>
						<a href="<? echo $root; ?>logout.php" class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">logout 
					<?php
						echo "Logged in as <strong>" . $member->getFullname() . "</strong>";
						if ($member->isAdmin()) {
							echo " (Admin)";
						}
					?>
						</a>
<?php
	} else {
?>
					<a href="<? echo $root; ?>login.php" class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">login</a>
					&nbsp;|&nbsp;
					<a href="<? echo $root; ?>register.php" class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">register</a>
<?php
	}
?>
					&nbsp;|&nbsp;
					<a href="<? echo $root; ?>help.php" class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">help</a>
				</p>
			</div>
		</div>
	</div>
</footer>

<?php


} else {
?>

<footer class="page-footer <?php echo $cfg['Site']['Scheme']['Footer']['Class']; ?>">
	<div class="container">
		<div class="row">
			<div class="col s12 m6 <?php echo $cfg['Site']['Scheme']['Footer']['Text']['Class']; ?>">
				<p><a href="<?php echo $cfg['Site']['URL']; ?>" class="<?php echo $cfg['Site']['Scheme']['Footer']['Text']['Class']; ?>"><?php echo $cfg['Site']['Name']; ?></a></p>
				<small>
					<blockquote>
						Laying these things before the brethren, thou wilt be a good minister of Christ Jesus, 
						nourished with the words of the faith and of the good teaching which thou hast fully followed up. 
						1 Timothy 4:6
					</blockquote>
				</small>
			</div>
			<div class="col s12 m6 <?php echo $cfg['Site']['Scheme']['Footer']['Text']['Class']; ?>">
				<ul class="pagination center-on-small-otherwise-right-align">
					
<?php
	if ($loggedin) {
?>
					<li><a href="<? echo $root; ?>logout.php" class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">logout</a></li>
<?php
	} else {
?>
					<li><a href="<? echo $root; ?>login.php" class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">login</a></li>
					<li>|</li>
					<li><a href="<? echo $root; ?>register.php" class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">register</a></li>
<?php
	}
?>
					<li>|</li>
					<li><a href="<? echo $root; ?>help.php" class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">help</a></li>
				</ul>
				<p class="center-on-small-otherwise-right-align">
					<?php
						if ($loggedin) {
							echo "Logged in as <strong>" . $member->getFullname() . "</strong>";
							if ($member->isAdmin()) {
								echo " (Admin)";
							}
						} else {
							echo "&nbsp;";
						}
					?>
				</p>
			</div>
		</div>
	</div>
	<div class="footer-copyright">
		<div class="container">
			<div class="center <?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>">
				<a class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>" href="<?php echo $root; ?>releases.php"><?php echo $cfg['Site']['Version']; ?> :: </a> 
				<a class="<?php echo $cfg['Site']['Scheme']['FooterCopyright']['Text']['Class']; ?>" href="//www.frontburner.co.uk">
					<span class="hide-on-small-and-down">System designed and maintained </span>by frontburner.co.uk
				</a>
			</div>
		</div>
	</div>
</footer>
<?php
}
?>

<?php /* javascript includes */ ?>
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="<?php echo $root;?>js/materialize.js"></script>
  <script src="<?php echo $root;?>js/gtsite.js"></script>

<?php /* 
<!-- may/not need these-->
<!-- disabled for the moment
  <script language="Javascript" src="<?php echo $root;?>date.js"></script>
  <script language="Javascript" src="<?php echo $root;?>form.js"></script>
-->
*/ ?>

</body>
</html>

