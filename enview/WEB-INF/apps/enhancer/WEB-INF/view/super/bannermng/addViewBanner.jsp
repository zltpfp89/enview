<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%@ page import="com.saltware.enview.Enview" %> 

<%
 Map userInfoMap = null;
 userInfoMap = EnviewSSOManager.getUserInfoMap(request);
 String langKnd = (String)userInfoMap.get("lang_knd");
 MultiResourceBundle msgs = null;
 msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);
 
 String flag = "Y";
 
 request.setAttribute("menuAuth",flag);	//관리자여부 구분자

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
	<title>배너추가</title>
	<%-- 
	<link href="<%=request.getContextPath()%>/hancer/css/super/banner/cssbasic.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/hancer/css/super/banner/core_banner.css" rel="stylesheet" type="text/css" />
	--%>
	<link href="<%=request.getContextPath()%>/hancer/css/super/banner/core_banner_bg.css" rel="stylesheet" type="text/css" /> 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/contents.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/banner/objCalendarCtrl.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/banner/validUtil.js"></script>
	<script type="text/javascript">
		var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
		var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
		var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer/banner";		
		var radioNo = "";
		var preViewCnt = 0;
		var beforeRadioNo = "";
		var bannerTextKor = "";
		var bannerTextEng = "";
		var subOrgCd = "";
		var today = "";
		var banner_seq = '<c:out value="${bannerInfo.BANNER_SEQ}"/>'

		//목록으로 돌아가기(2012.01.27)
		function backToList(){
			document.getElementById("backBnList").submit();
		}

		//화면초기화
			window.onload=function(){
			maskOn(document.getElementById("date1_ko").id);
			maskOn(document.getElementById("date2_ko").id);

			//Interval체크를 위한 오늘날짜 생성
			var now = new Date();
			var year= now.getFullYear();
			var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
			var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
			today = year+mon+day;

			//수정일경우 선택했던 Radio버튼 체크
			var radioSelVal = '<c:out value="${bannerInfo.TYPE}"/>';
			if(radioSelVal != "" && radioSelVal != null){
				var rdoLen = document.getElementById("bannerForm").bn_img.length;
				for(var i=0;i<rdoLen;i++){
					if(document.getElementById("bannerForm").bn_img[i].value == radioSelVal){
						document.getElementById("bannerForm").bn_img[i].checked = true;
						radioNo = radioSelVal;
						beforeRadioNo = radioSelVal;
						break;
					}
				}				
			}
			if(radioNo == '00' || radioNo == ''){
				//파일찾기부분 사용가능
				document.getElementById("thumbKor").disabled = false;
				document.getElementById("thumbEng").disabled = false;

				//커스텀 이미지 선택했거나 등록일때 필수 입력부분 제어(2012.01.16)
				document.getElementById("bannerForm").bn_img[0].checked = true;
				radioNo = '00';
				beforeRadioNo = '00';
				clearReqField();
			}else{
				//파일찾기부분 사용불가
				document.getElementById("thumbKor").disabled = true;
				document.getElementById("thumbEng").disabled = true;
			}

			//등록 , 수정후 메세지 alert(2012.01.27)
			var msgYn = document.getElementById("RST_MSG").value;
			if(msgYn != '' && msgYn != null){
				alert(msgYn);
			}
		}
		
		//커스텀 이미지 선택했거나 최초화면 로딩시 필수 입력부분 제어(2012.01.16)
		function clearReqField(){
			var requiredFields = document.getElementsByName('reqField');
			for(var i=0;i<requiredFields.length;i++){
				requiredFields[i].style.display = 'none';
			}
		}
		//배너이미지 선택시 필수 입력부분 제어(2012.01.16)
		function setReqField(){
			var requiredFields = document.getElementsByName('reqField');
			for(var i=0;i<requiredFields.length;i++){
				requiredFields[i].style.display = 'inline';
			}
		}

		//Radio Index 셋팅
		function setRadioNo(idx){				
			var cusImgKor = document.getElementById("imgfileKor").value;
			var cusImgEng = document.getElementById("imgfileEng").value;
			if((cusImgKor != "" || cusImgEng != "") && idx != '00'){
				if(confirm("커스텀이미지 등록시 배너샘플은 사용할 수 없습니다.\n초기화 하시겠습니까?")){
					var rdoLen = document.getElementById("bannerForm").bn_img.length;
					for(var i=0;i<rdoLen;i++){
						document.getElementById("bannerForm").bn_img[i].checked = false;
					}
					//파일경로 보이는 인풋박스 값 지우기
					document.getElementById("imgfileKor").value = "";
					document.getElementById("imgfileEng").value = "";
					
					//파일업로드 객체 초기화
					document.getElementById("thumbEng").value = "";
					document.getElementById("thumbEng").outerHTML = document.getElementById("thumbEng").outerHTML;
					
					document.getElementById("thumbKor").value = "";
					document.getElementById("thumbKor").outerHTML = document.getElementById("thumbKor").outerHTML;
					
					document.getElementById("bannerForm").bn_img[idx].checked = true;
					
				}else{
					document.getElementById("bannerForm").bn_img[0].checked = true;
					return;
				}
			}else{
				radioNo = idx;
			}
			
			if(idx == '00' || idx == ''){
				//파일찾기부분 사용가능
				document.getElementById("thumbKor").disabled = false;
				document.getElementById("thumbEng").disabled = false;
				clearReqField();//(2012.01.16)
			}else{
				//파일찾기부분 사용불가
				document.getElementById("thumbKor").disabled = true;
				document.getElementById("thumbEng").disabled = true;
				setReqField();//(2012.01.16)
			}	
			
		}
		
		//상단배너 값셋팅
		function checkValue(){
			if(document.getElementById("top_banner").checked){
				if(!document.getElementById("bannerForm").bn_img[0].checked){
					alert('<%=msgs.getString("ev.hnevent.msg.event.topBannerOnly")%>');
					document.getElementById("top_banner").checked = false;
					document.getElementById("topBanner").value = "N";
					//alert(document.getElementById("topBanner").value);
				}else{
					document.getElementById("topBanner").value = "Y";
				}
			}else{
				document.getElementById("topBanner").value = "N";
			}
		}
		
		//게시기간 Delimeter 삭제(게시기간영문 삭제 : 2012.01.16)
		function delDateMask(){
			maskOff(document.getElementById("date1_ko").id);
			maskOff(document.getElementById("date2_ko").id);
		}
		
		//게시기간 유효성 검사 실패시 Delimeter 삽입(게시기간영문 삭제 : 2012.01.16)
		function addDateMask(){
			maskOn(document.getElementById("date1_ko").id);
			maskOn(document.getElementById("date2_ko").id);
		}
		
		//미리보기시 데이터 입력여부 검사
		function validPreViewData(){
			var obj = document.getElementById("bannerForm");
			var msg = '<%=msgs.getString("ev.hnevent.msg.event.enterSubjectKor")%>';
			//제목(국문)
			if(!chkInput(obj.titleKor,msg))
				return false;
			else
				msg = '<%=msgs.getString("ev.hnevent.msg.event.enterSubjectEng")%>';
			
			//제목(영문)
			if(!chkInput(obj.titleEng,msg))
				return false;
			else
				msg = '<%=msgs.getString("ev.hnevent.msg.event.enterContactInfoKor")%>';
			
			//배너 수동으로 만들기 일때만 입력값체크(2012.01.16)
			if(radioNo != "00"){	
				//주관기관(국문)	
				if(!chkInput(obj.deptCdKor,msg))
					return false;
				else
					msg = '<%=msgs.getString("ev.hnevent.msg.event.enterContactInfoEng")%>';
				
				//주관기관(영문)	
				if(!chkInput(obj.deptCdEng,msg))
					return false;
				else
					msg = '<%=msgs.getString("ev.hnevent.msg.event.enterWhenWhereKor")%>';
					
				//일시장소(국문)	
				if(!chkInput(obj.schPlaceKor,msg))
					return false;
				else
					msg = '<%=msgs.getString("ev.hnevent.msg.event.enterWhenWhereEng")%>';
					
				//일시장소(영문)	
				if(!chkInput(obj.schPlaceEng,msg))
					return false;
			}
			return true;		
		}
		
		//배너내용 유효성 검사
		function validData(){
			if(!validPreViewData()){
				return;
			}
			
			var obj = document.getElementById("bannerForm");
			var	msg = '<%=msgs.getString("ev.hnevent.msg.event.enterDate")%>';
				
			//게시기간 입력값 체크(게시기간영문 삭제 : 2012.01.16)
			if(!chkInput(obj.date1_ko,msg))
				return false;
			if(!chkInput(obj.date2_ko,msg))
				return false;

			//게시기간 유효성체크(게시기간영문 삭제 : 2012.01.16)
			delDateMask();
			var startDateKor = document.getElementById("date1_ko").value;
			var endDateKor   = document.getElementById("date2_ko").value;

			/**************************등록가능일 검사 추가(2012.01.16)*******************************/
			var startDateMon = startDateKor.substr(0,6);
			var endDateMon   = endDateKor.substr(0,6);
			var intervalDtKor = fnGetIntervalDay(startDateKor, endDateKor);
			var intervalDtFromToday = fnGetIntervalDay(today, startDateKor);
			
			//게시시작일 오늘기준 30일 이내체크
			if(intervalDtFromToday > 30){
			/* 	alert("게시기간을 확인하십시오.\n오늘 기준으로 한달 이내 등록가능합니다.");
				addDateMask(); 
				return false;*/
			}
			
			//게시기간 Interval 체크
			if(startDateKor > endDateKor || intervalDtKor > 6){
				/* alert("게시기간을 확인하십시오.\n최대 게시일은 7일 입니다.");
				addDateMask(); 
				return false;*/
			}
			
			//하루 게시가능건수 초과여부(일자구간이 한달이내일때)
			if(startDateMon == endDateMon){
				var flag = false;
				$.ajax({ 
				   type: "POST", 
				   url: actPath+"/availabilityCheckBanner.hanc", 
				   data: "type=limit&baseData="+startDateMon+"&fromDt="+startDateKor+"&toDt="+endDateKor+"&bannerSeq="+banner_seq,
				   dataType:"json",
				   async:false,
				   success: function(data){ 
						var msg = data.msg;
						if(msg == 'NoError'){
							flag = eval(data.chkYn);
							if(!flag)
								alert("게시기간을 확인하십시오.\n하루 게시가능 건수를 초과하였습니다.");
						}
						else{
							flag = false;
							alert(msg);
						}
				   }, 
				   error: function(request, status, error) {
						alert("네트워크 에러가 발생하였습니다.");
						flag = false;
				   }
				});
				if(!flag){
					addDateMask();
					return false;
				}
			}

			//하루 게시가능건수 초과여부(일자구간이 두달에 걸쳐있을때)
			if(startDateMon != endDateMon){
				var fromMonLastDay = startDateMon+""+(new Date(startDateKor.substr(0,4),startDateKor.substr(4,2),0)).getDate();
				var toMonFirstDay = endDateMon+"01";
				var flag = false;
				//첫번째달 검사
				$.ajax({ 
				   type: "POST", 
				   url: actPath+"/availabilityCheckBanner.hanc", 
				   data: "type=limit&baseData="+startDateMon+"&fromDt="+startDateKor+"&toDt="+fromMonLastDay+"&bannerSeq="+banner_seq,
				   dataType:"json",
				   async:false,
				   success: function(data){ 
						var msg = data.msg;
						if(msg == 'NoError'){
							flag = eval(data.chkYn);
							if(!flag)
								alert("게시기간을 확인하십시오.\n하루 게시가능 건수를 초과하였습니다.");
						}
						else{
							flag = false;
							alert(msg);
						}
				   }, 
				   error: function(request, status, error) {
						alert("네트워크 에러가 발생하였습니다.");
						flag = false;
				   }
				});
				if(!flag){
					addDateMask();
					return false;
				}
				
				//두번째달 검사
				$.ajax({ 
				   type: "POST", 
				   url: actPath+"/availabilityCheckBanner.hanc", 
				   data: "type=limit&baseData="+endDateMon+"&fromDt="+toMonFirstDay+"&toDt="+endDateKor+"&bannerSeq="+banner_seq,
				   dataType:"json",
				   async:false,
				   success: function(data){ 
						var msg = data.msg;
						if(msg == 'NoError'){
							flag = eval(data.chkYn);
							if(!flag)
								alert("게시기간을 확인하십시오.\n하루 게시가능 건수를 초과하였습니다.");
						}
						else{
							flag = false;
							alert(msg);
						}
				   }, 
				   error: function(request, status, error) {
						alert("네트워크 에러가 발생하였습니다.");
						flag = false;
				   }
				});
				if(!flag){
					addDateMask();
					return false;
				}
			}
			
			//등록기관 배너등록 가능여부(2회연속불가) : 관리자는 by pass
			if('<c:out value="${menuAuth}"/>' == 'N'){
				var flag = false;
				$.ajax({ 
				   type: "POST", 
				   url: actPath+"/availabilityCheckBanner.hanc", 
				   data: "type=period&baseData="+subOrgCd+"&fromDt="+startDateKor+"&toDt="+endDateKor+"&bannerSeq="+banner_seq,
				   dataType:"json",
				   async:false,
				   success: function(data){ 
						var msg = data.msg;
						if(msg == 'NoError'){
							flag = eval(data.chkYn);
							if(!flag)
								alert("동일기관 2회 연속 게시는 불가능 합니다.");					
						}
						else{
							flag = false;
							alert(msg);
						}
				   }, 
				   error: function(request, status, error) {
						alert("네트워크 에러가 발생하였습니다.");
						flag = false;
				   }
				});
				if(!flag){
					addDateMask();
					return false;
				}
			}
			/*****************************************************************************************/

			//이미지선택여부(커스텀 or 템플릿)
			var cusImgKor = document.getElementById("imgfileKor").value;
			var cusImgEng = document.getElementById("imgfileEng").value;
			var imgNmKor = document.getElementById("IMAGE_NM_KOR").value;
			var imgNmEng = document.getElementById("IMAGE_NM_ENG").value;
			var rdoLen   = document.getElementById("bannerForm").bn_img.length
			var mode = document.getElementById("mode").value;
			var cnt = 0;
			for(var i=0;i<rdoLen;i++){
				if(i == 0 && document.getElementById("bannerForm").bn_img[i].checked && cusImgKor == "" && cusImgEng == "" && imgNmKor == "" && imgNmEng == ""){
					alert('<%=msgs.getString("ev.hnevent.msg.event.selectImg")%>');
					addDateMask();
					return false;
				}else{
					if(document.getElementById("bannerForm").bn_img[i].checked){
						cnt++;
					}
				}
			}
			
			//이미지파일 여부검사(커스텀이미지선택시)
			var imgKor = document.getElementById('thumbKor').value;
			var imgEng = document.getElementById('thumbEng').value;
			var lang_knd = '<c:out value="${paramMap.LANG_KND}"/>';
			if(imgKor !=""){
				if(!isImageFile(imgKor)){
					if(lang_knd == 'ko')
						alert('<%=msgs.getString("ev.hnevent.msg.event.invalidFile")%>');
					if(lang_knd == 'en')
						alert('<%=msgs.getString("ev.hnevent.msg.event.invalidFile")%>');

					document.getElementById('imgfileKor').focus();
					return;
				}
			}
			if(imgEng !=""){
				if(!isImageFile(imgEng)){
					if(lang_knd == 'ko')
						alert('<%=msgs.getString("ev.hnevent.msg.event.invalidFile")%>');
					if(lang_knd == 'en')
						alert('<%=msgs.getString("ev.hnevent.msg.event.invalidFile")%>');

					document.getElementById('imgfileEng').focus();
					return;
				}
			}

			//미리보기 실행여부(미리보기를 해야 배너커텐트가 만들어짐)
			if((radioNo != "00" || radioNo == "") && preViewCnt == 0){
				alert('<%=msgs.getString("ev.hnevent.msg.event.excutePreview")%>');
				addDateMask();
				return false;
			}
			if(radioNo != "00" && radioNo != beforeRadioNo){
				alert("ev.msg.event.changeImage");
				addDateMask();
				return false;
			}

			//URL입력여부검사(2012.01.19필수추가요청)
			if(document.getElementById("link").value == ""){
				alert('<%=msgs.getString("ev.hnevent.msg.event.insertURL")%>');
				addDateMask();
				return false;
			}

			return true;
		}
		
		//배너 등록(바로승인:2) or 수정(2) or 거부(1) or 거부해제(2) :서버에서 STATE 만 다르게 업데이트
		function saveBanner(state, act){
			if(validData()){
				document.getElementById("STATE").value = state;
				document.getElementById("REG_DEPT_CODE").value = subOrgCd;//등록기관코드
				//커스텀 배너일때는 <div>~</div>내용은 emptyString을 전송
				if(radioNo == '00'){
					document.getElementById("BANNER_TEXT_KOR").value = "";
					document.getElementById("BANNER_TEXT_ENG").value = "";	
				}else{
					document.getElementById("BANNER_TEXT_KOR").value = bannerTextKor;
					document.getElementById("BANNER_TEXT_ENG").value = bannerTextEng;	
				}

				//메세지셋팅을 위해 버튼별 구분값부여(2012.01.27)->등록:add / 수정:mod / 거부:rej / 거부해제;cle
				var langKnd = document.getElementById("LANG_KND").value;
				if(act == 'add'){
					if(langKnd == 'ko')
						document.getElementById("RST_MSG").value = "등록되었습니다.";
					if(langKnd == 'en')
						document.getElementById("RST_MSG").value = "Has been registered.";
				}
				if(act == 'mod'){
					if(langKnd == 'ko')
						document.getElementById("RST_MSG").value = "수정되었습니다.";
					if(langKnd == 'en')
						document.getElementById("RST_MSG").value = "Has been modified.";
				}
				if(act == 'rej'){
					if(langKnd == 'ko')
						document.getElementById("RST_MSG").value = "거부처리 되었습니다.";
					if(langKnd == 'en')
						document.getElementById("RST_MSG").value = "Denial has been processed.";
				}
				if(act == 'cle'){
					if(langKnd == 'ko')
						document.getElementById("RST_MSG").value = "거부해제 되었습니다.";
					if(langKnd == 'en')
						document.getElementById("RST_MSG").value = "Denial has been turned off.";
				}
				
				//배너등록 폼 서브밋
				document.getElementById("bannerForm").submit();
			}
		}
		
		//배너삭제
		function deleteBanner(seq,imgKor,imgEng){
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/deleteBanner.hanc", 
			   data: "BANNER_SEQ="+seq+"&IMAGE_PATH_KOR="+imgKor+"&IMAGE_PATH_ENG="+imgEng,
			   dataType:"text",
			   success: function(data){
					document.getElementById("bannerForm").action = actPath + "/selectBannerList.hanc";
					document.getElementById("bannerForm").submit();				
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
					//alert(request.responseText);
			   }
			});
		}
		
		//미리보기
		function preView(){
			if(radioNo == "" || radioNo == "00"){
				alert('<%=msgs.getString("ev.hnevent.msg.event.selectPreviewImg")%>');
				return;
			}
			if(!validPreViewData()){
				return;
			}
			
			var frm = document.getElementById("bannerForm");
			var title = "";
			var place = "";
			var date  = "";
			
			//로케일에 따른 배너텍스트구성
			if(document.getElementById("LANG_KND").value == 'ko'){
				title = frm.titleKor.value;
				place = frm.deptCdKor.value;
				date  = frm.schPlaceKor.value;
			}
			if(document.getElementById("LANG_KND").value == 'en'){
				title = frm.titleEng.value;
				place = frm.deptCdEng.value;
				date  = frm.schPlaceEng.value;
			}
			
			var contentKor = "";
			var contentEng = "";
			switch(radioNo) {
				case '01':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					break;
				case '02':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					break;
				case '03':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					break;
				case '04':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					break;
				case '05':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd><dd class="seoul">서울대학교</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd><dd class="seoul">SeoulNationalUniversity</dd></dl></div></div>';
					break;
				case '06':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+place+'</dt><dd class="place">'+title+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+place+'</dt><dd class="place">'+title+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					break;
				case '07':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+place+'</dt><dd class="place">'+title+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+place+'</dt><dd class="place">'+title+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					break;
				case '08':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+place+'</dt><dd class="place">'+title+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+place+'</dt><dd class="place">'+title+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					break;
				case '09':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+date+'</dt><dd class="place">'+title+'</dd><dd class="period">'+place+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+date+'</dt><dd class="place">'+title+'</dd><dd class="period">'+place+'</dd></dl></div></div>';
					break;
				case '10':
					contentKor = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					contentEng = '<div class="type'+radioNo+'"id="roll_banner"><div><dl><dt>'+title+'</dt><dd class="place">'+place+'</dd><dd class="period">'+date+'</dd></dl></div></div>';
					break;
				default:
					contentKor = "";
					contentEng = "";
			}	
			bannerTextKor = contentKor;
			bannerTextEng = contentEng;
			
			//미리보기 디스플레이
			if(document.getElementById("LANG_KND").value == 'ko')
				document.getElementById("pre_view").innerHTML = contentKor;
			if(document.getElementById("LANG_KND").value == 'en')
				document.getElementById("pre_view").innerHTML = contentEng;
			
			//미리보기 실행시 카운트+			
			preViewCnt++;
			
			//저장직전 이미지 변경여부 확인을 위해..
			beforeRadioNo = radioNo;
		}
		
		//이미지 다운로드
		function imgBgDownLoad(){
			var file_mask = "";
			var file_name = "";
			var frm = document.getElementById("bannerForm");
			var radioLen = frm.bn_img.length;
			var selFlag = 0;
			for(var i=1;i<radioLen;i++){
				if (frm.bn_img[i].checked){
					selFlag++;
					file_mask = "banner_bg"+frm.bn_img[i].value+".gif";
					file_name = "banner_bg"+frm.bn_img[i].value+".gif";
				} 
			}
			if(selFlag == 0){
				alert('<%=msgs.getString("ev.hnevent.msg.event.selectPreviewImg")%>');
				return;
			}
			document.getElementById("fileMask").value = file_mask;
			document.getElementById("fileName").value = file_name;
			document.getElementById("bannerBgDown").submit();
		}

		//게시가능일 보기 팝업(2012.01.16)
		function showRegEnable(){
			var sUrl = actPath+"/selectCalendarPopUp.hanc";
			openWinCenter(sUrl, "", 300, 180);
		}
		//팝업창 화면 가운데 정렬(2012.01.16)
		function openWinCenter(url, target, intwidth, intheight, options) {
			var top = 0;
			var left = 0;
			var w_width = intwidth; 	//창 넓이
			var w_height = intheight; 	//창 높이
			var option;
			if(left == 0){
				var x= screen.width/2 - w_width/2; //화면중앙으로위치
				left = x;
			}
			if(top == 0){
				var y= screen.height/2 - w_height/2;
				top = y;
			}
			
			option = "top="+top+",left="+left+",width="+intwidth+",height="+intheight+",resizable=0,scrollbars=0";
			if(options != null && options != ""){
				option = "top="+top+",left="+left+",width="+intwidth+",height="+intheight+","+options;
			}
			
			var winObj = window.open(url, target, option);
			if (winObj){
				winObj.focus();    
			} 
		}

		//수정일경우 게시기간 수정불가 체크
		function checkCalendarCreate(dateObj,langKnd,cal_id){
			var mode = '<c:out value="${paramMap.mode}"/>';
			if(mode == 'MODIFY'){
				var bannerStdDt = '<c:out value="${bannerInfo.START_DATE_KOR}"/>';
				var bannerEndDt = '<c:out value="${bannerInfo.END_DATE_KOR}"/>';
				/*var now = new Date();
				var year= now.getFullYear();
				var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
				var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
				today = year+mon+day;*/
				if(bannerStdDt <= today && today <= bannerEndDt){
					alert("게시중에는 기간을 수정할 수 없습니다.");
					return;
				}
				if(!(bannerStdDt <= today && today <= bannerEndDt)){
					Calendar_Create(dateObj,langKnd,cal_id);
				}
			}
			if(mode == 'WRITE'){
				Calendar_Create(dateObj,langKnd,cal_id);
			}
		}
	</script>
