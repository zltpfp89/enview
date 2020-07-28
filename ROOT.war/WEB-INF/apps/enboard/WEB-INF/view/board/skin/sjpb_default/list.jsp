<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.List,java.util.ArrayList"%>

<%@ page import="com.saltware.enview.Enview"%>
<%@ page import="com.saltware.enboard.integrate.DefaultBltnExtnMapper,com.saltware.enboard.integrate.DefaultBltnExtnVO"%>
<%@ page import="com.saltware.enview.components.dao.ConnectionContext"%>
<%@ page import="com.saltware.enview.components.dao.ConnectionContextForRdbms"%>
<%@ page import="com.saltware.enboard.security.SecurityMngr"%>
<%@ page import="com.saltware.enboard.vo.BoardVO"%>
<%@ page import="com.saltware.enview.components.dao.DAOFactory"%>
<%@ page import="com.saltware.enboard.dao.AdminDAO"%>
<%@ page import="com.saltware.enboard.form.AdminCateForm"%>

<%--BEGIN::현재 게시판이 속한 카테고리의 아들카테고리(바로 한레벨 밑의 카테고리)에 속한 게시판들의 목록을 뿌리는 예제--%>
<%
	ConnectionContext connCtxt = null;
	try {
		connCtxt = new ConnectionContextForRdbms (true);

		BoardVO brdVO = (BoardVO)request.getAttribute ("boardVO");
		AdminDAO admDAO = (AdminDAO)DAOFactory.getInst().getDAO (AdminDAO.DAO_NAME_PREFIX);

		String cateId = admDAO.getCateOfBoard (brdVO.getBoardId(), connCtxt);
		List childCateList = admDAO.getChildCatebase (cateId, true, SecurityMngr.getLocale (request), connCtxt);
		List boardList = new ArrayList();
		AdminCateForm acForm = new AdminCateForm();
		for (int i=0; i<childCateList.size(); i++) {
			acForm.setCateId ((String)childCateList.get(i));
			boardList.addAll (admDAO.getCateBoard (acForm, null, true, connCtxt));
		}
		
//		System.out.println("boardList=["+boardList+"]");
		
		com.saltware.enboard.cache.CacheMngr ebCacheMngr = (com.saltware.enboard.cache.CacheMngr)Enview.getComponentManager().getComponent ("com.saltware.enboard.cache.CacheMngr");
		List directChildBoardList = new ArrayList();
		for (int i=0; i<boardList.size(); i++) {
			directChildBoardList.add (ebCacheMngr.getBoard ((String)boardList.get(i), SecurityMngr.getLocale (request)));
		}
		
		request.setAttribute ("dcBoardList", directChildBoardList);	
	
	} catch (NullPointerException e) {
		if (connCtxt != null) connCtxt.rollback();
		// Ignore...
	} catch (Exception e) {
		if (connCtxt != null) connCtxt.rollback();
		// Ignore...
	} finally {
		if (connCtxt != null) connCtxt.release();
	}
%>
<c:forEach items="${dcBoardList}" var="dcBoard">
  <c:out value="${dcBoard.boardId}"/>,<c:out value="${dcBoard.boardNm}"/><br>
</c:forEach>
<%--END::현재 게시판이 속한 카테고리의 아들카테고리(바로 한레벨 밑의 카테고리)에 속한 게시판들의 목록을 뿌리는 예제--%>

<%-- Details of Board --%>
<body class="iframe">
<div class="board">
	<!-- tsearchArea -->
	<div class="tsearchArea">
		<%-- search --%>
		<form name="setSrch" OnSubmit="return ebList.srchBulletin()">
			<fieldset>
				<div class="inputbox sel_150">
					<p class="txt"></p>
					<select id="srchType" name="srchType">
						<c:forEach items="${srchList}" var="list">         
							<option value="<c:out value="${list.srchType}"/>"/><c:out value="${list.srchText}"/>
						</c:forEach>
					</select>
				</div>
				<label for="search"></label><input type="text" name="srchKey" class="txt_300" id="search"/>
				<a class="btn_search" href="#" style=cursor:pointer onClick=ebList.srchBulletin()><img src="/sjpb/images/btn_search.png" alt="search" /></a>
			</fieldset>    
		</form>
		<!-- search -->
	</div>
	<!-- tsearchArea -->

  <%-- contents start --%>
