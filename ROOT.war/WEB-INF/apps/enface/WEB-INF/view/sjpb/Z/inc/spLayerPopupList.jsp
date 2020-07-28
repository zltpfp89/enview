<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	request.setAttribute("cPath", request.getContextPath());
%>

<link rel="stylesheet" href="${cPath}/QCELL/css/qcell.css" type="text/css" />
<script type="text/javascript" src="${cPath}/QCELL/qcell.js"></script>

<script type="text/javascript" src="${cPath}/sjpb/js/Z/common.js?r=<%=Math.random()%>"></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/main.js" ></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/webtoolkit.base64.js"></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/loading/js/HoldOn.js"></script>
<script type="text/javascript" src="${cPath}/board/smarteditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript" src="${cPath}/dhtmlx/vault/dhtmlxvault.js"></script>

<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/js/Z/loading/css/HoldOn.css">
<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/popup.css" />
<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/contents.css" />
<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
<link rel="stylesheet" href="${cPath}/javascript/jstree/themes/default/style.min.css" />

<script type="text/javascript">

    var queryString="{}";
    var qcell;
    var sheet;
    var list="";
    var incSpVO = new Object();
    //피의자검색 팝업이 뜬다.
    function fn_f_selectCridtaSpList(){
    	 var incNum = document.f_cridtaSpList.incNum.value;
    	 var spNm = document.f_cridtaSpList.spNm.value;
    	 var spIdNum = document.f_cridtaSpList.spIdNum.value;
    	 var rcptNum = document.f_cridtaSpList.rcptNum.value;
    	 if((incNum=='' || incNum==null)&& (spNm=='' || spNm==null)&& (spIdNum==''||spIdNum==null)&& (rcptNum==''||rcptNum==null)){
    		 alert("검색조건을 입력하세요.");
    		 return;
    	 }else{
    		 $("#btnArea_pop").show();
    		 var searchSp = {
    				 "incNum":incNum,
    				 "spNm":Base64.encode(spNm),
    				 "spIdNum":Base64.encode(spIdNum),
    				 "rcptNum":rcptNum
    		 };
    		 
    		 goAjaxDefault("/sjpb/Z/selectCridtaSpList.face", searchSp, callBackFn_f_selectCridtaSpListSuccess,true);
    	 }
    }

    //피의자검색 팝업 리스트 화면 성공 함수
    function callBackFn_f_selectCridtaSpListSuccess(data){
    	if(data.qCell == ""|| data.qCell == null){
    		$("#sheetCridtaSpList").empty();
    		$("#sheetCridtaSpList").append("검색 결과가 없습니다.");
    	}else{
    		var QCELLProp = {
    				"parentid" : "sheetCridtaSpList",
    				"id" : "qCellSpList",
    				"data" : {
    					"input" : data.qCell
    				},
    				"rowheader" : "sequence",
    				"selectmode": "row",
    				"columns" : [ 
    					{ width : '5%', key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : false }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
    	                { width : '25%', key: 'incNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
    					{ width : '35%', key : 'spNm', title : [ '피의자명' ], type: "html", sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' }, options: {html: {data: fnDataDecode}}}, 
    					{ width : '35%', key : 'spIdNum', title : [ '주민등록번호' ], type: "html", sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' }, options: {html: {data: fnDataDecode}}}	
    					],
    				"frozencols" : 5
    			};
    			QCELL.create(QCELLProp);
    			sheet = QCELL.getInstance("qCellSpList");
    			sheet.bind("click",eventPopUpFn);
    	}
    }
    
    function fnDataDecode(id, row, col, val, obj){
  		var html = '';
       	  if(isNull(val)){
       		html = val;
       	  } else {
       		html = Base64.decode(val);
       	  }
       	  return html;
    }

    //피의자검색 팝업창 클릭이벤트
    function eventPopUpFn(e) {
    	// 선택한 인덱스 가져오기
    	var rowIdx = sheet.getIdx("row");
    	var colIdx = sheet.getIdx("col");
    	
    	//전체 체크 해제 
    	for(var i = 1; i <= sheet.getColData(1).length; i++){
    		if(JSON.stringify(sheet.getCellLabel(i,1)) == "true"){
    			//선택행이 아닐경우에 전체 체크해제 
				if(i != rowIdx){
					sheet.setCellData(i, 1, false);	    			
				}
    		}
    	}
    	
    	//셀 클릭 이벤트
    	if(colIdx>1){
    		//선택한 인덱스 체크박스 체크
			sheet.setCellData(rowIdx, 1, true);
    	}
    	
    }

    //피의자 추가 팝업 확인시 리스트값 보내줌
    function fn_f_selectSendItemList(){
    	for(var i = 1; i <= sheet.getRows("data"); i++){
    		if(JSON.stringify(sheet.getCellLabel(i,1)) == "true"){
    			incSpVO = sheet.getRowData(i);
    		}	
    	}
    	//incSpNumList = incSpNumList.substr(0,incSpNumList.length-1);
    	
    	//list = {
    	//		incSpNumList : incSpNumList
    	//}

    	//팝업창을 닫고 피의자번호 보냄.
    	window.parent.commonLayerPopup.closeLayerPopup(incSpVO);
    }

    //피의자 추가 팝업창 닫기 이벤트
    function fn_f_closeCridtaSpList(){
    	window.parent.commonLayerPopup.closeLayerPopup();
    }

    //초기화 함수
    function fn_f_init(form){
		var searchArea = $("#"+form);
    	
    	//input 값 초기화
    	searchArea.find("input[type=text]").val("");
    	
    	//select 값 초기화
    	searchArea.find("select").each(function() {
    		$(this).find("option:eq(0)").prop("selected", true);
    		$(this).prev('.txt').text($(this).find('option:selected').text());
    	});
    }
    
    var rcptNum = "${ empty param.rcptNum ? '' : param.rcptNum }";
    
    $(document).ready(function () {
    	
    	//사건번호가있으면, 사건 > 문서관리에서 호출, 사건내 피의자만 호출
    	if(!isNull(rcptNum)){
    		$(".searchArea").hide();
    		$("form[name=f_cridtaSpList]").find("input[name=rcptNum]").val(rcptNum);
    		
    		//자동검색 
    		fn_f_selectCridtaSpList();
    		
    	//사건번호가없으면, 문서관리 탭에서 호출
    	}else{
    		$(".searchArea").show();
    		$("form[name=f_cridtaSpList]").find("input[name=rcptNum]").val("");
    		
    	}
    	
   		
   	});
    
   
</script>
<style>
	.searchArea ul li {width: 50% !important;}	
	.ocrt_wrap {padding: 10px !important;}
</style>
<!-- size:748*670 --> 
<body class="popup">
    <h2><span>피의자 조회</span></h2>
    <div class="contents">
	    <div id="sub_tab">
	        <div class="ocrt_wrap clearfix">
	            <div class="ocrt_01 ocrt_list_tab0 list">	
					<!-- searchArea -->
					<div class="searchArea">
						<form name="f_cridtaSpList" id="f_cridtaSpList" method="post" onkeydown="if(event.keyCode==13) fn_f_selectCridtaSpList()">
							<input type="hidden" name="rcptNum" value="">
							<ul>
								<li><span class="title">사건번호</span><label for="incNum"></label><input type="text" name="incNum" value="" class="w100per"></li>
								<li><span class="title">피의자명</span><label for="spNm"></label><input type="text" name="spNm" value="" class="w100per"></li>
								<li><span class="title">주민번호</span><label for="spIdNum"></label><input type="text" name="spIdNum" value="" class="w100per"></li>
								<li></li>
							</ul>
							<div class="btnArea">
								<div class="r_btn">
									<a href="javascript:fn_f_selectCridtaSpList();" id="btn_search" class="btn_blue"><span>검색</span></a>
									<a href="javascript:fn_f_init('f_cridtaSpList');" class="btn_white"><span>초기화</span></a>
								</div>
							</div>
						</form>
					</div>
					<!-- //searchArea -->	
							
					<!-- listArea -->
					<div id="sheetCridtaSpList" class="listArea mrt15 area-mousewheel" style="height:270px; width:100%">
					</div>  
					<!-- //listArea -->
					
					<!-- btnArea -->
					<div class='btnArea pop_back' id="btnArea_pop" style="display:none;">
						<div class='r_btn'>
							<a href='javascript:fn_f_selectSendItemList();' class='btn_light_blue save' id='cnfmBtn'><span>추가</span></a>
							<a href='javascript:fn_f_closeCridtaSpList();' class='btn_light_blue_line appointed' id='closBtn'><span>닫기</span></a>
						</div>
					</div>
					<!-- //btnArea -->
					
				</div>    
			</div>
            <!--//ocrt_wrap-->
		</div>
		<!-- subtabs -->
	</div>
	<!-- contents //-->     
    <a href="javascript:fn_f_closeCridtaSpList();"><img class="btn_close" src="${cPath}/sjpb/images/popup_close.png" alt="닫기"/></a>
</body>