</head>
<body>
	<!-- sub_contents -->
	<div class="sub_contents">
		<!-- detail -->
		<div class="detail">
			<!-- board first -->
			<div class="board first">
				<!-- searchArea-->
				<div class="tsearchArea">
					<!--pageTitle -->
					<h1><%=msgs.getString("ev.hnevent.label.addBanner")%></h1>
					<!--pageTitle// -->
				</div>
				<!-- searchArea//-->
				<div style="overflow:hidden; padding:15px 0 0 0; width:980px;">
					<form id="bannerForm" name="bannerForm" method="post" action="<%=request.getContextPath()%>/hancer/banner/insertBanner.hanc" enctype="multipart/form-data">	
						<input type="hidden" id="BANNER_SEQ" name="BANNER_SEQ" value="<c:out value="${bannerInfo.BANNER_SEQ}"/>" />
						<input type="hidden" id="BANNER_TEXT_KOR" name="BANNER_TEXT_KOR" value="<c:out value="${bannerInfo.BANNER_TEXT_KOR}"/>" />
						<input type="hidden" id="BANNER_TEXT_ENG" name="BANNER_TEXT_ENG" value="<c:out value="${bannerInfo.BANNER_TEXT_ENG}"/>" />
						<input type="hidden" id="STATE" name="STATE" value="" /><!--버튼클릭에따라 상태값셋팅-->
						<input type="hidden" id="mode" name="mode" value="<c:out value="${paramMap.mode}"/>" />
						<!--input type="hidden" id="topBanner" name="topBanner" value="<c:out value="${bannerInfo.TOP_BANNER}"/>" /-->
						<input type="hidden" id="topBanner" name="topBanner" value="N"/>
						<input type="hidden" id="LANG_KND" name="LANG_KND" value="<c:out value="${paramMap.LANG_KND}"/>" />		
						<input type="hidden" id="USER_ID" name="USER_ID" value="<c:out value="${paramMap.USER_ID}"/>" />			
						<input type="hidden" id="userType" name="userType" value="<c:out value="${paramMap.userType}"/>" />		
						<input type="hidden" id="IMAGE_NM_KOR" name="IMAGE_NM_KOR" value="<c:out value="${bannerInfo.IMAGE_NM_KOR}"/>" />
						<input type="hidden" id="IMAGE_NM_ENG" name="IMAGE_NM_ENG" value="<c:out value="${bannerInfo.IMAGE_NM_ENG}"/>" />
						<input type="hidden" id="IMAGE_PATH_KOR" name="IMAGE_PATH_KOR" value="<c:out value="${bannerInfo.IMAGE_PATH_KOR}"/>" />
						<input type="hidden" id="IMAGE_PATH_ENG" name="IMAGE_PATH_ENG" value="<c:out value="${bannerInfo.IMAGE_PATH_ENG}"/>" />
						<input type="hidden" id="REG_DEPT_CODE" name="REG_DEPT_CODE" value="" />
						<input type="hidden" id="RST_MSG" name="RST_MSG" value="<c:out value="${paramMap.RST_MSG}"/>" /><!--2012.01.27-->
						
						<div class="banner1" style="width:390px; float:left;">
							<fieldset>
								<legend>배너 작성</legend>
								<div style="width:600px; margin-top:10px;">
									<h3 style="height:39px; line-height:39px; font-weight:600; border-top:0 none; color:#222; font-size:13px;"><%=msgs.getString("ev.hnevent.label.writeBanner")%></h3>
									<table id="grid-table" cellpadding="0" cellspacing="0" summary="배너 작성" class="table_board">
										<caption>배너 작성</caption>
										<colgroup>
											<col width="5%" />
											<col width="45%" />
											<col width="5%" />
											<col width="45%" />
										</colgroup>
										<tbody>
											<tr>
												<th class="L" scope="row"><input name="bn_img" type="radio" value="00" onclick="setRadioNo(this.value);"/></th>
												<td class="L">
													<div class="imgbox">
														<div class="title">Custom Image(KOR)</div>
														<div class="addimg">
															<c:if test="${not empty bannerInfo.IMAGE_PATH_KOR}">
																<img src="<%=request.getContextPath()%><c:out value='${bannerInfo.IMAGE_PATH_KOR}'/>" alt="배너썸네일이미지" style="width:147px;height:62px;"/>
															</c:if>
														</div>
														<div class="fileinput">
															<input type="file" style="width:200px;" id="thumbKor" name="thumbKor" onchange="document.getElementById('imgfileKor').value = this.value;" />
															<input type="text" class="txt_200" name="imgfileKor" id="imgfileKor" /> <span class="btn"></span>
														</div>
													</div>
												</td>
												<th scope="row"></th>
												<td class="L">
													<div class="imgbox">
														<div class="title">Custom Image(ENG)</div>
														<div class="addimg">
															<c:if test="${not empty bannerInfo.IMAGE_PATH_ENG}">
																<img src="<%=request.getContextPath()%><c:out value='${bannerInfo.IMAGE_PATH_ENG}'/>" alt="배너썸네일이미지" style="width:147px;height:62px;"/>
															</c:if>
														</div>
														<div class="fileinput">
															<input type="file" style="width:200px;" id="thumbEng" name="thumbEng" onchange="document.getElementById('imgfileEng').value = this.value;" />
															<input type="text" class="txt_200" name="imgfileEng" id="imgfileEng" /> <span class="btn"></span>
														</div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									<span><strong>[직접등록 이미지는 <font color="red">245*96(픽셀)</font>에서 최적화 되어 있습니다.]</strong></span>
								</div>
							</fieldset>
							<!-- 테이블 정의 -->
							<fieldset>
								<legend>배너이미지 선택</legend>
								<div style="width:600px; margin-top:10px;">
									<h3 style="height:39px; line-height:39px; font-weight:600; border-top:0 none; color:#222; font-size:13px;"><%=msgs.getString("ev.hnevent.label.bannerImageSelect")%></h3>
									<table id="grid-table" cellpadding="0" cellspacing="0" summary="배너이미지 선택" class="table_board">
										<caption>배너이미지 선택</caption>
										<colgroup>
											<col width="5%" />
											<col width="45%" />
											<col width="5%" />
											<col width="45%" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><input name="bn_img" type="radio" value="01" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_01.gif" alt="sample1" /></td>
												<th scope="row"><input name="bn_img" type="radio" value="02" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_02.gif" alt="sample2" /></td>
											</tr>
											<tr>
												<th scope="row"><input name="bn_img" type="radio" value="03" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_03.gif" alt="sample3"/></td>
												<th scope="row"><input name="bn_img" type="radio" value="04" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_04.gif" alt="sample4" /></td>
											</tr>
											<tr>
												<th scope="row"><input name="bn_img" type="radio" value="05" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_05.gif" alt="sample5" /></td>
												<th scope="row"><input name="bn_img" type="radio" value="06" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_06.gif" alt="sample6" /></td>
											</tr>
											<tr>
												<th scope="row"><input name="bn_img" type="radio" value="07" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_07.gif" alt="sample7" /></td>
												<th scope="row"><input name="bn_img" type="radio" value="08" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_08.gif" alt="sample8" /></td>
											</tr>
											<tr>
												<th scope="row"><input name="bn_img" type="radio" value="09" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_09.gif" alt="sample9" /></td>
												<th scope="row"><input name="bn_img" type="radio" value="10" onclick="setRadioNo(this.value);"/></th>
												<td><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/banner_10.gif" alt="sample10" /></td>
											</tr>
											<tr>
												<th scope="row" colspan="4" class="img">
													<center><a href="#bgdown" style="cursor:pointer;"  onclick="javascript:imgBgDownLoad();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.imageDownload")%></span></a></center>
												</th>
											</tr>
										</tbody>
									</table>
								</div>
							</fieldset>
						</div>
						<div class="form1" style="width:330px; float:right; margin-top:10px;">
							<fieldset>
								<legend>제목선택</legend>
								<h3 style="height:39px; line-height:39px; font-weight:600; border-top:0 none; color:#222; font-size:13px;"><%=msgs.getString("ev.hnevent.label.bannerTextSelect")%></h3>
								<table id="grid-table" cellpadding="0" cellspacing="0" summary="제목선택" class="table_board">
									<caption>제목선택</caption>
									<colgroup>
										<col width="45%" />
										<col width="55%" />
									</colgroup>
									<tbody>
										<c:if test="${adminRole == 'Y'}">
											<tr>
												<th scope="row">
													<%=msgs.getString("ev.hnevent.label.domainNm")%> <em>*</em>
												</th>
												<td colspan="3">
													<div class="sel_100">
														<select id="DOMAIN_ID" name="DOMAIN_ID" class="txt_100">
															<c:forEach items="${domainList}" var="domainInfo">
																	<option value="<c:out value="${domainInfo.domainId}"/>" <c:if test="${bannerInfo.DOMAIN_ID eq domainInfo.domainId}">selected</c:if>><c:out value="${domainInfo.domainNm}"/></option>
															</c:forEach>
														</select>
													</div>
												</td>		
											</tr>
										</c:if>
										<tr>
											<th scope="row">
												<%=msgs.getString("ev.hnevent.label.cateList")%> <em>*</em>
											</th>
											<td colspan="3">
												<div class="sel_100">
													<select id="CATEGORY_SEQ" name="CATEGORY_SEQ" class="txt_100">
														<c:forEach items="${cateCodeList}" var="data">
															<option value="<c:out value="${data.CATEGORY_SEQ}"/>" <c:if test="${bannerInfo.CATEGORY_SEQ eq data.CATEGORY_SEQ}">selected</c:if>><c:out value="${data.CATEGORY_NM}"/></option>
														</c:forEach>
													</select>
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row"><%=msgs.getString("ev.hnevent.label.titleKor")%> <em>*</em></th>
											<td><input name="titleKor" id="titleKor" type="text" class="ts_190" value="<c:out value="${bannerInfo.TITLE_KOR}"/>"/></td>
										</tr>
										<tr>
											<th scope="row"><%=msgs.getString("ev.hnevent.label.titleEng")%> <em>*</em></th>
											<td><input name="titleEng" id="titleEng" type="text" class="ts_190" value="<c:out value="${bannerInfo.TITLE_ENG}"/>"/></td>
										</tr>
										<tr>
											<th scope="row"><span name="reqField" id="reqField" style=""></span><%=msgs.getString("ev.hnevent.label.contactInfoKor")%> <em>*</em></th>
											<td><input name="deptCdKor" id="deptCdKor" type="text" class="ts_190" value="<c:out value="${bannerInfo.DEPT_CD_KOR}"/>"/></td>
										</tr>
										<tr>
											<th scope="row"><span name="reqField" id="reqField" style=""></span><%=msgs.getString("ev.hnevent.label.contactInfoEng")%> <em>*</em></th>
											<td><input name="deptCdEng" id="deptCdEng" type="text" class="ts_190" value="<c:out value="${bannerInfo.DEPT_CD_ENG}"/>"/></td>
										</tr>
										<tr>
											<th scope="row"><span name="reqField" id="reqField" style=""></span><%=msgs.getString("ev.hnevent.label.whenWhereKor")%> <em>*</em></th>
											<td><input name="schPlaceKor" id="schPlaceKor" type="text" class="ts_190" value="<c:out value="${bannerInfo.SCH_PLACE_KOR}"/>"/></td>
										</tr>
										<tr>
											<th scope="row"><span name="reqField" id="reqField" style=""></span><%=msgs.getString("ev.hnevent.label.whenWhereEng")%> <em>*</em></th>
											<td><input name="schPlaceEng" id="schPlaceEng" type="text" class="ts_190" value="<c:out value="${bannerInfo.SCH_PLACE_ENG}"/>"/></td>
										</tr>
										<tr>
											<th scope="row" rowspan="2"><%=msgs.getString("ev.hnevent.label.dateKor")%> <em>*</em></th> 
											<td><input name="date1_ko" type="text" class="txt_100" id="date1_ko" title="일자" value="<c:out value="${bannerInfo.START_DATE_KOR}"/>" readonly/><a id="switch_calendar"  href="#btn" style="cursor:pointer;" onclick="checkCalendarCreate('date1_ko','<c:out value="${paramMap.LANG_KND}"/>','switch_calendar');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/bbs/bu_icon_carlendar.gif" alt="달력" align="absmiddle" /></a> ~ <input name="date2_ko" type="text" class="txt_100" id="date2_ko" title="일자" value="<c:out value="${bannerInfo.END_DATE_KOR}"/>" readonly/><a id="switch_calendar1"  href="#btn" style="cursor:pointer;" onclick="checkCalendarCreate('date2_ko','<c:out value="${paramMap.LANG_KND}"/>','switch_calendar1');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/bbs/bu_icon_carlendar.gif" alt="달력" align="absmiddle" /></a></td>
										</tr>
										<tr>
											<td><a href="#" onclick="showRegEnable();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.availableDate")%></span></a></td>
										</tr>
										<tr>
											<th scope="row"><%=msgs.getString("ev.hnevent.label.url")%> <em>*</em></th>
											<td><input name="link" id="link" type="text" class="ts_190" value="<c:out value="${bannerInfo.TARGET_LINK}"/>"/></td>
										</tr>
										<c:if test="${menuAuth eq 'Y'}"><!--관리자만상단배너노출-->
										<!--tr>
											<th scope="row"><%=msgs.getString("ev.hnevent.label.topBanner")%></th>
											<td><input name="top_banner" id="top_banner" type="checkbox" value="<c:out value="${bannerInfo.TOP_BANNER}"/>" <c:if test="${bannerInfo.TOP_BANNER eq 'Y'}">checked</c:if> onclick="checkValue();"/></td>
										</tr-->
										</c:if>
									</tbody>
								</table>
							</fieldset>
							<a href="#btnLink" style="cursor:pointer;" onclick="javascript:preView();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.preview")%></span></a>					
							<!-- btnArea// -->
							<div class="view" id="pre_view" style="height:110px;">
								<c:if test="${!empty bannerInfo.BANNER_TEXT_KOR && paramMap.LANG_KND == 'ko'}"><c:out value="${bannerInfo.BANNER_TEXT_KOR}" escapeXml="false"/></c:if>
								<c:if test="${!empty bannerInfo.BANNER_TEXT_ENG && paramMap.LANG_KND == 'en'}"><c:out value="${bannerInfo.BANNER_TEXT_ENG}" escapeXml="false"/></c:if>			
							</div>
							<!-- 실행모드&상태별로 버튼 디스플레이 --> 
							<c:if test="${paramMap.mode eq 'WRITE'}">
								<!-- btnArea-->
								<div class="btnArea">
									<div class="rightArea">
										<%--	
										<a href="#linkUseInfo" onclick="window.open('<%=request.getContextPath()%>/statics/bannerUseInfo.jsp','_blank','width=650,height=450,resizable=no');">
											<span><%=msgs.getString("ev.hnevent.portlet.action.help")%></span>
										</a>
										--%>
										<a href="#back" onclick="javascript:backToList();" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.list")%></span></a>
										<a href="javascript:saveBanner('2','add');" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.reg")%></span></a>
									</div>
								</div>
								<!-- btnArea// -->
							</c:if>
							<c:if test="${paramMap.mode eq 'MODIFY'}">
								<c:if test="${menuAuth == 'Y'}"><!--관리자-->
									<c:if test="${bannerInfo.STATE eq '2'}"><!--승인-->
										<!-- btnArea-->
										<div class="btnArea">
											<div class="rightArea">
		 										<%--
		 										<a href="#linkUseInfo" onclick="window.open('<%=request.getContextPath()%>/statics/bannerUseInfo.jsp','_blank','width=650,height=450,resizable=no');" class="btn_B">
													<span><%=msgs.getString("ev.hnevent.portlet.action.help")%></span>
												</a>												 
												--%>
												<a href="#back" onclick="backToList();" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.list")%></span></a>
												<a href="javascript:saveBanner('2','mod');" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.save")%></span></a> 
												<a href="javascript:saveBanner('1','rej');" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.deny")%></span></a> 
												<a href="javascript:deleteBanner('<c:out value="${bannerInfo.BANNER_SEQ}" />','<c:out value="${bannerInfo.IMAGE_PATH_KOR}" />','<c:out value="${bannerInfo.IMAGE_PATH_ENG}" />');" class="btn_B">
													<span><%=msgs.getString("ev.hnevent.label.delete")%></span>
												</a>
											</div>
										</div>
										<!-- btnArea//-->
									</c:if>
									<c:if test="${bannerInfo.STATE eq '1'}"><!--거부-->
										<!-- btnArea-->
										<div class="btnArea">
											<div class="rightArea">
												<%-- 									
												<a href="#linkUseInfo" onclick="window.open('<%=request.getContextPath()%>/statics/bannerUseInfo.jsp','_blank','width=650,height=450,resizable=no');" class="btn_B">
													<span><%=msgs.getString("ev.hnevent.portlet.action.help")%></span>
												</a>
												 --%>
												<a href="#back" onclick="backToList();" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.list")%></span></a>
												<a href="javascript:saveBanner('2','cle');" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.releaseDeny")%></span></a> 
												<a href="javascript:deleteBanner('<c:out value="${bannerInfo.BANNER_SEQ}" />','<c:out value="${bannerInfo.IMAGE_PATH_KOR}" />','<c:out value="${bannerInfo.IMAGE_PATH_ENG}" />');" class="btn_B">
													<span><%=msgs.getString("ev.hnevent.label.delete")%></span>
												</a>
											</div>
										</div>
										<!-- btnArea//-->
									</c:if>
								</c:if>
								<c:if test="${menuAuth == 'N'}"><!--관리자가 아닐때-->
									<c:if test="${bannerInfo.STATE eq '2' && bannerInfo.REG_USER_ID eq paramMap.USER_ID}"><!--승인&본인작성글-->
										<!-- btnArea-->
										<div class="btnArea">
											<div class="rightArea">
												<%--
												<a href="#linkUseInfo" onclick="window.open('<%=request.getContextPath()%>/statics/bannerUseInfo.jsp','_blank','width=650,height=450,resizable=no');" class="btn_B">
													<span><%=msgs.getString("pt.ev.portlet.action.help")%></span>
												</a>
												--%>
												<a href="#back" onclick="backToList();" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.list")%></span></a>
												<a href="javascript:saveBanner('2','mod');" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.save")%></span></a> 
												<a href="javascript:deleteBanner('<c:out value="${bannerInfo.BANNER_SEQ}" />','<c:out value="${bannerInfo.IMAGE_PATH_KOR}" />','<c:out value="${bannerInfo.IMAGE_PATH_ENG}" />');" class="btn_B">
													<span><%=msgs.getString("ev.hnevent.label.delete")%></span>
												</a>
											</div>
										</div>
										<!-- btnArea//-->
									</c:if>
									<c:if test="${bannerInfo.STATE eq '1' && bannerInfo.REG_USER_ID eq paramMap.USER_ID}"><!--거부&본인작성글-->
										<!-- btnArea-->
										<div class="btnArea">
											<div class="rightArea">
												<%--
												<a href="#linkUseInfo" onclick="window.open('<%=request.getContextPath()%>/statics/bannerUseInfo.jsp','_blank','width=650,height=450,resizable=no');" class="btn_B>
													<span><%=msgs.getString("pt.ev.portlet.action.help")%></span>
												</a>
												--%>
												<a href="#back" onclick="backToList();" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.list")%></span></a>											
											</div>
										</div>
										<!-- btnArea// -->
									</c:if>
								</c:if>
							</c:if>
							<!-- 테이블 정의 끝 --> 
						</div>
					</form>
				</div>						
			</div>
			<!-- board first// -->
		</div>
		<!-- detail// -->
	</div>
	<!-- sub_contents// -->
	
	<!-- bannerBg DownLoad -->
	<form action="<%=request.getContextPath()%>/banner/fileMgr?cmd=bannerBg" id="bannerBgDown" name="bannerBgDown" method="post" target="invisible">
		<input type="hidden" id="fileMask"  name="fileMask"  value=""/>
		<input type="hidden" id="fileName"  name="fileName"  value=""/>
	</form> 

	<!-- back to bannerApproval list(2012.01.27) -->
	<form action="<%=request.getContextPath()%>/hancer/banner/selectBannerList.hanc" id="backBnList" name="backBnList" method="post">
		<input type="hidden" id="PAGE_NUM_BACK"  name="PAGE_NUM"  value="<c:out value='${paramMap.PAGE_NUM}'/>"/>
		<input type="hidden" id="PAGE_SIZE_BACK" name="PAGE_SIZE" value="<c:out value='${paramMap.PAGE_SIZE}'/>"/>
		<input type="hidden" id="TITLE_NM_BACK"  name="TITLE_NM"  value="<c:out value='${paramMap.TITLE_NM}'/>"/>
		<input type="hidden" id="STATE_BACK"     name="STATE"     value="<c:out value='${paramMap.STATE}'/>"/>
		<input type="hidden" id="REG_FROM_BACK"  name="REG_FROM"  value="<c:out value='${paramMap.REG_FROM}'/>"/>
		<input type="hidden" id="REG_TO_BACK"    name="REG_TO"    value="<c:out value='${paramMap.REG_TO}'/>"/>
	</form>

	<!-- //iframe Of used by attachFileUpload -->
	<iframe src="<%=request.getContextPath()%>/banner/blank.hanc" name="invisible" frameborder="0" width="0" height="0"></iframe>
</body>
</html>