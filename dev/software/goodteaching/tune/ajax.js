/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2020 frontburner.co.uk
 *
 * Tune Search
 *
 * Who  When         Why
 * CAM  30-May-2020  909743 : File Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

function getObjRef(p_ref) {
  return document.all ? document.all[p_ref] : document.getElementById(p_ref);
}

function view_tune(tune_id) {
  var frm = getObjRef("searchForm");
  frm.tune_id.value = tune_id;
  frm.submit();
}
