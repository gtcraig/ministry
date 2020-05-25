<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Person Class
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

/**
* A Person - ID, First and Last names.
*
* @author Craig McKay
* @version 2004
* @public
*/
class Person extends Tuple {

  // ----- Instance Variables --------------------------------------------- //

  /**
  * Person's first name.
  * @private
  * @type String
  */
  var $firstname = NULL;

  /**
  * Person's last name.
  * @private
  * @type String
  */
  var $lastname = NULL;

  /**
  * Person's email.
  * @private
  * @type String
  */
  var $email = NULL;

  /**
  * Person's Date of Birth.
  * @private
  * @type String
  */
  var $dob = NULL;

  /**
  * Is this Person an Administrator?
  * @private
  * @type boolean
  */
  var $admin = NULL;

  /**
  * Membership Type
  * @private
  * @type Tuple
  */
  var $membertype = NULL;

  /**
  * Email Verification code
  * @private
  * @type String
  */
  var $verify_code = NULL;

  // ----- Properties ----------------------------------------------------- //

  /**
  * Set the ID.
  *
  * @public
  * @returns Object
  */
  function setFirstname($firstname) {
    $this->firstname = $firstname;
  }

  /**
  * Return the ID.
  *
  * @public
  * @returns
  */
  function getFirstname() {
    return $this->firstname;
  }


  /**
  * Set the Description.
  *
  * @public
  * @returns
  */
  function setLastname($lastname) {
    $this->lastname = $lastname;
  }

  /**
  * Return the ID.
  *
  * @public
  * @returns String
  */
  function getLastname() {
    return $this->lastname;
  }


  /**
  * Set the Email.
  *
  * @public
  * @returns
  */
  function setEmail($email) {
    $this->email = $email;
  }

  /**
  * Return the Email.
  *
  * @public
  * @returns String
  */
  function getEmail() {
    return $this->email;
  }


  /**
  * Set the Admin flag.
  *
  * @public
  * @returns
  */
  function setAdmin($admin) {
    $this->admin = $admin;
  }

  /**
  * Return the Admin flag.
  *
  * @public
  * @returns String
  */
  function isAdmin() {
    return $this->admin;
  }

  /**
  * Set the Membership Type.
  *
  * @public
  * @returns
  */
  function setMembershipType($membertype) {
    $this->membertype = $membertype;
  }

  /**
  * Return the Membership Type.
  *
  * @public
  * @returns Tuple
  */
  function getMembershipType() {
    return $this->membertype;
  }

  // ----- Constructors --------------------------------------------------- //

  /**
  * Construct a new Person.
  *
  * @param Object The ID.
  * @param String The Description.
  *
  * @public
  * @returns
  */
  function Person($id='', $firstname='', $lastname='', $email='', $dob='', $admin=false, $membertype='', $verify_code='') {
    $this->id = $id;
    $this->desc = $firstname . " " . $lastname;
    $this->firstname = $firstname;
    $this->lastname = $lastname;
    $this->email = $email;
    $this->dob = $dob;
    $this->admin = $admin;
    $this->membertype = $membertype;
  }

  function getPerson($memberid) {
    $per = mysqli_query($dbConn, "SELECT m.*, mt.type_name ".
                       "FROM member m, member_type mt ".
                       "WHERE m.member_type = mt.member_type ".
                       "AND m.memberid='$memberid'");
    if ($row = mysqli_fetch_array($per)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $mt = new Tuple($member_type, $type_name);

      return new Person($memberid,$first_name,$last_name,$email_address,$dob,$admin,$mt,$verify_code);
    }
  }

  function getFullname() {
    return $this->firstname . " " . $this->lastname;
  }

  function toHtmlString($showID=false) {
    $rval = parent::toHtmlString($showID);

    $rval = $this->membertype->getDesc() . " " . $rval;

    return $rval;
  }

  /**
  * Return true if the Email Verification code supplied matches the user's.
  *
  * @public
  * @returns boolean
  */
  function isVerifyCodeMatch($verify_code) {
    return $this->verify_code == $verify_code;
  }
}
?>