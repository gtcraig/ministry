/***
 * Ministry Search Engine
 * Copyright (c) 2007,2016 frontburner.co.uk
 *
 * GT Site JavaScript
 *
 * $Id: $
 *
 * Who  When         Why
 * RWM  22-Dec-2015  508026 : v2 Responsive - File created.
 */

$(document).ready(function(){
	$(".dropdown-button").dropdown();
	$(".button-collapse").sideNav();
	$('.scrollspy ').scrollSpy();
    $('select').material_select();
});


/* Settings for Blue Letter Bible script "http://www.blueletterbible.org/scripts/blbToolTip/BLB_ScriptTagger-min.js" */
BLB.Tagger.Translation = 'DBY';
/* 
BLB.Tagger.HyperLinks = 'all'; // 'all', 'none', 'hover'
BLB.Tagger.HideTanslationAbbrev = false;
BLB.Tagger.TargetNewWindow = true;
BLB.Tagger.Style = 'par'; // 'line' or 'par'
BLB.Tagger.NoSearchTagNames = ''; // HTML element list
BLB.Tagger.NoSearchClassNames = 'noTag doNotTag'; // CSS class list
*/
