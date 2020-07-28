<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<html>
	<head>
		<title>범죄사건부 샘플</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/H9050SAMPLE.js?r=<%=Math.random()%>"></script>
        
        
        <script type="text/javascript">
        
        var jsonData = [{"사건번호":"2018-001","수리":"2018.09.30","구분":"고소","수사담당자":"이수사","성명":"홍길동","주민등록번호":"00000-00000","직업":"회사원","주거":"서울","조회":"지문","죄명수리":"식품위생법위반","죄명송치":"식품위생법위반","범죄일시":"2018.05.10","범죄장소":"서울","피해정도":"5만원","피해자":"김피해","체포영장":"2018.10.01","긴급체포":"2018.10.01","현행범인체포":"2018.10.01","구속영장":"2018.10.01","인치구금":"2018.10.01","석방일시 및 사유":"무혐의","송치연월일":"2018.10.01","송치번호":"제 10호","송치의견":"의견없음","압수번호":"압제 10호","수사미결사건철번호":"제 10호","검사처분연월일":"2018.10.01","검사처분요지":"불기소처분","판결연월일":"2018.10.01","판결요지":"불기소처분","비고":"내용없음","발생사건표":"2018.10.01 제 10호","검거사건표":"2018.10.01 제 10호","피의자표":"2018.10.01 제 10호","작성자":"김작성","작성일시":"2018.10.01"},{"사건번호":"2018-002","수리":"2018.09.30","구분":"고소","수사담당자":"이수사","성명":"홍길동","주민등록번호":"00000-00000","직업":"회사원","주거":"서울","조회":"지문","죄명수리":"식품위생법위반","죄명송치":"식품위생법위반","범죄일시":"2018.05.10","범죄장소":"서울","피해정도":"5만원","피해자":"김피해","체포영장":"2018.10.01","긴급체포":"2018.10.01","현행범인체포":"2018.10.01","구속영장":"2018.10.01","인치구금":"2018.10.01","석방일시 및 사유":"무혐의","송치연월일":"2018.10.01","송치번호":"제 10호","송치의견":"의견없음","압수번호":"압제 10호","수사미결사건철번호":"제 10호","검사처분연월일":"2018.10.01","검사처분요지":"불기소처분","판결연월일":"2018.10.01","판결요지":"불기소처분","비고":"내용없음","발생사건표":"2018.10.01 제 10호","검거사건표":"2018.10.01 제 10호","피의자표":"2018.10.01 제 10호","작성자":"김작성","작성일시":"2018.10.01"},{"사건번호":"2018-003","수리":"2018.09.30","구분":"고소","수사담당자":"이수사","성명":"홍길동","주민등록번호":"00000-00000","직업":"회사원","주거":"서울","조회":"지문","죄명수리":"식품위생법위반","죄명송치":"식품위생법위반","범죄일시":"2018.05.10","범죄장소":"서울","피해정도":"5만원","피해자":"김피해","체포영장":"2018.10.01","긴급체포":"2018.10.01","현행범인체포":"2018.10.01","구속영장":"2018.10.01","인치구금":"2018.10.01","석방일시 및 사유":"무혐의","송치연월일":"2018.10.01","송치번호":"제 10호","송치의견":"의견없음","압수번호":"압제 10호","수사미결사건철번호":"제 10호","검사처분연월일":"2018.10.01","검사처분요지":"불기소처분","판결연월일":"2018.10.01","판결요지":"불기소처분","비고":"내용없음","발생사건표":"2018.10.01 제 10호","검거사건표":"2018.10.01 제 10호","피의자표":"2018.10.01 제 10호","작성자":"김작성","작성일시":"2018.10.01"},{"사건번호":"2018-004","수리":"2018.09.30","구분":"고소","수사담당자":"이수사","성명":"홍길동","주민등록번호":"00000-00000","직업":"회사원","주거":"서울","조회":"지문","죄명수리":"식품위생법위반","죄명송치":"식품위생법위반","범죄일시":"2018.05.10","범죄장소":"서울","피해정도":"5만원","피해자":"김피해","체포영장":"2018.10.01","긴급체포":"2018.10.01","현행범인체포":"2018.10.01","구속영장":"2018.10.01","인치구금":"2018.10.01","석방일시 및 사유":"무혐의","송치연월일":"2018.10.01","송치번호":"제 10호","송치의견":"의견없음","압수번호":"압제 10호","수사미결사건철번호":"제 10호","검사처분연월일":"2018.10.01","검사처분요지":"불기소처분","판결연월일":"2018.10.01","판결요지":"불기소처분","비고":"내용없음","발생사건표":"2018.10.01 제 10호","검거사건표":"2018.10.01 제 10호","피의자표":"2018.10.01 제 10호","작성자":"김작성","작성일시":"2018.10.01"}];
        
        $(document).ready(function(){
        	drawQcell();
        });
        
        function drawQcell(){
        	
        	var QCELLProp = {
                    "parentid" : "sheet",
                    "id"		: "qcell",
                    "data"		: {"input" : jsonData},
                    "merge"		: {header : "rowandcol"},
                    //"selectmode": "cell",
                    "columns"	: [
                    	{width: '50',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                    	{type : "html", width: '70',	key: '사건번호',			title: ['사건번호', '사건번호'], type: "html", options: {html: {data: fnData}}},					
                        //{type : "input",width: '100',	key: '수리',		title: ['수리', '수리'],								sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
                        //{type : "input",width: '100',	key: '수리',		title: ['수리', '수리'], type: "html", options: {html: {data: fnData2}},
                        {type : "html", width: '70',	key: '수리',			title: ['수리', '수리'], type: "html", options: {html: {data: fnData2}}},
                        {type : "input",width: '100',	key: '구분',	title: ['구분', '구분'],									sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '수사담당자',			title: ['수사담당자', '수사담당자'],					sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '성명',		title: ['피의자', '성명'],						sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '주민등록번호',			title: ['피의자','주민등록번호'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '직업',	title: ['피의자','직업'],									sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '주거',		title: ['피의자','주거'],								sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{width: '100',	key: '조회',	title: ['조회','조회'],									sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '죄명수리',	title: ['죄명','수리'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '죄명송치',	title: ['죄명','송치'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '범죄일시',	title: ['범죄','일시'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '범죄장소',	title: ['범죄','장소'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{width: '100',	key: '피해정도',	title: ['피해정도','피해정도'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{width: '100',	key: '피해자',	title: ['피해자','피해자'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '체포영장',	title: ['체포.구속','체포영장'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '긴급체포',	title: ['체포.구속','긴급체포'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '현행범인체포',	title: ['체포.구속','현행범인체포'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '구속영장',	title: ['체포.구속','구속영장'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '인치구금',	title: ['체포.구속','인치구금'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '석방일시 및 사유',	title: ['석방일시 및 사유','석방일시 및 사유'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '송치연월일',	title: ['송치','송치연월일'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '송치번호',	title: ['송치','송치번호'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '송치의견',	title: ['송치','송치의견'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{width: '100',	key: '압수번호',	title: ['압수번호','압수번호'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '수사미결사건철번호',	title: ['수사미결사건철번호','수사미결사건철번호'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '검사처분연월일',	title: ['검사처분','검사처분연월일'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '검사처분요지',	title: ['검사처분','검사처분요지'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '판결연월일',	title: ['판결','판결연월일'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '판결요지',	title: ['판결','판결요지'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '비고',	title: ['비고','비고'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '발생사건표',	title: ['범죄원표','발생사건표'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '검거사건표',	title: ['범죄원표','검거사건표'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '피의자표',	title: ['범죄원표','피의자표'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '작성자',	title: ['작성자','작성자'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    					{type : "input",width: '100',	key: '작성일시',	title: ['작성일시','작성일시'],							sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
    					
    					],
    				//"rowheader"	: "sequence",
    				"frozencols" : 5
                };
        	
                QCELL.create(QCELLProp);
                qcell = QCELL.getInstance("qcell");
                
        }
        
        function fnData2(id, row, col, val, obj){
        
        	//debugger;
        		
      		var html = '';
      		
      		var nextData = qcell.getCellData(row, 1);	//사건번호데이터
      		
      		
      		
           	  if(nextData == '' || nextData == undefined){
           	 	//html = "<input type=\"button\" onclick='openDialog(\""+row+"\", \""+val+"\")' value=\"사건검색\"/>";
           		//html = "<input type=\"button\" onclick='qcellSetTest(\""+row+"\", \""+val+"\")' value=\"사건검색\"/>";
           		html = "<span>123</span>";
           	  } else {
           	   // html = "<a href='javascript:openDialog(\""+row+"\", \""+val+"\", \""+obj+"\")'>"+val+"<a>";
           		//html = "<a href='javascript:qcellSetTest(\""+row+"\", \""+val+"\", \""+obj+"\")'>"+val+"<a>";
           		html = "<input type=\"button\" onclick='openDialog(\""+row+"\", \""+val+"\")' value=\"사건아래추가\"/>";
           	  }
           	  
           	  //html = "<span>123</span>";

           	  return html;
        		
        }
        	
        function fnData(id, row, col, val, obj){
       	  var html = '';
       	  if(val === '' || val == undefined){
       	 	html = "<input type=\"button\" onclick='openDialog(\""+row+"\", \""+col+"\", \""+val+"\")' value=\"사건검색\"/>";
       		//html = "<input type=\"button\" onclick='qcellSetTest(\""+row+"\", \""+val+"\")' value=\"사건검색\"/>";
       	  } else {
       	    html = "<a href='javascript:openDialog(\""+row+"\", \""+col+"\", \""+val+"\", \""+obj+"\")'>"+val+"<a>";
       		//html = "<a href='javascript:qcellSetTest(\""+row+"\", \""+val+"\", \""+obj+"\")'>"+val+"<a>";
       	  }

       	  return html;
       	}
        
        function qcellSetTest(row, val, obj){
        	qcell.setCellData(row, 9, "컴퓨터"); 
        	
        	
        }
        
        function openDialog(row, col, val, obj){
        	commonLayerPopup.openLayerPopup('/sjpb/I/I0201.face', "1000px", "430px", function(data){ addNewItem(data, row, col, obj) });
        }
        
      	//검색을 통해서 신규사건을 추가한다.
        function addNewItem(data, row, col, obj) {
      		
      		//setCellData 선택한 ROW 의 데이터는 바뀌지 않는 버그가 있음.
      		//qcell.setCellData(row, 9, "컴퓨터"); 
      		
      		//헤더 merge로 인해 row -2
			var itemMap = jsonData[row-2];
        	
			itemMap.사건번호 = "2018-099";
        	itemMap.조회 = "컴퓨터";
        	itemMap.피해정도 = "15만원";
        	itemMap.피해자 = "수정피해자";
        	itemMap.압수번호 = "압제 115호";
        	
        	qcell.setCellData(row, 9, "컴퓨터");
        	
        	//테스트
        	//qcell.setCellData(row, 2, "<span>999</span>");
        	
        	
        	//다시그리기 
      		drawQcell();
        }
      	
      	function addItem(){
      		
      		var z9050VOMap = {
     				"사건번호":""
     				,"수리":""
     				,"구분":""
     				,"수사담당자":""
     				,"성명":""
     				,"주민등록번호":""
     				,"직업":""
     				,"주거":""
     				,"조회":""
     				,"죄명수리":""
     				,"죄명송치":""
     				,"범죄일시":""
     				,"범죄장소":""
     				,"피해정도":""
     				,"피해자":""
     				,"체포영장":""
     				,"긴급체포":""
     				,"현행범인체포":""
     				,"구속영장":""
     				,"인치구금":""
     				,"석방일시 및 사유":""
     				,"송치연월일":""
     				,"송치번호":""
     				,"송치의견":""
     				,"압수번호":""
     				,"수사미결사건철번호":""
     				,"검사처분연월일":""
     				,"검사처분요지":""
     				,"판결연월일":""
     				,"판결요지":""
     				,"비고":""
     				,"발생사건표":""
     				,"검거사건표":""
     				,"피의자표":""
     				,"작성자":""
     				,"작성일시":""
      		}
      		jsonData.push(z9050VOMap);
      		
      		//다시그리기 
      		drawQcell();
      		//qcell.addRow(z9050VOMap);
      	}
      	
      	function deleteItem(){
      		//삭제한다.
      		if(confirm("삭제하시겠습니까?") == true){
      			for(var i = 0; i < qcell.getColData(0).length; i++){
          			if(qcell.getColData(0)[i] == true){
          				qcell.deleteRow(i+2);
          			}
          		}
      			
      		}else{
      			return;
      		}
      	}
      	
        </script>
	</head>
	<body class="iframe">
	
		<!-- report -->
		<form name="reportForm" method="post">
			<input type="hidden" id="reptNm" name="reptNm" value="" />
			<input type="hidden" id="xmlData" name="xmlData" value="" />
		</form>
	
		<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	
		</form>	
		
		<!-- searchArea -->
	   <div class="searchArea">
		   <ul>
			   <li><span class="title">사건번호</span>
				   <label for="incNumSc"></label><input type="text" class="w65per" id="incNumSc" name="incNumSc" />
			   </li>
			   
			   <li><span class="title">수사담당자</span>
				   <label for="criTmSc"></label><input type="text" class="w65per" id="var1Sc" name="var1Sc" />
			   </li>
			  
			   <li><span class="title">피해자</span>
				   <label for="criTmSc"></label><input type="text" class="w65per" id="var2Sc" name="var2Sc" />
			   </li>
			   
			   <li><span class="title">작성일시</span>
				   <label for="sDateSc"></label><input type="text" class="w30per calendar datepicker" id="sDateSc" name="sDateSc" /> ~ <label for="eDateSc"></label><input type="text" class="w30per calendar datepicker" id="eDateSc" name="eDateSc" />
			   </li>
		   </ul>
		<div class="searchbtn"><a href="javascript:void(0);" class="btn_white"><span>초기화</span></a><a href="javascript:void(0);" class="btn_blue"><span>검색</span></a></div>
	   </div>
	   <!-- searchArea //-->
	   <!-- listArea -->
	   <div id="sheet" class="listArea area-mousewheel" style="height: 500px; width: 100%">
		
	   </div>
	   
	   <!-- btnArea -->
	   <div class="btnArea">
		   <div class="r_btn"><a href="javascript:void(0);" id="prnBtn" class="btn_white"><span>출력</span></a><a href="javascript:addItem();" id="addItem" class="btn_blue"><span>신규</span></a><a href="javascript:deleteItem();" id="deleteItem" class="btn_blue"><span>삭제</span></a></div>
	   </div>
	   <!-- btnArea //-->
	   
	</body>
</html>
