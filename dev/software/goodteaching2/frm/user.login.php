<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Login form
 *
 * $Id: user.login.php 894 2008-09-29 21:22:54Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  29-Sep-2008  10302 : Added root.
 * RWM  07-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */

//include_once $root.'Main.php';

$retry = NULL;        if (!empty($_POST['retry'])) $retry = $_POST['retry'];
//$memberid = NULL;     if (!empty($_POST['memberid'])) $retry = $_POST['memberid'];


if ($retry == NULL && !isset($_REQUEST['logmeout'])) {
  Msg::error("New user?  Please register.");
} else if ($memberid == NULL && !isset($_REQUEST['logmeout'])) {
  Msg::error("Please enter your Username!");
}

?>


<div class="card-panel">

	<form action="login.php" method="post" name="" id="login">
		<div class="row">
			<div class="col s10 input-field">
				<input name="memberid" type="text" id="memberid" autofocus="autofocus" tabindex="1" value="<? echo $memberid; ?>" />
				<label for="memberid">Username</label>
			</div>
		</div>
		<div class="row">
			<div class="col s10 input-field">
				<input name="password" type="password" tabindex="2" id="password" />
				<label for="password">Password</label>
			</div>
			<div class="col s2">
				<?php echo ActionUtil::goButton('Login',3); ?>
				<input type="hidden" name="retry" value="1"></td>
			</div>
		</div>
		<div class="row">
			<div class="col s12 right input-field">
				<a href="javascript:login.action='forgot.php';login.submit();">Forgotten Password?</a>
			</div>
		</div>
	</form>
</div>
