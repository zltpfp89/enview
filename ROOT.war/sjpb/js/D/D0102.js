var listQcell;
var rowIdx=1;
$(document).ready(function(){
	fn_d_selectList(initRcptNumTmp,initIncSpNumTmp);
});
function changeIndvCorpDivSC(){
	if($("#indvCorpDiv").val() == '2'){
		$("#indvCorpDiv_1").hide();	//주민등록번호 숨기기
		$("#indvCorpDiv_2").show();	//법인등록번호 보이기		
	}else{
		$("#indvCorpDiv_1").show();	//주민등록번호 보이기
		$("#indvCorpDiv_2").hide();	//법인등록번호 숨기기
	}
}
//수사분야 선택에 법률위반리스트 가져오기 
function changeFdCdSC(){

	//법률위반리스트를 가져온다.
	var reqMap = {
			fdCd : $("#fdCdSC").val()
		}
	goAjaxDefault("/sjpb/B/getRltActList.face", reqMap,callBackGetRltActListSuccess);
}
//법률위반리스트 성공 콜백함수
function callBackGetRltActListSuccess(data){
	targetObj = $("select[name=rltActCriNmCdSC]");
		
	var rltActCriNmCodeHtml = new StringBuffer();
	
	rltActCriNmCodeHtml.append('						<option value="" >전체</option>                                                                                                          ');
	$.each(data.rltActCriNmKndList, function(k, rltActCriNm) {
		rltActCriNmCodeHtml.append('						<option value="'+rltActCriNm.code+'">'+rltActCriNm.codeName+'</option>                                                                                                          ');
	});
	
	targetObj.html(rltActCriNmCodeHtml.toString());
	
	//select값 초기화
	targetObj.each(function(){
		setFieldValue($(this), "");
	});
	
}

//통합피의자 검색 리스트 화면 출력
function fn_d_selectList(num,sp){
	
	D0102SCMap={	//검색조건 세팅
			rcptNum :  num	,		//사건번호		
			incSpNum : sp 
		};
	debugger;
	//통합피의자조회 검색리스트 화면 성공함수 호출
	goAjaxDefault("/sjpb/D/selectList.face", D0102SCMap, fn_d_selectSpInfoSetting);
}

