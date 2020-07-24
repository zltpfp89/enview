<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::내가 가입한 카페--%>
<c:if test="${homeForm.initView == 'mine.all'}">
	<div class="mycafe_title">
		<h3 class="mycafe_ttl">내 카페목록</h3>
		<label><span class="bar" style="margin-right:5px;"> > </span>전체보기</label>
		<span class="txt_favor">아이콘을 클릭하시면 자주가는 카페로 추가됩니다.</span>
	</div>
	<table class="table_type2" summary="추천카페">
		<caption>추천카페 리스트입니다</caption>
		<colgroup>
			<col width="150px" />
			<col width="*px" />
			<col width="103px" />
			<col width="90px" />
			<col width="50px" />
		</colgroup>
		<thead>
			<tr class="titleRow">
				<td scope="row" class="Center"><util:message key="mm.title.category"/><%--카테고리--%></td>
				<td class="title colpipe Center"><util:message key="cf.title.cafe.name"/><%--카페이름--%></td>
				<td class="colpipe Center">회원등급</td>
				<td class="colpipe Center">가입일</td>
				<td class="colpipe Center">탈퇴</td>
			</tr>
		</thead>
	</table>
	<div class="a">
		<table class="table_type2" summary="추천카페">
			<caption>추천카페 리스트입니다</caption>
			<colgroup>
				<col width="50px" />
				<col width="100px" />
				<col width="*px" />
				<col width="103px" />
				<col width="90px" />
				<col width="50px" />
			</colgroup>
			<tbody>
				<c:if test="${!mmbrVO.isLogin}">
	    		<tr>
					<td scope="row" colspan="6" class="title Center">
						<dl class="emptyCafeList">
							<dt><util:message key="eb.error.need.login"/><%--로그인 하셔야 합니다.--%></dt>
						</dl>
					</td>
				</tr>
		  		</c:if>
				<c:if test="${mmbrVO.isLogin}">
					<c:if test="${empty myAllList}">
			    		<tr>
							<td scope="row" colspan="6" class="title Center">
								<dl class="emptyCafeList">
									<dt><util:message key="cf.error.not.exist.my.cafe"/><%--가입한 카페가 없습니다.--%></dt>
									<dd>새로운 카페를 개설하거나, 다양한 카페를 찾아 가입해 보세요.</dd>
								</dl>
							</td>
						</tr>
		  			</c:if>
				</c:if>
				<c:if test="${!empty myAllList}">
					<c:forEach items="${myAllList}" var="myAll">
						<tr>
							<td scope="row" class="star">
								<span id="star_<c:out value="${myAll.cmntVO.cmntId}"/>" onclick="cfHome.toggleFavorCafe('<c:out value="${myAll.cmntVO.cmntId}"/>');" 
										class="favor <c:if test="${myAll.isFavor }">starOn</c:if>">☆</span>
							</td>
							<td class="cate"><c:out value="${myAll.cmntVO.cateIdNm}"/></td>
							<td class="title colpipe"><a href="<%=evcp%>/cafe/<c:out value="${myAll.cmntVO.cmntUrl}"/>"><c:out value="${myAll.cmntVO.cmntNm}"/></a></td>
							<td class="colpipe Center"><c:out value="${myAll.mmbrGrdNm }"/></td>
							<td class="colpipe Center"><c:out value="${myAll.regDatimPF }"/></td>
							<td class="colpipe Center">
								<c:if test="${mmbrVO.loginId == myAll.cmntVO.makerId}"><span style="color: #DEDEDE;">탈퇴</span></c:if>
							    <c:if test="${mmbrVO.loginId != myAll.cmntVO.makerId}"><a href="javascript:cfHome.resignCafe('<c:out value="${myAll.cmntVO.cmntUrl}"/>');">탈퇴</a></c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
