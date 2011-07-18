/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2008 Southesk.com
 *
 * 1962 Hymn Book Search
 *
 * $Id: ajax.js 894 2008-09-29 21:22:54Z craig $
 *
 * Who  When         Why
 * CAM  29-Sep-2008  10302 : File created.
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
