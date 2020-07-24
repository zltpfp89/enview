<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO"%>

<c:set var="frameType"  value="${param.frameType}"/>
<c:set var="brdGrpType" value="${param.brdGrpType}"/>
<c:set var="brdType"    value="${param.brdType}"/>

<% int ellipsisLen = 0;%>
<c:if test="${brdType == 'IMG2'}">
  <% ellipsisLen = 14;%>
</c:if>
<c:if test="${brdType == 'IMG3'}">
  <% ellipsisLen = 24;%>
</c:if>
<c:if test="${brdType == 'IMG1'}">
	<c:if test="${brdGrpType == 'FLT10'}">
		<c:set var="colCnt" value="7"/>
		<c:set var="rowCnt" value="1"/>
	</c:if>
	<c:if test="${brdGrpType == 'FLT20'}">
		<c:set var="colCnt" value="21"/>
		<c:set var="rowCnt" value="3"/>
	</c:if>
	<c:if test="${brdGrpType == 'MLT10' || brdGrpType == 'MRT10'}">
		<c:set var="colCnt" value="8"/>
		<c:set var="rowCnt" value="2"/>
	</c:if>
	<c:if test="${brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
		<c:set var="colCnt" value="20"/>
		<c:set var="rowCnt" value="5"/>
	</c:if>
</c:if>
<c:if test="${brdType == 'IMG2'}">
	<c:if test="${brdGrpType == 'FLT10'}">
		<c:set var="colCnt" value="6"/>
		<c:set var="rowCnt" value="1"/>
	</c:if>
	<c:if test="${brdGrpType == 'FLT20'}">
		<c:set var="colCnt" value="12"/>
		<c:set var="rowCnt" value="2"/>
	</c:if>
	<c:if test="${brdGrpType == 'MLT10' || brdGrpType == 'MRT10'}">
		<c:set var="colCnt" value="3"/>
		<c:set var="rowCnt" value="1"/>
	</c:if>
	<c:if test="${brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
		<c:set var="colCnt" value="9"/>
		<c:set var="rowCnt" value="3"/>
	</c:if>
</c:if>
<c:if test="${brdType == 'IMG3'}">
	<c:if test="${brdGrpType == 'FLT10'}">
		<c:set var="colCnt" value="4"/>
		<c:set var="rowCnt" value="1"/>
	</c:if>
	<c:if test="${brdGrpType == 'FLT20'}">
		<c:set var="colCnt" value="8"/>
		<c:set var="rowCnt" value="2"/>
	</c:if>
	<c:if test="${brdGrpType == 'MLT10' || brdGrpType == 'MRT10'}">
		<c:set var="colCnt" value="2"/>
		<c:set var="rowCnt" value="1"/>
	</c:if>
	<c:if test="${brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
		<c:set var="colCnt" value="4"/>
		<c:set var="rowCnt" value="2"/>
	</c:if>
</c:if>
<c:set var="emptyCol" value="${colCnt}"/>
<c:set var="lastCol" value="${colCnt / rowCnt}"/>
<div class="boardNameBorder CF0501_nmBrdrStyle CF0501_nmBrdrWidth CF0501_nmBrdrColor">			
	<div class="title">
		<a class="boardName CF0501_nmFontColor CF0501_nmFontNm" href="javascript:cfCntt.readBulletin('<c:out value="${boardVO.boardId}"/>');"><c:out value="${boardVO.boardNm}"/></a>
	</div>
	<div class="more">
		<a class="more_view" onclick="cfCntt.readBulletin('<c:out value="${boardVO.boardId}"/>')">
			<util:message key="ev.prop.more"/>+
		</a>
	</div>
