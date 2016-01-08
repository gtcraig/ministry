<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * New User Form
 *
 * $Id: user.register.php 485 2007-07-29 19:59:18Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * RWM  08-Jan-2016  508026 : Begin v2 responsive.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<form action="register.php" method="post" name="" id="">
	<div class="card">
		<div class="card-content">
			<div class="input-field">
				<input name="username" type="text" id="username" size=6 class="validate" value="<?php echo $username; ?>" />
				<label for="username">Username <?php echo (!empty($retry) && empty($username)) ? "*" : ""; ?> </label>
			</div>
			<div class="input-field">      
				<input name="first_name" type="text" id="first_name" size=15 value="<?php echo $first_name; ?>" />
				<label for="first_name">First name  <?php echo (!empty($retry) && empty($first_name)) ? "*" : "" ?> </label>
			</div>
			<div class="input-field">
				<input name="last_name" type="text" id="last_name" size=15 value="<?php echo $last_name; ?>" />
				<label for="last_name">Surname <?php echo (!empty($retry) && empty($last_name)) ? "*" : "" ?></label>
			</div>
			<div class="input-field">
				<input name="dob" type="text" id="dob" size=10 onChange="checkDate(this);" value="<?php echo $dob; ?>" />
				<label for="dob">Date of Birth <?php echo (!empty($retry) && empty($dob)) ? "*" : "" ?></label>
			</div>
			<div class="input-field">
				<input name="email_address" type="text" id="email_address" size=30 value="<?php echo $email_address; ?>" />
				<label for="email_address">Email Address <?php echo (!empty($retry) && empty($email_address)) ? "*" : "" ?></label>
			</div>
			<div class="input-field">
				<input name="password1" type="password" id="password1" size=12 />
				<label for="password">Password <?php echo (!empty($retry) && empty($password1)) ? "*" : "" ?></label>
			</div>
			<div class="input-field">
				<input name="password2" type="password" id="password2" size=12 />
				<label for="password2"> Re-enter password <?php echo (!empty($retry) && empty($password2)) ? "*" : "" ?> </label>
			</div>
		</div>
		<div class="card-action">
			<input name="retry" type="hidden" id="retry" value="1">
			<input class="btn-large waves-effect red" type="submit" value="Register">
		</div>
	</div>
</form>
