


var se2App = null; 
nhn.husky.SE_PhotoUpload = jindo.$Class({
    name : "SE_PhotoUpload",
    $init : function(elAppContainer){
        this._assignHTMLObjects(elAppContainer);
    },

    _assignHTMLObjects : function(elAppContainer){
    	window.oMessageMap["SE_PhotoUpload.onEmpty"] = "사진파일을 선택하세요"; 
    	window.oMessageMap["SE_PhotoUpload.onInvalidFile"] = "gif, png, jpg, jpeg파일만 허용됩니다.";
    	window.oMessageMap_en_US["SE_PhotoUpload.onEmpty"] = "Plese select photo file"; 
    	window.oMessageMap_en_US["SE_PhotoUpload.onInvalidFile"] = "gif, png, jpg, jpeg files allowed";
    	
        this.oDropdownLayer =  cssquery.getSingle("DIV.husky_seditor_photoUpload_layer", elAppContainer);
        this.oApplyButton = cssquery.getSingle(".se2_button_apply", this.oDropdownLayer);
        this.oCancelButton = cssquery.getSingle(".se2_button_cancel", this.oDropdownLayer);
    },

    $ON_MSG_APP_READY : function(){
    	se2App = this.oApp;
        this.oApp.exec("REGISTER_UI_EVENT", ["photoUpload", "click", "SE_TOGGLE_PHOTOUPLOAD_LAYER"]);
        //input button에 click 이벤트를 할당.
        this.oApp.registerBrowserEvent(this.oApplyButton, 'click','APPLY_PHOTO');
        this.oApp.registerBrowserEvent(this.oCancelButton, 'click','CANCEL_PHOTO');
    },

    $ON_SE_TOGGLE_PHOTOUPLOAD_LAYER : function(){
		this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [this.oDropdownLayer, null, "SELECT_UI", ['photoUpload'], "DESELECT_UI", ['photoUpload']]);
    },

    $ON_APPLY_PHOTO : function(){
    	var formPhoto = document.getElementById("form_photo");
		formPhoto.action = ( parent.portalPage == null ? '' : parent.portalPage.getContextPath()) + '/attachFile/fileMngr?cmd=upload';
		formPhoto.systemId.value=  (window.parent.document.setUpload ?  window.parent.document.setUpload.systemId.value : '');

		var filename = formPhoto.NewFile.value;
		if(!/\.(gif|jpg|jpeg|png)$/i.test(filename)) {
			alert( this.oApp.$MSG("SE_PhotoUpload.onInvalidFile"));
			formPhoto.NewFile.value = '';
			return;
		}
		
		if( formPhoto.NewFile.value == '') {
			alert( this.oApp.$MSG("SE_PhotoUpload.onEmpty"));
			formPhoto.NewFile.value = '';
			return;
		}
		formPhoto.submit();
		formPhoto.NewFile.value = '';
		this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [this.oDropdownLayer, null, "SELECT_UI", ["photoUpload"], "DESELECT_UI", ["photoUpload"]]);
    },
    
    $ON_CANCEL_PHOTO : function(){
		this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [this.oDropdownLayer, null, "SELECT_UI", ["photoUpload"], "DESELECT_UI", ["photoUpload"]]);
    }
});

function pasteHTML( html) {
	se2App.exec("PASTE_HTML", [html]);	
}
