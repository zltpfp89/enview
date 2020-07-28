Report.prototype.getZoomCombo = function() {
	return this.zoomCombo;
};

Report.prototype.exeZoomIn = function(exeZoomValue) {
	var zoomValue = Number(exeZoomValue) / 100;
	if (this.m_buttonEvent.startZoomInSelect != null) {
		var returnValue = this.m_buttonEvent.startZoomInSelect();
		if (returnValue != true) {
			return;
		}
	}
	
	if (is_ie) {
		this.paintDiv.firstChild.style.visibility = "visible";
	}
	
	this.paintDiv.style.overflowX = "visible";
	this.paintDiv.style.overflowY = "visible";

	var paintDivWidth = this.paintDiv.clientWidth * zoomValue;
	var paintDivHeight = this.paintDiv.clientHeight * zoomValue;
	var tempWidth = paintDivWidth / Number(this.pageWidth);
	var tempHeight = paintDivHeight / Number(this.pageHeight);
	var value = tempWidth > tempHeight ? tempHeight : tempWidth;

	this.eFormDoodleOption.zoomIn = Re_zoom.rate = Number(value);

	var svg = this.paintDiv.firstChild.firstChild;
	if (null != svg) {
		svg.setAttribute("width", Number(this.pageWidth) * Number(value));
		svg.setAttribute("height", Number(this.pageHeight) * Number(value));
		if (null != svg.lastChild) {
			svg.lastChild.setAttribute("transform", "scale(" + value
					+ ") translate(0,0)");
		}
	}
	
	var htmlTag = this.paintDiv.firstChild.nextSibling;
	if (null != htmlTag) {
		htmlTag.style.zoom = value;
	}

	if (is_ie) {
		this.paintDiv.firstChild.style.visibility = "visible";
	}

	if (this.is_eForm) {
		this.zoomChangeEForm();
	}
};

function MainWebBrowserCtrl_Initialize(eform) {	
	window.MainWebBrowserCtrl_CallSubEForm = function() {
		eform.callSubReport();
	};

	window.MainWebBrowserCtrl_CloseSubReport = function() {
		eform.closeSubReport();
	};

	window.MainWebBrowserCtrl_MenuEnable = function() {
		eform.disabledMenu(false);
	};
};

function SubWebBrowserCtrl_Initialize(eform) {
	window.exeZoomResize = function(zoomValue) {
		eform.exeZoomIn(zoomValue);
	};
	
	window.SubWebBrowserCtrl_DoodleSignMode = function() {
		eform.EFormDoodle();
	};

	//형광펜 모드 종료
	window.SubWebBrowserCtrl_DoodleSignClose = function() {
		eform.closeDoodle();
	};

	//형광펜 모드일 때 펜 선택
	window.SubWebBrowserCtrl_DoodlePen = function() {
		eform.penDoodle();
	};

	//형광펜 모드일 때 팔레트 선택
	window.SubWebBrowserCtrl_Pallet = function() {
		eform.palletDoodle();
	};

	//형광펜 모드일 때 지우개 선택
	window.SubWebBrowserCtrl_Eraser = function() {
		eform.eraserDoodle();
	};

	//형광펜 모드일 때 모두 삭제
	window.SubWebBrowserCtrl_EraserAll = function() {
		eform.eraserAllDoodle();
	};

	//형광펜 모드일 때 이전 페이지 이동
	window.SubWebBrowserCtrl_PrevDoodlePage = function() {
		eform.previousDoodlePage();
	};

	//형광펜 모드일 때 다음 페이지 이동
	window.SubWebBrowserCtrl_NextDoodlePage = function() {
		eform.nextDoodlePage();
	};

	// 원하는 페이지로 이동
	window.SubWebBrowserCtrl_PageMove = function(pageIndex) {
		eform.pageMove(pageIndex);
	};
};