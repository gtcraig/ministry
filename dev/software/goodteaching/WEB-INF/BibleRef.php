<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * $Id: BibleRef.php 561 2007-10-25 14:08:15Z craig $
 *
 * Who  When         Why
 * CAM  25-Oct-2007  10187 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

class BibleRef {

  var $bibleBook;
  var $ref=0;
  var $chapter=0;
  var $vStart=0;
  var $vEnd=0;

  function BibleRef($bibleBook, $ref, $chapter, $vStart, $vEnd) {
    $this->bibleBook = $bibleBook;
    $this->ref = $ref;
    $this->chapter = $chapter;
    $this->vStart = $vStart;
    $this->vEnd = $vEnd;
  }

  function getBibleBook() {
    return $this->bibleBook;
  }
  function getRef() {
    return $this->ref;
  }
  function getChapter() {
    return $this->chapter;
  }
  function getVerseStart() {
    return $this->vStart;
  }
  function getVerseEnd() {
    return $this->vEnd;
  }

  function toHtmlString() {
    $html = "<b>" . $this->bibleBook->getBookName() . "</b>&nbsp;";

    if (!$this->bibleBook->isSingleChap()) {
      $html .= " " . $this->chapter;
    }

    if ($this->vStart > 0) {
      $html .= ":" . $this->vStart;
    }
    if ($this->vEnd > 0) {
      $sep = "-";
      if (($this->vEnd - $this->vStart) == 1) $sep = ",";

      $html .= $sep . $this->vEnd;
    }

    return $html;
  }
}

class BibleRefCollection {

  var $refs;

  function BibleRefCollection($sqlFactory, $author, $vol, $page, $para, $bookid, $chapter) {
    $this->refs = array();

    $sql = $sqlFactory->getBibleRefSql($author, $vol, $page, $para, $bookid, $chapter);

    $ssql = mysql_query($sql) or die(mysql_error());
    if ($row = mysql_fetch_array($ssql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $bibleBook = new BibleBook($bookid, $bookname, $singlechap);
      $bibleRef = new BibleRef($bibleBook, $ref, $chapter, $vstart, $vend);
      $this->refs[count($this->refs)] = $bibleRef;
    }
  }

  function Count() {
    return count($this->refs);
  }

  function Ref($i) {
    return $this->refs[$i];
  }
}

?>