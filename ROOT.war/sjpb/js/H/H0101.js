$(document).ready(function(){
	pageInit();
});

var h0101VOMap = new Object();
var isInitStyleQcell = false;
var headerRows ; 	//헤더라인수 
var rowIdx ;	//선택한 인덱스 전역변수관리
var qcell;

//화면 진입시 동작함
function pageInit(){
//	selectList();
	doSearch();
	
	//이벤트바인딩
	eventSetup();
}

//이벤트 세팅
function eventSetup() {
	
	$(".searchArea input[type=text]").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			doSearch();
		}
	});
	
	//출력 버튼 클릭
	$("#prnBtn").off("click").on("click", function() {		
		prnIntiInc();
	});
		
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "디지털포렌지_업무현황",
				url: '/excelDownload.face',
				border: true, // border 처리
				headershow: true, // header 출력
				colwidth: true, // col의 width 'px' 적용
				huge: false //대용량 여부

			};
		qcell.excelDownload(properties);
		
		
	  });
}

//사건 검색 매체연번 따오기
function fn_H_searchInc(){
	
	if($("#txt_04").val() != null && $("#txt_04").val() != "" && $("#txt_04").val() != " "){
		
		var reqMap = {
				"rcptIncNum" : $("#txt_04").val() 
		}
		//사건검색 매체연번, 지원번호 가져오기
		goAjaxDefault("/sjpb/H/selectMediSiNumMax.face", reqMap, callBackFn_H_searchIncSuccess);
	}else{
		alert("사건번호를 입력해주세요.");
		return;
	}
}

//사건검색 매체연번, 지원번호 가져오기 성공함수
function callBackFn_H_searchIncSuccess(data){
	
	debugger;
	$("#mediSiNum_0").val(data);
//	$("#txt_01").val(data.recdSiNum);
	$("#rcptChk").val("chk");
}

	
//출력 
function prnIntiInc(){
	selectListReport();
}

//리포트 리스트를 가져온다. 
function selectListReport(){
	goAjax("/sjpb/H/selectList.face", h0101SCMap, callBackSelectListReportSuccess);
}

//리포트 리스트 콜백 성공함수
function callBackSelectListReportSuccess(data){
	h0101RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(h0101RTMap);
	
	$("#reptNm").val("H0101.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  
	
}

//검색조건 초기화
function initSearchData(){
	var searchArea = $("div[class=searchArea]");
	
	//input 값 초기화
	searchArea.find("input[type=text]").val("");
	
	//select 값 초기화
	searchArea.find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	
	//검색맵 초기화
	initH0101SCMap();
}


//리스트 검색
function doSearch(){

	h0101SCMap.incNumSc = getFieldValue($("#incNumSc"));
	h0101SCMap.forsSuppPublYrSc = getFieldValue($("#forsSuppPublYrSc"));
	h0101SCMap.criTmSc = getFieldValue($("#criTmSc"));
	h0101SCMap.sDateSc = getFieldValue($("#sDateSc"));
	h0101SCMap.eDateSc = getFieldValue($("#eDateSc"));
	
	goAjax("/sjpb/H/selectList.face", h0101SCMap, callBackSelectListSuccess);
}

//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
	initH0101VOMap();
	
	//입력필드 초기화 
	var _$targetObj = $("#contentsArea");
	
	//input 값 초기화
	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	//_$targetObj.find("input[type=checkbox]:checked").prop("checked", false);
	
	//신규입력 or 수정 화면 컨트롤
	if (type == 0){
		//$("#subTitle").html("신규");
	}else{
		//$("#subTitle").html("상세보기");
	}
	
}

//디지털포렌식지원업무현황 화면(리스트)조회 (ajax)
function selectList(forsSuppSiNum){
	goAjax("/sjpb/H/selectList.face", h0101SCMap, function (data){callBackSelectListSuccess(data, forsSuppSiNum)});
}

