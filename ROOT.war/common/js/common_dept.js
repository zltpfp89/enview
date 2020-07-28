<!--

	if( ! window.common )
	    window.common = new Object();

	common.deptPopup = function() {
		this.usrDeptCd = '';
	};
	
	common.deptPopup.prototype = {
		search : function() {
			var text =$("#deptPopup_deptNm").val();
	        $("#deptPopup_deptTree").jstree('destroy');
			$('#deptPopup_deptTree').jstree({
				'core' : {
					'data' : {
						"url" : "/common/user/selectDeptTree.common" + (text=='' || text==null  ? '' : '?text=' + encodeURIComponent(text)),
						"dataType" : "json",
						"data" : function (node) {
							return { "id" : node.id };
						}
					}
				}
			});
			if( commonDeptPopup.usrDeptCd != '') {
				$("#deptPopup_deptTree").on('loaded.jstree', function (event, data) {
					var id = commonDeptPopup.usrDeptCd;
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
			$("#deptLayerPopup").load("/common/common/dept/deptLayerPopup.jsp",  function () {
				if( commonDeptPopup.text!=null) {
					$("#deptPopup_deptNm").val( commonDeptPopup.text);					
				}
				$("#deptPopup_searchBtn").click( function() { commonDeptPopup.search();});
				$("#deptPopup_deptNm").keyup( function( e) {
					if( e.keyCode==13) {
						commonDeptPopup.search();
					}
				});
//				$("#deptPopup_deptNm").focus( function( e) {
//					$(this).val('');
//				});
				commonDeptPopup.search();	
				var text = null;
				$("#deptLayerPopup").dialog( {
					title : "부서선택",
					width:400,
					height:460,
					modal : true,
					buttons : [
						{ 	text : "확인", 
							class:"btn_black"  ,
							click: function() { 
								var data = $('#deptPopup_deptTree').jstree("get_selected", true);
								if( callback != null) {
									try {
										callback( data);
									} catch(e) {
										console.log(e)
									}
								}
								$("#deptLayerPopup").dialog("close");								
							}
						},
						{ 	text : "취소", 
							class:"btn_orange",  
							click: function() { $("#deptLayerPopup").dialog("close");}
						}
					]	
			    }); // dialog
			}); // load
		} // showLayerPopup
	};
	
	var commonDeptPopup = new common.deptPopup();
-->