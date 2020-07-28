<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>개인정보 수집 및 이용 동의</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sjpb/css/board.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/sjpb/js/Z/jquery.js"></script>

	<script>
		$(document).ready(function() {
			
			
		});
		
	
		
		
	</script>


</head>
<body style="min-width:0;">
<div class="sub_layout">
<h1><a href="#">민생사법경찰단 수사정보 포털시스템</a></h1>
<!-- body -->
<div id="body">
	<!-- body_wrap -->
	<div id="body_wrap">
    	<!-- sub -->
        <div id="sub">
            <h3>개인정보 수집 및 이용 동의</h3>
            <div class="board">
				<div class="info">
					<h4>안내사항</h4>
					<p>한국농수산대학은 졸업생지도 관리 등 제반업무를 위해서 <em>｢개인정보 보호법｣ 제15조 및 제22조에 따라</em> 아래와 같이 개인정보를 수집ㆍ이용 및 제3자에게 제공하고자 합니다. 내용을 자세히 읽으신 후 동의 여부를 결정하여 주십시오.</p>
				</div>
				<h5>개인정보 수집․이용 동의</h5>
				<div class="policy">
					<ol>
						<li class="">개인정보의 수집·이용 목적 : <em>졸업생 의무영농 이행관리</em></li>
						<li>수집하려는 개인정보의 항목 : 성명, 전화번호, 주소, 이메일, 학번 등 졸업생 의무영농 이행에 관한 사항</li>
						<li>개인정보의 보유 및 이용 기간 : <em>영구</em></li>
						<li>동의를 거부할 수 있으며, 동의 거부시 한국농수산대학 학비지원조건이 불이행으로 처리 될 수 있음.</li>
					</ol>
					<p>위 개인정보 수집이용에 동의하십니까?
						<span>
							<input type="radio" id="agree_01" name="list_01" /><label for="agree_01">동의함</label>
							<input type="radio" id="disagree_01" name="list_01" /><label for="disagree_01">동의하지 않음</label>
						</span>
					</p>
				</div>
				<h5>고유식별정보 수집에 대한 동의</h5>
				<div class="policy">
					<ol>
						<li>고유식별정보의 수집․이용 목적 : <em>졸업생 의무영농 이행관리</em></li>
						<li>고유식별정보 항목 : <em>주민등록번호</em></li>
						<li>보유 및 이용기간 : <em>영구</em></li>
						<li>동의를 거부할 수 있으며, 동의 거부시 한국농수산대학 학비지원조건이 불이행으로 처리 될 수 있음.</li>
					</ol>
					<p>위 고유식별정보  수집이용에 동의하십니까?
						<span>
							<input type="radio" id="agree_02" name="list_02" /><label for="agree_02">동의함</label>
							<input type="radio" id="disagree_02" name="list_02" /><label for="disagree_02">동의하지 않음</label>
						</span>
					</p>
				</div>
				<h5>개인정보 제3자 제공에 대한 동의</h5>
				<div class="policy">
					<ol>
						<li>개인정보를 제공받는 자 : <em>국민건강보험 공단</em></li>
						<li>개인정보를 제공받는 자의 개인정보 이용 목적 : <em>직장 ㆍ지역의료보험 가입여부 조회</em></li>
						<li>제공하는 개인정보의 항목 : 성명, <em>주민등록번호</em>, 전화번호, 이메일</li>
						<li>개인정보를 제공받는 자의 개인정보 보유 및 이용 기간 : <em>처리 즉시 파기</em></li>
						<li>동의를 거부할 수 있으며, 동의 거부시 한국농수산대학 학비지원조건이 불이행으로 처리 될 수 있음.</li>
					</ol>
					<p>위 개인정보의 제3자 제공에 동의하십니까?
						<span>
							<input type="radio" id="agree_03" name="list_03" /><label for="agree_03">동의함</label>
							<input type="radio" id="disagree_03" name="list_03" /><label for="disagree_03">동의하지 않음</label>
						</span>
					</p>
				</div>

				<div class="btnArea">
					<div class="C"><a href="#" class="btn_blue"><span>확인</span></a> <a href="#" class="btn_white"><span>취소</span></a></div>
				</div>
			</div>

        </div>
        <!-- sub //-->
	</div>
	<!-- body_wrap //-->
</div>
<!-- body //-->
</div>
</body>
</html>