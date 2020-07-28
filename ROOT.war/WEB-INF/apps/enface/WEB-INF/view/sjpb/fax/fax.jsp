<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	request.setAttribute("cPath", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>:: 금융감독원 수사지원시스템 ::</title>
<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
<link rel="stylesheet" type="text/css" href="${cPath}/javascript/jstree/themes/default/style.min.css" />
<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>
<script type="text/javascript" src="${cPath}/javascript/jstree/jstree.min.js" ></script>	

<script>
	$(document).ready(function(){
		selectList();
		
		$("#holdon-overlay").css("display", "none");

		$("#receiver").off("focus").on("focus", function() {	
			openSearchBankPopup();
		});
		
		$("#sendFaxNo").off("focus").on("focus", function() {	
			openSearchBankPopup();
		});
		
		$("#addRcvBtn").click(function() {	
			openSearchBankMultiPopup();
		});
		
		$(".searchArea input[type=text],.searchArea select").keypress(function(e){
			if(e.keyCode == 13){
				e.stopPropagation();
				selectList();
			}
		});
		
		$("#exceldownIncPrnBtn").click(function(){
			if(qcellFax.getRows("data") == "0"){
				alert("다운로드할 검색결과가 없습니다.");
				return;
			}
			
			var properties={
				filename : "팩스전송내역",
// 				url : "/excelDownload.face",
				totaldata : true,
				border : true,
				headershow : true,
				colwidth : true,
				huge : false
			};
			
			qcellFax.excelDownload(properties);
		});
	});

	function initEditActionManager() {
		sjpbFile.init("fax");
	}
	
	var rowIdx ;	//선택한 인덱스 전역변수관리
	var qcellFax;
	var selected;
	
	var faxMap = {
		cmd : "" ,
		maxFileCnt : "",
		limitSize : "",
		totFileSize : "",
		sizeSF : "",
		contents : "",
		fileId : "",
		fileMask : "",
		fileNm : "",
		fileSize : "",
		fileType : "",
		filePath : "",
		fileCtype : "",
		fileCnt : "",
		delFileIds : "",
		sendNo : "",
		empNo : "",
		regUserNm : "",
		regUserFax : "",
		membNo : "",
		branchNo : "",
		receiver : "",
		sendFaxNo : "",
		susaCaseNo : "",
		finesMembNo : "",
		totalPage : "",
		rcvType : ""
	};
	
	//검색조건 초기화
	function initSearchData(){
		var searchArea = $("#searchArea");
		
		//input 값 초기화
		searchArea.find("input[type=text]").val("");
		
		//select 값 초기화
		searchArea.find("select").each(function() {
			$(this).find("option:eq(0)").prop("selected", true);
			$(this).prev('.txt').text($(this).find('option:selected').text());
		});
	}
	
	//팩스전송내역 리스트 조회
	function selectList(){
		$("#faxDetailDiv").hide();
		$("#faxListArea").show();
		
		//최소화 되어 있으면 검색중단
		if(!$('#faxGrid:visible').length) return;
		
		faxMap = {
			srchDocNo : $("#srchDocNo").val() ,
			srchCaseNo : $("#srchCaseNo").val() ,
			srchUser : $("#srchUser").val() ,
			srchReceiver : $("#srchReceiver").val() ,
			srchStartDate : $("#srchStartDate").val() ,
			srchEndDate : $("#srchEndDate").val() ,
			srchStatus : $("#srchStatus").val()
		};

		goAjax("/fax/selectFaxList.face", faxMap, callBackSelectFaxListSuccess);
	}
	
	function callBackSelectFaxListSuccess(data){
		var QCELLProp = {
            "parentid" : "faxGrid",
            "id"		: "qcellFax",
            "selectmode": "row",
//             "rowheaders": ["sequence"],
            "data"		: {"input" : data.faxList},
            "columns"	: [
//             	{width: '8%',	key: 'sendNo',			title: ['전송 일련번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '3%',	key: 'checkbox',		title: [''],		type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
        		{width: '10%',	key: 'docNo',		title: ['금융거래요청번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '9%',	key: 'susaCaseNm',		title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '7%',	key: 'regUserNm',		title: ['담당자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '9%',	key: 'regUserFax',		title: ['담당자 팩스번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '14%',	key: 'receiver',		title: ['수신처'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '9%',	key: 'sendFaxNo',		title: ['수신처 팩스번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '10%',	key: 'regDate',		title: ['작성시각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '10%',	key: 'sendDay',		title: ['전송시각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '9%',	key: 'sendDivNm',			title: ['전송상태'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
        		{width: '10%',	key: '',				title: [''], 			type: "html", options: {html: {data: fnSendFax}},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
        	],
        	"pagination" : {
        		unitlis: [10, 20, 30],
        		pageunit: 10,
        		pagecount: 10,
        		mode: 'extend',
        		extendmove: true
        	}
        };
	        
		QCELL.create(QCELLProp);
        qcellFax = QCELL.getInstance("qcellFax");
        qcellFax.bind("click", eventFn);
        
       	rowIdx = 0;
       	//insertFaxSendView();  
	}
	
	//팩스 전송 신규입력화면으로 전환
	function insertFaxSendView(){
		if($("#userFax").val() == null || $("#userFax").val() == "" || $("#emailAddr").val() == null || $("#emailAddr").val() == "" || $("#offcTel").val() == null || $("#offcTel").val() == "" || $("#userInfo02").val() == null || $("#userInfo02").val() == ""){
			alert("전자팩스 기능을 사용하기 위해서는 마이페이지 내에서 기본정보와 신분증 사본이 등록되어 있어야 합니다.");
			return;
		}
		
		$("#faxDetailDiv").show();

		$(".rcvDtl").hide();
		$(".rcvAdd").show();
		
		$("#cmd").val("WRITE");
		$("#docNoSpan").html("신규");
		$("#sendDivSpan").html("작성중");
		
		$("#susaCaseNo").attr("disabled", false);
		$("#rcvType").attr("disabled", false);
		$("#totalPage").attr("disabled", false);
		$("#susaCaseNo").val("").trigger("click");
		$("#rcvType").val("").trigger("click");
		$("#docNo").val("");
		$("#totalPage").val("");
		
		$("#empNo").val($("#userId").val());
		$("#regUserNm").val($("#userName").val());
		$("#regUserFax").val($("#userFax").val());
		$("#regUserSpan").html($("#userName").val());
		$("#regUserFaxSpan").html($("#userFax").val());
		
		$("#receiver").attr("disabled", false);
		$("#sendFaxNo").attr("disabled", false);
		$("#membNo").val("");
		$("#branchNo").val("");
		$("#receiver").val("");
		$("#sendFaxNo").val("");
		$("#remk").val("");
		
		$("#vault_upload").empty();
		$("#vault_fileList").empty();
		initEditActionManager();
		
		$("#popSaveBtn").show();
		autoResize();
	}
	
	//리스트 셀 클릭 이벤트
	function eventFn(e){
		if(qcellFax.getIdx("col") != 0){
			//선택한 인덱스 가져오기
			rowIdx = qcellFax.getIdx("row");
			colIdx = qcellFax.getIdx("col");
			
			//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
			qcellFax.removeRowStyle(qcellFax.getIdx("row","focus","previous") == -1?1:qcellFax.getIdx("row","focus","previous"));
			qcellFax.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
			
			//전송팩스내역 상세
			if (rowIdx > 0) {
				selectFaxSend(qcellFax.getRowData(rowIdx).sendNo);
			}
		}
	}
	
	//팩스발송내역 상세를 가져온다.
	function selectFaxSend(sendNo){
		selected = sendNo;
		
		faxMap = {
			sendNo : selected
		};

		goAjax("/fax/selectFaxSend.face", faxMap, callBackSelectFaxSendSuccess);
	}
	
	//팩스전송내역 상세 조회 콜백함수
	function callBackSelectFaxSendSuccess(data){
		if(data.faxSend == null){
			alert("팩스전송내역을 가져오는 중 오류가 발생했습니다. 관리자에게 문의하세요.");
			return;
		}

		if($("#userId").val() == data.faxSend.empNo && data.faxSend.sendDiv == "0"){//본인이 작성중인 팩스 내역이 발송전일 경우만 수정 화면으로 전환
			$(".rcvDtl").show();
			$(".rcvAdd").hide();
			
			$("#cmd").val("MODIFY");
			$("#docNo").val(data.faxSend.docNo);
			$("#docNoSpan").html(data.faxSend.docNo);
			$("#sendDivSpan").html(data.faxSend.sendDivNm);
			
			$("#susaCaseNo").attr("disabled", false);
			$("#rcvType").attr("disabled", false);
			$("#totalPage").attr("disabled", false);
			$("select[id=susaCaseNo]").val(data.faxSend.susaCaseNo).trigger('change');
			$("select[id=rcvType]").val(data.faxSend.rcvType).trigger('change');
			$("#finesMembNo").val(data.faxSend.finesMembNo);
			$("#totalPage").val(data.faxSend.totalPage);
			
			$("#empNo").val($("#userId").val());
			$("#regUserNm").val($("#userName").val());
			$("#regUserFax").val($("#userFax").val());
			$("#regUserSpan").html($("#userName").val());
			$("#regUserFaxSpan").html($("#userFax").val());
			
			$("#receiver").attr("disabled", false);
			$("#sendFaxNo").attr("disabled", false);
			$("#remk").attr("disabled", false);
			$("#membNo").val(data.faxSend.membNo);
			$("#branchNo").val(data.faxSend.branchNo);
			$("#receiver").val(data.faxSend.receiver);
			$("#sendFaxNo").val(data.faxSend.sendFaxNo);
			$("#remk").val(data.faxSend.remk);
			
			$("#vault_upload").empty();
			
			var fileListHtml="";
			$.each(data.fileList, function(index, item) {
				fileListHtml += '<li data-id="'+item.fileId+'" data-name="'+item.fileNm+'" data-size="'+item.fileSize+'" data-mask="'+item.fileMask +'" data-type="'+item.fileType+'" data-path="'+item.filePath+'" data-cType="'+item.fileCtype+'">';
				fileListHtml += '<a href="#">'+item.fileNm+'('+item.fileSize+')</a>';
				fileListHtml += '</li>';
			});
			$("#vault_fileList").html(fileListHtml);
			
			initEditActionManager();
			$("#popSaveBtn").show();
			autoResize();
			
		} else {//그 외의 경우는 발송 상세내역 확인만 가능한 화면으로 전환
			$(".rcvDtl").show();
			$(".rcvAdd").hide();
			
			$("#docNo").val(data.faxSend.docNo);
			$("#docNoSpan").html(data.faxSend.docNo);
			$("#sendDivSpan").html(data.faxSend.sendDivNm);
			
			$("#susaCaseNo").attr("disabled", false);
			$("#rcvType").attr("disabled", false);
			$("select[id=susaCaseNo]").val(data.faxSend.susaCaseNo).trigger("change");
			$("select[id=rcvType]").val(data.faxSend.rcvType).trigger("change");
			$("#finesMembNo").val(data.faxSend.finesMembNo);
			$("#totalPage").val(data.faxSend.totalPage);
			$("#susaCaseNo").attr("disabled", true);
			$("#rcvType").attr("disabled", true);
			$("#totalPage").attr("disabled", true);
			
			$("#empNo").val(data.faxSend.empNo);
			$("#regUserNm").val(data.faxSend.regUserNm);
			$("#regUserFax").val(data.faxSend.regUserFax);
			$("#regUserSpan").html(data.faxSend.regUserNm);
			$("#regUserFaxSpan").html(data.faxSend.regUserFax);
			
			$("#receiver").attr("disabled", true);
			$("#sendFaxNo").attr("disabled", true);
			$("#remk").attr("disabled", true);
			$("#membNo").val(data.faxSend.membNo);
			$("#branchNo").val(data.faxSend.branchNo);
			$("#receiver").val(data.faxSend.receiver);
			$("#sendFaxNo").val(data.faxSend.sendFaxNo);
			$("#remk").val(data.faxSend.remk);
			
			$("#vault_upload").empty();
			var fileListViewHtml="";
			fileListViewHtml += '<ul>';
			$.each(data.fileList, function(index, item) {
				fileListViewHtml += '<li data-id="'+item.fileId+'" data-name="'+item.fileNm+'" data-size="'+item.fileSize+'" data-mask="'+item.fileMask +'" data-type="'+item.fileType+'" data-path="'+item.filePath+'" data-cType="'+item.fileCtype+'">';
				fileListViewHtml += '<a href="${cPath}/sjpb/Z/AddOnDownload.face?fileId=' +item.fileId+ '" target="invisible"><img src="${cPath}/common/images/icon_file.png" alt="첨부파일" />';
				fileListViewHtml += '<span>'+item.fileNm+'('+item.fileSize+')</span>';
				fileListViewHtml += '</a>';
				fileListViewHtml += '</li>';
			});
			fileListViewHtml += '</ul>';
			$("#vault_upload").html(fileListViewHtml);
			
			$("#popSaveBtn").hide();
			autoResize();
		}
	}
	
	//팩스내역을 저장한다.(실제 전송은 아니고 내용을 저장)
	function faxSave() {
		// vaildation
		if($("#cmd").val() == "WRITE"){
			if ($("#rcvList li").length == 0){
				alert("수신처는 필수입니다.");
				return;
			}
		} else {
			if ($("#receiver").val() == null || $("#receiver").val() == "") {
				alert("수신처는 필수입니다.");
				return;
			}
		}
		
		if ($("#susaCaseNo").val() == null || $("#susaCaseNo").val() == "") {
			alert("사건번호는 필수입니다.");
			return;
		}
		
		var chars = "0123456789";
		var page = $("#totalPage").val();
		for (var i=0; i<page.length; i++){
			if(chars.indexOf(page.charAt(i)) == -1){
				alert("페이지수는 숫자만 입력해주세요.");
				return;
			}
		}
		
		sjpbFile.setForm();
	}
	
	//팩스내역 저장 AJAX
	function setFormSuccess(){
		if (sjpbFile.isCancel) {
			return;
		}
		
		if($("#cmd").val() == "WRITE"){
			var membNo = "";
			var branchNo = "";
			var receiver = "";
			var sendFaxNo = "";
			var finesMembNo = "";
			$("li[data-name=bank]").each(function(i){
				membNo += $(this).attr("data-membNo") + "^";
				branchNo += $(this).attr("data-branchNo") + "^";
				receiver += $(this).attr("data-branchNm") + "^";
				sendFaxNo += $(this).attr("data-sendFaxNo") + "^";
				finesMembNo += $(this).attr("data-finesMembNo") + "^";
			});
			
			faxMap = {
				cmd : $("#cmd").val() ,
				maxFileCnt : $("#maxFileCnt").val() ,
				limitSize : $("#limitSize").val() ,
				totFileSize : $("#totFileSize").val() ,
				sizeSF : $("#sizeSF").val() ,
				contents : $("#contents").val() ,
				fileId : $("#fileId").val() ,
				fileMask : $("#fileId").val() ,
				fileNm : $("#fileNm").val() ,
				fileSize : $("#fileSize").val() ,
				fileType : $("#fileType").val() ,
				filePath : $("#filePath").val() ,
				fileCtype : $("#fileCtype").val() ,
				fileCnt : $("#fileCnt").val() ,
				delFileIds : $("#delFileIds").val() ,
				empNo : $("#empNo").val() ,
				regUserNm : $("#regUserNm").val() ,
				regUserFax : $("#regUserFax").val() ,
				susaCaseNo : $("#susaCaseNo").val(),
				membNo : membNo,
				branchNo : branchNo ,
				receiver : receiver ,
				sendFaxNo : sendFaxNo,
				finesMembNo : finesMembNo,
				totalPage : $("#totalPage").val(),
				rcvType : $("#rcvType").val(),
				remk : $("#remk").val()
			}; 
		} else if($("#cmd").val() == "MODIFY") {
			faxMap = {
				cmd : $("#cmd").val() ,
				maxFileCnt : $("#maxFileCnt").val() ,
				limitSize : $("#limitSize").val() ,
				totFileSize : $("#totFileSize").val() ,
				sizeSF : $("#sizeSF").val() ,
				contents : $("#contents").val() ,
				fileId : $("#fileId").val() ,
				fileMask : $("#fileId").val() ,
				fileNm : $("#fileNm").val() ,
				fileSize : $("#fileSize").val() ,
				fileType : $("#fileType").val() ,
				filePath : $("#filePath").val() ,
				fileCtype : $("#fileCtype").val() ,
				fileCnt : $("#fileCnt").val() ,
				delFileIds : $("#delFileIds").val() ,
				sendNo : $("#sendNo").val() ,
				empNo : $("#empNo").val() ,
				regUserNm : $("#regUserNm").val() ,
				regUserFax : $("#regUserFax").val() ,
				membNo : $("#membNo").val() ,
				branchNo : $("#branchNo").val() ,
				receiver : $("#receiver").val() ,
				sendFaxNo : $("#sendFaxNo").val(),
				susaCaseNo : $("#susaCaseNo").val(),
				finesMembNo : $("#finesMembNo").val(),
				totalPage : $("#totalPage").val(),
				rcvType : $("#rcvType").val(),
				remk : $("#remk").val()
			}; 
		}
		
		goAjax("/fax/saveFaxSend.face", faxMap, callBackSaveFaxSendSuccess);
	}
	
	function callBackSaveFaxSendSuccess(data){
		alert("저장 완료되었습니다.");
		location.reload();
	}
	
	//수신처 선택 팝업(수정화면용-단일)
	function openSearchBankPopup(){
		commonLayerPopup.openLayerPopup("/fax/searchBankPopup.face", "530px", "472px", callbackSelectBank);	
	}
	
	function callbackSelectBank(bank){
		$("#membNo").val(bank.membNo);
		$("#branchNo").val(bank.branchNo);
		$("#finesMembNo").val(bank.finesMembNo);
		$("#receiver").val(bank.branchNm);
		$("#sendFaxNo").val(bank.sendFaxNo);
	}
	
	//수신처 선택 팝업(신규화면용-다중)
	function openSearchBankMultiPopup(){
		commonLayerPopup.openLayerPopup("/fax/searchBankMultiPopup.face", "570px", "472px", function(data){callbackSelectBankMulti(data)});	
	}
	
	function callbackSelectBankMulti(data){
		var JsonData = JSON.parse(data);
		
		//기존에 있는 수신처에 추가해서 들어가야함
		var bankData = [];
		var isDuplication = false;
		
		//1.중복체크를 위해 기존 수신처를 배열에 담는다
		$("li[data-name=bank]").each(function(i){
			bankData.push($(this).attr("data-branchNo"));
		});
		
		var bankHtml = new StringBuffer();
		$.each(JsonData.bank, function(i, bank){
			//2.중복체크
			if($.inArray(bank.branchNo, bankData) == -1){
				bankHtml.append('<li data-name="bank" data-finesMembNo="' +bank.finesMembNo+ '" data-membNo="'+bank.membNo+'" data-branchNo="'+bank.branchNo+'" data-branchNm="'+bank.branchNm+'" data-sendFaxNo="'+bank.faxNo+'"><span>'+bank.branchNm+'</span><a href="javascript:void(0);" onclick="removeRcv(this);" class="list_box_close" data-name="removeRcvBtn" data-always="y"><img src="/sjpb/images/btn_box_close.png" alt="닫기 버튼" /></a></li>');
			} else {
				isDuplication = true;
			}
		});
		
		if(isDuplication){
			alert("이미 추가한 수신처입니다.");
		}
		
		$("#rcvList").append(bankHtml.toString());
		autoResize();
	}
	
	//qcell 팩스 전송버튼 그리기
	function fnSendFax(id, row, col, val, obj){
		var html = "";
		
		//본인이 작성한 팩스만 전송가능 
		if($("#userId").val() == obj.empNo){
			if(obj.sendDiv == "0"){	//팩스전송상태가 성공일 경우는 다시 전송하지 않음
				html = "<a href=\"javascript:sendFaxData('"+obj.sendNo+"')\" class=\"btn_white\" ><span>팩스전송</span><a>";
			} else {
				html = "<a href=\"javascript:void(0);\" class=\"btn_grey send\" ><span>전송완료</span></a>";
			}
		}
		
		return html;
	}
	
	//팩스 상태를 '대기중'으로 바꿔 팩스서버에서 팩스내역을 끌어가 전송할 수 있도록 함
	function sendFaxData(sendNo){
		if(confirm("팩스를 발송하면 해당 건은 더 이상 수정이 불가능합니다.\n전송하시겠습니까?")){
			$("#reptNm").val("M0200.crf");
			$("#SENDNUM").val(sendNo);
			$("#POLICENAME").val($("#userId").val());
			$("#isMulti").val("N");
			
			//레포트 호출
			openDownloadReportServiceFSS(reportForm);
		}
	}
	
	function afterPdfMade(sendNo){
		faxMap = {
			sendNo : sendNo,
			filePath : $("#userInfo02").val()
		};
		
		goAjax("/fax/changeSendStatus.face", faxMap, callBacksendFaxDataSuccess);
	}	
	
	function callBacksendFaxDataSuccess(data){
		alert("팩스를 전송했습니다.");
		location.reload();
	}
	
	function openNewFax(){
		insertFaxSendView();
	}
	
	//수신처 삭제
	function removeRcv(obj){
		$(obj).closest("li").remove();
	}
	
	//팩스 멀티 전송
	function sendMultiFax(){
		if(confirm("팩스를 발송하면 더 이상 수정이 불가능합니다. \n전송하시겠습니까?")){
			var fax;
			var sendNo="";
			for(var i=1; i<= qcellFax.getRows("data"); i++){
				if(JSON.stringify(qcellFax.getCellLabel(i, 0)) == "true"){
					fax = qcellFax.getRowData();
					if(fax.empNo != $("#userId").val()){
						alert("본인이 작성한 팩스만 전송가능합니다.");
						return;
					} else if(fax.sendDiv != 0){
						alert("이미 전송한 팩스는 다시 전송할 수 없습니다.");
						return;
					} else {
						sendNo += fax.sendNo + ",";
					}
				}
			}
			
			$("#reptNm").val("M0200.crf");
			$("#SENDNUM").val(sendNo.substring(0, sendNo.length -1));
			$("#POLICENAME").val($("#userId").val());
			$("#isMulti").val("Y");
			
			//레포트 호출
			openDownloadReportServiceFSS(reportForm);
		}
	}
	
	function afterPdfMulti(sendNo){
		faxMap = {
			sendNo : sendNo,
			filePath : $("#userInfo02").val()
		};
		
		goAjax("/fax/changeSendStatusMulti.face", faxMap, callBacksendFaxDataSuccess);
	}
	
</script>
</head>
<body class="iframe">
	<form name="generalData" id="generalData">
		<input type="hidden" id="userId" name="userId" value="${user.userId}" />   <!-- 사용자계정 -->
		<input type="hidden" id="userName" name="userName" value="${user.nmKor}" />  <!-- 사용자이름 -->
		<input type="hidden" id="userFax" name="userFax" value="${user.faxNo}" />  <!-- 사용자팩스 -->
		<input type="hidden" id="emailAddr" name="emailAddr" value="${user.emailAddr}" />  <!-- 사용자팩스 -->
		<input type="hidden" id="offcTel" name="offcTel" value="${user.offcTel}" />  <!-- 사용자팩스 -->
		<input type="hidden" id="userInfo01" name="userInfo01" value="${user.userInfo01}" />  
		<input type="hidden" id="userInfo02" name="userInfo02" value="${user.userInfo02}" />  
		<input type="hidden" id="userInfo03" name="userInfo03" value="${user.userInfo03}" />  
		<input type="hidden" id="todayDateYmd" name="todayDateYmd" value="${todayDateYmd}" />  <!-- 오늘날짜 yyyy-mm-dd -->
	</form>
	<form name="reportForm" method="post">
		<input type="hidden" id="reptNm" name="reptNm" value="" />
		<input type="hidden" id="SENDNUM" name="SENDNUM" value="" />
		<input type="hidden" id="POLICENAME" name="POLICENAME" value="" />
		<input type="hidden" id="isMulti" name="isMulti" value="" />
	</form>
<div id="faxListArea">
	<div class="searchArea" id="searchArea">
		<ul>
			<li><span class="title">금융거래요청번호</span>
				<input type="text" id="srchDocNo" name="srchDocNo" value="" />
			</li>
			<li><span class="title">사건번호</span>
				<div class="inputbox w65per">
					<p class="txt"></p>
					<select id="srchCaseNo" name="srchCaseNo">
						<option value="">전체</option>
						<c:forEach items="${caseList}" var="cse">
							<option value="${cse.rcptNum}">${cse.rcptIncNum}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li><span class="title">담당자</span>
				<input type="text" id="srchUser" name="srchUser" value="" />
			</li>
		</ul>
		<ul>
			<li><span class="title">수신처</span>
				<input type="text" id="srchReceiver" name="srchReceiver" value="" />
			</li>
			<li><span class="title">전송일</span>
				<label for="srchStartDate"></label><input type="text" class="w30per calendar datepicker" id="srchStartDate" name="srchStartDate" value="${today}" data-type="date" data-optional-value="true" title="시작일" readonly="readonly" />
				~<label for="srchEndDate"></label><input type="text" class="w30per calendar datepicker" id="srchEndDate" name="srchEndDate" value="${today}" data-type="date" data-optional-value="true" title="종료일" readonly="readonly" />
			</li>
			<li><span class="title">전송상태</span>
				<div class="inputbox w65per">
					<p class="txt"></p>
					<select id="srchStatus" name="srchStatus">
						<option value="">전체</option>
						<option value="0">작성중</option>
						<option value="1">대기중</option>
						<option value="2">처리중</option>
						<option value="R">처리예약</option>
						<option value="3">송신성공</option>
						<option value="4">송신실패</option>
						<option value="5">송신에러</option>
						<option value="6">부분성공</option>
						<option value="7">취소</option>
						<option value="04">FAX전송완료</option>
						<option value="05">FAX전송오류</option>
						<option value="06">Data접수</option>
						<option value="07">Data처리중</option>
						<option value="08">Data오류</option>
						<option value="09">Data접수완료</option>
						<option value="10">Batch오류</option>
						<option value="11">완료</option>
					</select>
				</div>
			</li>
		</ul>		
		<div class="btnArea">
			<div class="r_btn">
				<a href="javascript:void(0);" id="exceldownIncPrnBtn" class="btn_light_green_line excel"><span>엑셀</span></a>
				<a href="javascript:insertSearchData();" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:selectList();" class="btn_light_blue search_01"><span>검색</span></a>
				<a href="javascript:void(0);" class="btn_light_blue enrollment" onclick="openNewFax();"><span>신규</span></a>
			</div>
		</div>	
	</div>

	<div id="faxGrid" class="listArea area-mousewheel" style="height: 400px; width: 100%">
   	</div>
	<!-- btnArea -->
	<div class="btnArea">
		<div class="r_btn">
			<a href="javascript:void(0);" class="btn_light_blue enrollment" onclick="sendMultiFax();"><span>선택전송</span></a>
		</div>
	</div>
	<!-- btnArea //-->
<div id="faxDetailDiv" style="display:none;">
	<div class="tab_mini_wrap m1">
		<ul>
			<li class="m1"><a href="#" class="tabtitle"><span>FAX 전송정보</span></a>
				<div class="tab_mini_contents" id="faxDetailTab">
					<div class="list">
						<table class="list" cellpadding="0" cellspacing="0">
							<caption>게시판쓰기</caption>
							<colgroup>
								<col width="20%" />
								<col width="15%" />
								<col width="*" />
							</colgroup>
							<form id="editForm" name="editForm" method="post" action="">
					           	<input type="hidden" name="cmd"         id="cmd" 	value=""/>             <%-- 작성 : WRITE, 수정 : MODIFY --%>
	           					<input type="hidden" name="maxFileCnt"  id="maxFileCnt" value="20"/>       <%-- 최대파일 갯수 --%>
					           	<input type="hidden" name="limitSize"   id="limitSize"  value="10485760"/> <%-- 파일별 최대 용량 --%>
					           	<input type="hidden" name="totFileSize" id="totFileSize" />                <%-- 전체 파일사이즈 --%>
					           	<input type="hidden" name="sizeSF"      id="sizeSF" />                     <%-- 파일 사이즈 format --%>
					           	<input type="hidden" name="contents"    id="contents" />                   <%-- 본문내용, 저장시 여기 값이 저장 --%>
					           	<input type="hidden" name="fileId"      id="fileId" />                      
					           	<input type="hidden" name="fileNm"      id="fileNm" />
					           	<input type="hidden" name="fileSize"    id="fileSize" />
					           	<input type="hidden" name="fileType"    id="fileType" />
					           	<input type="hidden" name="filePath"    id="filePath" />
					           	<input type="hidden" name="fileCtype"   id="fileCtype" />
					           	<input type="hidden" name="fileCnt"     id="fileCnt" value="0" />
					           	<input type="hidden" name="delFileIds"  id="delFileIds" />  
					           	
					           	<input type="hidden" name="sendNo" id="sendNo" value="" />
							<tr>
								<th class="C th_line">금융거래요청번호<em class="red">*</em></th>
								<td class="L td_line" colspan="2">
									<input type="hidden" name="docNo" id="docNo" value="" />
									<span id="docNoSpan"></span>
								</td>
							</tr>
							<tr>
								<th class="C th_line">사건번호<em class="red">*</em></th>
								<td class="L td_line" colspan="2">
									<div class="inputbox w100per">
										<p class="txt"></p>                                    
										<select name="susaCaseNo" id="susaCaseNo">
											<option value=""></option>
											<c:forEach items="${caseList}" var="cse">
									   			<option value="${cse.rcptNum}">${cse.rcptIncNum}</option>   
									   		</c:forEach>
										</select>   
									</div>   
								</td>
							</tr>
							<tr>
								<th class="C th_line">총 페이지수</th>
								<td class="L td_line" colspan="2">
									<input type="text" name="totalPage" id="totalPage" value="" style="width:100%;" />
								</td>
							</tr>
							<tr>
								<th class="C th_line">회신타입 선택</th>
								<td class="L td_line" colspan="2">
									<div class="inputbox w100per">
										<p class="txt"></p>                                    
										<select name="rcvType" id="rcvType">
											<option value="0">긴급</option>
											<option value="1">검토요망</option>
											<option value="2">설명요망</option>
											<option value="3">답신요망</option>
											<option value="4">재사용</option>
										</select>   
									</div>   
								</td>
							</tr>
							<tr>
								<th class="C th_line">전송상태</th>
								<td class="L td_line" colspan="2">
									<input type="hidden" name="sendDiv" id=""sendDiv"" value="" />
									<span id="sendDivSpan"></span>
								</td>
							</tr>
							<tr>
								<th class="C th_line r_line" rowspan="2">발신정보</th>
								<th class="C th_line">담당자</th>
								<td class="L td_line">
									<input type="hidden" name="empNo" id="empNo" value="" />
									<input type="hidden" name="regUserNm" id="regUserNm" value="" />
									<span id="regUserSpan"></span>
								</td>
							</tr>
                            <tr>
								<th class="C th_line">FAX번호</th>
								<td class="L td_line">
									<input type="hidden" name="regUserFax" id="regUserFax" value="" />
									<span id="regUserFaxSpan"></span>
								</td>
                            </tr>
                            <tr class="rcvDtl">
								<th class="C th_line r_line" rowspan="2">수신정보</th>
								<th class="C">수신처<em class="red">*</em></th>
								<td class="L">
									<input type="hidden" name="membNo" id="membNo" value="" />
									<input type="hidden" name="branchNo" id="branchNo" value="" />
									<input type="hidden" name="finesMembNo" id="finesMembNo" value="" />
                                	<label for="txt_01"><input type="text" class="w100per" id="receiver" name="receiver" value="" readonly="readonly" /></label>
								</td>
							</tr>
                            <tr class="rcvDtl">
                            	<th class="C th_line">FAX번호<em class="red">*</em></th>
								<td class="L">
                                	<label for="txt_02"><input type="text" class="w100per" id="sendFaxNo" name="sendFaxNo" value="" readonly="readonly" /></label>
                                </td>
                            </tr>
                            <tr class="rcvAdd">
                            	<th class="C th_line">수신정보<em class="red">*</em>&nbsp;&nbsp;<a class="btn_light_blue search_01" id="addRcvBtn"><span>수신처선택</span></a></th>
								<td class="L td_line" colspan="2">
                                	<ul id="rcvList"></ul>
                                </td>
                            </tr>
                            <tr>
                            	<th class="C th_line">비고</th>
								<td class="L td_line" colspan="2">
                                	<input type="text" name="remk" id="remk" value="" style="width:100%;" />
                                </td>
                            </tr>
                            </form>
                            <tr>
                            	<th class="C th_line">첨부파일</th>
                                <td class="L td_line" colspan="2">
			                    	<div id="vault_upload"></div>
									<ul id="vault_fileList" style="display: none;">
<%-- 										<c:forEach items="${faxSend.fileList}" var="fList"> --%>
<%-- 											<li data="<c:out value="${fList.fileId}"/>^<c:out value="${fList.fileNm}"/>^<c:out value="${fList.fileSize}"/>^<c:out value="${fList.fileType}"/>^<c:out value="${fList.filePath}"/>^<c:out value="${fList.fileCtype}"/>"> --%>
<%-- 												<a href="#"><c:out value="${fList.fileNm}"/>(<c:out value="${fList.fileSize}"/>)</a> --%>
<!-- 											</li> -->
<%-- 										</c:forEach> --%>
									</ul>
									<form name="setFileList" method="post" target="invisible" action="${cPath}/sjpb/fileMngr?cmd=delete">
	                                    <input type=hidden name=semaphore value="${semaphore}">
										<input type=hidden name=vaccum> 
										<input type=hidden name=delBoardId value="">
										<input type=hidden name=unDelList> 
										<input type=hidden name=delList> 
										<input type=hidden name=subId value=sub01>
                                   </form>
                                </td>
                            </tr>
						</table>
					</div>
					<!-- btnArea -->
					<div class="btnArea" id="saveBtnArea">
						<div class="r_btn"><a href="javascript:faxSave();" class="btn_light_blue enrollment" id="popSaveBtn"><span>저장</span></a></div>
					</div>
					<!-- btnArea //-->
				</div>
			</li>
		</ul>
    </div>
</div>
<iframe name='invisible' frameborder="0" width="0" height="0"></iframe>
</body>
</html>
