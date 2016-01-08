<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Tuple Class
 *
 * $Id: Tuple.php 485 2007-07-29 19:59:18Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

/**
* Implementation of an ID, Description pair
*
* @author Craig McKay
* @version 2004
* @public
*/
class Tuple {

  // ----- Instance Variables --------------------------------------------- //

  /**
  * The ID.
  * @private
  * @type Object
  */
  var $id = NULL;


  /**
  * The Description.
  * @private
  * @type String
  */
  var $desc = NULL;


  // ----- Properties ----------------------------------------------------- //

  /**
  * Set the ID.
  *
  * @public
  * @returns Object
  */
  function setID($id) {
    $this->id = $id;
  }

  /**
  * Return the ID.
  *
  * @public
  * @returns
  */
  function getID() {
    return $this->id;
  }


  /**
  * Set the Description.
  *
  * @public
  * @returns
  */
  function setDesc($desc) {
    $this->desc = $desc;
  }

  /**
  * Return the ID.
  *
  * @public
  * @returns String
  */
  function getDesc() {
    return $this->desc;
  }


  // ----- Constructors --------------------------------------------------- //

  /**
  * Construct a new Tuple.
  *
  * @param Object The ID.
  * @param String The Description.
  *
  * @public
  * @returns
  */
  function Tuple($id='', $desc='') {
    $this->id = $id;
    $this->desc = $desc;
  }


  // ----- Public Methods ------------------------------------------------- //

  /**
  * Format this Tuple as an HTML String.
  *
  * @param boolean Show ID
  *
  * @public
  * @returns String
  */
  function toHtmlString($showID=false) {
    $rval = "<b>" . $this->desc . "</b>";

    if ($showID) $rval .= " (<b>" . $this->id . "</b>)";

    return $rval;
  }

  /**
  * Format this Tuple as an HTML String.
  *
  * @param boolean Show ID
  *
  * @public
  * @returns String
  */
  function toString($showID=false) {
    $rval = $this->desc;

    if ($showID) $rval .= " (" . $this->id . ")";

    return $rval;
  }
}
?>