<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setAttribute("cPath", request.getContextPath());
%>
<html>
<head>
	<title>증권사-지점 선택 팝업</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-style-type" content="text/css" />
	<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
	<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/popup.css" />
	<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>
	
	<script>
		var qCellBankList;
		var rowIdx;
		var colIdx;
		var searchBank;
		var list="";
		var selectedBank="";
		
		$(document).ready(function(){
			//수신처 선택 팝업 닫기 버튼
			$("#closBtn").on("click", function(){
				window.parent.commonLayerPopup.closeLayerPopupOnly();
			});
		});
		
		function selectBankList(){
			//최소화 되어 있으면 검색중단
			if(!$('#bankGrid:visible').length) return;
			
			searchBank = {
				membNm:$("#bankName").val(),
				brNm:$("#branchName").val()
			};
				
			goAjax("/stock/selectBankList.face", searchBank, callBackSelectBankListSuccess);
		}
	
		//금융사 검색 리스트 화면 성공 함수
		function callBackSelectBankListSuccess(data){
			if(data.bankList == ""|| data.bankList == null){
				alert("조회된 금융사 목록이 없습니다.");
			}else{
				$("#cnfmBtn").show(); 
			}
			
			var QCELLProp = {
				"parentid" : "bankGrid",
				"id" : "qcellBankList",
				"data" : {
					"input" : data.bankList
				},
				"rowheader" : "sequence",
				"selectmode": "row",
				"columns" : [ 
                	{ width : '205px' , key : 'membNm',	title : ['증권사명'],	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                	{ width : '210px' , key : 'brNm',  title : ['지점명'],	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
				]
			};
			
			QCELL.create(QCELLProp);
			qCellBankList = QCELL.getInstance("qcellBankList");
			qCellBankList.bind("click", eventPopUpFn);
		}
	
		//금융사 검색 팝업창 클릭이벤트
		function eventPopUpFn(e) {
			// 선택한 인덱스 가져오기
			rowIdx = qCellBankList.getIdx("row");
		}
	
		//금융사 선택 시 명과 팩스번호를 자동 입력
		function fn_selectBank(){
			selectedBank=qCellBankList.getRowData(rowIdx);
			
			if(selectedBank == null){
				alert("증권사/지점을 선택해주세요.");
				return;
			}else{
				bank = {
					membNo : selectedBank.membNo,
					branchNo : selectedBank.branchNo,
					membNm : selectedBank.membNm,
					branchNm : selectedBank.brNm
				} 
					
				window.parent.commonLayerPopup.closeLayerPopup(bank);
			}
		}
	
		//검색값 초기화 함수
		function fn_f_init(form){
			$("#"+form)[0].reset();
		}
	</script>
</head>
<body class="popup">
    <div class="contents">
	    <div id="sub_tab">
	        <div class="ocrt_wrap clearfix">
	            <div class="ocrt_01 ocrt_list_tab0 list">	
					<!-- searchArea -->
					<div class="searchArea">
						<form name="searchForm" id="searchForm" method="post" onkeydown="if(event.keyCode==13) selectBankList();">
							<ul>
								<li style="width: 50%;">
									<span class="title">증권사명</span>
									<label for="bankName"></label><input type="text" id="bankName" name="bankName" value="" class="w100per">
								</li>
								<li style="width: 50%;">
									<span class="title">지점명</span>
									<label for="branchName"></label><input type="text" id="branchName" name="branchName" value="" class="w100per">
								</li>
							</ul>
							<div class="btnArea">
								<div class="r_btn">
									<a href="javascript:selectBankList();" id="searchBtn" class="btn_light_blue search_01"><span>검색</span></a>
									<a href="javascript:fn_f_init('searchForm');" class="btn_white reset"><span>초기화</span></a>
								</div>
							</div>
						</form>
					</div>
					<!-- //searchArea -->	
					<!-- listArea -->
					<div id="bankGrid" class="listArea mrt15 area-mousewheel" style="width:100%; height:270px;">
					</div>  
					<!-- //listArea -->
					<!-- btnArea -->
					<div class='btnArea pop_back' id="btnArea_pop">
						<div class='r_btn'>
							<a href='javascript:fn_selectBank();' class='btn_light_blue save' id='cnfmBtn' style="display:none;"><span>선택</span></a>
							<a href='#' class='btn_white appointed' id="closBtn"><span>닫기</span></a>
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
	<a href="#"><img class="btn_close" src="${cPath}/sjpb/images/popup_close.png" alt="닫기" /></a> 
</body>
</html>
