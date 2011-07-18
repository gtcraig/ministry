<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Action Utilities
 *
 * $Id: ActionUtil.php 582 2007-11-12 19:15:02Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : More useful Submit button (note - not called on pressing Enter).
 * CAM  12-Nov-2007  10203 : Fixed onclick bug.
 * * * * * * * * * * * * * * * * * * * * * * * */

/**
* A utility class for Actions
*
* @author Craig McKay
* @version 2004
* @public
*/
class ActionUtil {

  /**
  * Return the Action name for a code.
  *
  * @public
  * @returns String
  */
  function getDesc($action) {
    if ($action == 'C') return "Confirm";
    if ($action == 'X') return "Cancel";
  }

  /**
  * Return the URL for an Action
  *
  * @public
  * @returns String
  */
  function url($action, $proceed='') {
    $rval = "action.php?action=$action";

    if (!empty($proceed)) {
      $rval .= "&proceed=1";
    }

    return $rval;
  }

  /**
  * Return the HTML for an Action Button
  *
  * @public
  * @returns String
  */
  function linkButton($action, $buttonText, $className='button', $hoverClass='') {

    $hover = "";

    if (!empty($hoverClass)) {
      $hover = " onmouseover=\"this.className='$hoverClass';\" onmouseout=\"this.className='$className'\" ";
    }

    $rval = "<input class=\"$className\" type=\"submit\" $hover onclick=\"top.location.href='$action';return false;\" value=\"". $buttonText . "\">";

    return $rval;
  }

  /**
  * Return the HTML for a Submit Button
  *
  * @public
  * @returns String
  */
  function submitButton($buttonText, $className='button', $hoverClassName='buttonhover', $action='submit') {
    $button = "<input class=\"$className\" onmouseover=\"this.className='$hoverClassName';\" onmouseout=\"this.className='$className'\" value=\"". $buttonText . "\"";

    if ($action == 'submit') {
      $button .= " type=\"submit\">";
    } else {
      $button .= " type=\"button\" onClick=\"$action\">";
    }

    return $button;
  }
}
?>