</div>
<div class="boardList boardList_<c:out value="${brdType}"/>">	
	<ul class="<c:out value="${brdType}"/> <c:out value="${brdGrpType}"/> <c:out value="${brdType}"/>_<c:out value="${brdGrpType}"/>">
	<c:if test="${brdType == 'IMG1'}">
		<c:forEach items="${bltnList}" begin="0" end="${colCnt-1}" var="list" varStatus="status">			
		<li class="img1_box<c:if test="${!status.first && status.count%colCnt == 0}">_last</c:if>">		
			<dl class="img1_data">				
				<dt>
					<c:if test="${list != null}">
						<a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<img id="<c:out value="${list.fileMask}"/>" class="img1_img CF0802_extraBrdrColor" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc100}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>						
						</a>
					</c:if>
					<c:if test="${list == null}">
						<div class="img1_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div>
					</c:if>
				</dt>
			</dl>
		</li>
		<c:if test="${status.last}">
			<c:set var="emptyCol" value="${colCnt - status.count }"/>
		</c:if>
		</c:forEach>
		<c:if test="${emptyCol > 0}">
			<c:forEach begin="0" end="${emptyCol-1}" varStatus="status">		
			<li class="img1_box<c:if test="${(emptyCol - status.count + lastCol ) % lastCol == 0 }">_last</c:if>">
				<dl class="img1_data"><dd><div class="img1_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div></dd></dl>
			</li>
			</c:forEach>
		</c:if>
	</c:if>
	<c:if test="${brdType == 'IMG2'}">
		<c:forEach items="${bltnList}" begin="0" end="${colCnt-1}" var="list" varStatus="status">		
		<li class="img2_box<c:if test="${!status.first && status.count%lastCol == 0}">_last</c:if>">
			<dl class="img2_data">				
				<dt>
					<c:if test="${list != null}">
						<a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<img id="<c:out value="${list.fileMask}"/>" class="img2_img CF0802_extraBrdrColor" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc100}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>						
						</a>
					</c:if>
					<c:if test="${list == null}">
						<div class="img2_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div>
					</c:if>
				</dt>
				<dd class="img_subject CF0501_subjFontColor"><a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)"><c:out value="${list.bltnSubj}"/></a></dd>
				<dd class="img_regDatim"><c:out value="${list.regDatimSSF}"/></dd>
				<dd class="img_userNick"><c:out value="${list.userNick}"/></dd>
			</dl>
		</li>
		<c:if test="${status.last}">
			<c:set var="emptyCol" value="${colCnt - status.count }"/>
		</c:if>
		</c:forEach>
		<c:if test="${emptyCol > 0}">
			<c:forEach begin="0" end="${emptyCol-1}" varStatus="status">		
			<li class="img2_box<c:if test="${(emptyCol - status.count + lastCol ) % lastCol == 0}">_last</c:if>">
				<dl class="img2_data"><dd><div class="img2_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div></dd></dl>
			</li>
			</c:forEach>
		</c:if>
	</c:if>
	<c:if test="${brdType == 'IMG3'}">
		<c:forEach items="${bltnList}" begin="0" end="${colCnt-1}" var="list" varStatus="status">
		<li class="img3_box<c:if test="${!status.first && status.count%lastCol == 0}">_last</c:if> count_<c:out value="${status.count}"/>">
			<dl class="img3_data">				
				<dt>
					<c:if test="${list != null}">
						<a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<img id="<c:out value="${list.fileMask}"/>" class="img3_img CF0802_extraBrdrColor" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc150}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>						
						</a>
					</c:if>
					<c:if test="${list == null}">
						<div class="img3_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div>
					</c:if>
				</dt>
				<dd class="img3_subject CF0501_subjFontColor"><a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)"><c:out value="${list.bltnSubj}"/></a></dd>
				<dd class="img3_regDatim"><c:out value="${list.regDatimSSF}"/></dd>
				<dd class="img3_userNick"><c:out value="${list.userNick}"/></dd>
			</dl>
		</li>
		<c:if test="${status.last}">
			<c:set var="emptyCol" value="${colCnt - status.count}"/>
		</c:if>
		</c:forEach>
		<c:if test="${emptyCol > 0}">
			<c:forEach begin="0" end="${emptyCol-1}" varStatus="status">		
			<li class="img3_box<c:if test="${(emptyCol - status.count + lastCol ) % lastCol == 0 }">_last</c:if> emptyCol_<c:out value="${emptyCol}"/>">
				<dl class="img3_data"><dd><div class="img3_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div></dd></dl>
			</li>
			</c:forEach>
		</c:if>
	</c:if>
	</ul>
</div>