//디지털포렌식지원업무현황 화면(리스트)조회 성공 콜백함수
function callBackSelectListSuccess(data, forsSuppSiNum){
	
	var QCELLProp = {
            "parentid" : "sheet",
            "id"		: "qcell",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '5%',  key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
            	{width: '10%',	key: 'forsSuppPublYr',			title: ['발행년도'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'recdSiNum',			title: ['연번'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'incNum',				title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'docuNum',				title: ['지원문서번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'criTm',				title: ['수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'respIo',				title: ['담당수사관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'collDt',				title: ['수집일시'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'mediCount',				title: ['매체건수'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
            	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
        };
	
		
        QCELL.create(QCELLProp);
        qcell = QCELL.getInstance("qcell");
        headerRows = qcell.getRows("header");
        
        qcell.bind("click", eventFn);
        
        if (qcell.getRows("data") > 0) {
        	
        	//최초 로딩시
        	if(forsSuppSiNum == null){	//forsSuppSiNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		//debugger;
        		selectSuppWork(qcell.getRowData(rowIdx).forsSuppSiNum);
        	//수정 후, 로딩시
        	}else{
        		selectSuppWork(forsSuppSiNum);
        	}
        	
        	//qcell 첫번째줄에 초기 커스텀 스타일 추가 (후에, 클릭시 스타일 제거) 
    		var colCnt = qcell.getCols();
    		for (var i = 0; i < colCnt; i++) {
				qcell.setCellStyle(rowIdx, i, {"background-color" : "#c1c8e8 !important", "border-color" : "#a8b0d4 !important"});
				isInitStyleQcell = true;
			}
        	
        //데이터가 없을경우
        } else {
        	rowIdx = 0 + headerRows;
        	insertSuppWorkView();  //No Data 신규등록화면 노출
        	
        }
}

//포렌식지원업무현황을 가져온다.
function selectSuppWork(forsSuppSiNum){
	var reqMap = {
			forsSuppSiNum : forsSuppSiNum
		}
	goAjaxDefault("/sjpb/H/selectSuppWork.face", reqMap, callBackSelectSuppWorkSuccess);
}

//포렌식지원업무현황 가져오기 성공 콜백함수
function callBackSelectSuppWorkSuccess(data){
	
	//초기화
	initData("1");
	
	h0101VOMap = data.h0101VO;
	
	if(h0101VOMap == null){
		if(data.searchInc == "searchInc"){
		
		}else{
			alert("포렌식지원업무현황 데이터에 문제가 있습니다. 관리자에게 문의하세요.");
			return;
		}		
	}
	
	//정보 셋팅 (테이블 그리기)
	var forsHtml = new StringBuffer();
	
	forsHtml.append('<table class="list" cellpadding="0" cellspacing="0">																																								');
	forsHtml.append('	<caption>지원정보</caption>                                                                                                                                                                                         ');
	forsHtml.append('	<colgroup>                                                                                                                                                                                                      ');
	forsHtml.append('		<col width="15%" />                                                                                                                                                                                         ');
	forsHtml.append('		<col width="35%" />                                                                                                                                                                                         ');
	forsHtml.append('		<col width="15%" />                                                                                                                                                                                         ');
	forsHtml.append('		<col width="35%" />                                                                                                                                                                                         ');
	forsHtml.append('	</colgroup>                                                                                                                                                                                                     ');
	forsHtml.append(' <tbody>                                                                                                                                                                                                         ');
	forsHtml.append('	 <tr>                                                                                                                                                                                                           ');
	forsHtml.append('		<th class="C th_line ">지원번호 <em class=\"red\">*</em></th>                                                                                                                                                                            ');
	forsHtml.append('		<td class="L td_line "><label for="txt_01"></label><input type="text" class="w100per" id="txt_01" name="recdSiNum" title="지원번호" data-type="required" value="'+h0101VOMap.recdSiNum+'"/></td>                                                  ');
	forsHtml.append('		<th class="C th_line ">지원문서번호</th>                                                                                                                                                                          ');
	forsHtml.append('		<td class="L td_line "><label for="txt_02"></label><input type="text" class="w100per" id="txt_02" name="docuNum" value="'+h0101VOMap.docuNum+'"/></td>                                                                                      ');
	forsHtml.append('	</tr>                                                                                                                                                                                                           ');
	forsHtml.append('	<tr>                                                                                                                                                                                                            ');
	forsHtml.append('		<th class="C th_line ">수집일시 <em class=\"red\">*</em></th>                                                                                                                                                                            ');
	forsHtml.append('		<td class="L td_line "><label for="txt_03"></label><input type="text" class="w100per calendar datepicker" data-type="date" data-optional-value="true" title="수집일시" id="txt_03" name="collDt" value="'+h0101VOMap.collDt+'"/></td>          ');
	forsHtml.append('		<th class="C th_line ">사건번호 <em class=\"red\">*</em></th>                                                                                                                                                                            ');
	forsHtml.append('		<td class="L td_line "><label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="incNum" value="'+h0101VOMap.incNum+'"/></td>                                                                                       ');
	forsHtml.append('	</tr>                                                                                                                                                                                                           ');
	forsHtml.append('	<tr>                                                                                                                                                                                                            ');
	forsHtml.append('		<th class="C th_line ">수사팀</th>                                                                                                                                                                             ');
	forsHtml.append('		<td class="L td_line "><label for="txt_05"></label><input type="text" class="w100per" id="txt_05" name="criTm" value="'+h0101VOMap.criTm+'"/></td>                                                                                        ');
	forsHtml.append('		<th class="C th_line ">담당수사관</th>                                                                                                                                                                           ');
	forsHtml.append('		<td class="L td_line "><label for="txt_06"></label><input type="text" class="w100per" id="txt_06" name="respIo" value="'+h0101VOMap.respIo+'"/></td>                                                                                       ');
	forsHtml.append('	</tr>                                                                                                                                                                                                           ');
	forsHtml.append(' </tbody>                                                                                                                                                                                                        ');
	forsHtml.append('</table>                                                                                                                                                                                                         ');
	
	
	$.each(h0101VOMap.forsSuppMediVOList, function(i, forsSuppMedi) {
		
		//매체정보 
		forsHtml.append('<div class="mediinfo" data-name="mediinfo">                                                                                                                                                                                                                                ');
		/*
		forsHtml.append('<div class="btnArea">                                                                                                                                                                                                                                ');
		forsHtml.append('   <div class="r_btn">                                                                                                                                                                                                                                  ');
		forsHtml.append('	   <a name="sp_add_btn" onclick="javascript:spAdd(this);" href="javascript:void(0);"><img src="/sjpb/images/plus_icon.png" alt="더하기버튼" /></a>                                                                                                                                           ');
		forsHtml.append('	   <a name="sp_sub_btn" onclick="javascript:spSub(this);" href="javascript:void(0);"><img src="/sjpb/images/minus_icon.png" alt="빼기버튼" /></a>                                                                                                                                           ');
		forsHtml.append('	   <a name="sp_up_btn" onclick="javascript:spUp(this);" href="javascript:void(0);"><img src="/sjpb/images/Add_icon.png" alt="올리기버튼" /></a>                                                                                                                                            ');
		forsHtml.append('	   <a name="sp_down_btn" onclick="javascript:spDown(this);" href="javascript:void(0);"><img src="/sjpb/images/delete_icon.png" alt="내리기버튼" /></a>                                                                                                                                         ');
		forsHtml.append('   </div>                                                                                                                                                                                                                                            ');
		forsHtml.append('</div>                                                                                                                                                                                                                                               ');
		*/
		forsHtml.append('<table name="grid-table-medi" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
		forsHtml.append('	<input type="hidden" name="forsSuppMediSiNum" value="'+forsSuppMedi.forsSuppMediSiNum+'" />  ');
		forsHtml.append('	<input type="hidden" name="updateCd" value="U" />   ');
		forsHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
		forsHtml.append('   <col width="10%" />                                                                                                                                                                                                                               ');
		forsHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		forsHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		forsHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		forsHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		forsHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
		forsHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C line_right" rowspan="11">매체정보</th>                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">매체연번</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="mediSiNum_'+i+'"></label><input type="text" class="w100per" id="mediSiNum_'+i+'" name="mediSiNum" value="'+forsSuppMedi.mediSiNum+'" disabled="true" data-always="y" title="매체연번"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('		   <th class="C">피압수자</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="revSeizPers_'+i+'"></label><input type="text" class="w100per" id="revSeizPers_'+i+'" name="revSeizPers" title="피압수자" value="'+forsSuppMedi.revSeizPers+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">업체명(주소)</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="compNmAddr_'+i+'"></label><input type="text" class="w100per" id="compNmAddr_'+i+'" name="compNmAddr" title="업체명(주소)" value="'+forsSuppMedi.compNmAddr+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('		   <th class="C">압수수사관</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="seizIo_'+i+'"></label><input type="text" class="w100per" id="seizIo_'+i+'" name="seizIo" title="압수수사관" value="'+forsSuppMedi.seizIo+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">매체구분</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <div class="inputbox w100per">                                                                                                                                                                                                           ');
		
		var mediDivName = "";
		var mediCodeHtml = new StringBuffer();
		if(isNull(forsSuppMedi.mediDiv)){
			mediDivName = "선택";
		}
		mediCodeHtml.append('						<option value="">선택</option>                                                                                                          ');
		$.each(data.mediDivKndList, function(i, mediDiv) {
			if(forsSuppMedi.mediDiv == mediDiv.code){
				mediDivName = mediDiv.name;
			}
			
			mediCodeHtml.append('						<option value="'+mediDiv.code+'" '+(forsSuppMedi.mediDiv == mediDiv.code ? "selected=\"selected\"":"")+'>'+mediDiv.codeName+'</option>                                                                                                          ');
		});
		forsHtml.append('			   <p class="txt">'+mediDivName+'</p>                                                                                                                                                                                                                      ');
		forsHtml.append('				   <select id="mediDiv_'+i+'" name="mediDiv" title="매체구분">                                                                                                                                                                                                                             ');
		forsHtml.append('				   		<option value="">선택</option>							');
		forsHtml.append(mediCodeHtml);
		forsHtml.append('				   </select>                                                                                                                                                                                                                            ');
		forsHtml.append('			   </div>                                                                                                                                                                                                                                   ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		
		forsHtml.append('		   <th class="C">매체종류</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <div class="inputbox w100per">                                                                                                                                                                                                           ');
		var mediTypeName = "";
		var mediTypeCodeHtml = new StringBuffer();
		if(isNull(forsSuppMedi.mediType)){
			mediTypeName = "선택";
		}
		mediTypeCodeHtml.append('						<option value="">선택</option>                                                                                                          ');
		var mediTypeCodeHtml = new StringBuffer();
		$.each(data.mediTypeKndList, function(i, mediType) {
			if(forsSuppMedi.mediType == mediType.code){
				mediTypeName = mediType.name;
			}
			
			mediTypeCodeHtml.append('						<option value="'+mediType.code+'" '+(forsSuppMedi.mediType == mediType.code ? "selected=\"selected\"":"")+'>'+mediType.codeName+'</option>                                                                                                          ');
		});
		forsHtml.append('			   <p class="txt">'+mediTypeName+'</p>                                                                                                                                                                                                                      ');
		forsHtml.append('				   <select id="mediType_'+i+'" name="mediType" title="매체종류">                                                                                                                                                                                                                             ');
		forsHtml.append('				   		<option value="">선택</option>							');
		forsHtml.append(mediTypeCodeHtml);
		forsHtml.append('				   </select>                                                                                                                                                                                                                            ');
		forsHtml.append('			   </div>                                                                                                                                                                                                                                   ');
		
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">전화번호</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="phonNum_'+i+'"></label><input type="text" class="w100per" id="phonNum_'+i+'" name="phonNum" title="전화번호" value="'+forsSuppMedi.phonNum+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('		   <th class="C">제조사</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="maftInfo_'+i+'"></label><input type="text" class="w100per" id="maftInfo_'+i+'" name="maftInfo" title="제조사" value="'+forsSuppMedi.maftInfo+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">모델명</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="modlNm_'+i+'"></label><input type="text" class="w100per" id="modlNm_'+i+'" name="modlNm" title="모델명" value="'+forsSuppMedi.modlNm+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('		   <th class="C">S/N</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="siNum_'+i+'"></label><input type="text" class="w100per" id="siNum_'+i+'" name="siNum" title="S/N" value="'+forsSuppMedi.siNum+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">매체내용</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="mediCont_'+i+'"></label><input type="text" class="w100per" id="mediCont_'+i+'" name="mediCont" title="매체내용" value="'+forsSuppMedi.mediCont+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">분석관</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="anasOffi_'+i+'"></label><input type="text" class="w100per" id="anasOffi_'+i+'" name="anasOffi" title="분석관" value="'+forsSuppMedi.anasOffi+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('		   <th class="C">분석일시</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="anasDt_'+i+'"></label><input type="text" class="w100per calendar datepicker" data-type="date" data-optional-value="true" data-name="anasDt"  id="anasDt_'+i+'" name="anasDt_'+i+'" title="분석일시" value="'+forsSuppMedi.anasDt+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">참관여부</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		
		//첫번재 클래스 
		var classTmp = "";
		$.each(data.obsrYnKndList, function(j, obsrYn) {
			
			classTmp = "";
			if(j == 0){
				classTmp = " radio_first";
			}
			
			forsHtml.append('			   <input id="obsrYn_'+i+'_'+j+'" name="obsrYn_'+i+'" data-name="obsrYn" type="radio" class="radio_pd'+classTmp+'" value="'+obsrYn.code+'" '+(forsSuppMedi.obsrYn == obsrYn.code ? "checked=\"checked\"":"")+'/><label for="obsrYn_'+i+'_'+j+'">'+obsrYn.codeName+'</label>                                                                                                               ');
		});
		
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('		   <th class="C">참관일</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="obsrDt_'+i+'"></label><input type="text" class="w100per calendar datepicker" data-type="date" data-optional-value="true"  id="obsrDt_'+i+'" disabled="true" name="obsrDt" title="참관일" value="'+forsSuppMedi.obsrDt+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">참관인</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="obsrPern_'+i+'"></label><input type="text" class="w100per" id="obsrPern_'+i+'" name="obsrPern" title="참관인" value="'+forsSuppMedi.obsrPern+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('		   <th class="C">비고</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="obsrRmComn_'+i+'"></label><input type="text" class="w100per" id="obsrRmComn_'+i+'" name="obsrRmComn" title="비고" value="'+forsSuppMedi.obsrRmComn+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">송치일시</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="digtTrfDt_'+i+'"></label><input type="text" class="w100per calendar datepicker" id="digtTrfDt_'+i+'" name="digtTrfDt" title="송치일시" value="'+forsSuppMedi.digtTrfDt+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('		   <th class="C">순번</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="digtTrfSiNum_'+i+'"></label><input type="text" class="w100per" id="digtTrfSiNum_'+i+'" name="digtTrfSiNum" title="순번" value="'+forsSuppMedi.digtTrfSiNum+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		forsHtml.append('		   <th class="C">관리번호</th>                                                                                                                                                                                                                        ');
		forsHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                               ');
		forsHtml.append('			   <label for="digtTrfMngNum_'+i+'"></label><input type="text" class="w100per" id="digtTrfMngNum_'+i+'" name="digtTrfMngNum" title="관리번호" value="'+forsSuppMedi.digtTrfMngNum+'"/>                                                                                                                                                    ');
		forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		
		forsHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		forsHtml.append('</table>                                                                                                                                                                                                                                             ');
			
		forsHtml.append('</div>                                                                                                                                                                                                                                               ');
		
	});

	forsHtml.append('<div class="btnArea" id="criArea02">                                                                                                                                                                                                                                ');
	forsHtml.append('   <div class="r_btn" id="btnArea_EditButtons"><a href="javascript:updateSuppWork();" class="btn_light_blue_line appointed"><span>수정</span></a></div>                                                                                                                     ');
	forsHtml.append('</div>                                                                                                                                                                                                                                               ');
	
	$("#tab_mini_m1_contents").html(forsHtml.toString());	
	
	
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});
	
	handleUI();
	
	setDefaultEvent();
	
	eventSupMediSetup();
	
	//화면사이즈 갱신
	autoResize();
}

//수정 
function updateSuppWork(){
	//Map 데이터 갱신
	if(syncH0101VOMap(true)){
		goAjax("/sjpb/H/updateSuppWork.face", h0101VOMap, callBackUpdateSuppWorkSuccess);
	}
}

//수정 성공 콜백함수 
function callBackUpdateSuppWorkSuccess(data){
	alert("수정되었습니다.");
	//리스트재조회
	selectList(data.h0101VO.forsSuppSiNum);
}

//상황에 맞는 화면노출
function handleUI(){
	
	//버튼 리스트 그리기
	var btnHtml = new StringBuffer();
	
	//신규 등록일 경우, 저장 버튼 노출 
	if(isNull(h0101VOMap.forsSuppSiNum)){
		btnHtml.append('<a href="javascript:insertSuppWork();" class="btn_light_blue save"><span>저장</span></a>');
		
	//수정일 경우, 수정 버튼 노출 
	}else{
		btnHtml.append('<a href="javascript:updateSuppWork();" class="btn_light_blue_line appointed"><span>수정</span></a>');
		
	}
	
	$("#btnAreaDiv").html(btnHtml.toString());
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	
	//선택한 인덱스 가져오기
	rowIdx = qcell.getIdx("row");
	
	//qcell 커스텀 스타일이 있는경우, 제거 
	if(isInitStyleQcell){
		qcell.clearCellStyles();
		isInitStyleQcell = false;
	}
	
	//포렌식지원업무현황상세 호출(헤더영역 아래부분 클릭했을시만)
	if (rowIdx > headerRows -1) {
		selectSuppWork(qcell.getRowData(rowIdx).forsSuppSiNum);
	}
}

//삭제 
function deleteSuppWork(){
	
	//TODO 처리 ?
//	//포렌식 담당자만 삭제 가능 
//	if(SJPBRole.getDgtFrsRoleYn()){
//		
//	}
	
	//선택된 ROW가져오기
	var h0101VOArray = [];
	
	for(var i = 0; i < qcell.getColData(0).length; i++){
		if(qcell.getColData(0)[i] == true){
			
//			var h0101VOTmp = new Object();
			//h0101VOTmp = qcell.getRowData(i+1);
//			h0101VOTmp = qcell.getRowData(i+headerRows).forsSuppSiNum;
			
			h0101VOArray.push(qcell.getRowData(i+headerRows).forsSuppSiNum);
		}
	}
	
	//체크여부확인 
	if(h0101VOArray.length == 0){
		alert("하나이상 체크해주세요.");
		return;
	}
	
	//병합한다.
	if(confirm("삭제하시겠습니까?") == true){
		var reqMap = {
				"forsSuppSiNumList" : h0101VOArray
		}
		
		goAjaxDefault("/sjpb/H/deleteSuppWork.face", reqMap, callBackDeleteSuppWorkSuccess);
	}else{
		return;
	}
}

//삭제 성공 콜백 함수 
function callBackDeleteSuppWorkSuccess(data){
	//성공
	if(data.h0101VO.result == "01"){
		alert("삭제되었습니다.");
		
		//리스트재조회
		selectList();
		
	}else{
		var errMsg = "";
		if(data.h0101VO.errMsg != null){
			errMsg = data.h0101VO.errMsg;
		}else{
			errMsg = "삭제 실패 관리자에 문의해주세요.";
		}
		alert(errMsg);
	}
}


//신규 입력 화면 노출 
function insertSuppWorkView(){
	goAjaxDefault("/sjpb/H/insertSuppWorkView.face", null, callBackInsertSuppWorkViewSuccess);
}

//신규등록 화면 노출 성공 콜백함수 
function callBackInsertSuppWorkViewSuccess(data){
	//초기화 
	initData("0");
	
	
	//정보 셋팅 (테이블 그리기)
	var forsHtml = new StringBuffer();
	forsHtml.append('<input type="hidden" id="rcptChk" name="rcptChk">');
	forsHtml.append('<table class="list" cellpadding="0" cellspacing="0">																																								');
	forsHtml.append('	<caption>지원정보</caption>                                                                                                                                                                                         ');
	forsHtml.append('	<colgroup>                                                                                                                                                                                                      ');
	forsHtml.append('		<col width="15%" />                                                                                                                                                                                         ');
	forsHtml.append('		<col width="35%" />                                                                                                                                                                                         ');
	forsHtml.append('		<col width="15%" />                                                                                                                                                                                         ');
	forsHtml.append('		<col width="35%" />                                                                                                                                                                                         ');
	forsHtml.append('	</colgroup>                                                                                                                                                                                                     ');
	forsHtml.append(' <tbody>                                                                                                                                                                                                         ');
	forsHtml.append('	 <tr>                                                                                                                                                                                                           ');
	forsHtml.append('		<th class="C th_line ">지원번호 <em class=\"red\">*</em></th>                                                                                                                                                                            ');
	forsHtml.append('		<td class="L td_line "><label for="txt_01"></label><input type="text" class="w100per" id="txt_01" name="recdSiNum" title="지원번호" data-type="number"/></td>                                                  ');
	forsHtml.append('		<th class="C th_line ">지원문서번호</th>                                                                                                                                                                          ');
	forsHtml.append('		<td class="L td_line "><label for="txt_02"></label><input type="text" class="w100per" id="txt_02" name="docuNum"/></td>                                                                                      ');
	forsHtml.append('	</tr>                                                                                                                                                                                                           ');
	forsHtml.append('	<tr>                                                                                                                                                                                                            ');
	forsHtml.append('		<th class="C th_line ">수집일시 <em class=\"red\">*</em></th>                                                                                                                                                                            ');
	forsHtml.append('		<td class="L td_line "><label for="txt_03"></label><input type="text" class="w100per calendar datepicker" data-type="date" data-optional-value="true" title="수집일시" id="txt_03" name="collDt"/></td>          ');
	forsHtml.append('		<th class="C th_line ">사건번호 <em class=\"red\">*</em></th>                                                                                                                                                                            ');
//	forsHtml.append('		<td class="L td_line "><label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="incNum"/></td>                                                                                       ');
	forsHtml.append('		<td class="L td_line "><p class="searchinput"><label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="incNum" data-always="y" title="사건번호" data-type="required" /><a name="spBtn" class="btn_search" id="spBtn" href="javascript:fn_H_searchInc();"><img alt="search" src="/sjpb/images/btn_search.png"></a></p>	</td>                                                                                       ');
	forsHtml.append('	</tr>                                                                                                                                                                                                           ');
	forsHtml.append('	<tr>                                                                                                                                                                                                            ');
	forsHtml.append('		<th class="C th_line ">수사팀</th>                                                                                                                                                                             ');
	forsHtml.append('		<td class="L td_line "><label for="txt_05"></label><input type="text" class="w100per" id="txt_05" name="criTm"/></td>                                                                                        ');
	forsHtml.append('		<th class="C th_line ">담당수사관</th>                                                                                                                                                                           ');
	forsHtml.append('		<td class="L td_line "><label for="txt_06"></label><input type="text" class="w100per" id="txt_06" name="respIo"/></td>                                                                                       ');
	forsHtml.append('	</tr>                                                                                                                                                                                                           ');
	forsHtml.append(' </tbody>                                                                                                                                                                                                        ');
	forsHtml.append('</table>                                                                                                                                                                                                         ');
	

	//매체정보 
	forsHtml.append('<div class="mediinfo" data-name="mediinfo">                                                                                                                                                                                                                                ');
	/*
	forsHtml.append('<div class="btnArea">                                                                                                                                                                                                                                ');
	forsHtml.append('   <div class="r_btn">                                                                                                                                                                                                                                  ');
	forsHtml.append('	   <a name="sp_add_btn" onclick="javascript:spAdd(this);" href="javascript:void(0);"><img src="/sjpb/images/plus_icon.png" alt="더하기버튼" /></a>                                                                                                                                           ');
	forsHtml.append('	   <a name="sp_sub_btn" onclick="javascript:spSub(this);" href="javascript:void(0);"><img src="/sjpb/images/minus_icon.png" alt="빼기버튼" /></a>                                                                                                                                           ');
	forsHtml.append('	   <a name="sp_up_btn" onclick="javascript:spUp(this);" href="javascript:void(0);"><img src="/sjpb/images/Add_icon.png" alt="올리기버튼" /></a>                                                                                                                                            ');
	forsHtml.append('	   <a name="sp_down_btn" onclick="javascript:spDown(this);" href="javascript:void(0);"><img src="/sjpb/images/delete_icon.png" alt="내리기버튼" /></a>                                                                                                                                         ');
	forsHtml.append('   </div>                                                                                                                                                                                                                                            ');
	forsHtml.append('</div>                                                                                                                                                                                                                                               ');
	*/
	forsHtml.append('<table name="grid-table-medi" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
	forsHtml.append('	<input type="hidden" name="forsSuppMediSiNum" value="" />  ');
	forsHtml.append('	<input type="hidden" name="updateCd" value="C" />   ');
	forsHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
	forsHtml.append('   <col width="10%" />                                                                                                                                                                                                                               ');
	forsHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
	forsHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
	forsHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
	forsHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
	forsHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
	forsHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C line_right" rowspan="11">매체정보</th>                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">매체연번</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="mediSiNum_0"></label><input type="text" class="w100per" id="mediSiNum_0" name="mediSiNum" value="1" disabled="true" data-always="y" title="매체연번" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">피압수자</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="revSeizPers_0"></label><input type="text" class="w100per" id="revSeizPers_0" name="revSeizPers" title="피압수자" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">업체명(주소)</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="compNmAddr_0"></label><input type="text" class="w100per" id="compNmAddr_0" name="compNmAddr" title="업체명(주소)" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">압수수사관</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="seizIo_0"></label><input type="text" class="w100per" id="seizIo_0" name="seizIo" title="압수수사관" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">매체구분</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <div class="inputbox w100per">                                                                                                                                                                                                           ');
	var mediCodeHtml = new StringBuffer();
	$.each(data.mediDivKndList, function(i, mediDiv) {
		mediCodeHtml.append('						<option value="'+mediDiv.code+'" >'+mediDiv.codeName+'</option>                                                                                                          ');
	});
	forsHtml.append('			   <p class="txt">선택</p>                                                                                                                                                                                                                      ');
	forsHtml.append('				   <select id="mediDiv" name="mediDiv" title="매체구분">                                                                                                                                                                                                                             ');
	forsHtml.append('				   		<option value="">선택</option>							');
	forsHtml.append(mediCodeHtml);
	forsHtml.append('				   </select>                                                                                                                                                                                                                            ');
	forsHtml.append('			   </div>                                                                                                                                                                                                                                   ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">매체종류</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <div class="inputbox w100per">                                                                                                                                                                                                           ');
	var mediTypeCodeHtml = new StringBuffer();
	$.each(data.mediTypeKndList, function(i, mediType) {
		mediTypeCodeHtml.append('						<option value="'+mediType.code+'" >'+mediType.codeName+'</option>                                                                                                          ');
	});
	forsHtml.append('			   <p class="txt">선택</p>                                                                                                                                                                                                                      ');
	forsHtml.append('				   <select id="mediType" name="mediType" title="매체종류">                                                                                                                                                                                                                             ');
	forsHtml.append('				   		<option value="">선택</option>							');
	forsHtml.append(mediTypeCodeHtml);
	forsHtml.append('				   </select>                                                                                                                                                                                                                            ');
	forsHtml.append('			   </div>                                                                                                                                                                                                                                   ');
	
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">전화번호</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="phonNum_0"></label><input type="text" class="w100per" id="phonNum_0" name="phonNum" title="전화번호" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">제조사</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="maftInfo_0"></label><input type="text" class="w100per" id="maftInfo_0" name="maftInfo" title="제조사" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">모델명</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="modlNm_0"></label><input type="text" class="w100per" id="modlNm_0" name="modlNm" title="모델명" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">S/N</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="siNum_0"></label><input type="text" class="w100per" id="siNum_0" name="siNum" title="S/N" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">매체내용</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="mediCont_0"></label><input type="text" class="w100per" id="mediCont_0" name="mediCont" title="매체내용" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">분석관</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="anasOffi_0"></label><input type="text" class="w100per" id="anasOffi_0" name="anasOffi" title="분석관" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">분석일시</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="anasDt_0"></label><input type="text" class="w100per calendar datepicker" data-type="date" data-optional-value="true" data-name="anasDt" id="anasDt_0" name="anasDt_0" title="분석일시"/>                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">참관여부</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	
	//첫번재 클래스 
	var classTmp = "";
	$.each(data.obsrYnKndList, function(j, obsrYn) {
		classTmp = "";
		if(j == 0){
			classTmp = " radio_first";
		}
		
		forsHtml.append('			   <input id="obsrYn_'+j+'"  name="obsrYn_'+'0'+'" data-name="obsrYn" type="radio" class="radio_pd'+classTmp+'" value="'+obsrYn.code+'" '+(j == 1 ? "checked=\"checked\"":"")+'/><label for="obsrYn_'+j+'">'+obsrYn.codeName+'</label>                                                                                                               ');
	});
	
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">참관일</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="obsrDt_0"></label><input type="text" class="w100per datepicker" data-type="date" data-optional-value="true"  id="obsrDt_0" name="obsrDt" title="참관일" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">참관인</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="obsrPern_0"></label><input type="text" class="w100per" disabled="true" id="obsrPern_0" name="obsrPern" title="참관인" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">비고</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="obsrRmComn_0"></label><input type="text" class="w100per" disabled="true" id="obsrRmComn_0" name="obsrRmComn" title="비고" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">송치일시</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="digtTrfDt_0"></label><input type="text" class="w100per calendar datepicker" data-type="date" data-optional-value="true" id="digtTrfDt_0" name="digtTrfDt" title="송치일시" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('		   <th class="C">순번</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="digtTrfSiNum_0"></label><input type="text" class="w100per" id="digtTrfSiNum_0" name="digtTrfSiNum" title="순번" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	forsHtml.append('		   <th class="C">관리번호</th>                                                                                                                                                                                                                        ');
	forsHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                               ');
	forsHtml.append('			   <label for="digtTrfMngNum_0"></label><input type="text" class="w100per" id="digtTrfMngNum_0" name="digtTrfMngNum" title="관리번호" />                                                                                                                                                    ');
	forsHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	forsHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	
	forsHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
	forsHtml.append('</table>                                                                                                                                                                                                                                             ');
		
	forsHtml.append('</div>                                                                                                                                                                                                                                               ');

	forsHtml.append('<div class="btnArea" id="criArea02">                                                                                                                                                                                                                                ');
	forsHtml.append('   <div class="r_btn" id="btnArea_EditButtons"><a href="javascript:insertSuppWork();" class="btn_light_blue save"><span>등록</span></a></div>                                                                                                                     ');
	forsHtml.append('</div>                                                                                                                                                                                                                                               ');
	
	$("#tab_mini_m1_contents").html(forsHtml.toString());	
	
	
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});
	
	
	var userName = $("#userName").val();	
	$("#anasOffi_0").val(userName);	
	
	
	handleUI();
	
	setDefaultEvent();
	
	eventSupMediSetup();
	
	//화면사이즈 갱신
	autoResize();
}

//신규 저장
function insertSuppWork(){
	//Map 데이터 갱신
	if($("#rcptChk").val() == "chk"){
		
		var collDtChk = $("input[name=collDt]").val();
		if(collDtChk == null || collDtChk == "" || collDtChk == " " ){
			alert("수집일시를 입력하세요.");
			return;
		}
		if(syncH0101VOMap(true)){
			
			goAjax("/sjpb/H/insertSuppWork.face", h0101VOMap, callBackInsertSuppWorkSuccess);
		}
	}else{
		alert("포렌식사건번호 유무를 확인해주세요.");
		return;
	}
}

//신규저장 성공 콜백함수
function callBackInsertSuppWorkSuccess(data){
	alert("디지털 포렌식지원 업무가 등록되었습니다.");
	//리스트재조회
	selectList(data.h0101VO.forsSuppSiNum);
}


function eventSupMediSetup(i) {
	//i : 몇번째 영역만 바인딩 할지 결정
	if(isNull(i)){
		var mediinfo = $("div[data-name=mediinfo]");
	}else{
		var mediinfo = $("div[data-name=mediinfo]").eq(i-1);
	}
	
	mediinfo.each (function (index) {
		
		var tableIndex = $(this).data("table-index");

		//개인 법인 변경
	    $("input[data-name=obsrYn]").off("click, change").on("click, change", function() {
	    	
	    	var targetTbody = $(this).closest("tbody");
	    	var tempObsrDt = targetTbody.find("input[name=obsrDt]").val();
	    	var tempObsrPern = targetTbody.find("input[name=obsrPern]").val();
	    	var tempObsrRmComn = targetTbody.find("input[name=obsrRmComn]").val();
	    	
	    	if (targetTbody.find("input[data-name=obsrYn]:checked").val() == "0") {   //참관    		
	    		targetTbody.find("input[name=obsrDt]").attr("disabled",false);
	    		targetTbody.find("input[name=obsrDt]").addClass("calendar");
	    		targetTbody.find("input[name=obsrPern]").attr("disabled",false);
	    		targetTbody.find("input[name=obsrRmComn]").attr("disabled",false);
	    		if(tempObsrDt != null || tempObsrDt != ''){
	    			targetTbody.find("input[name=obsrDt]").val(tempObsrDt);
	    		}
				if(tempObsrPern != null || tempObsrPern != ''){
					targetTbody.find("input[name=obsrPern]").val(tempObsrPern);
				}
				if(tempObsrRmComn != null || tempObsrRmComn != ''){
					targetTbody.find("input[name=obsrRmComn]").val(tempObsrRmComn);
				}
	    		
	    	} else {  //미참관
	    		targetTbody.find("input[name=obsrDt]").attr("disabled",true);
	    		targetTbody.find("input[name=obsrPern]").attr("disabled",true);
	    		targetTbody.find("input[name=obsrDt]").removeClass("calendar");
	    		targetTbody.find("input[name=obsrRmComn]").attr("disabled",true);
	    		
	    		
	    		targetTbody.find("input[name=obsrDt]").val('');
	    		targetTbody.find("input[name=obsrPern]").val('');
	    		targetTbody.find("input[name=obsrRmComn]").val('');
	    		    
	    	}
		});

	    $("input[data-name=obsrYn]").trigger("change");
	});

}



//매체정보를 추가한다. 
function spAdd(obj){
	//선택한 피의자 영역을 잡고
	var targetObj = $(obj).closest(".btnArea").parent("div");
	
	var cloneObj = targetObj.clone(true);
	
	//대상 Div의 data-name
	var cloneObjName = cloneObj.data("name");
	
	//input, 성별 값 초기화
	cloneObj.find("input[type=hidden]").val("");
	
	//cloneObj updateCd 'C'(생성) 으로 셋팅
	cloneObj.find("input[name=updateCd]").val("C");
	
	
	
	cloneObj.find("input[name=mediSiNum]").val("");
	//select값 초기화
	//1. 모든 필드 초기화함 
	//cloneObj.find("input[type=text]").val("");
	cloneObj.find("select").each(function(){
		var self = $(this);
		var targetName = $(this).attr("name");
		var prevTxt = self.prev(".txt").text();
		var selfVal = "";
		self.find("option").each(function(){
			if($(this).html() == prevTxt){
				selfVal = $(this).val();
				return false;
			}
		});
		
		$(this).val(selfVal);

		self.prev(".txt").text(self.find('option:selected').text());
	});
	
	//radio 필드 name +"_"+피의자수 , 유니크하기 위해서
	cloneObj.find("input[type=radio]").each(function(){
		var oldName = $(this).attr("name");
		var newName = oldName+"_"+$("div[data-name=mediinfo]").length;

		$(this).attr("name", newName);
	});
	
	//label, id 필드 +"_" , 유니크하기 위해서
	cloneObj.find("label").each(function(){
		var oldId = $(this).attr("for");
		var newId = oldId+"_"+$("div[data-name=mediinfo]").length;
		
		if(oldId.indexOf("anasDt") != -1){
			var nameId = "anasDt"+"_"+$("div[data-name=mediinfo]").length;
			
			$(this).attr("for", nameId);
			$(this).parent().find("input[id="+oldId+"]").attr("id", nameId);
			$(this).parent().find("input[name="+oldId+"]").attr("name", nameId);
		}else{
			$(this).attr("for", newId);
			$(this).parent().find("input[id="+oldId+"]").attr("id", newId);
		}
		
		
	
		
	});
	
	//선택한 피의자 영역 뒤에 붙인다.
	targetObj.after(cloneObj);
	
	eventSupMediSetup(cloneObj.index());
	
	//버튼 컨트롤
	spBtnControl();
	
	//화면사이즈 갱신
	autoResize();
}


//매체정보를 삭제한다.
function spSub(obj){
	//선택한 매체 영역을 잡고
	var targetObj = $(obj).closest(".btnArea").parent("div");
	
	//대상 Div의 data-name
	var targetObjName = $(obj).closest(".btnArea").parent("div").data("name");
	
	//삭제한다.
	if(confirm("삭제하시겠습니까?") == true){
		//targetObj.remove();
		
		//1. hide 시킨다. 
		targetObj.hide();
		//2. updateCd 값을 'D'로 셋팅한다. (피의자, 법률을 같이 사용하기 위해 targetObj바로 밑의 'updateCd'를 찾는다.)  
		targetObj.find("input[name=updateCd]:eq(0)").val("D");
		//3. 필수값을 해제한다. 
		targetObj.find("input[data-type]").data("optional-value",true)
		//4. 맨 마지막으로 이동시킨다. 
		targetObj.parent().find("div[data-name="+targetObjName+"]:last").after(targetObj);
		
	}else{
		return;
	}
	
	//버튼 컨트롤
	spBtnControl();
	
	//화면사이즈 갱신
	autoResize();
}

//매체정보를 위로 이동한다.
function spUp(obj){
	//선택한 매체 영역을 잡고
	var targetObj = $(obj).closest(".btnArea").parent("div");
	
	targetObj.prev("div").before(targetObj);

	//버튼 컨트롤
	spBtnControl();
}

//매체정보를 아래로 이동한다. 
function spDown(obj){
	//선택한 매체 영역을 잡고
	var targetObj = $(obj).closest(".btnArea").parent("div");
	
	targetObj.next("div").after(targetObj);
	
	//버튼 컨트롤
	spBtnControl();
}

//버튼 컨트롤
function spBtnControl(){
	//1. 버튼 컨트롤 
	//		1) 매체정보가 1일경우, "-", "아래이동", "위로이동" 버튼은 비활성화
	if($("div[data-name=mediinfo]:visible").length < 2){
		
		$("a[name=sp_sub_btn]").removeAttr("onclick");
		$("a[name=sp_up_btn]").removeAttr("onclick");
		$("a[name=sp_down_btn]").removeAttr("onclick");
		
	}else{
		$("a[name=sp_sub_btn]").attr("onclick", "javascript:spSub(this);");
		$("a[name=sp_up_btn]").attr("onclick", "javascript:spUp(this);");
		$("a[name=sp_down_btn]").attr("onclick", "javascript:spDown(this);");
		
	}
	
	//2) 첫번째 매체는 위로이동 버튼 비활성화
	$("a[name=sp_up_btn]:first").removeAttr("onclick");
	
	//3) 마지막 매체는 아래이동 버튼 비활성화
	$("a[name=sp_down_btn]:visible:last").removeAttr("onclick");
	
}

//공통스크립트 가져옴
function setDefaultEvent(){
	$('.inputbox').find('select').each(function() {
		var self = $(this),
			parentBox = self.parents('.inputbox'),
			change = function() {
				$(this).prev('.txt').text($(this).find('option:selected').text());
			},
			focusin = function() {
				$(this).parents('.inputbox').addClass('selected');
			},
			focusout = function() {
				$(this).parents('.inputbox').removeClass('selected');
			};

		self.css({

			'height' : parentBox.height() + 'px'
		}).on({
			'change' : change,
			'focusin' : focusin,
			'focusout' : focusout
		});
	}).end().find('.txt').each(function(){
		var self = $(this);
		self.text(self.next('select').find('option:selected').text());
	});
	
}



//TODO 삭제 필요 - 디지털포렌식지원업무현황 테스트 데이터 셋팅 
function setSjpbForsSuppWorkCustTestData(){
	var thisName = "";
	$("#contentsArea").find("input, select, span").each(function(){
		
		if(thisName == $(this).attr("name")){
			return true;
		}
		thisName = $(this).attr("name");
		var nodeName = $(this)[0].nodeName.toUpperCase();
		
		if(nodeName == "SELECT"){
			setSelectBoxIndex($(this), 1);
		}else if(nodeName == "INPUT"){
			var type = $(this).attr("type").toUpperCase();
			if(type == "TEXT"){
				setFieldValue( $(this), "1");
			}else if(type == "RADIO"){
				setFieldValue( $(this), "1");
			}else if(type == "CHECKBOX"){
				setFieldValue( $(this), "1");
			}
		}
	});
}

//Map 데이터 갱신
function syncH0101VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}
	
	h0101VOMap.recdSiNum = getFieldValue($("input[name=recdSiNum]"));		//지원번호
	h0101VOMap.docuNum = getFieldValue($("input[name=docuNum]"));			//지원문서번호
	h0101VOMap.collDt = getFieldValue($("input[name=collDt]"));				//수집일시
	h0101VOMap.incNum = getFieldValue($("input[name=incNum]"));				//사건번호
	h0101VOMap.criTm = getFieldValue($("input[name=criTm]"));				//수사팀
	h0101VOMap.respIo = getFieldValue($("input[name=respIo]"));				//담당수사관
	
	//매체정보 
	syncMediVOList(h0101VOMap);
	
	return true;
	
}

//매체정보 데이터 갱신
function syncMediVOList(paramMap){
	//매체정보 셋팅 n명
	//radio 는 data-name 으로 찾는다. 
	var mediVOArray = new Array();
	var medi = 1;
	if($("#mediSiNum_0").val() != null && $("#mediSiNum_0").val() != "" && $("#mediSiNum_0").val() != " "){
		medi = $("#mediSiNum_0").val()
		
	}
	$("div[data-name=mediinfo]").each(function(i) {

		var mediVO = {
			forsSuppMediSiNum : $(this).find("input[name=forsSuppMediSiNum]").val()
			,mediSiNum : i+Number(medi)
			,revSeizPers : $(this).find("input[name=revSeizPers]").val()
			,compNmAddr : $(this).find("input[name=compNmAddr]").val()
			,seizIo : $(this).find("input[name=seizIo]").val()
			,mediDiv : $(this).find("select[name=mediDiv]").val()
			,mediType : $(this).find("select[name=mediType]").val()
			,phonNum : $(this).find("input[name=phonNum]").val()
			,maftInfo : $(this).find("input[name=maftInfo]").val()
			,modlNm : $(this).find("input[name=modlNm]").val()
			,siNum : $(this).find("input[name=siNum]").val()
			,mediCont : $(this).find("input[name=mediCont]").val()
			,anasOffi : $(this).find("input[name=anasOffi]").val()
			,anasDt : $(this).find("input[data-name=anasDt]").val()
			,obsrYn : $(this).find("input[data-name=obsrYn]:checked").val()
			,obsrDt : $(this).find("input[name=obsrDt]").val()
			,obsrPern : $(this).find("input[name=obsrPern]").val()
			,obsrRmComn : $(this).find("input[name=obsrRmComn]").val()
			,obsrPern : $(this).find("input[name=obsrPern]").val()
			,digtTrfMngNum : $(this).find("input[name=digtTrfMngNum]").val()
			,digtTrfSiNum : $(this).find("input[name=digtTrfSiNum]").val()
			,digtTrfDt : $(this).find("input[name=digtTrfDt]").val()
			,updateCd : $(this).find("input[name=updateCd]:eq(0)").val()
		}
		
		mediVOArray.push(mediVO);
	});
	
	paramMap.forsSuppMediVOList = mediVOArray;
}

//초기화
function initH0101VOMap(){
	h0101VOMap = {
			forsSuppSiNum : ""		//포렌식지원일련번호
			,forsSuppPublYr : ""	//포렌식지원발행년도
			,recdSiNum : ""			//지원번호
			,docuNum : ""			//문서번호
			,collDt : ""			//수집일시
			,incNum : ""			//사건번호
			,criTm : ""				//수사팀
			,respIo : ""			//담당수사관
			,regUserId : ""         //등록자
			,regDate : ""           //등록일자
			,updUserId : ""         //수정자
			,updDate : ""           //수정일자
			,forsSuppMediVOList : null  //매체정보
		}                           
}


//포렌식
var h0101VOMap = {
	forsSuppSiNum : ""		//포렌식지원일련번호
	,forsSuppPublYr : ""	//포렌식지원발행년도
	,recdSiNum : ""			//지원번호
	,docuNum : ""			//문서번호
	,collDt : ""			//수집일시
	,incNum : ""			//사건번호
	,criTm : ""				//수사팀
	,respIo : ""			//담당수사관
	,regUserId : ""         //등록자
	,regDate : ""           //등록일자
	,updUserId : ""         //수정자
	,updDate : ""           //수정일자
	,mediCount : ""			//매체건수
	,forsSuppMediVOList : null  //매체정보
}

//초기화
function initH0101SCMap(){
	h0101SCMap = {
		incNumSc : ""	//사건번호
		,forsSuppPublYrSc : ""  // 년도
		,criTmSc : ""	//수사팀
		,sDateSc : ""	//분석시작일
		,eDateSc : ""	//분석종료일
	}
}

//검색조건
var h0101SCMap = {
	incNumSc : ""	//사건번호
	,forsSuppPublYrSc : ""  //년도
	,criTmSc : ""	//수사팀
	,sDateSc : ""	//분석시작일
	,eDateSc : ""	//분석종료일
}

//리포트맵
var h0101RTMap = {
	rexdataset : null
}
