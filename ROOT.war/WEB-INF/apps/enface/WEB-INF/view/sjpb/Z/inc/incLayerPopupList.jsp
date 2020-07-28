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
    var queryString;
    var sheet;
    var incIncVO = new Object();
    function fn_m_selectIncMastList(){
    	var reqMap={	//검색조건 세팅
    			fdCdSc : $("select[name=incPop_fdCdSc]").val(),
    			criTmSc : $("select[name=incPop_criTmSc]").val(),
    			rcptIncNumSc : $("input[name=incPop_rcptIncNumSc]").val(),			//사건번호
    			dvFormSc : $("select[name=incPop_dvFormSc]").val(),
    			rltActCriNmSc : $("select[name=incPop_rltActCriNmSc]").val(),
    			sDateSc : $("input[name=incPop_sDateSc]").val(),				//등록일자시작
    			eDateSc : $("input[name=incPop_eDateSc]").val(),				//등록일자종료
    			nmKorSc : $("input[name=incPop_nmKorSc]").val()				//수사담당자
    		}
    	goAjaxDefault("/sjpb/Z/selectIncMastList.face",reqMap,callBackFn_m_selectIncMastSuccess,true);
    }

    function callBackFn_m_selectIncMastSuccess(data){
    	var QCELLProp = {
    			"parentid" : "sheetIncMastList",
    			"id" : "cell",
    			"data" : {
    				"input" : data.qCell
    			},
    			"rowheader" : "sequence",
    			"selectmode": "row",
    			"columns" : [ 
    				{width: '4%', key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
    			    {width: '13%',  key: 'rcptIncNum',         title: ['사건번호'],       sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    			    {width: '13%',  key: 'fdDesc',           title: ['구분'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    			    {width: '13%',  key: 'dvFormDesc',           title: ['발각형태'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    			    {width: '13%',  key: 'criTmNm',           title: ['수사팀'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    			    {width: '13%',  key: 'nmKor',           title: ['수사담당자'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    			    {width: '30%',  key: 'rltActCriNmCdDesc',           title: ['관련법률 및 죄명'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
    			    ],
    			"frozencols" : 5,
    		};
    		QCELL.create(QCELLProp);
    		sheet = QCELL.getInstance("cell");
    		sheet.bind("click",eventPopUpFn);
    		$("#btnArea_pop").show();
    }
    
  	//사건검색 팝업창 클릭이벤트
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

    //사건 추가 성공함수
    function fn_m_selectSendItemList(){
    	var list=[];
    	for(var i = 1; i <= sheet.getRows("data"); i++){
    		if(JSON.stringify(sheet.getCellLabel(i,1)) == "true"){
    			incIncVO = sheet.getRowData(i);
    		}	
    	}
    	window.parent.commonLayerPopup.closeLayerPopup(incIncVO);
    }

    //사건 추가 팝업창 닫기 이벤트
    function fn_m_closeIncMastList(){
    	window.parent.commonLayerPopup.closeLayerPopup();
    }
    
  	//초기화 함수
    function fn_m_init(form){
    	var searchArea = $("#"+form);
    	
    	//input 값 초기화
    	searchArea.find("input[type=text]").val("");
    	
    	//select 값 초기화
    	searchArea.find("select").each(function() {
    		$(this).find("option:eq(0)").prop("selected", true);
    		$(this).prev('.txt').text($(this).find('option:selected').text());
    	});
    }
  	
   
</script>
<style>
	.searchArea ul li {width: 50% !important;}	
	.ocrt_wrap {padding: 10px !important;}
</style>
<!-- size:748*670 -->
<body class="popup">
    <h2><span>사건 추가</span></h2>
    <div class="contents">
	    <div id="sub_tab">
	        <div class="ocrt_wrap clearfix">
	            <div class="ocrt_01 ocrt_list_tab0 list">	
					<!-- searchArea -->
					<div class="searchArea">
						<form name="m_searchIncMastList" id="m_searchIncMastList" method="post" onkeydown="if(event.keyCode==13) fn_m_selectIncMastList()">
							<ul>
								<li><span class="title">구분</span>
								   <div class="inputbox w65per">
									   <p class="txt"></p>
									   <select id="incPop_fdCdSc" name="incPop_fdCdSc">
											<option value="">전체</option>
											<c:forEach items="${fdKndList}" var="fd" varStatus="status">
												<option value="${fd.code}">${fd.codeName}</option>
											</c:forEach>
									   </select>
								   </div>
							   </li>
							   <li><span class="title">부서</span>
								   <div class="inputbox w65per">
									   <p class="txt"></p>
									   <select id="incPop_criTmSc" name="incPop_criTmSc">
										   <option value="">전체</option>
											<c:forEach items="${criTmList}" var="criTm" varStatus="status">
												<option value="${criTm.criTmId}">${criTm.criTmNm}</option>
											</c:forEach>
									   </select>
								   </div>
							   </li>
								<li><span class="title">사건번호</span>
								   <label for="incPop_rcptIncNumSc"></label><input type="text" class="w65per" id="incPop_rcptIncNumSc" name="incPop_rcptIncNumSc" />
							   </li>
							   <li><span class="title">발각형태</span>
								   <div class="inputbox w65per">
									   <p class="txt"></p>
									   <select id="incPop_dvFormSc" name="incPop_dvFormSc">
										   <option value="">전체</option>
											<c:forEach items="${dvFormKndList}" var="dvForm" varStatus="status">
												<option value="${dvForm.code}">${dvForm.codeName}</option>
											</c:forEach>
									   </select>
								   </div>
							   </li>
							   <li><span class="title">등록일자</span>
								   <label for="incPop_sDateSc"></label><input type="text" class="w30per calendar datepicker" id="incPop_sDateSc" name="incPop_sDateSc" /> ~ <label for="incPop_eDateSc"></label><input type="text" class="w30per calendar datepicker" id="incPop_eDateSc" name="incPop_eDateSc" />
							   </li>
							   <li><span class="title">관련법률</span>
								   <div class="inputbox w65per">
									   <p class="txt"></p>
									   <select id="incPop_rltActCriNmSc" name="incPop_rltActCriNmSc">
										   <option value="">전체</option>
											<c:forEach items="${rltActCriNmKndList}" var="rltActCriNm" varStatus="status">
												<option value="${rltActCriNm.code}">${rltActCriNm.codeName}</option>
											</c:forEach>
									   </select>
								</div>
							   </li>
							   <li><span class="title">수사담당자</span>
								   <label for="incPop_nmKorSc"></label><input type="text" class="w65per" id="incPop_nmKorSc" name="incPop_nmKorSc" />
							   </li>
							</ul>
							<div class="btnArea">
								<div class="r_btn">
									<a href="javascript:fn_m_selectIncMastList();" id="btn_search" class="btn_blue"><span>검색</span></a>
									<a href="javascript:fn_m_init('m_searchIncMastList');" class="btn_white"><span>초기화</span></a>
								</div>
							</div>
						</form>
					</div>
					<!-- //searchArea -->	
							
					<!-- listArea -->
					<div id="sheetIncMastList" class="listArea mrt15 area-mousewheel" style="height:270px; width:100%">
					</div>  
					<!-- //listArea -->
					
					<!-- btnArea -->
					<div class='btnArea pop_back' id="btnArea_pop" style="display:none;">
						<div class='r_btn'>
							<a href='javascript:fn_m_selectSendItemList();' class='btn_light_blue save' id='cnfmBtn'><span>추가</span></a>
							<a href='javascript:fn_m_closeIncMastList();' class='btn_light_blue_line appointed' id='closBtn'><span>닫기</span></a>
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
    <a href="javascript:fn_m_closeIncMastList();"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기"/></a>
</body>
