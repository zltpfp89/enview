<!--


if( ! window.ekr )
    window.ekr = new Object();

	ekr.exctPopup = function() {	
};

ekr.exctPopup.prototype = {
	search : function() {
		var searchKey =$("#exctPopup_keyword").val();
		var params = {"searchKey" : searchKey};
		$.ajax( {
			url : '/schd/selectExctListPopup.face',
			type : "post",
			data : params,
			success : function( data) {
				var tbody = $(data).find("#exctPopup_tbody");
				$("#exctPopup_tbody").html( tbody.html());
				$("#exctPopup_tbody > tr").click( function() {
					if( callback != null) {
						callback( { "id" : $(this).attr("id"), "text" : $(this).attr("text")})
					}
				});
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
		});
	},
	
	showLayerPopup : function ( callback) {
		fn_makeDiv('exctLayerPopup');
		$("#exctLayerPopup").load("/schd/selectExctListPopup.face", function () {
			$("#exctPopup_searchBtn").click( function() { ekrExctPopup.search();});
			$("#exctPopup_keyword").keyup( function( e) {
				if( e.keyCode==13) {
					ekrExctPopup.search();
				}
			});
			$("#exctPopup_tbody > tr").css("cursor", "hand");
			$("#exctPopup_tbody > tr").click( function() {
				if( callback != null) {
					callback( { "id" : $(this).attr("id"), "text" : $(this).attr("text")})
				}
				$("#exctLayerPopup").dialog("close");
			});
//			ekrExctPopup.search();	
			var text = null;
			$("#exctLayerPopup").dialog( {
				title : "임원선택",
				width: 500,
				height:480,
				modal : true
		    }); // dialog
		}); // load
	} // showLayerPopup
};

var ekrExctPopup = new ekr.exctPopup();
-->