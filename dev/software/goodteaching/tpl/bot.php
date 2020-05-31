<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
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
 * CAM  12-Dec-2015  476204 : Lookup latest version from the database, and reference support email rather than frontburner.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * CAM  30-May-2020  909743 : Updated table structure of page.
 * * * * * * * * * * * * * * * * * * * * * * * */

 $releaseNo = "";
 $releaseDate = "";
 $sql = "SELECT release_no, DATE_FORMAT(completion_date, '%e %b %Y') ".
        "FROM mse_release_history ".
        "WHERE completion_date = ( ".
          "SELECT MAX(completion_date) ".
          "FROM mse_release_history)";
   $ssql = mysqli_query($dbConn, $sql) or die(mysql_error());
  if ($row = mysqli_fetch_array($ssql)) {
    $releaseNo = $row[0];
    $releaseDate = $row[1];
  }
 

?>
</td></tr>
<tr><td class="cpyrght" colspan="3"><a href="<? echo $root; ?>releases.php">V<?=$releaseNo?></a> released <?=$releaseDate?>.  For help, contact <a href="mailto:support@goodteaching.org">Support</a></td></tr>
</td></tr>
</table>
</body>
</html>

