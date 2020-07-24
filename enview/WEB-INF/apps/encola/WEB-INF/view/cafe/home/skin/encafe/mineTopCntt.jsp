<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<!-- BEGIN::내가 가입한 카페  -->
<c:if test="${homeForm.initView == 'mine.all'}">
	<div class="board_btn_wrap" style="margin-top:30px;">
		<div class="board_btn_wrap_left">
			<h3><util:message key="cf.title.myCafe"/></h3>
		</div>
		<div class="board_btn_wrap_right">
		<%--
			<util:message key="ef.info.add.favor.cafe"/>
 		--%>			
		</div>
	</div>
		
	<table class="table_type01" summary="추천카페">
		<caption>추천카페 리스트입니다</caption>
		<colgroup>
			<col width="80px;">
			<col width="150px;">
			<col width="auto;">
			<col width="100px;">
			<col width="120px;">
			<%--
			<col width="100px;"> --%>
		</colgroup>
		<thead>
			<tr>
				<th></th>
				<th><util:message key="mm.title.category"/></th> <%--카테고리--%>
				<th><util:message key="cf.title.cafe.name"/></th> <%--카페이름--%>
				<th><util:message key="cf.title.mmbrLevel"/></th> <%--회원등급 --%>
				<th><util:message key="cf.title.joinDate"/></th> <%--가입일 --%>
				<%--
				<th><util:message key="cf.title.secession"/></th>
				 탈퇴--%>
			</tr>
		</thead>
		<tbody>
			<c:if test="${!mmbrVO.isLogin}">
	    		<tr>
					<td scope="row" colspan="5" class="title Center">
						<dl class="emptyCafeList">
							<dt><util:message key="eb.error.need.login"/><%--로그인 하셔야 합니다.--%></dt>
						</dl>
					</td>
				</tr>
		  	</c:if>
		  	<c:if test="${mmbrVO.isLogin}">
					<c:if test="${empty myAllList}">
			    		<tr>
							<td scope="row" colspan="5" class="title Center">
								<dl class="emptyCafeList">
									<dt><util:message key="cf.error.not.exist.my.cafe"/><%--가입한 카페가 없습니다.--%></dt>
									<dd><util:message key="cf.error.not.exist.my.cafe2"/><%--새로운 카페를 개설하거나, 다양한 카페를 찾아 가입해 보세요.--%></dd>
								</dl>
							</td>
						</tr>
		  			</c:if>
				</c:if>
				<c:if test="${!empty myAllList}">
					<c:forEach items="${myAllList}" var="myAll">
						<tr>
							<td onclick="cfHome.toggleFavorCafe('<c:out value="${myAll.cmntVO.cmntId}"/>');" >
								<span id="star_<c:out value="${myAll.cmntVO.cmntId}"/>" class="icon <c:if test="${myAll.isFavor}">on</c:if><c:if test="${!myAll.isFavor}">off</c:if>"></span>
							</td>
							<td><c:out value="${myAll.cmntVO.cateIdNm}"/></td>
							<td><a href="<%=evcp%>/cafe/<c:out value="${myAll.cmntVO.cmntUrl}"/>"><c:out value="${myAll.cmntVO.cmntNm}"/></a></td>
							<td><c:out value="${myAll.mmbrGrdNm }"/></td>
							<td><c:out value="${myAll.regDatimPF }"/></td>
							<%--
							<td>
								<c:if test="${mmbrVO.loginId == myAll.cmntVO.makerId}"><a href="javascript:cfHome.resignCafe('<c:out value="${myAll.cmntVO.cmntUrl}"/>');" class="btn white"><util:message key="cf.title.secession"/></a></c:if>
							    <c:if test="${mmbrVO.loginId != myAll.cmntVO.makerId}"><a href="javascript:cfHome.resignCafe('<c:out value="${myAll.cmntVO.cmntUrl}"/>');" class="btn white"><util:message key="cf.title.secession"/></a></c:if>
							</td>
							 --%>
						</tr>
					</c:forEach>
				</c:if>
		</tbody>
	</table>
