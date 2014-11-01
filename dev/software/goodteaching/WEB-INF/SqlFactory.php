<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007,2009 frontburner.co.uk
 *
 * SqlFactory Class
 *
 * $Id: SqlFactory.php 933 2009-03-28 14:04:28Z craig $
 *
 * Who  When         Why
 * CAM  15-Oct-2007  File created.
 * CAM  15-Oct-2007  10187 : Added Book Reference search, improved tests for valid search and included all functions.
 * CAM  25-Oct-2007  10187 : Correctly return references when Scripture searching.
 * CAM  08-Nov-2007  10200 : Added ability to Count and Limit results.
 * CAM  29-Dec-2007  10211 : Added getAtoms.
 * CAM  28-Mar-2009  10407 : Added Search Type.
 * * * * * * * * * * * * * * * * * * * * * * * */

class SqlFactory {

  var $tableName = "";
  var $fieldList = "";
  var $orderBy = "";
  var $connection;

  var $searchText = "";
  var $searchType = "WORDS";
  var $fulltextKey = "";
  var $atoms;

  var $authors;

  var $bookId;
  var $chapter;
  var $vStart;
  var $vEnd;

  var $whereConjunct;

  var $maxRows;
  var $pageNo;

  // ----- Constructors --------------------------------------------------- //

