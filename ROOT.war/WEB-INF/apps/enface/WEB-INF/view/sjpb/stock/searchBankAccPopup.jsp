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
	<title>계좌번호 선택 팝업</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-style-type" content="text/css" />
	<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
	<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/popup.css" />
	<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>
	
	<script>
		var qCellBankAccList;
		var rowIdx;
		var colIdx;
		var searchBank;
		var list="";
		var selectedBankAcc="";
		
		$(document).ready(function(){
			selectBankAccList();
		});
		
		function selectBankAccList(){
			//최소화 되어 있으면 검색중단
			if(!$('#bankAccGrid:visible').length) return;
			
			searchBankAcc = {
				bankName:$("#bankName").val(),
				branchName:$("branchName").val(),
				accountNo:#("#accountNo").val()
			};
				
			goAjax("/stock/selectBankAccList.face", searchBankAcc, callBackSelectBankAccListSuccess);
		}
	
		//금융사 검색 리스트 화면 성공 함수
		function callBackSelectBankAccListSuccess(data){
			if(data.bankAccList == ""|| data.bankAccList == null){
				
			}else{
				$("#btnArea_pop").show();
			}
			
			var QCELLProp = {
				"parentid" : "bankAccGrid",
				"id" : "qcellBankAccList",
				"data" : {
					"input" : data.bankAccList
				},
				"rowheader" : "sequence",
				"selectmode": "row",
				"columns" : [ 
                	{ width : '165px' , key : 'membNm',	title : ['증권사명'],	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                	{ width : '165px' , key : 'brNm',	title : ['지점명'],	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                	{ width : '165px' , key : 'accNo',	title : ['계좌번호'],	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                	{ width : '170px' , key : 'trusterNm',  title : ['계좌주'],	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
				]
			};
			
			QCELL.create(QCELLProp);
			qCellBankAccList = QCELL.getInstance("qcellBankAccList");
			qCellBankAccList.bind("click", eventPopUpFn);
		}
	
		//금융사 검색 팝업창 클릭이벤트
		function eventPopUpFn(e) {
			// 선택한 인덱스 가져오기
			rowIdx = qCellBankAccList.getIdx("row");
		}
	
		//금융사 선택 시 명과 팩스번호를 자동 입력
		function fn_selectBankAcc(){
			selectedBankAcc=qCellBankAccList.getRowData(rowIdx);
			
			if(selectedBankAcc == null){
				alert("계좌를 선택해주세요.");
				return;
			}else{
				bankAcc = {
					membNo : selectedBankAcc.membNo,
					branchNo : selectedBankAcc.branchNo,
					branchNm : selectedBankAcc.brNm,
					accNo : selectedBankAcc.accNo
				} 
					
				window.parent.commonLayerPopup.closeLayerPopup(bankAcc);
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
						<form name="searchForm" id="searchForm" method="post" onkeydown="if(event.keyCode==13) selectBankAccList();">
							<ul>
								<li style="width: 33%;">
									<span class="title">증권사명</span>
									<label for="bankName"></label><input type="text" id="bankName" name="bankName" value="" class="w100per">
								</li>
								<li style="width: 33%;">
									<span class="title">지점명</span>
									<label for="branchName"></label><input type="text" id="branchName" name="branchName" value="" class="w100per">
								</li>
								<li style="width: 33%;">
									<span class="title">계좌번호</span>
									<label for="accountNo"></label><input type="text" id="accountNo" name="accountNo" value="" class="w100per">
								</li>
							</ul>
							<div class="btnArea">
								<div class="r_btn">
									<a href="javascript:selectBankList();" id="btn_search" class="btn_blue"><span>검색</span></a>
									<a href="javascript:fn_f_init('searchForm');" class="btn_white"><span>초기화</span></a>
								</div>
							</div>
						</form>
					</div>
					<!-- //searchArea -->	
					<!-- listArea -->
					<div id="bankAccGrid" class="listArea mrt15 area-mousewheel" style="width:100%; height:270px;">
					</div>  
					<!-- //listArea -->
					<!-- btnArea -->
					<div class='btnArea pop_back' id="btnArea_pop" style="display:none;">
						<div class='r_btn'>
							<a href='javascript:fn_selectBankAcc();' class='btn_white' id='cnfmBtn'><span>선택</span></a>
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
</body>
</html>
