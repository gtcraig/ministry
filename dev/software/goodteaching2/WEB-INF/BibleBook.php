<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * $Id: BibleBook.php 561 2007-10-25 14:08:15Z craig $
 *
 * Who  When         Why
 * CAM  15-Oct-2007  10187 : File created.
 * CAM  25-Oct-2007  10187 : Allow construction with all parameters passed in.
 * * * * * * * * * * * * * * * * * * * * * * * */

class BibleBook {

  var $bookId = 0;
  var $bookName = "";
  var $singleChap = false;

  function BibleBook($bookid, $bookName='', $singleChap=0) {
    $this->bookId = $bookid;

    if (empty($bookName)) {
      $sql = "SELECT bookname,singlechap FROM mse_bible_book WHERE bookid = '$bookid' ";
          $ssql = mysql_query($sql);
          if ($row = mysql_fetch_array($ssql)) {
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