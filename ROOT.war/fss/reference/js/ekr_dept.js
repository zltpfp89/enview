<!--

	if( ! window.ekr )
	    window.ekr = new Object();

	ekr.deptPopup = function() {
		this.usrDeptCd = '';
	};
	
	ekr.deptPopup.prototype = {
		search : function() {
			var text =$("#deptPopup_deptNm").val();
			var param = (text == '' || text == null ) ? {} : { text : text };
			
	        $("#deptPopup_deptTree").jstree('destroy');
			$('#deptPopup_deptTree').jstree({
				'core' : {
					'data' : {
						"url" : "/sjpb/Z/selectDeptTree.face",
						"dataType" : "json",
						"data" : param,
						"type" : "post"
					}
				}
			});
			if( ekrDeptPopup.usrDeptCd != '') {
				$("#deptPopup_deptTree").on('loaded.jstree', function (event, data) {
					var id = ekrDeptPopup.usrDeptCd;
					$("#deptPopup_deptTree").jstree('select_node', '#' + id);
					while( id != '' && id !='#') {
						id = $("#deptPopup_deptTree").jstree('get_parent', '#' + id);
						$("#deptPopup_deptTree").jstree('open_node', '#' + id);
					}
				}); 
			}
			
			
		},
		showLayerPopup : function ( callback) {
			fn_makeDiv('deptLayerPopup');
			$("#deptLayerPopup").load("/sjpb/reference/common/dept/deptLayerPopup.jsp",  function () {
				if( ekrDeptPopup.text!=null) {
					$("#deptPopup_deptNm").val( ekrDeptPopup.text);					
				}
				$("#deptPopup_searchBtn").click( function() { ekrDeptPopup.search();});
				$("#deptPopup_deptNm").keyup( function( e) {
					if( e.keyCode==13) {
						ekrDeptPopup.search();
					}
				});
//				$("#deptPopup_deptNm").focus( function( e) {
//					$(this).val('');
//				});
				ekrDeptPopup.search();	
				var text = null;
				$("#deptLayerPopup").dialog( {
					title : "부서선택",
					width:400,
					height:460,
					modal : true,
					buttons : [
						{ 	text : "확인", 
							class:"btn_gray"  ,
							click: function() { 
								var data = $('#deptPopup_deptTree').jstree("get_selected", true);
								if( callback != null) {
									try {
										callback( data);
									} catch(e) {
									}
								}
								$("#deptLayerPopup").dialog("close");								
							}
						},
						{ 	text : "취소", 
							class:"btn_gray",  
							click: function() { $("#deptLayerPopup").dialog("close");}
						}
					]	
			    }); // dialog
			}); // load
		} // showLayerPopup
	};
	
	var ekrDeptPopup = new ekr.deptPopup();
-->