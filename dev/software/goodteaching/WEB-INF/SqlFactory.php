<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007,2015 frontburner.co.uk
 *
 * SqlFactory Class
 *
 * Who  When         Why
 * CAM  15-Oct-2007  File created.
 * CAM  15-Oct-2007  10187 : Added Book Reference search, improved tests for valid search and included all functions.
 * CAM  25-Oct-2007  10187 : Correctly return references when Scripture searching.
 * CAM  08-Nov-2007  10200 : Added ability to Count and Limit results.
 * CAM  29-Dec-2007  10211 : Added getAtoms.
 * CAM  28-Mar-2009  10407 : Added Search Type.
 * CAM  05-Sep-2015  159308 : Accept new primary flag and include article title in results.
 * CAM  04-Dec-2015  863707 : Greatly simplified searching using BOOLEAN MODE.
 * CAM  24-May-2020  481548 : Ensure proper checks for authors array before using as such.
 * * * * * * * * * * * * * * * * * * * * * * * */

class SqlFactory {

  var $tableName = "";
  var $fieldList = "";
  var $orderBy = "";
  var $connection;

  var $searchText = "";
  var $searchType = "ALL";
  var $fulltextKey = "";
  var $atoms;

  var $authors;

  var $bookId;
  var $chapter;
  var $vStart;
  var $vEnd;

  var $primary;

  var $whereConjunct;

  var $maxRows;
  var $pageNo;

  // ----- Constructors --------------------------------------------------- //

  function __construct($tableName='', $fieldList='') {
    $this->tableName = $tableName;
    $this->fieldList = $fieldList;
    $this->orderBy = "author, vol, page";

    $this->maxRows = 0;
  }


  // ----- Public Methods ------------------------------------------------- //

  function setSearchText($text="") {
    $this->searchText = trim(str_replace("  ", " ", $text));
  }

  function setSearchType($searchType="") {
    $this->searchType = trim($searchType);
  }

  function setAuthors($authors) {
    $this->authors = $authors;
  }

  function setBookRef($bookid, $primary, $chapter, $vStart) {
    $this->bookId = $bookid;
    $this->primary = $primary;
    $this->chapter = $chapter;
    $this->vStart = $vStart;
  }

  function setLimit($maxRows, $pageNo) {
    $this->maxRows = $maxRows;
    $this->pageNo = $pageNo;
  }

  function isSearchText() {
    return (!empty($this->searchText));
  }

  function isPrimary() {
    return $this->primary;
  }

  function isAuthorFilter() {
    if (!is_array($this->authors)) return false;
    return (count($this->authors) > 0);
  }

  function isBookRef() {
    return (!empty($this->bookId) && (!empty($this->chapter) || !empty($this->vStart)));
  }

  function isShowBookRef() {
    return ($this->isBookRef() && !$this->isSearchText());
  }

  function isSearch() {
    return ($this->isSearchText() || $this->isBookRef());
  }

  function getSelect() {
    // SELECTION
    $sql = $this->fieldList . ",\n";

    if (!$this->isSearchText() || $this->searchType == "PHRASE") {
      // No Search Text - add dummy relevance
      $sql .= "1";
    } else {
      // Add Search Relevance
      $sql .= $this->fullTextSearch();
    }

    $sql .= " as relevance, ";

    if ($this->isBookRef()) {
      $sql .= "b.bookname, b.singlechap, r.ref, r.vstart, r.vend, a.article \n" ;
    } else {
      $sql .= "'' as bookname, 0 as singlechap, 0 as ref, 0 as vstart, 0 as vend, '' as article \n" ;
    }

    return $sql;
  }

  function getSql($countOnly=false) {
    $this->whereConjunct = "WHERE";

    $sql = "SELECT ";

    if ($countOnly) {
      $sql .= "COUNT(*) row_count ";
    } else {
      $sql .= $this->getSelect();
    }

    // TABLES
    $sql .= "FROM " . $this->tableName . " t ";

    if ($this->isBookRef()) {
      $sql .= ", mse_bible_ref r, mse_bible_book b, mse_article a " ;
    }
    $sql .= "\n";

    // WHERE
    if ($this->isSearchText()) {
      $sql .= $this->whereClause($this->fullTextSearch());
    }

    if ($this->isBookRef()) {
      $sql .= $this->whereClause(
        "r.bookid = b.bookid \n".
        "AND r.author = t.author \n".
        "AND r.vol = t.vol \n".
        "AND r.page = t.page \n".
        "AND r.para = t.para \n".
        "AND a.author = r.author \n".
        "AND a.vol = r.vol \n".
        "AND a.page = r.article_page \n".
        "AND r.bookid = " . $this->bookId . "\n".
        "AND r.chapter = " . $this->chapter . "\n");

      if ($this->vStart > 0) {
        $sql .= "AND r.vstart = " . $this->vStart . "\n";
      }

      if ($this->primary == 1) {
        $sql .= "AND r.article_primary = 1\n";
      }
    }

    if ($this->isAuthorFilter() && is_array($this->authors)) {
      $sql .= $this->whereClause("t.author IN ('" . implode("','", $this->authors) . "')");
    }

    if (!$countOnly) {
      $sql .= "ORDER BY relevance DESC, " . $this->orderBy . "\n";

      if ($this->maxRows > 0) {
        $sql .= "LIMIT ". (($this->pageNo-1)*$this->maxRows) . "," . $this->maxRows . "\n";
      }
    }
    return $sql;
  }

  function fullTextSearch() {
    $rval = " MATCH (text) AGAINST ('";

    if ($this->searchType == "PHRASE") {
      $rval .= "\"" . $this->searchText . "\"";
    } else {
      $rval .= $this->searchText;
    }

    $rval .= "' IN BOOLEAN MODE) ";

    return $rval;
  }

  function getAtoms() {
    if (!isset($this->atoms)) {
			$this->atoms = explode(' ', trim($this->searchText));

			// Remove any NOT atoms
			for($i=count($this->atoms)-1; $i>=0; $i--) {
			  $fc = substr($this->atoms[$i],0,1);

				if (($fc == '-') || ($fc == '~')) {
				  unset($this->atoms[$i]);
				} else if (($fc == '+')) {
				  $this->atoms[$i] = substr($this->atoms[$i],1);
				}

			}
			$this->atoms = array_merge($this->atoms);
    }

    return $this->atoms;
  }

   public static function removeOperators($search_text) {
    $atoms = explode(' ', trim($search_text));
    for($i=count($atoms)-1; $i>=0; $i--) {
      $fc = substr($atoms[$i],0,1);
      if (($fc == '-') || ($fc == '+') || ($fc == '~')) {
        $atoms[$i] = substr($atoms[$i],1);
      }
    }
    return implode(' ', $atoms);
  }

   public static function addAndOperators($search_text) {
    $atoms = explode(' ', trim($search_text));
    for($i=count($atoms)-1; $i>=0; $i--) {
      $fc = substr($atoms[$i],0,1);
      if (($fc == '-') || ($fc == '+') || ($fc == '~')) {
        $atoms[$i] = substr($atoms[$i],1);
      }
      $atoms[$i] = '+' . $atoms[$i];
    }
    return implode(' ', $atoms);
  }
 
  function whereClause($sql) {
    $sql = $this->whereConjunct . " $sql\n";

    $this->whereConjunct = "AND";

    return $sql;
  }
}
?>