</c:if>
<!-- END::내가 가입한 카페  -->
<!-- BEGIN::내가 가입 신청한 카페  -->
<c:if test="${homeForm.initView == 'mine.wait'}">
	<div class="board_btn_wrap" style="margin-top:30px;">
		<div class="board_btn_wrap_left">
			<h3><util:message key="cf.title.cafe.subscribed"/></h3>
		</div>
	</div>
	<table class="table_type01" summary="추천카페">
		<caption>추천카페 리스트입니다</caption>
		<colgroup>
			<col width="150px;">
			<col width="auto;">
			<col width="100px;">
			<col width="120px;">
		</colgroup>
		<thead>
			<tr>
				<th><util:message key="mm.title.category"/></th> <%--카테고리--%> 
				<th><util:message key="cf.title.cafe.name"/></th> <%--카페이름--%> 
				<th><util:message key="cf.title.appDate"/> </th> <%--가입 신청일 --%>
				<th><util:message key="cf.title.cancelApp"/></th> <%--신청 취소 --%>
			</tr>
		</thead>
		<tbody>
			<c:if test="${!mmbrVO.isLogin}">
	    		<tr>
					<td scope="row" colspan="4" class="title Center">
						<dl class="emptyCafeList">
							<dt><util:message key="eb.error.need.login"/><%--로그인 하셔야 합니다.--%></dt>
						</dl>
					</td>
				</tr>
		  	</c:if>
		  	<c:if test="${mmbrVO.isLogin}">
				<c:if test="${empty myAllWaitList}">
		    		<tr>
						<td scope="row" colspan="4" class="title Center">
							<dl class="emptyCafeList">
								<dt><util:message key="cf.error.not.exist.to.join.cafe"/><%--가입 신청한  카페가 없습니다.--%></dt>
							</dl>
						</td>
					</tr>
	  			</c:if>
				<c:if test="${!empty myAllWaitList}">
					<c:forEach items="${myAllWaitList}" var="myWait">
						<tr>
							<td class="cate"><c:out value="${myWait.cmntVO.cateIdNm}"/></td>
							<td class="title colpipe"><a href="<%=evcp%>/cafe/<c:out value="${myWait.cmntVO.cmntUrl}"/>"><c:out value="${myWait.cmntVO.cmntNm}"/></a></td>
							<td class="colpipe Center"><c:out value="${myWait.regDatimPF }"/></td>
							<td class="colpipe Center">
							    <a href="javascript:cfHome.cancelCafeJoin('<c:out value="${myWait.cmntVO.cmntUrl}"/>');"><util:message key="ev.title.cancel"/></a> <%--취소 --%>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</c:if>
		</tbody>
	</table>
</c:if>
<!-- END::내가 가입 신청한 카페 -->
<!-- BEGIN::자주가는 카페 -->
<c:if test="${homeForm.initView == 'mine.favor'}">
	<div class="board_btn_wrap" style="margin-top:30px;">
		<div class="board_btn_wrap_left">
			<h3><util:message key="ev.title.favor.cafe"/></h3> <%--자주가는 카페 --%>
		</div>
		<c:if test="${mmbrVO.isLogin}">
			<div class="board_btn_wrap_right">
				<a href="javascript:cfHome.showFavorCafeEdit()" class="btn white">
					<util:message key="ev.title.edit"/>
				</a>
			</div>
		</c:if>
	</div>
	<table class="table_type01" summary="추천카페">
		<caption>추천카페 리스트입니다</caption>
		<colgroup>
			<col width="150px;">
			<col width="auto;">
			<col width="100px;">
			<col width="120px;">
			<%--			<col width="100px;"> --%>
		</colgroup>
		<thead>
			<tr>
				<th><util:message key="mm.title.category"/></th> <%--카테고리--%>
				<th><util:message key="cf.title.cafe.name"/></th> <%--카페이름--%>
				<th><util:message key="cf.title.mmbrLevel"/></th> <%--회원등급 --%>
				<th><util:message key="cf.title.joinDate"/></th> <%--가입일 --%>
				<%--탈퇴 <th><util:message key="cf.title.secession"/></th> --%>
			</tr>
		</thead>
			<tbody>
			<c:if test="${!mmbrVO.isLogin}">
	    		<tr>
					<td scope="row" colspan="4" class="title Center">
						<dl class="emptyCafeList">
							<dt><util:message key="eb.error.need.login"/><%--로그인 하셔야 합니다.--%></dt>
						</dl>
					</td>
				</tr>
		  	</c:if>
		  	<c:if test="${mmbrVO.isLogin}">
				<c:if test="${empty favorList}">
		    		<tr>
						<td scope="row" colspan="4" class="title Center">
							<dl class="emptyCafeList">
								<dt><util:message key="cf.error.not.exist.favor.cafe"/><%--등록된 자주가는 카페가 없습니다.--%></dt>
							</dl>
						</td>
					</tr>
	  			</c:if>
	  			<c:if test="${!empty favorList}">
					<c:forEach items="${favorList}" var="favor">
						<tr>
							<td scope="row" class="cate Center"><c:out value="${favor.cmntVO.cateIdNm}"/></td>
							<td class="title colpipe"><a href="<%=evcp%>/cafe/<c:out value="${favor.cmntVO.cmntUrl}"/>"><c:out value="${favor.cmntVO.cmntNm}"/></a></td>
							<td class="colpipe Center"><c:out value="${favor.mmbrGrdNm }"/></td>
							<td class="colpipe Center"><c:out value="${favor.regDatimPF }"/></td>
							<%--
							<td class="colpipe Center">
								<c:if test="${mmbrVO.loginId == favor.cmntVO.makerId}"><a href="javascript:cfHome.resignCafe('<c:out value="${favor.cmntVO.cmntUrl}"/>');" class="btn white"><util:message key="cf.title.secession"/></a></c:if>
							    <c:if test="${mmbrVO.loginId != favor.cmntVO.makerId}"><a href="javascript:cfHome.resignCafe('<c:out value="${favor.cmntVO.cmntUrl}"/>');" class="btn white"><util:message key="cf.title.secession"/></a></c:if>
							</td>
							 --%>
						</tr>
					</c:forEach>
				</c:if>
			</c:if>
		</tbody>
	</table>