//피의자 정보 상세화면 데이터 세팅
function fn_d_selectSpInfoSetting(data){
	
	debugger;
	var spData = data.qCell[0];

	if(spData.indvCorpDivDesc == "개인"){ //개인일 경우
		$("#personalInfo").show();						// 개인 구분 보이기
		$("#corpInfo").hide(); 							// 법인 구분 숨기기
		$("#indvDivDesc").html(spData.indvCorpDivDesc);	// 구분 출력
		$("#homcForcPernDivDesc").html(spData.homcForcPernDivDesc);// 내외국인 출력
		$("#personalNum").show(); 						// 개인 식별번호 보이기
		$("#corpNum").hide(); 							//법인 식별번호 숨기기
		$("#spIdNum").html(spData.spIdNum);				//주민등록번호 출력
		$("#gendDivDesc").html(spData.gendDivDesc);		//성별 출력
	}else if(spData.indvCorpDivDesc == "법인"){ //법인일 경우
		$("#personalInfo").hide();						// 개인 구분 숨기기
		$("#corpInfo").show();							// 법인 구분 보이기
		$("#CorpDivDesc").html(spData.indvCorpDivDesc);	// 구분 출력
		$("#personalNum").hide();						// 개인 식별번호 숨기기
		$("#corpNum").show();							// 법인 식별번호 보이기
		$("#CorpNum").html(spData.spIdNum);				// 법인번호 출력
	}
	$("#spNmInfo").html(spData.spNm);						// 피의자 이름 출력
	$("#spAddr").html(spData.spAddr);						// 피의자 주소 출력
	$("#spCnttNum").html(spData.spCnttNum);				// 피의자 연락처 출력
	
	var incSpNumMap = {
    		incSpNum : spData.incSpNum,
    		rcptNum : spData.rcptNum
    };
	//위반법률 div 비우기
	$("#lawArea").empty();
	//피의자 정보 상세화면 위반법률 성공 호출
    goAjaxDefault("/sjpb/D/selectSpVioClaList.face",incSpNumMap,callBackFn_d_selectSpVioClaListSuccess);
    
    //iframe 자동사이즈 조정
    autoResize();
}
//피의자 정보 상세화면 위반법률 성공함수
function callBackFn_d_selectSpVioClaListSuccess(data){
	if(data.vioList == ""){ //위반법률에 대한 데이터가 없을때
		$("#vioArea").hide();
	}else{
		$("#vioArea").show();
		
		//위반법률 영역에 테이블 그리기
		var vioHtml = new StringBuffer();
		$.each(data.vioList,function(index,vio){
			vioHtml.append("<br>");
			vioHtml.append("<div class='law'>");
			vioHtml.append("	<ul>");
			vioHtml.append("		<li>");	
			vioHtml.append("			<span class='title'>관련법률 및 죄명</span>");	
			vioHtml.append("			<label for='rltActCriNmCdDesc'></label>");	
			vioHtml.append(vio.rltActCriNmCdDesc);
			vioHtml.append("		</li>");	
			vioHtml.append("		<li>");	
			vioHtml.append("			<span class='title'>위반내용</span>");
			vioHtml.append("			<label for='vioCont'></label>");	
			vioHtml.append(vio.vioCont);	
			vioHtml.append("		</li>");	
			vioHtml.append("		<li>");	
			vioHtml.append("			<span class='title'>위반조항</span>");
			vioHtml.append("			<label for='actVioClaNm'></label>");	
			$.each(vio.vioClaList,function(i,vioCla){
				vioHtml.append(vioCla.actVioClaNm);
				if(i+1 != vio.vioClaList.length){
					vioHtml.append(", ");
				}
			});
			vioHtml.append("		</li>");	
			vioHtml.append("		<li>");	
			vioHtml.append("			<span class='title'>검찰내용</span>");
			vioHtml.append("			<label for='poContCd'></label>");	
			vioHtml.append(vio.poContCd);		
			vioHtml.append("		</li>");	
			vioHtml.append("		<li>");	
			vioHtml.append("			<span class='title'>처분내용</span>");
			vioHtml.append("			<label for='dipCont'></label>");	
			vioHtml.append(vio.dipCont);		
			vioHtml.append("		</li>");	
			vioHtml.append("		<li>");	
			vioHtml.append("			<span class='title'>벌금액</span>");	
			vioHtml.append("			<label for='fnAmt'></label>");
			if(vio.fnAmt != null){
				vioHtml.append(vio.fnAmt+"만원");
			}
			vioHtml.append("		</li>");	
			vioHtml.append("		<li>");	
			vioHtml.append("			<span class='title'>판결내용</span>");
			vioHtml.append("			<label for='jdtCont'></label>");
			vioHtml.append(vio.jdtCont);	
			vioHtml.append("		</li>");	
			vioHtml.append("	</ul>");	
			vioHtml.append("</div>");
		});
		//관련법률 영역 그리기
		$("#lawArea").html(vioHtml.toString());	
	}
	//iframe 자동사이즈 조정
	autoResize();
}
//통합피의자조회 셀클릭 이벤트
function eventFn(e){
	
	// 선택한 인덱스 가져오기
	if(rowIdx == null){
		rowIdx = 1;//초기값 설정
	}else{
		rowIdx = listQcell.getIdx("row");	
	}
	//기존 체크박스 열번호
	var pastchk = listQcell.getIdx("row","focus","previous") == -1?1:listQcell.getIdx("row","focus","previous");
	
	//기존 체크항목 해제
	listQcell.removeRowStyle(pastchk);

	//새로 선택한 행 스타일적용
	listQcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");

	var histMap ={
			incSpNum : listQcell.getRowData(rowIdx).incSpNum
			,rcptNum : listQcell.getRowData(rowIdx).rcptNum
	};
	//피의자 검색 이력 쌓기
	goAjaxDefault("/sjpb/D/searchIncHist.face",histMap,callBackFn_d_searchIncHistSuccess);
	
}

//피의자 검색 이력 쌓기 성공함수
function callBackFn_d_searchIncHistSuccess(data){
	if(data == 1){
		//피의자 상세정보세팅
		fn_d_selectSpInfoSetting(listQcell.getRowData(rowIdx));
	}else{
		alert("시스템에러입니다. 관리자에게 문의하세요.");
	}
	
}

//초기화 함수
function fn_d_init(form){
	$("#"+form)[0].reset();
	//select 값 초기화
	$("#"+form).find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	
	//피의자구분 디폴트값이 개인
	$("#indvCorpDiv_1").show();	//주민등록번호 보이기
	$("#indvCorpDiv_2").hide();	//법인등록번호 숨기기
	
	//검색맵 초기화
	D0102SCMap={
			rcptNum : "",		//사건번호
			incSpNum : ""
		}	
}

var D0102SCMap={
	rcptNum : "",		//사건번호
	incSpNum : ""
};

var D0101VOMap = {
		"rcptIncNum" : "",
	    "beDt" : "",
	    "criTmNm" : "",
	    "fdCdDesc" : "",
	    "nmKor" : "",
	    "dvFormDesc" : "",
	    "spNm" : "",
	    "trfNum" : "",
	    "criStatCdDesc" : ""
};