</c:if>
<%--END::내가 가입한 카페--%>
<%--BEGIN::내가 가입 신청한 카페--%>
<c:if test="${homeForm.initView == 'mine.wait'}">
	<div class="mycafe_title">
		<h3 class="mycafe_ttl">내 카페목록</h3>
		<label><span class="bar" style="margin-right:5px;"> > </span>가입 신청한 카페 목록</label>
	</div>
	<table class="table_type2" summary="추천카페">
		<caption>추천카페 리스트입니다</caption>
		<colgroup>
			<col width="126px" />
			<col width="*px" />
			<col width="100px" />
			<col width="80px" />
		</colgroup>
		<thead>
			<tr class="titleRow">
				<td scope="row" class="Center"><util:message key="mm.title.category"/><%--카테고리--%></td>
				<td class="title colpipe Center"><util:message key="cf.title.cafe.name"/><%--카페이름--%></td>
				<td class="colpipe Center">가입 신청일</td>
				<td class="colpipe Center">신청 취소</td>
			</tr>
		</thead>
	</table>
	<div class="a">
		<table class="table_type2" summary="추천카페">
			<caption>추천카페 리스트입니다</caption>
			<colgroup>
				<col width="20px" />
				<col width="100px" />
				<col width="*px" />
				<col width="100px" />
				<col width="80px" />
			</colgroup>
			<tbody>
				<c:if test="${!mmbrVO.isLogin}">
	    		<tr>
					<td scope="row" colspan="6" class="title Center">
						<dl class="emptyCafeList">
							<dt><util:message key="eb.error.need.login"/><%--로그인 하셔야 합니다.--%></dt>
						</dl>
					</td>
				</tr>
		  		</c:if>
				<c:if test="${mmbrVO.isLogin}">
					<c:if test="${empty myAllWaitList}">
			    		<tr>
							<td scope="row" colspan="6" class="title Center">
								<dl class="emptyCafeList">
									<dt><util:message key="cf.error.not.exist.my.cafe"/><%--가입한 카페가 없습니다.--%></dt>
									<dd>새로운 카페를 개설하거나, 다양한 카페를 찾아 가입해 보세요.</dd>
								</dl>
							</td>
						</tr>
		  			</c:if>
				</c:if>
				<c:if test="${!empty myAllWaitList}">
					<c:forEach items="${myAllWaitList}" var="myWait">
						<tr>
							<td scope="row" class="star">
								<a href="javascruot: addFavorCafe();" class="starOff">☆</a>
							</td>
							<td class="cate"><c:out value="${myWait.cmntVO.cateIdNm}"/></td>
							<td class="title colpipe"><a href="<%=evcp%>/cafe/<c:out value="${myWait.cmntVO.cmntUrl}"/>"><c:out value="${myWait.cmntVO.cmntNm}"/></a></td>
							<td class="colpipe Center"><c:out value="${myWait.regDatimPF }"/></td>
							<td class="colpipe Center">
							    <a href="javascript:cfHome.cancelCafeJoin('<c:out value="${myWait.cmntVO.cmntUrl}"/>');">취소</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
</c:if>
<%--END::내가 가입 신청한 카페--%>
<%--BEGIN::자주가는 카페--%>
<c:if test="${homeForm.initView == 'mine.favor'}">
	<div class="mycafe_title">
		<h3 class="mycafe_ttl">내 카페목록</h3>
		<label><span class="bar" style="margin-right:5px;"> > </span>자주가는 카페</label>
		<c:if test="${mmbrVO.isLogin}">
			<span class="btn_pack small" style="float:right; top: -5px;"><a href="javascript:cfHome.showFavorCafeEdit()"><util:message key="ev.title.edit"/></a></span>
		</c:if>
	</div>
	<table class="table_type2" summary="추천카페">
		<caption>추천카페 리스트입니다</caption>
		<colgroup>
			<col width="130px" />
			<col width="*px" />
			<col width="103px" />
			<col width="90px" />
			<col width="50px" />
		</colgroup>
		<thead>
			<tr class="titleRow">
				<td scope="row" class="Center"><util:message key="mm.title.category"/><%--카테고리--%></td>
				<td class="title colpipe Center"><util:message key="cf.title.cafe.name"/><%--카페이름--%></td>
				<td class="colpipe Center">회원등급</td>
				<td class="colpipe Center">가입일</td>
				<td class="colpipe Center">탈퇴</td>
			</tr>
		</thead>
	</table>
	<div class="a">
		<table class="table_type2" summary="추천카페">
			<caption>추천카페 리스트입니다</caption>
			<colgroup>
				<col width="130px" />
				<col width="*px" />
				<col width="103px" />
				<col width="90px" />
				<col width="50px" />
			</colgroup>
			<tbody>
				<c:if test="${!mmbrVO.isLogin}">
	    		<tr>
					<td scope="row" colspan="6" class="title Center">
						<dl class="emptyCafeList">
							<dt><util:message key="eb.error.need.login"/><%--로그인 하셔야 합니다.--%></dt>
						</dl>
					</td>
				</tr>
		  		</c:if>
				<c:if test="${mmbrVO.isLogin}">
					<c:if test="${empty favorList}">
			    		<tr>
							<td scope="row" colspan="6" class="title Center">
								<dl class="emptyCafeList">
									<dt><util:message key="cf.error.not.exist.favor.cafe"/><%--가입한 카페가 없습니다.--%></dt>
								</dl>
							</td>
						</tr>
		  			</c:if>
				</c:if>
				<c:if test="${!empty favorList}">
					<c:forEach items="${favorList}" var="favor">
						<tr>
							<td scope="row" class="cate Center"><c:out value="${favor.cmntVO.cateIdNm}"/></td>
							<td class="title colpipe"><a href="<%=evcp%>/cafe/<c:out value="${favor.cmntVO.cmntUrl}"/>"><c:out value="${favor.cmntVO.cmntNm}"/></a></td>
							<td class="colpipe Center"><c:out value="${favor.mmbrGrdNm }"/></td>
							<td class="colpipe Center"><c:out value="${favor.regDatimPF }"/></td>
							<td class="colpipe Center">
								<c:if test="${mmbrVO.loginId == favor.cmntVO.makerId}"><span style="color: #DEDEDE;">탈퇴</span></c:if>
							    <c:if test="${mmbrVO.loginId != favor.cmntVO.makerId}"><a href="javascript:cfHome.resignCafe('<c:out value="${favor.cmntVO.cmntUrl}"/>');">탈퇴</a></c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
