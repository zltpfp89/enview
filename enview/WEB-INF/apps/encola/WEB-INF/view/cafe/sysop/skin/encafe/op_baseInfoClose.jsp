<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

    <%--BEGIN::'폐쇄신청' 상태이면--%>
	<c:if test="${cmntVO.cmntState == '13'}">
	<table class="table_type01 write " summary="폐쇄">
	    <tbody>	
		<tr>
		  <th>
		  	<c:if test="${langKnd=='ko'}">
				<p class="closing"><span class="font_color_violet"><c:out value="${cmntVO.updDatimSF}"/> 에 이미 폐쇄 신청을 하신 상태이며, 현재 카페지기를 포함한 잔류 회원은 <c:out value="${cmntVO.mmbrTot}"/> 명입니다.</span><br/>
				폐쇄 신청일로부터 <b><c:out value="${cafeCloseNoticeDays}"/></b> 일 동안 공지 안내 후에 폐쇄가 진행됩니다.<br>
				공지기간이 경과한 후에는 가입 회원이 남아 있더라도 <b><c:out value="${cafeCloseDeferedDays}"/></b> 일 동안 작성된 글이 없으면 자동으로 폐쇄가 진행됩니다.<br>
				폐쇄가 진행된 후에는 게시글을 포함한 카페 데이터에 대한 복구가 불가능합니다.
				</p>
			</c:if>
			<c:if test="${langKnd=='en'}">
				<p class="closing">
					<span class="font_color_violet">We have already closed applications in <c:out value="${cmntVO.updDatimSF}"/>, and we have <c:out value="${cmntVO.mmbrTot}"/> remaining members including sysop.</span>
					<br/>
					The closure will be held after <b><c:out value="${cafeCloseNoticeDays}"/></b> days notice from the date of closure application.<br>
					After the announcement period has elapsed, if there are no posts made for <b><c:out value="${cafeCloseDeferedDays}"/></b> days, the closure is automatically performed even if the member remains.<br>
					After the closure, cafe data including postings can not be recovered.
				</p>
			</c:if>
		  </th>
		</tr>
		</tbody>
	</table>
	<%--
	<br/>
	<h2> - <util:message key="cf.title.cancelClosingCafe"/></h2>
	<table class="table_type01 write" summary="<util:message key="eb.title.board.mode.list"/>">
		<caption><util:message key="eb.title.board.mode.list"/></caption>
		<colgroup>
			<col width="110px;">
			<col width="auto;">
		</colgroup>			
		<tbody>			
			<tr>
				<th><util:message key="ev.info.title"/></th>
				<td>
					<input type=text id=close_title name=close_title class="w_p100"/>
				</td> 
			</tr>
			<tr>
				<th><util:message key="cf.title.noticeContent"/></th>
				<td>
				  <div class="bltnCntt" id="dextEditor">
					<div id="editorCntt"></div>
					<input type=hidden id=set_close_content name=set_close_content>
				    <textarea id="close_content" name="close_content" style="display: none;" >
						<c:if test="${langKnd=='ko'}">
							    &lt;font color=blue&gt;&lt;b&gt;카페 폐쇄 취소 공지&lt;/b&gt;&lt;/font&gt;&lt;br&gt;
								  &lt;br&gt;
								  안녕하십니까? 카페지기입니다.&lt;br&gt;
								  &lt;br&gt;
								  <c:out value="${cmntVO.updDatimSF}"/> 에 신청한 카페 폐쇄를 취소하고자 합니다.&lt;br&gt;
								  변합없는 사랑을 부탁드립니다.
						</c:if>
						<c:if test="${langKnd=='en'}">
								&lt;font color=blue&gt;&lt;b&gt;Notice of closure cancellation&lt;/b&gt;&lt;/font&gt;&lt;br&gt;
								  &lt;br&gt;
								 	Hello? i'm a sysop.&lt;br&gt;
								  &lt;br&gt;
								  I would like to cancel the cafe closure I applied on <c:out value="${cmntVO.updDatimSF}"/>.&lt;br&gt;
								  I ask for love without change.
						</c:if>
				    </textarea>
				  </div>
			 	</td>
			</tr>
		</tbody>
	</table>
	--%>
	<div class="board_btn_wrap">				
		<div class="board_btn_wrap_center">
			<a href="#" onclick="javascript:cfOp.baseInfo.closeCafe('cancel')"class="btn black"><util:message key="cf.title.cancelClosingCafe"/></a>
		</div>
	</div>
	</c:if>
    <%--END::'폐쇄신청' 상태이면--%>
    <%--BEGIN::'개설승인'(정상) 상태이면--%>
    <c:if test="${cmntVO.cmntState == '11'}">
	<%--BEGIN::회원이 있는 상태이면--%>
	<c:if test="${cmntVO.mmbrTot > 1}">
	<table class="table_type01 write " summary="폐쇄">
    <tbody>	
	<tr>
	  <th>
		<c:if test="${langKnd=='ko'}">
			<p class="closing"><span class="font_color_violet">현재 카페지기를 포함한 회원이 <c:out value="${cmntVO.mmbrTot}"/> 명으로 카페를 당장은 폐쇄할 수 없습니다.</span><br/>
			카페 폐쇄 공지를 작성하신 후 폐쇄신청을 하시면, <b><c:out value="${cafeCloseNoticeDays}"/></b> 일 동안 공지 안내 후에 폐쇄가 진행됩니다.<br>
			공지기간이 경과한 후에는 가입 회원이 남아 있더라도 <b><c:out value="${cafeCloseDeferedDays}"/></b> 일 동안 작성된 글이 없으면 자동으로 폐쇄가 진행됩니다.<br>
			폐쇄가 진행된 후에는 게시글을 포함한 카페 데이터에 대한 복구가 불가능합니다.
			</p>
		</c:if>
		<c:if test="${langKnd=='en'}">
			<p class="closing"><span class="font_color_violet">You can not close a cafe right now with <c:out value="${cmntVO.mmbrTot}"/> members including a sysop.</span><br/>
			After completing the cafe closure notice and requesting closure, the closure will be closed after <b><c:out value="${cafeCloseNoticeDays}"/></b>.<br/>
			After the notification period has elapsed, we will automatically close if there are no posts made for <b><c:out value="${cafeCloseDeferedDays}"/></b> days.<br>
			After the closure, cafe data including postings can not be recovered.
			</p>
		</c:if>
	  </th>
	</tr>
	</tbody>
	</table>
	<br/>
	<table class="table_type01 write" summary="게시판">
		<caption>게시판</caption>
		<colgroup>
			<col width="110px;">
			<col width="auto;">
		</colgroup>			
		<tbody>				
			<tr>
				<th><util:message key="ev.info.title"/></th>
				<td>
					<input type=text id=close_title name=close_title class="w_p100" value="${langKnd=='ko' ? '카페 폐쇄 공지' : 'Cafe Close Notice' }"/>
				</td> 
			</tr>
			<tr>
				<th><util:message key="cf.title.noticeContent"/></th>
				<td>
				  <div class="bltnCntt" id="dextEditor">
					<div id="editorCntt"></div>
					<input type=hidden id=set_close_content name=set_close_content>
				    <textarea id="close_content" name="close_content" style="display: none;" >
						<c:if test="${langKnd=='ko'}">
					    	&lt;font color=blue&gt;&lt;b&gt;카페 폐쇄 공지&lt;/b&gt;&lt;/font&gt;&lt;br&gt;
						  	&lt;br&gt;
						  	안녕하십니까? 카페지기입니다.&lt;br&gt;
						  	&lt;br&gt;
						 	 폐쇄 예정일: <c:out value="${opForm.stateDatimSF}"/>
						</c:if>
						<c:if test="${langKnd=='en'}">
					    	&lt;font color=blue&gt;&lt;b&gt;Cafe Closure Notice&lt;/b&gt;&lt;/font&gt;&lt;br&gt;
						  	&lt;br&gt;
						  	Hello? I'm a sysop.&lt;br&gt;
						  	&lt;br&gt;
						 	 Closing date: <c:out value="${opForm.stateDatimSF}"/>
						</c:if>
				    </textarea>
				  </div>
			 	</td>
			</tr>
		</tbody>
	</table>
	<div class="board_btn_wrap">				
		<div class="board_btn_wrap_center">
			<a href="#" onclick="javascript:cfOp.baseInfo.closeCafe('defered')"class="btn black"><util:message key="cf.title.applyClosingCafe"/></a>
		</div>
	</div>
	</c:if>
	<%--END::회원이 있는 상태이면--%>
	<%--BEGIN::회원이 없는 상태이면--%>
	<c:if test="${cmntVO.mmbrTot == 1}">
	<table class="table_type01 write " summary="폐쇄">
    	<tbody>	
			<tr>
				<th>
					<p class="closing"><span class="font_color_violet"><util:message key="cf.info.closing.Info"/></span><br/>
					<util:message key="cf.info.closing.Info2"/>
					</p>
				</th>
			</tr>
		</tbody>
	</table>
	<div class="board_btn_wrap">				
		<div class="board_btn_wrap_center">
			<a href="#" onclick="javascript:cfOp.baseInfo.closeCafe('realtime')"class="btn black"><util:message key="cf.title.applyClosingCafe"/></a>
		</div>
	</div>
	</c:if>
	<%--END::회원이 없는 상태이면--%>
	</c:if>
    <%--END::'개설승인'(정상) 상태이면--%>
  <input type=hidden id=close_try name=close_try>
