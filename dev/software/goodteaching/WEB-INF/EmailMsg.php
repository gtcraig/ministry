<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * EmailMsg - Sends an Email
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  18-Nov-2007  10205 : Added sendNewQuery - will need attention for 10207.
 * CAM  29-Sep-2008  10302 : Added root.
 * CAM  01-Nov-2014  576402 : Changed sendNewQuery recipient.
 * CAM  06-Nov-2014  823080 : Removed deprecated functions.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once $root.'Main.php';

require_once($root."ip/ip.codehelper.io.php");
require_once($root."ip/php_fast_cache.php");

/**
* EmailMsg information.
*
* @author Craig McKay
* @version 2005
* @public
*/
class EmailMsg {

  /**
  * Email Type (Notification or Reminder).
  * @private
  * @type String
  */
  var $emailType;

  /**
  * Description of Email Type (Notification or Reminder).
  * @private
  * @type String
  */
  var $typeDesc;

  /**
  * Originator Member
  * @private
  * @type Person
  */
  var $memPerson;

  var $_visitor_location;

  function __construct() {
  }

  function getHeaders($cc='') {
    global $cfg;

    $cr = "\r\n";
    $headers = "From: " . $cfg['Site']['Name'] . "<" . $cfg['Site']['Email'] . ">$cr";
    if (!empty($cc)) $headers .= "Cc: $cc$cr";
    $headers .= "MIME-Version: 1.0$cr";
    //$headers .= "X-Priority: 1$cr";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1$cr";
    return $headers;
  }

  function getHTMLStart($subject) {
    global $cfg;

    $cr = "\r\n";
    return "<html><head>".
          "<link href=" . $cfg['Site']['URL'] . "/mse.css rel=stylesheet type=text/css>".
          "</head><body>".
          "<table cellspacing=0 cellpadding=0 border=0 width=\"100%\">".
            "<tr><td valign=center align=center><table cellspacing=5 cellpadding=0 border=0>".
              "<tr>".
                "<td colspan=2 align=center><b>$subject</b></td>$cr$cr".
              "</tr><tr>".
                "<td><table width=\"100%\" border=0 cellpadding=2>";
  }

  function getHTMLEnd() {
    $cr = "\r\n";
    return "</table></td>".
        "</tr></table>".
      "</td></tr>".
    "</table>$cr".
    "</body></html>$cr";
  }

  function sendVerify($verify_code) {
    global $cfg;

    $to = $this->memPerson->getEmail();
    $cc = $cfg['Site']['Email'];
    $subject = "Email Verification";
    $cr = "\r\n";

    $url = $cfg['Site']['URL'] . "/verifyemail.php?username=" . $this->memPerson->getID() .
           "&code=$verify_code";

    $message = $this->getHTMLStart($subject);
    $message .= "<tr><td>Hi " . $this->memPerson->getFirstname() . ",<br><br>$cr$cr".
            "Thank you for registering with " . $cfg['Site']['Name'] . ".$cr".
            "Please verify your email address by clicking on the link below:<br>$cr".
            "<a href=\"$url\">$url</a>$cr".
            "</td></tr>$cr";
    $message .= $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders($cc));
  }

  function sendForgot($new_pwd) {
    global $cfg;

    $to = $this->memPerson->getEmail();
    $subject = "Your " . $cfg['Site']['Name'] . " password for $memberid";
    $cr = "\r\n";

    $url = $cfg['Site']['URL'] . "/login.php";

    $message = $this->getHTMLStart($subject);
    $message .= "<tr><td>Hi " . $this->memPerson->getFirstname() . ",<br>$cr".
            "We have reset your password to: $new_pwd.$cr".
            "Please use the link below to login:<br>$cr".
            "<a href=\"$url\">$url</a><br>$cr".
            "Thanks!<br>$cr".
            $cfg['Site']['Name'] . "<br>$cr".
            "</td></tr>$cr";
    $message .= $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders());
  }

  function AddServerVar($var){
    return "<tr><td><b>$var</b></td><td>". $_SERVER[$var] . "</td></tr>";
  }

  function sendNewQuery($query) {
    global $cfg;

	$_ip = new ip_codehelper();
	$ipaddr = $_ip->getRealIP();
	$this->_visitor_location = $_ip->getLocation($ipaddr);

    $to = $cfg['Site']['Admin']['Email'];
    $subject = $cfg['Site']['Name'] . " Query";
    $cr = "\r\n";

    $message =
      $this->getHTMLStart($subject) .
      "<tr><td><p>Hi ". $cfg['Site']['Admin']['Name'] . ",</p><p>The following new query has just been executed:</p>".
      "<p><ul>".
      "<li>Query &mdash; <b>". str_replace("|", "&nbsp;&nbsp;", $query) . "</b></li>".
      "<li>IP Address &mdash; <b>". $ipaddr . "</b></li>".
      "<li>Country &mdash; <b>". $this->_visitor_location['Country'] . "</b></li>";
    if (!empty($this->_visitor_location['City'])) {
      $message .= "<li>City &mdash; <b>". $this->_visitor_location['City'] . "</b></li>";
    }
    $message .= "<li>Browser &mdash; <b>". $_SERVER['HTTP_USER_AGENT'] . "</b></li>".
      "</ul></p>".
      $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders());
  }
}
?>