  function SqlFactory($tableName='', $fieldList='', $orderBy='') {
    $this->tableName = $tableName;
    $this->fieldList = $fieldList;
    $this->orderBy = $orderBy;

    $this->maxRows = 0;

    if (!empty($tableName)) $this->deriveFulltextKey();
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

  function setBookRef($bookid, $chapter, $vStart) {
    $this->bookId = $bookid;
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

  function isAuthorFilter() {
    return (count($this->authors) > 0);
  }

  function isBookRef() {
    return (!empty($this->bookId) && !empty($this->chapter));
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
      $sql .= $this->boolean_sql_select($this->boolean_inclusive_atoms($this->searchText), $this->fulltextKey);
    }

    $sql .= " as relevance, ";

    if ($this->isBookRef()) {
      $sql .= "b.bookname, b.singlechap, r.ref, r.vstart, r.vend \n" ;
    } else {
      $sql .= "'' as bookname, 0 as singlechap, 0 as ref, 0 as vstart, 0 as vend \n" ;
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
      $sql .= ", mse_bible_ref r, mse_bible_book b " ;
    }
    $sql .= "\n";

    // WHERE
    if ($this->isSearchText()) {
      if ($this->searchType == "PHRASE") {
        $sql .= $this->whereClause("t.text LIKE '%" . $this->searchText . "%'");
      } else {
        $sql .= $this->whereClause($this->boolean_sql_where($this->searchText, $this->fulltextKey));
      }
    }

    if ($this->isBookRef()) {
      $sql .= $this->whereClause(
          "r.bookid = b.bookid \n".
          "AND r.author = t.author \n".
          "AND r.vol = t.vol \n".
          "AND r.page = t.page \n".
          "AND r.para = t.para \n".
          "AND r.bookid = " . $this->bookId . "\n".
          "AND r.chapter = " . $this->chapter . "\n");

      if ($this->vStart > 0) {
        $sql .= "AND r.vstart = " . $this->vStart . "\n";
      }
    }

    if ($this->isAuthorFilter()) {
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

  function deriveFulltextKey() {
    $match_a = array();

    /* grab all keys of db.table */
    $indices=mysql_query("SHOW INDEX FROM " . $this->tableName) or die(mysql_error());
    $indices_rows=mysql_num_rows($indices);
    /* grab only fulltext keys */
    for($nth=0;$nth<$indices_rows;$nth++) {
      $nth_index=mysql_result($indices,$nth,'Index_type');
      if($nth_index=='FULLTEXT') {
        $match_a[].=mysql_result($indices,$nth,'Column_name');
      }
    }

    /* delimit with commas */
    $this->fulltextKey = implode(',',$match_a);
  }

  function whereClause($sql) {
    $sql = $this->whereConjunct . " $sql\n";

    $this->whereConjunct = "AND";

    return $sql;
  }

  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *  :: boolean_inclusive_atoms($string) ::
   *  returns only inclusive atoms within boolean statement
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  function boolean_inclusive_atoms($string) {

    $result=trim($string);
    $result=preg_replace("/([[:space:]]{2,})/",' ',$result);

    /* convert normal boolean operators to shortened syntax */
    $result=preg_replace('/ not /i',' -',$result);
    $result=preg_replace('/ and /i',' ',$result);
    $result=preg_replace('/ or /i',',',$result);

    /* drop unnecessary spaces */
    $result=str_replace(' ,',',',$result);
    $result=str_replace(', ',',',$result);
    $result=str_replace('- ','-',$result);

    /* strip exlusive atoms */
    $result=preg_replace(
      "(\-\([A-Za-z0-9]{1,}[A-Za-z0-9\-\.\_\,]{0,}\))",
      '',
      $result);
    $result=preg_replace(
      "(\-[A-Za-z0-9]{1,}[A-Za-z0-9\-\.\_]{0,})",
      '',
      $result);
    $result=str_replace('(',' ',$result);
    $result=str_replace(')',' ',$result);
    $result=str_replace(',',' ',$result);

    return $result;
  }

  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *  :: boolean_sql_select($string,$match) ::
   *  function used to transform a boolean search string into a
   *  mysql parseable fulltext sql string used to determine the
   *  relevance of each record;
   *  1. put all subject words into array
   *  2. enumerate array elements into scoring sql syntax
   *  3. return sql string
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  function  boolean_sql_select($string,$match) {
    /* build sql for determining score for each record */
    $stringsum_long = "";
    $stringsum = "";
    preg_match_all(
      "([A-Za-z0-9]{1,}[A-Za-z0-9\-\.\_]{0,})",
      $string,
      $result);
    $result = $result[0];
    for($cth=0;$cth<count($result);$cth++) {
      //if(strlen($result[$cth])>=4) {
        $stringsum_long .=
          " $result[$cth] ";
      //}else{
      //  $stringsum_a[] =
      //    ' '.$this->boolean_sql_select_short($result[$cth],$match).' ';
      //}
    }
    if(strlen($stringsum_long)>0) {
        $stringsum_a[] = " match ($match) against ('$stringsum_long') ";
    }
    $stringsum .= implode("+",$stringsum_a);
    return $stringsum;
  }

  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *  :: boolean_mark_atoms($string) ::
   *  used to identify all word atoms; works using simple
   *  string replacement process:
   *        1. strip whitespace
   *        2. apply an arbitrary function to subject words
   *        3. represent remaining characters as boolean operators:
   *          a. ' '[space] -> AND
   *          b. ','[comma] -> OR
   *          c. '-'[minus] -> NOT
   *        4. replace arbitrary function with actual sql syntax
   *        5. return sql string
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  function boolean_mark_atoms($string) {
    $result=trim($string);
    $result=preg_replace("/([[:space:]]{2,})/i",' ',$result);

    /* convert normal boolean operators to shortened syntax */
    $result=preg_replace('/ not /i',' -',$result);
    $result=preg_replace('/ and /i',' ',$result);
    $result=preg_replace('/ or /i',',',$result);

    /* strip excessive whitespace */
    $result=str_replace('( ','(',$result);
    $result=str_replace(' )',')',$result);
    $result=str_replace(', ',',',$result);
    $result=str_replace(' ,',',',$result);
    $result=str_replace('- ','-',$result);

    /* apply arbitrary function to all 'word' atoms */
    $result=preg_replace(
      "/([A-Za-z0-9]{1,}[A-Za-z0-9\.\_-]{0,})/",
      "foo[('$0')]bar",
      $result);

    /* strip empty or erroneous atoms */
    $result=str_replace("foo[('')]bar",'',$result);
    $result=str_replace("foo[('-')]bar",'-',$result);

    /* add needed space */
    $result=str_replace(')foo[(',') foo[(',$result);
    $result=str_replace(')]bar(',')]bar (',$result);

    /* dispatch ' ' to ' AND ' */
    $result=str_replace(' ',' AND ',$result);

    /* dispatch ',' to ' OR ' */
    $result=str_replace(',',' OR ',$result);

    /* dispatch '-' to ' NOT ' */
    $result=str_replace(' -',' NOT ',$result);

    return $result;
  }

  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *  :: getAtoms($string) ::
   * Return an array of atoms involved in the current search.
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  function getAtoms() {
    if (!isset($this->atoms)) {

      if ($this->searchType == "PHRASE") {
        // For Phrase, the "atom" is the whole phrase, spaces and all
        $this->atoms = array($this->searchText);

      } else {
        $result=trim($this->searchText);
        $result=preg_replace("/([[:space:]]{2,})/",' ',$result);

        /* convert normal boolean operators to shortened syntax */
        $result=preg_replace('/ not /i',' -',$result);
        $result=preg_replace('/ and /i',' ',$result);
        $result=preg_replace('/ or /i',' ',$result);

        /* strip paranethesis and extra whitespace */
        $result=str_replace('(','',$result);
        $result=str_replace(')','',$result);
        $result=str_replace(',',' ',$result);
        $result=str_replace('- ','-',$result);
        $result=trim(preg_replace("/([[:space:]]{2,})/",' ',$result));

        $this->atoms = explode(' ', $result);

        // Remove any NOT atoms
        for($i=count($this->atoms)-1; $i>=0; $i--) {
          if (substr($this->atoms[$i],0,1) == '-') {
            unset($this->atoms[$i]);
          }
        }
        $this->atoms = array_merge($this->atoms);
      }
    }

    return $this->atoms;
  }


  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *  :: boolean_sql_where($string,$match) ::
   *  function used to transform identified atoms into mysql
   *  parseable boolean fulltext sql string; allows for
   *  nesting by letting the mysql boolean parser evaluate
   *  grouped statements
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  function boolean_sql_where($string,$match){
    $result = $this->boolean_mark_atoms($string);

    /* dispatch 'foo[(#)]bar to actual sql involving (#) */
    $result=preg_replace(
      "/foo\[\(\'([^\)]{4,})\'\)\]bar/",
      " match ($match) against ('$1')>0 ",
      $result);

    $result=preg_replace(
      "/foo\[\(\'([^\)]{1,3})\'\)\]bar/e",
      " '('.\$this->boolean_sql_where_short(\"$1\",\"$match\").')' ",
      $result);

    return $result;
  }


  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *  :: boolean_sql_where_short($string,$match) ::
   *  parses short words <4 chars into proper SQL: special adaptive
   *  case to force return of records without using fulltext index
   *  keep in mind that allowing this functionality may have serious
   *  performance issues, especially with large datasets
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  function boolean_sql_where_short($string,$match) {
    $match_a = explode(',',$match);
    for($ith=0;$ith<count($match_a);$ith++) {
      $like_a[$ith] = " $match_a[$ith] LIKE '%$string%' ";
    }
    $like = implode(" OR ",$like_a);

    return $like;
  }

  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *  :: boolean_sql_select_short($string,$match) ::
   *  parses short words <4 chars into proper SQL: special adaptive
   *  case to force 'scoring' of records without using fulltext index
   *  keep in mind that allowing this functionality may have serious
   *  performance issues, especially with large datasets
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  function boolean_sql_select_short($string,$match) {
    $match_a = explode(',',$match);
    $score_unit_weight = .2;
    for($ith=0;$ith<count($match_a);$ith++) {
      $score_a[$ith] =
        " $score_unit_weight*(
        LENGTH($match_a[$ith]) -
        LENGTH(REPLACE(LOWER($match_a[$ith]),LOWER('$string'),'')))
        /LENGTH('$string') ";
    }
    $score = implode(" + ",$score_a);

    return $score;
  }

  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *  :: boolean_parsed_as($string) ::
   *  returns the equivalent boolean statement in user readable form
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  function boolean_parsed_as($string) {
    $result = $this->boolean_mark_atoms($string);

    /* dispatch 'foo[(%)]bar' to empty string */
    $result=str_replace("foo[('","",$result);
    $result=str_replace("')]bar","",$result);

    return $result;
  }
}
?>