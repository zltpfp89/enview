var RightTechPath ="/";
window.qcellpath = '';
try{
	if (RightTechPath){
		window.qcellpath = RightTechPath + 'QCELL/';
	}
} catch(e){
	window.qcellpath = './';
}
this.strScriptHead = '<script src="';
this.strScriptTail = '" type="text/javascript"></script>';
this.strLinkHead = '<link href="';
this.strLinkTail = '" rel="stylesheet" type="text/css">';
this.strScript = '';
this.strScript +=
	
this.strLinkHead + window.qcellpath + 'css/'					+ 'qcell_layout.css'		+	this.strLinkTail +
this.strLinkHead + window.qcellpath + 'css/'					+ 'qcell.css'				+	this.strLinkTail +

this.strScriptHead + window.qcellpath + 'lib/' 					+ 'underscore-min.js' 		+	this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/' 					+ 'underscore.string.min.js'+	this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/ds/' 				+ 'hashtable.js' 			+	this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/ds/' 				+ 'hashset.js' 				+	this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/jquery/' 			+ 'jquery-1.12.4.min.js'	+	this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/jquery/plugins/'	+ 'jquery.browser.min.js'	+	this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/jquery/plugins/'	+ 'jquery.mousewheel.min.js'+	this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/jquery/plugins/'	+ 'jquery.stylesheet.js'	+	this.strScriptTail +

this.strLinkHead + window.qcellpath + 'lib/jquery/plugins/jquery.mCustomScrollbar/' + 'jquery.mCustomScrollbar.custom.css'	+ this.strLinkTail +
this.strScriptHead + window.qcellpath + 'lib/jquery/plugins/jquery.mCustomScrollbar/' + 'jquery.mCustomScrollbar.custom.js'	+ this.strScriptTail +

this.strLinkHead + window.qcellpath + 'lib/jquery/plugins/jqueryUI/' + 'jquery-ui.css'	+ this.strLinkTail +
this.strScriptHead + window.qcellpath + 'lib/jquery/plugins/jqueryUI/' + 'jquery-ui.min.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/jquery/plugins/jqueryUI/' + 'datepicker-en.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/jquery/plugins/jqueryUI/' + 'datepicker-ko.js'	+ this.strScriptTail +

this.strScriptHead + window.qcellpath + 'lib/xlsx/' + 'shim.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/xlsx/' + 'jszip.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/xlsx/' + 'FileSaver.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/xlsx/' + 'xlsx.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/xlsx/' + 'jquery.fileDownload.js'	+ this.strScriptTail +

this.strScriptHead + window.qcellpath + 'lib/format/' + 'jquery.numberformatter-1.2.4.min.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/format/' + 'ssf_min.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/format/' + 'moment-with-locales.min.js'	+ this.strScriptTail +

this.strScriptHead + window.qcellpath + 'lib/inputmask/' + 'inputmask.min.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/inputmask/' + 'inputmask.extensions.min.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/inputmask/' + 'inputmask.numeric.extensions.min.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/inputmask/' + 'inputmask.date.extensions.min.js'	+ this.strScriptTail +
this.strScriptHead + window.qcellpath + 'lib/inputmask/' + 'jquery.inputmask.js'	+ this.strScriptTail +

this.strScriptHead + window.qcellpath + 'js/'	+ 'qcell.min.js'	+ this.strScriptTail;
document.write(this.strScript);