</c:if>
<%--END::자주가는 카페--%>
<%--BEGIN::자주가는 카페 편집--%>
<c:if test="${homeForm.initView == 'mine.favorEdit'}">
	<div class="mycafe_title">
		<h3 class="mycafe_ttl">내 카페목록</h3>
		<label><span class="bar" style="margin-right:5px;"> > </span>자주가는 카페 > 편집</label>
		<span class="btn_pack small" style="float:right; top: -5px;"><a href="javascript:cfHome.getFavorMngr().cancel()"><util:message key="ev.title.favor.cafe"/></a></span>
	</div>
	<c:if test="${!mmbrVO.isLogin}">
		<div><util:message key="eb.error.need.login"/></div>
	</c:if>
	<c:if test="${mmbrVO.isLogin}">
		<div class="favorEdit">
			<table class="favorEditTable">
				<tr>
					<td width="280" style="border-style:solid;border-width:1px">
						<ul id="favor_edit_allUl" class="favor_edit_ul">
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
					</td>
					<td width="60" align="center">
						<span class="btn_pack small"><a href="javascript:cfHome.getFavorMngr().add()">추가 ></a></span>
						<br />
						<br />
						<span class="btn_pack small"><a href="javascript:cfHome.getFavorMngr().rem()">< 제거</a></span>
		  			</td>
		  			<td width="280" style="border-style:solid;border-width:1px">
						<ul id="favor_edit_favorUl" class="favor_edit_ul">
							<c:forEach items="${favorList}" var="favor">
			  					<li id="favor_edit_favorLi_<c:out value="${favor.cmntVO.cmntId}"/>" cmntId="<c:out value="${favor.cmntVO.cmntId}"/>" class="favorEditLi favorEditFavorLi ellipsis" onclick="cfHome.getFavorMngr().select(this)">
									<c:out value="${favor.cmntVO.cmntNm}"/>
								</li>
							</c:forEach>
						</ul>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="right" height="36">
					    <img src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/btn_up_first.gif" onclick="cfHome.getFavorMngr().move('first')"/>
					    <img src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/btn_up.gif" onclick="cfHome.getFavorMngr().move('up')"/>
					    <img src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/btn_down.gif" onclick="cfHome.getFavorMngr().move('down')"/>
						<img src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/btn_down_last.gif" onclick="cfHome.getFavorMngr().move('last')"/>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<span class="btn_pack medium"><a href="javascript:cfHome.getFavorMngr().save()"><util:message key="ev.title.save"/></a></span>
						<span class="btn_pack medium"><a href="javascript:cfHome.getFavorMngr().cancel()"><util:message key="ev.title.cancel"/></a></span>
					</td>
				</tr>
			</table>
		</div>
	</c:if>
</c:if>
<%--END::자주가는 카페 편집--%>
