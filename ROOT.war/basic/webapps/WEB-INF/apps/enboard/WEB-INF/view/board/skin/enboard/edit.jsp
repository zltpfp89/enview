<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,java.util.ArrayList" %>
<%@ page import="com.saltware.enview.Enview"%>
<%@ page import="com.saltware.enboard.vo.BoardVO,com.saltware.enboard.vo.BulletinVO,com.saltware.enboard.vo.BltnPollVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="./css/board/skin/<c:out value="${boardVO.boardSkin}"/>/bbs.css" rel="stylesheet" type="text/css" />
<style type="text/css">
  <!--
  body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
  }
  -->
</style>

<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>
<%--jsp:useBean id="loginInfo" type="java.util.Map"/--%>

<c:if test="${boardVO.extUseYn == 'Y'}">
  <c:set var="extnMapper" value="${boardVO.bltnExtnMapper}"/>
  <%--jsp:useBean id="extnMapper" type="com.saltware.enboard.integrate.DefaultBltnExtnMapper"/--%>
  <c:if test="${!empty bltnVO.bltnExtnVO}">
	<c:set var="extnVO" value="${bltnVO.bltnExtnVO}"/>
	<%--jsp:useBean id="extnVO" type="com.saltware.enboard.integrate.DefaultBltnExtnVO"/--%>
  </c:if>
</c:if>

<table width=100% border=0 cellspacing=0 cellpadding=0>
<tr>
<td align="center">
<div class="board">
  <%-- contents start --%>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <% int remainWidth = Integer.parseInt(((BoardVO)request.getAttribute("boardVO")).getBoardWidth()) - 103;%>
        <colgroup width=100>
        <colgroup width=3>
        <colgroup width=<%=remainWidth%>>
		<form name="editForm" onsubmit="return false">
        <tr><td height="2" colspan="3" bgcolor="blue"></td></tr>
		<%-- 작성자 --%>
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">작 성 자</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
		  <%--익명게시판이 아닌 경우--%>
		  <c:if test="${boardVO.anonYn == 'N'}">
			<input type="text" maxlength="30" name="userNick" style="width:300px" class="form" readonly
				   <c:if test="${boardSttVO.cmd != 'MODIFY'}">value="<c:out value="${secPmsnVO.userNick}"/>"</c:if>
		           <c:if test="${boardSttVO.cmd == 'MODIFY'}">value="<c:out value="${bltnVO.userNick}"/>"</c:if>
			/>
		  </c:if>
		  <%--익명게시판인 경우--%>
		  <c:if test="${boardVO.anonYn == 'Y'}">
		    <input type="text" maxlength="30" name="userNick" style="width:300px" class="form"/>
		  </c:if>
  		  <%--실명인증 게시판인 경우--%>
		  <c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}">
		    <input type="text" maxlength="30" name="userNick" style="width:300px" class="form" readonly value='<%=(String)session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name"))%>'/>
		  </c:if>
		  </td>
        </tr>
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>
        <%-- Bulletin Category --%>
	    <c:if test="${boardVO.cateYn == 'Y'}">
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">Category</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
	        <select name=cateList style=font-size:9pt;width:300px>
	          <option style=background-color:#777777;color:#dddddd value=-1>** Select Category **</option>
	          <c:forEach items="${bltnCateList}" var="cList">
	            <c:if test="${!empty cList.bltnCateNm}">
	              <option style=background-color:#eeeeee value="<c:out value="${cList.bltnCateId}"/>" <c:if test="${bltnVO.cateId==cList.bltnCateId}">selected</c:if>><c:out value="${cList.bltnCateNm}"/></option>
	            </c:if>
	          </c:forEach>
	        </select>
          </td>
        </tr>
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>
        </c:if>
	    
	    <%-- 확장필드 사용예 --%>
	    <c:if test="${boardVO.extUseYn == 'Y'}">
	      <c:if test="${extnMapper.ext_str2Yn == 'Y'}">
          <tr>
            <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l"><c:out value="${extnMapper.ext_str2Ttl}"/></td>
            <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif"></td>
            <td class="table_list_l">
              <input type=text name="ext_str2" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str2}"/>"</c:if> maxlength="512" style="width:300px"/>
            </td> 
	      </tr>
          <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
          </c:if>
	      <c:if test="${extnMapper.ext_str3Yn == 'Y'}">
          <tr>
            <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l"><c:out value="${extnMapper.ext_str3Ttl}"/></td>
            <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif"></td>
            <td class="table_list_l">
              <input type=text name="ext_str3" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str3}"/>"</c:if> maxlength="512" style="width:300px"/>
            </td> 
	      </tr>
          <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
          </c:if>
	    </c:if>

        <%-- Subject --%>
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">제목</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
            <input type=text name="bltnSubj" value="<c:out value="${bltnVO.bltnSubj}"/>" maxlength="120" style="width:<%=remainWidth-10%>px"/>
          </td>
        </tr>
		
	    <%-- Term of boarding --%>
	    <c:if test="${boardVO.termYn == 'Y'}">
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
	    <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">게시기간</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
		    <input type='text' name='bltnBgnYmd' id='bltnBgnYmd' value="<c:out value="${bltnVO.bltnBgnYmdF}"/>" style='width:110px' readonly='true'>
		    <img align=absmiddle src=./board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/calendar.gif onclick="displayCalendar(new Date(), 'bltnBgnYmd', event)"> 
		    ~
		    <input type='text' name='bltnendYmd' id='bltnEndYmd' value="<c:out value="${bltnVO.bltnEndYmdF}"/>" style='width:110px' readonly='true'>
		    <img align=absmiddle src=./board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/calendar.gif onclick="displayCalendar(new Date(), 'bltnEndYmd', event)">
		    