<!-- 	  <form name="frmlist" onsubmit="return false"> -->
	  <table cellpadding="0" cellspacing="0" summary="게시판리스트" class="list web" > 
	    <caption>게시판리스트</caption>
        <colgroup>
            <col width="12%" />
            <col width="*%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
        </colgroup>
		<thead>
		    <tr>
	          <c:if test="${boardVO.ttlNoYn == 'Y'}">
	          	<th class="C first"><span class="table_title">번호</span></th>
	          </c:if>    
		      <th class="C"><span class="table_title">제목</span></th>
		      <c:if test="${boardVO.listAtchYn == 'Y'}">
		      	<th class="C"><span class="table_title">다운로드</span></th>
		      </c:if>
		      <c:if test="${boardVO.ttlNickYn == 'Y'}">
		      	<th class="C"><span class="table_title">작성자</span></th>
	          </c:if>
		      <c:if test="${boardVO.ttlRegYn == 'Y'}">
		      	<th class="C"><span class="table_title">등록일</span></th>
	          </c:if>
		      <c:if test="${boardVO.ttlReadYn == 'Y'}">
		      	<th class="C"><span class="table_title">조회</span></th>
	          </c:if>
		    </tr>
		</thead>
        <%-- Bulletins are not exist.. --%>
        <c:if test="${empty bltnList}">
        <tr>
          <td align="center" colspan="6">등록된 게시물이 존재하지 않습니다.<input type=hidden name=chk></td>
        </tr>
        </c:if>

        <%-- List of Bulletin --%>
        <c:forEach items="${bltnList}" var="list">         
    	<tr <c:if test="${list.boardRow == '0'}">class="notice"</c:if>>
          <c:if test="${boardVO.ttlNoYn == 'Y'}">
	          <td class="C">
	            <c:if test="${list.selected == 'false'}">
	              <c:if test="${list.boardRow == '0'}"><img src="/sjpb/images/notice_icon.png" alt="공지" /></c:if>
	              <c:if test="${list.boardRow != '0'}"><c:out value="${list.boardRow}"/></c:if>
	            </c:if>
	            <c:if test="${list.selected != 'false'}">
	              <c:out value="${boardVO.imgSelected}" escapeXml="false"/>
	            </c:if>
	          </td>
          </c:if>       

          <td class="L">
            <c:if test="${list.bltnLev != '1'}">
              <span style=visibility:hidden><img height=1 width=<c:out value="${list.bltnLevLen}"/>></span>
              <c:out value="${boardVO.imgRe}" escapeXml="false"/>
            </c:if>
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
              <c:if test="${boardVO.ttlPntYn == 'Y'}">
                <c:if test="${list.betPnt > '0'}"><font color=#A51818>$<c:out value="${list.betPnt}"/></font></c:if>
              </c:if>
			  <a style=cursor:pointer OnMouseOver=this.style.textDecoration='underline' OnMouseOut=this.style.textDecoration='none'
			    <c:if test="${list.readable == 'true'}">
			      <%--게시판이 가상게시판일 수도 있으므로, 게시물이 아니라 게시물이 속한 게시판의 boardId 를 이용하여 읽기화면으로 가야 한다.--%>
				  <c:if test="${boardVO.mergeType == 'A'}">
			        onclick="ebList.readBulletin('<c:out value="${boardVO.boardId}"/>','<c:out value="${list.bltnNo}"/>')"
				  </c:if>
				  <c:if test="${boardVO.mergeType != 'A'}">
			        onclick="ebList.readBulletin('<c:out value="${list.eachBoardVO.boardId}"/>','<c:out value="${list.bltnNo}"/>')"
				  </c:if>
			    </c:if>
			    <c:if test="${list.readable == 'false'}">
				  onclick="alert('작성자가 글읽기를 허용하지 않았습니다');"
			    </c:if>
			  
			    <%--c:out value="${list.bltnOrgSubj}" escapeXml="false"/--%>
			    
			    <c:if test="${not empty list.bltnBgnYmd and today < list.bltnBgnYmd }">
			    [ 예약 :   <c:out value="${list.bltnBgnYmdHmF}"/> ]
			    </c:if>
			    
			    <span class="title"><c:out value="${list.bltnOrgSubj}"/></span>
				<%--게시기간설정기능을 사용하는 게시판의 공지글이고 현재 관리자/운영진/게시판관리자이면 게시기간을 출력한다.--%>
				<c:if test="${boardVO.termYn == 'Y' && list.boardRow == '0' && (secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete)}">
				  <br>게시시작일:<c:out value="${list.bltnBgnYmdF}"/> 게시종료일:<c:out value="${list.bltnEndYmdF}"/>
				</c:if>
              </a>
              <c:if test="${boardVO.ttlReplyYn == 'Y'}">
                <c:if test="${list.bltnReplyCnt != '0'}">
                  <c:out value="${boardVO.imgReCnt}" escapeXml="false"/>
                  <font color="#CC4848">(<c:out value="${list.bltnReplyCnt}"/>)</font>
                </c:if>
              </c:if>
              <c:if test="${boardVO.ttlMemoYn == 'Y'}">
                <c:if test="${list.bltnMemoCnt != '0'}">
                  <c:out value="${boardVO.imgMemo}" escapeXml="false"/>
                  <font color="#CC4848">(<c:out value="${list.bltnMemoCnt}"/>)</font>
                </c:if>
              </c:if>
              <c:if test="${boardVO.ttlNewYn == 'Y'}">
                <c:if test="${list.recentBltn == 'Y'}"><img src="/sjpb/images/icon_new.png" alt="새 글" /></c:if>
              </c:if>
              <c:if test="${boardVO.listCnttYn == 'Y'}">
              <table border=0 cellspacing=0 cellpadding=0 width=100% style="table-layout:fixed">
                <tr>
                  <td width=22></td>
                  <td style="padding-left:5px;word-wrap:break-word;word-break:break-all"><c:out value="${list.bltnCntt}"/></td>
                </tr>
              </table>
              </c:if>
			</c:if>
			<c:if test="${list.delFlag == 'y'}"><%--삭제표시된 답글있는 글--%>
			  삭제된 글입니다.
			</c:if>
          </td>

	      <c:if test="${boardVO.listAtchYn == 'Y'}">
			<c:if test="${list.fileDownable}">
	          <td class="C" id=i<c:out value="${list.bltnNo}"/> name=i<c:out value="${list.bltnNo}"/> align=center>
				<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
                  <c:if test="${!empty list.fileList}">
	    	        <c:forEach items="${list.fileList}" var="fList">
			          <a href="${fList.downloadUrl}"><img src="/sjpb/images/icon_file.png" alt="첨부파일"/></a>
	                </c:forEach>
                  </c:if>
				</c:if>
	          </td>
			</c:if>
			<c:if test="${!list.fileDownable}">
	          <td class="C" id=i<c:out value="${list.bltnNo}"/> name=i<c:out value="${list.bltnNo}"/>
				<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
			      align=center onclick="alert('작성자가 파일다운로드를 허용하지 않았습니다.')"
				</c:if>
				>
			  </td>
			</c:if>
	      </c:if>

          <c:if test="${boardVO.ttlNickYn == 'Y'}">
          <td class="C">
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
		      <c:out value="${list.userNick}"/>
			</c:if>
		  </td>
          </c:if>
      
          <c:if test="${boardVO.ttlRegYn == 'Y'}">
          <td class="C">
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
		      <c:out value="${list.regDatimSF}"/>
			</c:if>		
		  </td>
          </c:if>
      
          <c:if test="${boardVO.ttlReadYn == 'Y'}">
          <td class="C">
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
              <c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"><b><font color=<c:out value="${boardVO.raiseColor}"/>></c:if>
              <c:out value="${list.bltnReadCnt}"/>&nbsp;
              <c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"></b></font></c:if>
			</c:if>
          </td>
          </c:if>
        </tr>
        </c:forEach>
        <%-- End of List of Bulletin --%>
      </table>
