<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	//모바일 브라우저 문자열 체크
	String browser[] = {"android","blackberry","googlebot-mobile","iemobile","iphone","ipod","opera mobile","palmos","webos"};
	String userAgent = request.getHeader("user-agent");
	String userAgent1 = userAgent.toLowerCase();
	String flag = "";

	for(int i = 0; i < browser.length; i++){
	  if(userAgent1.matches(".*"+browser[i]+".*")){
		flag = "Y";           // 모바일 브라우저
	  }
	}
	if("Y".equals(flag)){         // 모바일 브라우저일때
	// 만약 html을 사용해야한다면
		request.setAttribute("mobileYn", "Y");
	}
%>	
	
<c:set var="count" value="0"/>
<div class="con_article">
	<div class="sitemap_wrap">
		<ul>
			<c:forEach items="${topMenuList}" var="menu" varStatus="status">
				<c:if test="${menu.hidden=='false'}">
					<c:if test="${!menu.hidden && menu.name != menu2hide1 && menu.name != menu2hide2}">
						<c:set var="count" value="${count +1}"/>
						<li><a href="<c:out value="${menu.fullUrl}"/>" target='<c:out value="${menu.target}"/>'><c:out value="${menu.shortTitle}"/></a>
							<c:if test="${not empty menu.elements}">
								<ul class="sitemap no_0${count}">
									<c:forEach items="${menu.elements}" var="subMenu" varStatus="status">
										<c:if test="${subMenu.hidden == 'false' }">
											<li><a href="<c:out value="${subMenu.fullUrl}"/>"  target="${subMenu.target}"><c:out value="${subMenu.shortTitle}"/></a>
												<ul>
													<c:forEach items="${subMenu.elements}" var="subSubMenu" varStatus="status">
														<c:if test="${subSubMenu.hidden=='false'}">
															<c:choose>
																<c:when test="${mobileYn eq 'Y' }">
																	<c:if test="${subSubMenu.deviceType eq 'M' or  subSubMenu.deviceType eq null}">
																		<li><a href="<c:out value="${subSubMenu.fullUrl}"/>"  target="${subSubMenu.target}"><c:out value="${subSubMenu.shortTitle}"/></a></li>
																	</c:if>
																</c:when>
																<c:otherwise>
																	<c:if test="${subSubMenu.deviceType eq 'P' or  subSubMenu.deviceType eq null}">
																		<li><a href="<c:out value="${subSubMenu.fullUrl}"/>"  target="${subSubMenu.target}"><c:out value="${subSubMenu.shortTitle}"/></a></li>
																	</c:if>
																</c:otherwise>
															</c:choose>
														</c:if>
													</c:forEach>
												</ul>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</c:if>
						</li>
					</c:if>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div> <!-- //con_article -->