<c:out value="${bltnVO.bltnBgnYmdHmF}"/>		    
          </td>
	    </tr>
	    </c:if>
		
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" class="table_title_l">내 용</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l"></td>
        </tr>
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>
  		<tr>
          <td colspan=3 id="smarteditor">
            <textarea id=editorCntt style="width:99%;height:100px"><c:out value="${bltnVO.bltnCntt}"/></textarea>
            <input type=hidden name=bltnOrgCntt>
          </td>
        </tr>  	    

	    <%-- Set permission for accesing the bulletin--%>
	    <c:if test="${boardVO.accSetYn == 'Y'}">
		<c:if test="${isBltnPrinMode == 'false'}">
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">접근권한 설정</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
			<c:if test="${boardSttVO.cmd != 'MODIFY'}">
		    <input type=button value='게시물 접근 허용권한 설정' onclick="ebEdit.getAccSetMngr().doShow('true','<c:out value="${boardVO.boardRid}"/>')"/>
			</c:if>
			<c:if test="${boardSttVO.cmd == 'MODIFY'}">
		    <input type=button value='게시물 접근 허용권한 설정' onclick="ebEdit.getAccSetMngr().doShow('true','<c:out value="${boardVO.boardRid}"/>','<c:out value="${bltnVO.bltnNo}"/>')"/>
			</c:if>
			<input type=hidden id=accSetTempList name=accSetTempList/>
          </td>
        </tr>
		</c:if>
		<%--BEGIN::Keep this snippet for compatiablility with old version--%>
		<c:if test="${isBltnPrinMode == 'true'}">
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">목록조회 허용</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
		  허용 등급:
		  <select name=ableListGrade multiple=true size=5 style="width:160px">
            <c:forEach items="${gradeList}" var="grade">
		      <option value="<c:out value="${grade.codeId}"/>"><c:out value="${grade.codeName}"/>
			</c:forEach>
		  </select>
		  <span style=visibility:hidden><img src='' height=1 width=15></span>
		  허용 그룹:
		  <select name=ableListGroup multiple=true size=5 style="width:160px">
            <c:forEach items="${groupList}" var="group">
		      <option value="<c:out value="${group.codeId}"/>"><c:out value="${group.codeName}"/>
			</c:forEach>
		  </select>
		  <span style=visibility:hidden><img src='' height=1 width=15></span>
		  허용 롤:
		  <select name=ableListRole multiple=true size=5 style="width:160px">
            <c:forEach items="${roleList}" var="role">
		      <option value="<c:out value="${role.codeId}"/>"><c:out value="${role.codeName}"/>
			</c:forEach>
		  </select>
          </td>
        </tr>
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">본문읽기 허용</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
		  허용등급:
		  <select name=ableReadGrade multiple=true size=5 style="width:160px">
            <c:forEach items="${gradeList}" var="grade">
		      <option value="<c:out value="${grade.codeId}"/>"><c:out value="${grade.codeName}"/>
			</c:forEach>
		  </select>
		  <span style=visibility:hidden><img src='' height=1 width=15></span>
		  허용그룹:
		  <select name=ableReadGroup multiple=true size=5 style="width:160px">
            <c:forEach items="${groupList}" var="group">
		      <option value="<c:out value="${group.codeId}"/>"><c:out value="${group.codeName}"/>
			</c:forEach>
		  </select>
		  <span style=visibility:hidden><img src='' height=1 width=15></span>
		  허용롤:
		  <select name=ableReadRole multiple=true size=5 style="width:160px">
            <c:forEach items="${roleList}" var="role">
		      <option value="<c:out value="${role.codeId}"/>"><c:out value="${role.codeName}"/>
			</c:forEach>
		  </select>
          </td>
        </tr>
        </c:if>
		<%--END::Keep this snippet for compatiablility with old version--%>
        </c:if>

	    <%-- Notice --%>
	    <c:if test="${boardVO.noticeYn == 'Y' && secPmsnVO.ableNotice == 'true'}">
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">공지글여부</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
            <input type=checkbox name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'Y'}">checked</c:if> value="Y" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'Y')"/>&nbsp;공지글
		    <span style=visibility:hidden><img src='' height=1 width=30></span>
            <input type=checkbox name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'N'}">checked</c:if> value="N" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'N')"/>&nbsp;공지글 아님
		    <span style=visibility:hidden><img src='' height=1 width=30></span>
            <input type=checkbox name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'T'}">checked</c:if> value="T" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'T')"/>&nbsp;최상위 공지글
          </td>
        </tr>
        </c:if>
	    
	    <%-- Secret --%>
	    <c:if test="${boardVO.secretYn == 'Y' && secPmsnVO.isLogin == 'true'}">
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">비밀글여부</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
            <input type=checkbox name=bltnSecretYn <c:if test="${bltnVO.bltnSecretYn == 'Y' || (not empty rplBltnVO and rplBltnVO.bltnSecretYn == 'Y')}">checked</c:if>>&nbsp;Y / N
          </td>
        </tr>
        </c:if>

	    <%-- Point --%>
	    <c:if test="${boardVO.boardType == 'C'}">
	    <c:if test="${boardSttVO.cmd == 'WRITE'}">
	    <c:if test="${secPmsnVO.isLogin == 'true'}">
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">포인트</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
            <input type=text name=betPnt size=10 style=text-align:right;height:18px> 당신의 포인트: <c:out value="${loginInfo.mileTot}"/> 점
          </td>
        </tr>
        </c:if>
        </c:if>
        <c:if test="${boardSttVO.cmd == 'MODIFY'}">
	    <c:if test="${secPmsnVO.isLogin == 'true'}">
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
		<tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">포인트</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
	        <c:out value="${bltnVO.betPnt}"/> 점
          </td>
        </tr>
	    </c:if>
	    </c:if>
	    </c:if>
	    
	    <%-- Able Anonymous --%>
	    <c:if test="${boardVO.ableAnonYn == 'Y'}">
	    <c:if test="${secPmsnVO.isLogin == 'true'}">
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">익명글여부</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
		    <c:if test="${boardSttVO.cmd == 'MODIFY'}">
			  <c:if test="${empty bltnVO.userId}"><input type="checkbox" name="anonFlag" checked onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N</c:if>
			  <c:if test="${!empty bltnVO.userId}"><input type="checkbox" name="anonFlag" onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N</c:if>
			</c:if>
		    <c:if test="${boardSttVO.cmd != 'MODIFY'}">
			  <input type="checkbox" name="anonFlag" onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N
			</c:if>
	        <c:if test="${boardVO.anonYn == 'N'}">
			  &nbsp;&nbsp;&nbsp;&nbsp;비밀번호&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;
			  <input type="password" name="userPass" value="<c:out value="${bltnVO.userPass}"/>" maxlength="12" size="14"/>				
            </c:if>
  		  </td>
        </tr>
        </c:if>
        </c:if>

	    <%-- Password.--%>
	    <c:if test="${boardVO.anonYn != 'N'}"><%--익명/실명인증 게시판의 경우 항상 비번을 받는다--%>
        <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">비밀번호</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
            <input type="password" name="userPass" value="<c:out value="${bltnVO.userPass}"/>" maxlength="12" size="14"/>
          </td>
        </tr>
	    </c:if>
		</form><%--editForm--%>
		
	    <%-- Poll --%>
	    <c:if test="${boardVO.boardType == 'B'}">
        <tr><td colspan="3" height="1" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">답변항목</td>
          <td background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td class="table_list_l">
		  <% 
			int pollWidth = remainWidth - 20 - 10;
			BoardVO brdVO = (BoardVO)request.getAttribute("boardVO");
			if ("Y".equals(brdVO.getPollImgYn())) pollWidth -= 100;
		  %>
            <table id=poll width=100% border=0 cellspacing=0 cellpadding=0>
            <tr>
	          <td width=20></td>
			  <td>
                <img onclick="ebEdit.poll('+')" src='./board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/imgPollAdd.gif' style=cursor:pointer alt=항목추가 >
                <img onclick="ebEdit.poll('-')" src='./board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/imgPollDel.gif' style=cursor:pointer alt=항목삭제 >
		      </td>
			</tr>
			<%--아래 루프 제어의 편의를 위해 BltnPollVO(답변문항)을 9개 할당하고 시작한다.2011.06.14.KWShin.--%>
			<%
				BulletinVO bltnVO = (BulletinVO)request.getAttribute("bltnVO");
				List pollList = bltnVO.getPollList();
				int idx = 0;
				if( pollList == null ) {
					idx = 0;
					pollList = new ArrayList();
				} else {
					idx = pollList.size();
				}
				for( int i=idx; i<9; i++ ) {
					pollList.add( new BltnPollVO());
				}
				bltnVO.setPollList( pollList );
			%>
			<c:set var="poll2" value="${bltnVO.pollList}"/>
			<%--jsp:useBean id="poll2" type="java.util.ArrayList"/--%>
			<c:forEach items="${poll2}" var="pList" varStatus="status">
			<tr>
			  <td colspan=2>
			    <div id="setPollDiv<c:out value="${status.count}"/>"
			      <c:if test="${boardSttVO.cmd == 'MODIFY'}">
				    <c:if test="${empty pList.pollCntt}">style="display:none"</c:if>
				  </c:if>
                  <c:if test="${boardSttVO.cmd != 'MODIFY'}">
				    <c:if test="${status.count > '2'}">style="display:none"</c:if>
				  </c:if>
				>
				  <table width=100% border=0 cellspacing=0 cellpadding=0>
			      <form name="setPoll<c:out value="${status.count}"/>" method="post" enctype="multipart/form-data" target="invisible" action="fileMngr?cmd=upload">
                    <tr>
			          <td width=20><c:out value="${status.count}"/>.</td>
			          <td>
			            <input type=text id="pollCntt<c:out value="${status.count}"/>" name="poll<c:out value="${status.count}"/>" style="width:<%=pollWidth%>px"
				               value="<c:out value="${pList.pollCntt}"/>">
			          </td>
			          <c:if test="${boardVO.pollImgYn == 'Y'}"><%--이미지사용하는 경우.--%>	  
			          <td rowspan=2 width=100 name="pollImg<c:out value="${status.count}"/>" id="pollImg<c:out value="${status.count}"/>"></td>
			        </tr>
			        <tr><%--이미지 업로드 파일콘트롤.--%>
			          <td width=20></td>
			          <td>
			            <input type=file id="pollFile<c:out value="${status.count}"/>" name="pollFile<c:out value="${status.count}"/>" style="width:<%=pollWidth-140%>px">
                        <img src='./board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/imgUpload.gif' onclick="ebEdit.uploadPollImg(event)" style=cursor:pointer alt=이미지올리기 width="65" height="24" align="absmiddle">
                        <img src='./board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/imgUpoff.gif' onclick="ebEdit.deletePollImg(event)" style=cursor:pointer alt=이미지내리기 width="65" height="24" align="absmiddle">
			          </td>
			          </c:if>
			        </tr>
                    <input type=hidden name=boardId value="<c:out value="${boardVO.boardRid}"/>">
                    <input type=hidden name=subId value=sub11>
                    <input type=hidden name=mode value=poll>
                    <input type=hidden name=seq value="<c:out value="${status.count}"/>">
                    <input type=hidden name=fileMask>
			      </form>
				  </table>
			    </div>
			  </td>
			</tr>
			</c:forEach>
			</table>
			
			<%--이미지설문 기능을 사용하는 설문형 게시판--%>
			<c:if test="${boardVO.boardType == 'B' && boardVO.pollImgYn == 'Y'}">
		    <form name=setPollDel method=post target=invisible action="fileMngr?cmd=delete" style=disply:none>
              <input type=hidden name=semaphore value="<c:out value="${boardSttVO.semaphore}"/>">
              <input type=hidden name=delBoardId value="<c:out value="${boardVO.boardRid}"/>">
              <input type=hidden name=subId value=sub11>
              <input type=hidden name=seq>
              <input type=hidden name=fileMask>
            </form>
			</c:if>

          </td>
        </tr>
	    </c:if>
        <tr><td height="2" colspan="3" bgcolor="blue"></td><td id=temp></td></tr>
      </table>
    </td>
  </tr>
  <tr><td height="11" align="right" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif"></td></tr>
  <tr>
    <td valign="top" width=100% >
      <%-- Attach File --%>
	  <c:if test="${boardVO.maxFileCnt > '0'}">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td height="2" colspan="2" bgcolor="#C8CBDB"></td></tr>
        <tr>
          <td rowspan="3" width="100" align="left" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">첨부파일</td>
          <%-- <form name=setUpload method=post enctype="multipart/form-data" target=invisible action="fileMngr?cmd=upload">
          <td height="30" valign="bottom" bgcolor="#F7F8F9" class="gab_3" align="left">
		    <% 
			  int fileWidth = remainWidth - 20 - ( 65 * 2 );
		    %>
            <input type=file name=filename style="width:350px" OnMouseOver=this.style.backgroundColor='#efebef' OnMouseOut=this.style.backgroundColor='' OnKeyDown="this.blur()">
            <img id="btnUploadFile" src='${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/imgUpload.gif' onclick="ebEdit.uploadFile()" style=cursor:pointer alt=파일올리기 width="65" height="24" align="absmiddle">&nbsp;
            <img id="btnDeleteFile" src='${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/imgUpoff.gif' onclick="ebEdit.deleteFile()" style=cursor:pointer alt=파일내리기 width="65" height="24" align="absmiddle">
            <input type=hidden name=viewsize readonly style=background-color:#eeeeee;width:100%;text-align:center;border:none value='총 파일 크기: 0KB'>
            <input type=hidden name=boardId value="<c:out value="${boardVO.boardRid}"/>">
            <input type=hidden name=totalsize value=0>
            <input type=hidden name=subId value=sub01>
            <input type=hidden name=mode value=attach>
          </td>
          </form> --%>
          <td>
          	<div id="vault_upload"></div>
          	<c:if test="${boardSttVO.cmd eq 'MODIFY'}">
          	<c:set var="fileList" value="${bltnVO.fileList}"/>
          	<ul id="vault_fileList" style="display: none;">
          		<c:forEach items="${fileList}" var="file">
          		<li data-name="<c:out value='${file.fileName}'/>" data-mask="<c:out value='${file.fileMask}'/>" data-size="<c:out value='${file.fileSize}'/>"><c:out value="${file.fileName}"/> (<c:out value="${file.sizeSF}"/>)</li>
          		</c:forEach>	
          	</ul>
          	</c:if>
          </td>
        </tr>
        <tr>
          <td>
		    <span id=uploading style=display:none>
			  <c:out value="${boardVO.imgLoading}" escapeXml="false"/>
			  <span id=uploadStatus></span>
			</span>
		  </td>
        </tr>
        <tr>
          
          <form name=setFileList method=post target=invisible action="fileMngr?cmd=delete">
          <td bgcolor="#F7F8F9" class="gab_3">
          	<%-- 기존 select 태그 방식 --%>
            <%-- <select style="font-size:8pt;height:84;width:<%=remainWidth-10%>px;background-color:#eeeeee" name="list" multiple>
            <option value="-1" style=background-color:#444444;color:white>Upload List</option>
            <c:if test="${boardSttVO.cmd == 'MODIFY'}">
			  <c:set var="file" value="${bltnVO.fileList}"/>
              <c:forEach items="${file}" var="fList">
                <option value="<c:out value="${fList.fileMask}"/>-<c:out value="${fList.fileSize}"/>"><c:out value="${fList.fileName}"/>&nbsp;(<c:out value="${fList.sizeSF}"/>)</option>
              </c:forEach>
            </c:if>
            </select> --%>
             <%-- jquery-ui selectable을 사용하는 방식. 태블릿에서 PC보기를 할때 파일목록 select가 한줄로 보이므로 변경 
			<ol id="uploadFileList">
			<c:if test="${boardSttVO.cmd == 'MODIFY'}">
				<c:set var="file" value="${bltnVO.fileList}"/>
				<c:forEach items="${file}" var="fList">
					<li data="<c:out value="${fList.fileMask}"/>-<c:out value="${fList.fileSize}"/>"><c:out value="${fList.fileName}"/>&nbsp;(<c:out value="${fList.sizeSF}"/>)</li>
				</c:forEach>
			</c:if>
			</ol>
             --%>
          </td>
          <input type=hidden name=semaphore value="<c:out value="${boardSttVO.semaphore}"/>">
          <input type=hidden name=vaccum>
          <%-- 게시판별 별도 디렉터리에 첨부파일 관리하는 것 때문에 추가 2009.02.25.KWShin. --%>
          <input type=hidden name=delBoardId value="<c:out value="${boardVO.boardRid}"/>">
          <input type=hidden name=unDelList>
          <input type=hidden name=delList>
          <input type=hidden name=subId value=sub01>
          </form>
          
        </tr>
        <tr><td height="2" colspan="2" bgcolor="#dbdee7"></td></tr>
      </table>
      </c:if>
    </td>
  </tr>
  <tr><td height="11" align="right" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif"></td></tr>

  <!-- 답변 원본글 -->
  <c:if test="${!empty rplbltnVO}">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td height="2" colspan="6" bgcolor="blue"></td></tr>
        <tr>
          <td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">원 본 글</td>
          <td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif"></td>
          <td colspan="4" height="25" class="table_list_r">
            작성일 : <c:out value="${rplbltnVO.regDatimSF}"/>&nbsp;&nbsp;&nbsp;
            최종수정일 : <c:out value="${rplbltnVO.updDatimSF}"/>&nbsp;&nbsp;&nbsp;
            <c:if test="${boardVO.boardType == 'C'}">
            <c:if test="${rplbltnVO.betPnt > '0'}">
              <font color=#A51818>포인트 : <c:out value="${rplbltnVO.betPnt}"/></font>
            </c:if>
            </c:if>
            조회수 : <c:out value="${rplbltnVO.bltnReadCnt}"/>
          </td>
        </tr>
        <tr><td height="1" colspan="6" bgcolor="#dbdee7"></td></tr>
        <tr>
          <td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">원본글 제목</td>
          <td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif"></td>
          <td height="25" class="table_list_l" width="<%=remainWidth-208%>px"><c:out value="${rplbltnVO.bltnSubj}" escapeXml="false"/></td>
          <td width="70" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">작 성 자</td>
          <td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif"></td>
          <td width="100" height="25" class="table_list_l"><c:out value="${rplbltnVO.userNick}"/></td>
        </tr>
        <tr><td height="1" colspan="6" bgcolor="#dbdee7"></td></tr>
        <tr>
          <td colspan="6">
            <table border=0 width=99% cellspacing=0 cellpadding=0>
              <!-- 원본글 내용 -->
              <tr>
                <td style="padding:3 10 3 10">
                  <style>P {white-space:pre;margin-top:3px;margin-bottom:3px;margin-left:3;margin-right:3;word-break:break-all;}</style>
                  <c:out value="${rplbltnVO.bltnOrgCntt}" escapeXml="false"/>
                </td>
              </tr>
              <!-- 원본글 설문 -->
              <c:if test="$!empty rplbltnVO.pollList}">
			  <c:set var="poll" value="${rplbltnVO.pollList}"/>
			  <%--jsp:useBean id="poll" type="java.util.ArrayList"/--%>
              <tr>
                <td>
                  <table width=100% border=0 cellspacing=0 cellpadding=0>
                    <tr>
                      <td colspan=4>Total Poll <c:out value="${rplbltnVO.pollHitSum}"/></td>
                    </tr>
                    <c:forEach items="${poll}" var="pList">           
                    <tr>
                      <td width=30><input type=radio name=poll style=border:none value="<c:out value="${pList.pollSeq}"/>"></td>          
                      <td>
                        <c:out value="${boardVO.imgPollL}" escapeXml="false"/><c:out value="${boardVO.imgPollC}" escapeXml="false"/><c:out value="${boardVO.imgPollR}" escapeXml="false"/>
                        <c:out value="${pList.pollRate}"/>%
                        [<c:out value="${pList.pollHit}"/>]
                        <input type=hidden name=pollGraphSize value="${pList.pollGraphSize}"/>">
                      </td>            
                      <td width=20><c:out value="${pList.pollSeq}"/>.</td>
                      <td width=<c:out value="${pList.pollCnttSize}"/>><c:out value="${pList.pollCntt}"/></td>            
                    </tr>
                    </c:forEach>
                  </table>
                </td>
              </tr>       
              </c:if>
            </table>
          </td>
        </tr>
        <!-- 원본글 업로드된 파일정보 -->
        <c:if test="${!empty rplbltnVO.fileList}">
        <tr><td height="1" colspan="6" bgcolor="#dbdee7"></td></tr>
        <tr>
          <td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">원본글 첨부파일</td>
          <td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
          <td height="25" class="table_list_l">
            <c:set var="rplfile" value="${rplbltnVO.fileList}"/>
			<%--jsp:useBean id="rplfile" type="java.util.ArrayList"/--%>
            <c:forEach items="${rplfile}" var="rplfList">
              <c:out value="${rplfList.downloadLink}" escapeXml="false"/>&nbsp;
              <c:out value="${rplfList.sizeSF}"/><br>
            </c:forEach>
          </td>
        </tr>
        </c:if>
        <tr><td height="2" colspan="6" bgcolor="blue"></td></tr>
      </table>
    </td>
  </tr>
  <tr><td height="11" align="right" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif"></td></tr>  
  </c:if>
  <tr>
    <td align="right">
      <table>
        <tr>
          <td width=46 align="right" onclick=ebEdit.list() style=cursor:pointer><c:out value="${boardVO.imgList}" escapeXml="false"/></td>
          <td width=46 align="right" onclick=ebEdit.save() style=cursor:pointer><c:out value="${boardVO.imgSave}" escapeXml="false"/></td>
		</tr>
      </table>
    </td>
  </tr>
  <tr><td height="11" align="right" background="${pageContext.request.contextPath}/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif"></td></tr>
  </table>
</div>
</td>
</tr>
</table>

<script type="text/javascript">
$(function(){ //DOM Ready
	var formData = $("[name='setTransfer']").serialize();
	var listUri = "list.brd?" + formData;
	document.setTransfer.rtnURI.value=listUri;
	// 승인기능을 사용할때 승인자여도 미승인상태로 저장되도록한다 
	document.setTransfer.bltnPermitYn.value='N';
});
</script>