</c:if>
<!-- END::자주가는 카페 -->
<!-- BEGIN::자주가는 카페 편집 -->
<c:if test="${homeForm.initView == 'mine.favorEdit'}">

	<div class="board_btn_wrap" style="margin-top:30px;">
		<div class="board_btn_wrap_left">
			<h3><util:message key="ev.title.favor.cafe"/></h3> <%--자주가는 카페 --%>
		</div>
		<c:if test="${mmbrVO.isLogin}">
			<div class="board_btn_wrap_right">
				<a href="javascript:cfHome.getFavorMngr().cancel()"" class="btn white">
					<util:message key="ev.title.favor.cafe"/>
				</a>
			</div>
		</c:if>
	</div>

	<c:if test="${!mmbrVO.isLogin}">
		<div><util:message key="eb.error.need.login"/></div>
	</c:if>
	<c:if test="${mmbrVO.isLogin}">
	<div class="favorite_edit_wrap">
		<div class="regcafe_list">
			<ul id="favor_edit_allUl" >
				<c:if test="${empty myAllList}">
					<li style="padding-top:3px"><util:message key="cf.error.not.exist.my.cafe"/></li><%--가입한 카페가 없습니다.--%>
				</c:if>
				<c:if test="${!empty myAllList}">
					<c:forEach items="${myAllList}" var="myAll">
						<li id="favor_edit_MyLi_<c:out value="${myAll.cmntId}"/>" cmntId="<c:out value="${myAll.cmntId}"/>" class="favorEditLi favorEditMyLi ellipsis" onclick="cfHome.getFavorMngr().select(this)">
							<c:out value="${myAll.cmntNm}"/>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<div class="favorite_edit">
			<button class="add" onclick="cfHome.getFavorMngr().add()"><util:message key="ev.title.add" /> &gt;</button> <%--추가 --%>
			<button class="del" onclick="cfHome.getFavorMngr().rem()">&lt; <util:message key="ev.title.remove" /></button>  <%--제거 --%>
		</div>
		<div class="favoritecafe_list">
			<ul id="favor_edit_favorUl" >
				<c:forEach items="${favorList}" var="favor">
  					<li id="favor_edit_favorLi_<c:out value="${favor.cmntVO.cmntId}"/>" cmntId="<c:out value="${favor.cmntVO.cmntId}"/>" class="favorEditLi favorEditFavorLi ellipsis" onclick="cfHome.getFavorMngr().select(this)">
						<c:out value="${favor.cmntVO.cmntNm}"/>
					</li>
				</c:forEach>
			</ul>
		</div>
		</div>
		<div class="board_btn_wrap">				
			<div class="board_btn_wrap_right favoritecafe_list_btn">
				<button onclick="cfHome.getFavorMngr().move('first')" class="top"><util:message key="cf.prop.top"/></button>
				<button onclick="cfHome.getFavorMngr().move('up')" class="up"><util:message key="cf.prop.up"/></button>
				<button onclick="cfHome.getFavorMngr().move('down')" class="down"><util:message key="cf.prop.down"/></button>
				<button onclick="cfHome.getFavorMngr().move('last')" class="bottom"><util:message key="cf.prop.bottom"/></button>
			</div>
		</div>
		
		<div class="board_btn_wrap">				
			<div class="board_btn_wrap_center">
				<a href="javascript:cfHome.getFavorMngr().save()" class="btn black"><util:message key="cf.title.save.do"/></a>
				<a href="javascript:cfHome.getFavorMngr().cancel()" class="btn white"><util:message key="cf.title.cancel.do"/></a>
			</div>
		</div>
	</c:if>
</c:if>
<!-- END::자주가는 카페 편집  -->