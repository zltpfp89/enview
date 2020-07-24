<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<ul class="lnb_dep1">
		<li>
			<a class="category" id="category_" onclick="cfHome.selectCateMenu('<util:message key="ev.title.all"/>', '', '');" style="cursor:pointer " onmouseout="this.style.textDecoration='none';" onmouseover="this.style.textDecoration='underline';">
				<util:message key="ev.title.all"/> (<c:out value="${cafeTotal}"/>) 
			</a>
		</li>
	<c:forEach items="${cateList}" var="cate" varStatus="status">
		<li>
			<a class="category" id="category_<c:out value="${cate.cateId}"/>" onclick="cfHome.selectCateMenu('<c:out value="${cate.cateNm}"/>',<c:out value="${cate.cateId}"/>,<c:out value="${cate.cateLevel}"/>);" style="cursor:pointer " onmouseout="this.style.textDecoration='none';" onmouseover="this.style.textDecoration='underline';">
				<c:out value="${cate.cateNm}"/> (<c:out value="${cate.itemCnt}"/>)
				<c:if test="${ not empty cate.childList}">
				<button> + </button>
				</c:if>
			</a>
			<c:if test="${ not empty cate.childList}">
				<ul class="lnb_dep2">
					<c:forEach items="${cate.childList}" var="cate2" varStatus="status">
						<li>
							<a id="category_<c:out value="${cate2.cateId}"/>"  class="category" onclick="cfHome.selectCateMenu(<c:out value="${cate.cateId}"/>,<c:out value="${cate2.cateId}"/>,<c:out value="${cate2.cateLevel}"/>);" >
								<c:out value="${cate2.cateNm}"/>
								(<c:out value="${cate2.itemCnt}"/>)
								<c:if test="${ not empty cate2.childList}">
								<button>하위메뉴 보기</button>
								</c:if>
							</a>
							<c:if test="${ not empty cate2.childList}">
								<ul class="lnb_dep2">
									<c:forEach items="${cate2.childList}" var="cate3" varStatus="status">
										<li>
											<a id="category_<c:out value="${cate3.cateId}"/>"  class="category" onclick="cfHome.selectCateMenu(<c:out value="${cate.cateId}"/>,<c:out value="${cate3.cateId}"/>,<c:out value="${cate3.cateLevel}"/>);" >
												<c:out value="${cate3.cateNm}"/> (<c:out value="${cate3.itemCnt}"/>)
											</a>
										</li>
									</c:forEach>
								</ul>
							</c:if>
						</li>
					</c:forEach>
				</ul>
			</c:if>
		</li>
	</c:forEach>
</ul>
