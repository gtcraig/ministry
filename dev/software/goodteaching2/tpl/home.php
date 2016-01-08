<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Home page
 *
 * $Id: home.php 485 2007-07-29 19:59:18Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * RWM  01-Jan-2016  508026 : Begin v2 responsive.
 * RWM  08-Jan-2016  508026 : Redirects to index.php after 5s.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>


<a href="<?php echo $root; ?>index.php">Click here to go to the Home page...</a>

<script>
    window.setTimeout(function () {
        location.href = "<?php echo $root; ?>index.php";
    }, 5000);
</script>