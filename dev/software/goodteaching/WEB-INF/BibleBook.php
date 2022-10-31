<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2020 frontburner.co.uk
 *
 * Who  When         Why
 * CAM  15-Oct-2007  10187 : File created.
 * CAM  25-Oct-2007  10187 : Allow construction with all parameters passed in.
 * CAM  24-May-2020  481548 : Replace deprecated ext/mysql calls with MySQLi.
 * * * * * * * * * * * * * * * * * * * * * * * */

class BibleBook {

  var $bookId = 0;
  var $bookName = "";
  var $singleChap = false;

  function __construct($dbConn, $bookid, $bookName='', $singleChap=0) {
    $this->bookId = $bookid;

    if (empty($bookName)) {
      $sql = "SELECT bookname,singlechap FROM mse_bible_book WHERE bookid = '$bookid' ";
          $ssql = mysqli_query($dbConn, $sql);
          if ($row = mysqli_fetch_array($ssql)) {
            $this->bookName = $row[0];
            $this->singleChap = ($row[1] == 1);
      }
    } else {
      $this->bookName = $bookName;
      $this->singleChap = ($singleChap==1);
    }
  }

  function getBookId() {
    return $this->bookId;
  }
  function getBookName() {
    return $this->bookName;
  }
  function isSingleChap() {
    return $this->singleChap;
  }
}

?>