<!--       </form> -->
      <!-- btnArea-->
    <div class="btnArea">
        <c:if test="${boardVO.writableYn == 'Y'}">
			  <c:if test="${boardVO.mergeType == 'A'}">
				<div class="R"><a class="btn_gray" onClick=ebList.writeBulletin() style=cursor:pointer><span>글쓰기</span></a></div>
			  </c:if>
		</c:if>
    </div>
    <!-- boardbtnArea//-->
    <!-- tcontrol-->
	<div class="tcontrol">
        <!-- paging -->
        <div class="paging" id="pageIndex"></div>
        <!-- paging//-->
	</div>
    <!-- tcontrol//-->
</div>
</body>
<script language="javascript">
	var currentPage = <c:out value="${boardSttVO.page}"/>;
	var totalPage   = <c:out value="${boardSttVO.totalPage}"/>;
	var setSize     = 10; <%--하단 Page Iterator에서의 Navigation 갯수--%>
// 	var imgUrl      = "${pageContext.request.contextPath}/board/images/board/skin/enboard/";
	var imgUrl      = "${pageContext.request.contextPath}/sjpb/images/";
	var color       = "808080";
	
	var afpImg = "btn_arr_first.png";
	var pfpImg = "btn_arr_first.png";
	var alpImg = "imgLastActive.gif";
	var plpImg = "btn_arr_last.png";
	var apsImg = "imgPrev10Active.gif";
	var ppsImg = "btn_arr_prev.png";
	var ansImg = "imgNext10Active.gif";
	var pnsImg = "btn_arr_next.png";
	
	var startPage;    
	var endPage;      
	var cursor;      
	var curList = "";
	var prevSet = "";
	var nextSet = "";
	var firstP  = "";
	var lastP   = "";

	moduloCP = (currentPage - 1) % setSize / setSize ;
	startPage = Math.ceil((((currentPage - 1) / setSize) - moduloCP)) * setSize + 1;
	moduloSP = ((startPage - 1) + setSize) % setSize / setSize;
	endPage   = Math.ceil(((((startPage - 1) + setSize) / setSize) - moduloSP)) * setSize;

	if (totalPage <= endPage) endPage = totalPage;
		
	if (currentPage > setSize) {
		firstP = "<font onclick=ebList.next('1') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		firstP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+afpImg+"' align=absmiddle border=0 alt='맨 앞 페이지로 가기'></font>";
	    cursor = startPage - 1;
	    prevSet = "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		prevSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+apsImg+"' align=absmiddle border=0 alt='열 페이지 앞으로 가기'></font>";
	} else {
		firstP = "<img src='"+imgUrl+pfpImg+"' align=absmiddle border=0></font>";
		prevSet = "<img src='"+imgUrl+ppsImg+"' align=absmiddle border=0>"; 
	}
		
	cursor = startPage;
	while( cursor <= endPage ) {
		if( cursor == currentPage ) 
	   		curList += "<a href='javascript:void(0);' class='on'>"+currentPage+"</a>&nbsp;";
		else {
	    	curList += "<a class='first' onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			curList += " onmouseout=this.style.textDecoration='none'>"+cursor+"</font></a>&nbsp;";
		}
		
		cursor++;
	}
		     
	if ( totalPage > endPage) {
		lastP = "<font onclick=ebList.next('"+totalPage+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		lastP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+alpImg+"' align=absmiddle border=0 alt='맨 끝 페이지로 가기'></font>";
		cursor = endPage + 1;  
		nextSet = "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		nextSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+ansImg+"' align=absmiddle border=0 alt='열 페이지 뒤로 가기'></font>";
	} else {
		lastP  = "<img src='"+imgUrl+plpImg+"' align=absmiddle border=0>"; 
		nextSet = "<img src='"+imgUrl+pnsImg+"' align=absmiddle border=0>"; 
	}
	
	curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
	
	document.getElementById("pageIndex").innerHTML = curList;
</script>
