<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


			<c:choose>
				<c:when test="${requestScope['enview.portal.requestPage'].pageType=='main'}">
					</div> <!-- //sub_conainer -->
				</c:when>
				<c:otherwise>
					</div> <!-- //con_article -->
					</div> <!-- //sub_conainer -->
				</c:otherwise>
			</c:choose>


		<div class="footer">
			
			<div class="footer_top">
				<ul>
					<li><a href="${cPath}/portal/kbig/policy/privacy">개인정보처리방침</a></li>
					<li><a href="${cPath}/portal/kbig/policy/promise">이용약관</a></li>
					<li>개인정보보호책임자 : 실장 권미수</li>
					<li>이메일 <a href="mailto:Webmaster@nia.or.kr" title="이메일"> webmaster@nia.or.kr</a></li>
				</ul>
			</div> <!-- //footer_top -->
			<div class="footer_info">
				<div class="address">
					<p><span>대표 : 문용식</span><span>사업자번호 : 135-82-04900</span></p>
					<p><span>경기도 성남시 판교로 289번길 스타트업 캠퍼스 6층 [본원 : 대구광역시 동구 첨단로 53]</span></p>
					<p><span>TEL : 1670-1317</span><span>E-mail : bigdatamanager@nia.or.kr</span></p>
				</div>
				<div class="foot_logo">
					<a href="http://www.msit.go.kr/web/main/main.do" class="no_1" target="_blank">과학기술정보통신부</a>
					<a href="http://www.nia.or.kr/" class="no_2" target="_blank">NIA 한국정보화진흥원</a>
				</div>
			</div> <!-- //footer_info -->
			
		</div> <!-- //footer -->
	
</body>
</html>

<script>
		initEnview();
</script>
<%
%>