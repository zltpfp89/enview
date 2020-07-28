<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			
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
										<li><a href="<c:out value="${subMenu.fullUrl}"/>"  target="${subMenu.target}"><c:out value="${subMenu.shortTitle}"/></a>
											<ul>
												<c:forEach items="${subMenu.elements}" var="subSubMenu" varStatus="status">
													<c:if test="${subSubMenu.hidden=='false'}">
														<li><a href="<c:out value="${subSubMenu.fullUrl}"/>"  target="${subSubMenu.target}"><c:out value="${subSubMenu.shortTitle}"/></a></li>
													</c:if>
												</c:forEach>
											</ul>
										</li>
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