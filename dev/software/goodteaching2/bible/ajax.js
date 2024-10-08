/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2009 frontburner.co.uk
 *
 * Bible Search
 *
 * $Id: ajax.js 1109 2009-12-30 13:02:57Z craig $
 *
 * Who  When         Why
 * CAM  29-Dec-2009  10515 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

function getObjRef(p_ref) {
  return document.all ? document.all[p_ref] : document.getElementById(p_ref);
}

function view_hymn(hymn_no) {
  var frm = getObjRef("searchForm");
  frm.hymn_no.value = hymn_no;
  frm.submit();
}

function view_author(author) {
  var frm = getObjRef("searchForm");
  frm.keywords.value = "";
  frm.author.value = author;
  frm.submit();
}

function toggle_language() {
  var frm = getObjRef("searchForm");
  frm.meter_id.value = "ALL";
  frm.submit();
}
