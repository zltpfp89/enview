var listQcell;
var rowIdx=1;
$(document).ready(function(){

	//페이지 진입시 통합피의자조회화면 출력시 성공함수 호출
	goAjax("/sjpb/D/selectList.face",D0101SCMap,callBackFn_d_selectListSuccess);

	//피의자구분 라디오버튼 클릭이벤트
	$("input:radio[name=indvCorpDiv]").click(function(){
		if($("input:radio[name=indvCorpDiv]:checked").val() == 1){//개인일 경우
			$("#indvCorpDiv_1").show();	//주민등록번호 보이기
			$("#indvCorpDiv_2").hide();	//법인등록번호 숨기기
		}
		if($("input:radio[name=indvCorpDiv]:checked").val() == 2){//법인일 경우
			$("#indvCorpDiv_1").hide();	//주민등록번호 숨기기
			$("#indvCorpDiv_2").show();	//법인등록번호 보이기
		}
	});
});

//페이지 진입시 통합피의자조회화면 출력
function pageInit(){
	//통합피의자조회 화면 성공함수 호출
	goAjax("/sjpb/D/selectList.face",D0101SCMap,callBackFn_d_selectListSuccess);
}

//통합피의자 검색 리스트 화면 출력
function fn_d_selectList(){
	var spIdNumAll ="";
	//개인일경우
	if($("#d_searchList [name=indvCorpDiv]:checked").val() == '1'){ 
		if($("#d_searchList [name=spIdNum_1_A]").val() != '' || $("#d_searchList [name=spIdNum_1_B]").val() != ''){
			if($("#d_searchList [name=spIdNum_1_A]").val() == '' || $("#d_searchList [name=spIdNum_1_B]").val() == ''){
				alert("주민등록번호를 전부 입력해주세요.");
				return;
			}else{
				//피의자 식별번호 전체
				spIdNumAll = $("#d_searchList [name=spIdNum_1_A]").val()+"-"+$("#d_searchList [name=spIdNum_1_B]").val();
			}
		}
	}
	//법인일경우
	if($("#d_searchList [name=indvCorpDiv]:checked").val() =='2'){
		if($("#d_searchList [name=spCorpIdNum_2_A]").val() != '' || $("#d_searchList [name=spCorpIdNum_2_B]").val() != '' || $("#d_searchList [name=spCorpIdNum_2_C]").val() != ''){
			if($("#d_searchList [name=spCorpIdNum_2_A]").val() == '' || $("#d_searchList [name=spCorpIdNum_2_B]").val() == '' || $("#d_searchList [name=spCorpIdNum_2_C]").val() == ''){
				alert("법인등록번호를 전부 입력해주세요.");
				return;
			}else{
				//피의자 식별번호 전체
				spIdNumAll = $("#d_searchList [name=spCorpIdNum_2_A]").val()+"-"+$("#d_searchList [name=spCorpIdNum_2_B]").val()+"-"+$("#d_searchList [name=spCorpIdNum_2_C]").val();
			}
		}
	}
	D0101SCMap={	//검색조건 세팅
			fdCdSC :  $("#d_searchList [name=fdCdSC]").val(),			//사건구분
			rltActCriNmCdSC :  $("#d_searchList [name=rltActCriNmCdSC]").val(),	//관련법률
			indvCorpDiv : $("#d_searchList [name=indvCorpDiv]:checked").val(),		//개인법인구분
			spNm : $("#d_searchList [name=spNm]").val(),				//피의자명
			spIdNum : spIdNumAll										//피의자 식별번호 전체
		}
	//통합피의자조회 검색리스트 화면 성공함수 호출
	goAjaxDefault("/sjpb/D/selectList.face", D0101SCMap, callBackFn_d_selectListSuccess);
}

//통합피의자조회 검색리스트 화면 성공함수
function callBackFn_d_selectListSuccess(data){
	if(data.qCell==""){
		$("#mergeSpTab").hide();
	}else{
		$("#mergeSpTab").show();
	}
	var QCELLProp = {
			"parentid" : "mergeSp",
			"id" : "cell",
			"data" : {
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"selectmode": "row",
			"columns" : [ 
			    {width: '10%',  key: 'rcptIncNum',         title: ['사건번호'],       sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'fdCdDesc',           title: ['구분'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'dvFormDesc',           title: ['발각형태'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'beDt',           title: ['입건일자'],      sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'incTrfItemNum',            title: ['송치번호'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'criTmNm',           title: ['수사팀'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'nmKor',            title: ['수사 담당자'],       sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'spNm',            title: ['피의자명'],       sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'spIdNum',            title: ['피의자식별번호'],       sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '10%',  key: 'criStatCdDesc',         title: ['상태'],      sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
				],
			"frozencols" : 5,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");
		listQcell.bind("click", eventFn);
		if (listQcell.getRows("data") > 0) {
			listQcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
    		fn_d_selectSpInfoSetting(listQcell.getRowData(1));
		}
	
}
//피의자 정보 상세화면 데이터 세팅
function fn_d_selectSpInfoSetting(data){
	$("#spInfoTable").show();
	if(data.indvCorpDivDesc == "개인"){ //개인일 경우
		$("#personalInfo").show();						// 개인 구분 보이기
		$("#corpInfo").hide(); 							// 법인 구분 숨기기
		$("#indvDivDesc").html(data.indvCorpDivDesc);	// 구분 출력
		$("#homcForcPernDivDesc").html(data.homcForcPernDivDesc);// 내외국인 출력
		$("#personalNum").show(); 						// 개인 식별번호 보이기
		$("#corpNum").hide(); 							//법인 식별번호 숨기기
		$("#spIdNum").html(data.spIdNum);				//주민등록번호 출력
		$("#gendDivDesc").html(data.gendDivDesc);		//성별 출력
	}else if(data.indvCorpDivDesc == "법인"){ //법인일 경우
		$("#personalInfo").hide();						// 개인 구분 숨기기
		$("#corpInfo").show();							// 법인 구분 보이기
		$("#CorpDivDesc").html(data.indvCorpDivDesc);	// 구분 출력
		$("#personalNum").hide();						// 개인 식별번호 숨기기
		$("#corpNum").show();							// 법인 식별번호 보이기
		$("#CorpNum").html(data.spIdNum);				// 법인번호 출력
	}
	$("#spNmInfo").html(data.spNm);						// 피의자 이름 출력
	$("#spAddr").html(data.spAddr);						// 피의자 주소 출력
	$("#spCnttNum").html(data.spCnttNum);				// 피의자 연락처 출력
	
	var incSpNumMap = {
    		incSpNum : data.incSpNum,
    		rcptNum : data.rcptNum
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
			vioHtml.append(vio.fnAmt);	
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

	//피의자 상세정보세팅
	fn_d_selectSpInfoSetting(listQcell.getRowData(rowIdx));

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
	D0101SCMap={
			fdCdDesc : "",			//사건구분
			rltActCriNmCdDesc : "",	//관련법률
			indvCorpDiv : "",		//개인법인구분
			spNm : "",				//피의자명
			spIdNum : ""
		}	
}

var D0101SCMap={
	fdCdDesc : "",			//사건구분
	rltActCriNmCdDesc : "",	//관련법률
	indvCorpDiv : "",		//개인법인구분
	spNm : "",				//피의자명
	spIdNum : ""
};