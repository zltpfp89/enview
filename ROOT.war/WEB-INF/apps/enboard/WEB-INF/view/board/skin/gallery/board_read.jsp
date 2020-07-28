<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="./css/board/skin/enboard/bbs.css" rel="stylesheet" type="text/css" />
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
  <c:set var="rsExtnMapper" value="${boardVO.bltnExtnMapper}"/>
  <%--jsp:useBean id="rsExtnMapper" type="com.saltware.enboard.integrate.DefaultBltnExtnMapper"/--%>
</c:if>

<table width=100% border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td align="center">
      <div class="board">
	  
<%-- Bulletins in mode of multiview --%>
<c:forEach items="${bltnVOs}" var="list">
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr><td height="60" colspan="15"><font style="color:blue;font-weight:bold;font-size:18px"><c:out value="${boardVO.boardNm}"/></font></td></tr>
        <tr><td height="2" colspan="15" bgcolor="blue"></td></tr>
        <c:if test="${boardVO.cateYn == 'Y'}">
        <tr>
          <td height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">Category</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
          <td height="25" colspan="10" class="table_list_l"><c:out value="${list.cateNm}" escapeXml="false"/></td>
        </tr>
        <tr><td height="1" colspan="15" bgcolor="#dbdee7"></td></tr>
        </c:if>
		<%--확장필드 사용예 1--%>
		<c:if test="${boardVO.extUseYn == 'Y' && !empty list.bltnExtnVO}">
		  <c:set var="rsExtnVO" value="${list.bltnExtnVO}"/>
		  <%--jsp:useBean id="rsExtnVO" type="com.saltware.enboard.integrate.DefaultBltnExtnVO"/--%>
		</c:if>
	    <c:if test="${boardVO.extUseYn == 'Y' && rsExtnMapper.ext_str2Yn == 'Y'}">
        <tr>
          <td height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">목    차</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
          <td height="25" colspan="10" class="table_list_l">
		    <c:if test="${!empty list.bltnExtnVO}"><c:out value="${rsExtnVO.ext_str2}"/></c:if>
		  </td>
        </tr>
        <tr><td height="1" colspan="15" bgcolor="#dbdee7"></td></tr>
        </c:if>
	    <c:if test="${boardVO.extUseYn == 'Y' && rsExtnMapper.ext_str3Yn == 'Y'}">
        <tr>
          <td height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">주 제 어</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
          <td height="25" colspan="10" class="table_list_l">
		    <c:if test="${!empty list.bltnExtnVO}"><c:out value="${rsExtnVO.ext_str3}"/></c:if>
		  </td>
        </tr>
        <tr><td height="1" colspan="15" bgcolor="#dbdee7"></td></tr>
        </c:if>
        <tr>
          <td height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">제    목</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
          <td height="25" colspan="10" class="table_list_l">
            <c:if test="${list.bltnBestLevel == '9'}">
              <c:out value="${boardVO.imgBest9}" escapeXml="false"/>
            </c:if>
            <c:out value="${list.bltnOrgSubj}" escapeXml="false"/> 
          </td>
        </tr>
        <tr><td height="1" colspan="15" bgcolor="#dbdee7"></td></tr>
		<%--확장필드 사용예 2--%>
	    <c:if test="${boardVO.extUseYn == 'Y' && rsExtnMapper.ext_str1Yn == 'Y'}">
        <tr>
          <td height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">관    서</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
          <td height="25" colspan="10" class="table_list_l">
		    <c:if test="${!empty list.bltnExtnVO}"><c:out value="${rsExtnVO.ext_str1}"/></c:if>
		  </td>
        </tr>
        <tr><td height="1" colspan="15" bgcolor="#dbdee7"></td></tr>
        </c:if>
        <tr>
          <c:if test="${boardVO.anonYn == 'N'}"><%--익명게시판이 아니다--%>
            <td width="100" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" class="table_title_l">작 성 자</td>
            <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
            <td width="70" class="table_list_l"><c:out value="${list.userNick}"/></td>
          </c:if>
          <c:if test="${boardVO.anonYn == 'Y'}"><%--익명게시판--%>
            <td width="65" height="25"></td>
            <td width="3"></td>
            <td width="70"></td>
          </c:if>
          <c:if test="${boardVO.boardType == 'C' && list.bltnGq == '0'}"><%-- 지식형인 경우, 원문이면 내건 점수 --%>
            <td width="37" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">포인트</td>
            <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
            <td width="35" class="table_list_l"><c:out value="${list.betPnt}"/></td>
          </c:if>
          <c:if test="${boardVO.boardType != 'C' || (boardVO.boardType == 'C' && list.bltnGq != '0')}">
            <td width="45" height="25"></td>
            <td width="3"></td>
            <td width="35"></td>
          </c:if>
          <td width="45" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">작성일</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
          <td width="70" class="table_list_l"><c:out value="${list.regDatimSF}"/></td>
          <td width="65" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">최종수정일</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
          <td width="70" class="table_list_l"><c:out value="${list.updDatimSF}"/></td>
          <td width="40" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">조회수</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
          <td class="table_list_l"><c:out value="${list.bltnReadCnt}"/></td>
        </tr>
        <tr><td height="1" colspan="15" bgcolor="#dbdee7"></td></tr>
        <tr>
          <td align="left" height="150" colspan="15" valign="top" class="content_text">
            <c:out value="${list.bltnOrgCntt}" escapeXml="false"/>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td valign="top" >
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <%-- Poll --%>
        <c:if test="${!empty list.pollList}">
		<form name=pollForm_<c:out value="${list.bltnNo}"/> style="display:inline">
        <tr><td height="1" colspan="4" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td width="100" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">전체투표수</td>
          <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif"></td>
          <td width="70" height="25" class="table_list_l"><c:out value="${list.pollHitSum}"/></td>
	      <c:if test="${boardVO.boardType == 'B'}">
          <td height="25" class="table_list_l">
            <a onclick="ebRead.actionBulletin('poll','<c:out value="${list.bltnNo}"/>')" style=cursor:pointer>
	          <c:out value="${boardVO.imgSmallPoll}" escapeXml="false"/>
	        </a>
          </td>
          </c:if>
        </tr>
        <tr><td height="1" colspan="4" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td class="td_pad" colspan="4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <c:if test="${boardVO.pollImgYn != 'Y'}">
			  <colgroup width="50%"/>
              <colgroup width="50%"/>
              </c:if>			  
              <c:if test="${boardVO.pollImgYn == 'Y'}">
			  <colgroup width="30%"/>
              <colgroup width="40%"/>
              <colgroup width="30%"/>
              </c:if>
			  <c:set var="poll" value="${list.pollList}"/>
			  <%--jsp:useBean id="poll" type="java.util.List"/--%>
              <c:forEach items="${poll}" var="pList">           
              <tr>
			    <c:if test="${boardVO.pollImgYn == 'Y'}">
				<td align=absmiddle>
				  <c:out value="${pList.imgBdLine}"/>
				</td>
				</c:if>
                <td>
                  <table>
	                <tr>
	                  <td width=20><c:out value="${pList.pollSeq}"/>.</td>
	                  <td width=30><input type=radio name=poll value=<c:out value="${pList.pollSeq}"/>></td>
	                  <td width=<c:out value="${pList.pollCnttSize}"/>><c:out value="${pList.pollCntt}"/></td>
	                </tr>
	              </table>
	            </td>
	            <td align=right>
	              <c:out value="${pList.pollRate}"/>%
	              [<c:out value="${pList.pollHit}"/>]
	              <input type=hidden name=pollGraphSize value=<c:out value="${pList.pollGraphSize}"/>>
	              <c:out value="${boardVO.imgPollL}" escapeXml="false"/><c:out value="${boardVO.imgPollC}" escapeXml="false"/><c:out value="${boardVO.imgPollR}" escapeXml="false"/>
	            </td>            
	          </tr>
	          </c:forEach>
            </table>
          </td>
        </tr>
        </form>
        </c:if>
        
        <%-- Attached file --%>
        <c:set var="rsfile" value="${list.fileList}"/>
		<%--jsp:useBean id="rsfile" type="java.util.List"/--%>
        <c:if test="${!empty rsfile}">
		<tr><td height="1" colspan="4" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td colspan="4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="100" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">첨부파일</td>
                <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
                <td height="25" class="table_list_l">
	              <c:forEach items="${rsfile}" var="fList">   
			        <c:out value="${fList.downloadLink}" escapeXml="false"/>&nbsp;
			        (<c:out value="${fList.sizeSF}"/>)(<c:out value="${fList.downCntCF}"/>)<br>
			        <c:out value="${fList.downopenLink}" escapeXml="false"/>&nbsp;
			        (<c:out value="${fList.sizeSF}"/>)(<c:out value="${fList.downCntCF}"/>)<br>
			        <c:out value="${fList.downloadCntLink}" escapeXml="false"/>&nbsp;
			        (<c:out value="${fList.sizeSF}"/>)(<c:out value="${fList.downCntCF}"/>)<br>
			        <c:out value="${fList.downopenCntLink}" escapeXml="false"/>&nbsp;
			        (<c:out value="${fList.sizeSF}"/>)(<c:out value="${fList.downCntCF}"/>)<br>
	              </c:forEach>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </c:if>
        
        <%-- Permit --%>
        <c:if test="${boardVO.permitYn == 'Y'}">
        <c:if test="${secPmsnVO.ablePermit == 'true'}">
        <tr><td height="1" colspan="4" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td colspan="4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="100" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">게시승인</td>
                <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
                <td height="25" class="table_list_l">
                  <c:if test="${list.bltnPermitYn == 'Y'}">
                    <c:out value="${boardVO.imgPermit}" escapeXml="false"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a style=cursor:pointer onclick="ebRead.actionBulletin('permit_no','<c:out value="${list.bltnNo}"/>')">
                      <c:out value="${boardVO.imgForbid}" escapeXml="false"/>
                    </a>
                  </c:if>
                  <c:if test="${list.bltnPermitYn == 'N'}">
                    <a style=cursor:pointer onclick="ebRead.actionBulletin('permit_yes','<c:out value="${list.bltnNo}"/>')">
                      <c:out value="${boardVO.imgPermit}" escapeXml="false"/>
                    </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <c:out value="${boardVO.imgForbid}" escapeXml="false"/>
                  </c:if>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </c:if>
        </c:if>

        <%-- Appraisal. two option(추천/반대). --%>
        <c:if test="${boardVO.rcmdYn == 'Y'}">
        <tr><td height="1" colspan="4" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td colspan="4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="100" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">추천/반대</td>
                <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
                <td height="25" class="table_list_l">
                  <a style=cursor:pointer onclick="ebRead.actionBulletin('eval-up','<c:out value="${list.bltnNo}"/>')">
                    <c:out value="${boardVO.imgRcmdUp}" escapeXml="false"/> Good
                  </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <a style=cursor:pointer onclick="ebRead.actionBulletin('eval-dn','<c:out value="${list.bltnNo}"/>')">
                    <c:out value="${boardVO.imgRcmdDn}" escapeXml="false"/> Bad
                  </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <font color=#ED7642><b>추천:<c:out value="${list.bltnRcmdUpCnt}"/>명&nbsp;&nbsp;&nbsp;반대:<c:out value="${list.bltnRcmdDnCnt}"/>명</b></font>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </c:if>
        <%-- Appraisal. multiple option(평가).--%>
        <c:if test="${boardVO.evalYn == 'Y'}">
		<c:set var="evalLevel" value="${boardVO.evalLevelList}"/>
		<%--jsp:useBean id="evalLevel" type="java.util.List"/--%>
		<c:if test="${!empty evalLevel}">
        <tr><td height="1" colspan="4" bgcolor="#dbdee7"></td></tr>          
        <tr>
          <td colspan="4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="100" height="50" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">글 평가</td>
                <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
                <td height="50" class="table_list_l">
                  현재 <font color=#ED7642><b><c:out value="${list.bltnEvalCntCF}"/></b></font>분이 평가하셨습니다.&nbsp;
                  총점:&nbsp;<font color=#ED7642><b><c:out value="${list.bltnEvalSumCF}"/></b></font>&nbsp;
                  평점:&nbsp;<font color=#ED7642><b><c:out value="${list.bltnEvalAvgCF}"/></b></font>
                  <br>
				  <c:if test="${list.bltnEvaled == 'Y'}">
                    <c:forEach items="${evalLevel}" var="levelList">
                      <c:if test="${levelList.code == list.bltnEvalPnt}">                      
				        이미 <font color=#ED7642><b>'<c:out value="${levelList.codeName}"/>'(<c:out value="${levelList.code}"/>)</b></font> (으)로 평가하셨습니다.
                      </c:if>
                    </c:forEach>
                  </c:if>
                  <c:if test="${list.bltnEvaled == 'N'}">
                    <c:forEach items="${evalLevel}" var="levelList">
                      <input type="radio" name="pnt" value=<c:out value="${levelList.code}"/> onclick="ebRead.actionBulletin('eval','<c:out value="${list.bltnNo}"/>')">
					  <c:out value="${levelList.codeName}"/>
                    </c:forEach>
                  </c:if>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </c:if>
		</c:if>
        <tr><td height="2" colspan="15" bgcolor="blue"></td></tr>
      </table>
    </td>
  </tr>
  <tr><td height="5"></td></tr>
  <tr>
    <td valign="top" >
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <%-- Reply List --%>
        <c:if test="${boardVO.readReplyYn == 'Y'}">
		<c:set var="reply" value="${list.replyList}"/>
		<%--jsp:useBean id="reply" type="java.util.List"/--%>
        <c:if test="${!empty reply}">
        <tr>
          <td>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr height=0>
                <td width=20></td>
                <c:if test="${boardVO.cateYn == 'Y'}">
                <td width=60></td>
                </c:if>
                <td></td>
                <c:if test="${boardVO.anonYn == 'N'}">            
                <td width=80></td>
                </c:if>
                <td width=110></td>
                <td width=40></td>
              </tr>
              <%-- list of reply --%>    
              <c:forEach items="${reply}" var="rList">
              <tr height=22>
                <td>
                  <c:if test="${rList.selected == 'true'}">
                  <img src="/board/images/board/skin/enboard/dit_icon_arrow.gif" align="absmiddle"/>
                  </c:if>
                </td>
                <c:if test="${boardVO.cateYn == 'Y'}">
                <td align=center><c:out value="${rList.cateNm}" escapeXml="false"/></td>
                </c:if>
                <td align=left>
                  <c:if test="${!empty rList.bltnBestLevel && rList.bltnBestLevel > '0'}"><%--최고답변으로선정되었다--%>
					<c:if test="${rList.bltnBestLevel == '9'}"><c:out value="${boardVO.imgBest9}" escapeXml="false"/></c:if>
					<c:if test="${rList.bltnBestLevel == '8'}"><c:out value="${boardVO.imgBest8}" escapeXml="false"/></c:if>
					<c:if test="${rList.bltnBestLevel == '7'}"><c:out value="${boardVO.imgBest7}" escapeXml="false"/></c:if>
				  </c:if>
				  <c:if test="${empty rList.bltnBestLevel || rList.bltnBestLevel == '0'}">
					<c:if test="${boardVO.permitYn == 'Y' && rList.bltnPermitYn == 'N'}"><%--승인기능을 사용하는데 승인이 되질 않았다.--%>
					  <c:out value="${boardVO.imgProhibit}" escapeXml="false"/>
				    </c:if>
				    <c:if test="${boardVO.permitYn == 'N' || rList.bltnPermitYn != 'N' }">
					  <c:if test="${rList.bltnIcon == 'A'}"><c:out value="${boardVO.imgDoc}" escapeXml="false"/></c:if>
					  <c:if test="${rList.bltnIcon == 'B'}"><c:out value="${boardVO.imgFile}" escapeXml="false"/></c:if>
					  <c:if test="${rList.bltnIcon == 'C'}"><c:out value="${boardVO.imgPoll}" escapeXml="false"/></c:if>
					  <c:if test="${rList.bltnIcon == 'D'}"><c:out value="${boardVO.imgSecret}" escapeXml="false"/></c:if>
				    </c:if>
				  </c:if>
                
                  <c:if test="${rList.bltnLev != '1'}">
                  <span style=visibility:hidden><img src='' height=1 width=<c:out value="${rList.bltnLevLen}"/>></span>
                  <c:out value="${boardVO.imgRe}" escapeXml="false"/>
                  </c:if>
                
                  <c:if test="${rList.betPnt > '0'}">
                  <font color=#A51818>$<c:out value="${rList.betPnt}"/></font>
                  </c:if>
                
                  <font onclick="ebList.readBulletin('<c:out value="${rList.boardId}"/>','<c:out value="${rList.bltnNo}"/>')" style=cursor:pointer OnMouseOver=this.style.textDecoration='underline' OnMouseOut=this.style.textDecoration='none'>
                  <c:out value="${rList.bltnOrgSubj}" escapeXml="false"/> 
                  </font>
                
                  <c:if test="${rList.bltnMemoCnt != '0'}">
                  <font color="#CC4848">(<c:out value="${rList.bltnMemoCnt}"/>)</font>
                  </c:if>
                
                  <c:if test="${rList.recentBltn == 'Y'}">
                  <c:out value="${boardVO.imgNew}" escapeXml="false"/>
                  </c:if> 
                </td>
                <c:if test="${boardVO.anonYn == 'N'}">
                <td><c:out value="${rList.userNick}" escapeXml="false"/></td>
                </c:if>
                <td align=center><c:out value="${rList.regDatimSF}"/></td>
                <td align=right><c:out value="${rList.bltnReadCnt}"/>&nbsp;</td>
              </tr>
              </c:forEach>
            </table>
          </td>
        </tr>
        <tr><td height="5" colspan="4"></td></tr>
        </c:if>
        </c:if>
      
        <%-- List of Memo --%>
        <c:if test="${!empty list.memoList}">
		<c:set var="memo" value="${list.memoList}"/>
		<%--jsp:useBean id="memo" type="java.util.List"/--%>
        <tr>
          <td colspan=4>
            <table width=100% border="0" cellpadding="4" cellspacing="1" bgcolor="#E0E0E0">       
              <c:forEach items="${memo}" var="mList">
              <tr>
                <td align="left" valign="top" bgcolor="#F5F5F5" onMouseOver=this.style.backgroundColor='CCCCCC'; onMouseOut=this.style.backgroundColor='#F5F5F5';>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
		              <td>
					    <c:if test="${mList.memoLev != '1'}">
					      <span style=visibility:hidden><img src='' height=1 width=<c:out value="${mList.memoLevLen}"/>></span>
						  <c:out value="${boardVO.imgRe}" escapeXml="false"/>
					    </c:if>
					  </td>
                      <td align="left">
                        <c:if test="${boardVO.anonYn == 'N'}">
                        <img src="/board/images/board/skin/enboard/dit_icon_person.gif" align="absmiddle" />
                        <b><c:out value="${mList.userNick}" escapeXml="false"/></b>
                        </c:if>
                        (<c:out value="${mList.regDatimF}"/>)&nbsp;&nbsp;<font color=#888888><c:out value="${mList.maskUserIp}"/></font>
                      </td>
                      <td align=right>
                        <c:if test="${boardVO.badStdCnt > '0'}">
                          <c:if test="${mList.badCnt > '0'}">
                            <font style=font-size:7pt color=#264C72>+<c:out value="${mList.badCnt}"/></font>
                          </c:if>
                          <img src=/board/images/board/skin/enboard/i_bad.gif align=absmiddle style=cursor:pointer title=신고하기
                               onclick="ebRead.actionBulletin('bad-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')"
						  >&nbsp;
                        </c:if>
						<c:if test="${boardVO.memoReplyYn == 'Y' && boardVO.memoReplyableYn == 'Y'}">
		                  <c:if test="${mList.memoLev == '1'}"><%--댓답글은 1레벨까지만--%>
						    <a style=cursor:pointer onclick="ebRead.actionBulletin('reply-init-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')">
							  <c:out value="${boardVO.imgMemoR}" escapeXml="false"/>
						    </a>
						  </c:if>
						</c:if>
                        <c:if test="${mList.editable == 'true'}">
                          <a style=cursor:pointer onclick="ebRead.actionBulletin('modify-init-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')">
						    <c:out value="${boardVO.imgMemoU}" escapeXml="false"/>
						  </a>
                        </c:if>
                        <c:if test="${mList.deletable == 'true'}">
                          <a style=cursor:pointer onclick="ebRead.actionBulletin('delete-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')">
						    <c:out value="${boardVO.imgMemoX}" escapeXml="false"/>
						  </a>
                        </c:if>
                      </td>
                    </tr>
                    <tr>
		              <td>
					    <c:if test="${mList.memoLev != '1'}">
					      <span style=visibility:hidden><img src='' height=1 width=<c:out value="${mList.memoLevLen}"/>></span>
					    </c:if>
					  </td>
                      <td class="td_pad" colspan=2>
					    <c:out value="${mList.memoCntt}" escapeXml="false"/>
					  </td>
                    </tr>
					<tr>
					  <td>
					    <c:if test="${mList.memoLev != '1'}">
						  <span style=visibility:hidden><img src='' height=1 width=<c:out value="${mList.memoLevLen}"/>></span>
					    </c:if>
					  </td>
					  <td colspan=2>
					    <div id="memoReplyDiv_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" style="display:none">
						<form name="memoReplyForm_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
						<input type=hidden name="memoOrgCntt" value="<c:out value="${mList.memoOrgCntt}"/>">
						<input type=hidden name=rorm>
						<table width=100%>
						  <tr>
							<td width="100" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">
							  <c:if test="${boardVO.anonYn == 'N'}"><%--익명게시판이 아닌 경우--%>
								작성자<br><input type=text name=userNick size=10 value='<c:out value="${loginInfo.nm_kor}" escapeXml="false"/>' readonly>
							  </c:if>
							  <c:if test="${boardVO.anonYn == 'Y'}"><%--익명게시판인 경우--%>
								작성자<br><input type=text name=userNick size=10>
							  </c:if>
							</td>
							<td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
							<td bgcolor="#F7F8F9" class="gab_3">
							  <textarea name=memoCntt style="overflow:visible;height:40;width:100%"  maxlength="3000"></textarea>
							</td>
							<td width="113" bgcolor="#F0F3F5" class="gab_3">
							  <a name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" onclick="ebRead.actionBulletin('rorm-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');return false;"/>
								<c:out value="${boardVO.imgComment}" escapeXml="false"/>
							  </a>
							  <a name="memoCancelBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" onclick="ebRead.actionBulletin('cancel-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');return false;"/>
								<c:out value="${boardVO.imgCommentX}" escapeXml="false"/>
							  </a>
							</td>
						  </tr>
						</table>
						</form>
						</div>
					  </td>
					</tr>
                  </table>
                </td>
              </tr>
              </c:forEach>
            </table>
          </td>
        </tr>
        </c:if>
        <tr><td height="5" colspan="4"></td></tr>
        <%-- Write memo. --%>
		<c:if test="${boardVO.memoYn == 'Y' && boardVO.memoWritableYn == 'Y'}">
        <form name=memoForm_<c:out value="${list.bltnNo}"/>>
        <tr><td height="2" colspan="4" bgcolor="#C8CBDB"></td></tr>
        <tr>
          <td colspan=4>
            <table width=100%>
              <tr>
                <td width="100" height="25" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">
				  <c:if test="${boardVO.anonYn == 'N'}"><%--익명게시판이 아닌 경우--%>
					작성자<br><input type=text name=userNick size=10 value='<c:out value="${loginInfo.nm_kor}" escapeXml="false"/>' readonly>
				  </c:if>
				  <c:if test="${boardVO.anonYn == 'Y'}"><%--익명게시판인 경우--%>
					작성자<br><input type=text name=userNick size=10>
				  </c:if>
                </td>
                <td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
                <td bgcolor="#F7F8F9" class="gab_3">
                  <textarea name=memoCntt style="overflow:visible;height:40;width:100%"  maxlength="3000"></textarea>
                </td>
                <td width="60" bgcolor="#F0F3F5" class="gab_3">
                  <a name="memoBttn" onclick="ebRead.actionBulletin('write-memo',<c:out value="${list.bltnNo}"/>);return false;"/>
                    <c:out value="${boardVO.imgComment}" escapeXml="false"/>
                  </a>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </form>
        <tr><td height="2" colspan="4" bgcolor="#dbdee7" ></td></tr>
		</c:if>
        <tr><td height="11"  align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
        <tr>
          <td align="left">
		    <c:if test="${!empty list.nextBoardId && !empty list.nextBltnNo}">
		      <strong><font color="blue">다음글</font></strong>
			  <a style=cursor:pointer onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>')">
			    <c:out value="${list.nextBltnOrgSubj}" escapeXml="false" />
			  </a><br>
			  <c:out value="${list.nextRegDatimF}"/><br>
			  <c:out value="${list.nextRegDatimSF}"/><br>
			  <c:out value="${list.nextUpdDatimF}"/><br>
			  <c:out value="${list.nextUpdDatimSF}"/><br>
			</c:if>
		    <c:if test="${!empty list.prevBoardId && !empty list.prevBltnNo}">
		      <strong><font color="blue">이전글</font></strong>&nbsp;&nbsp;&nbsp;
			  <a style=cursor:pointer onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>')">
			    <c:out value="${list.prevBltnOrgSubj}" escapeXml="false"/>
			  </a><br>
			  <c:out value="${list.prevRegDatimF}"/><br>
			  <c:out value="${list.prevRegDatimSF}"/><br>
			  <c:out value="${list.prevUpdDatimF}"/><br>
			  <c:out value="${list.prevUpdDatimSF}"/><br>
			</c:if>
		  </td>
		</tr>
		<tr>
          <td align="right">
		    <c:if test="${!empty list.prevBoardId && !empty list.prevBltnNo}">
              <a style=cursor:pointer onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>')">
			    <c:out value="${boardVO.imgPrevBltn}" escapeXml="false"/>
			  </a>&nbsp;
			</c:if>
		    <c:if test="${!empty list.nextBoardId && !empty list.nextBltnNo}">
              <a style=cursor:pointer onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>')">
			    <c:out value="${boardVO.imgNextBltn}" escapeXml="false"/>
			  </a>&nbsp;
			</c:if>
			<c:if test="${boardSttVO.cmd == 'SEARCH'}">
              <a style=cursor:pointer onclick="ebRead.actionBulletin('search',-1)">
			    <c:out value="${boardVO.imgSearch}" escapeXml="false"/>
			  </a>&nbsp;
            </c:if>
            <a style=cursor:pointer onclick="ebRead.actionBulletin('list',-1)">
			  <c:out value="${boardVO.imgList}" escapeXml="false"/>
			</a>&nbsp;
            <c:if test="${boardVO.writableYn == 'Y'}">
              <a style=cursor:pointer onclick="ebRead.actionBulletin('write',-1)">
			    <c:out value="${boardVO.imgWrite}" escapeXml="false"/>
			  </a>&nbsp;
            </c:if>
            <c:if test="${boardVO.replyableYn == 'Y' && boardVO.replyYn == 'Y'}">
              <a style=cursor:pointer onclick="ebRead.actionBulletin('reply',<c:out value="${list.bltnNo}"/>)">
				<c:out value="${boardVO.imgReply}" escapeXml="false"/>
			  </a>&nbsp;
            </c:if>
            <c:if test="${boardVO.anonYn == 'N'}"><%--'익명게시판'이 아니면--%>
			  <c:if test="${list.editable == 'true'}"><%--수정권한이 있는 경우--%>
                <a style=cursor:pointer onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true)">
				  <c:out value="${boardVO.imgModify}" escapeXml="false"/>
				</a>&nbsp;
              </c:if>
			  <c:if test="${list.editable == 'false'}"><%--수정권한이 없는 경우--%>
			    <c:if test="${empty list.userId}"><%--익명글이면--%>
			      <c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
                    <a style=cursor:pointer onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true)">
				      <c:out value="${boardVO.imgModify}" escapeXml="false"/>
				    </a>&nbsp;
                  </c:if>
			      <c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
					<c:if test="${boardVO.writableYn == 'Y'}">
                      <a style=cursor:pointer onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false)">
				        <c:out value="${boardVO.imgModify}" escapeXml="false"/>
				      </a>&nbsp;
					</c:if>
                  </c:if>
			    </c:if>
			  </c:if>
              <c:if test="${list.deletable == 'true'}"><%--삭제권한이 있는 경우--%>
                <a style=cursor:pointer onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true)">
				  <c:out value="${boardVO.imgDelete}" escapeXml="false"/>
				</a>&nbsp;
              </c:if>
              <c:if test="${list.deletable == 'false'}"><%--삭제권한이 없는 경우--%>
			    <c:if test="${empty list.userId}"><%--익명글이면--%>
			      <c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>
                    <a style=cursor:pointer onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true)">
				      <c:out value="${boardVO.imgDelete}" escapeXml="false"/>
				    </a>&nbsp;
                  </c:if>
			      <c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
					<c:if test="${boardVO.writableYn == 'Y'}">
                      <a style=cursor:pointer onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false)">
				        <c:out value="${boardVO.imgDelete}" escapeXml="false"/>
				      </a>&nbsp;
					</c:if>
                  </c:if>
				</c:if>  
			  </c:if>
			</c:if>
            <c:if test="${boardVO.anonYn == 'Y'}"><%--'익명게시판'인 경우--%>
			  <c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
                <a style=cursor:pointer onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true)">
			      <c:out value="${boardVO.imgModify}" escapeXml="false"/>
			    </a>&nbsp;
			  </c:if>
			  <c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
                <a style=cursor:pointer onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false)">
			      <c:out value="${boardVO.imgModify}" escapeXml="false"/>
			    </a>&nbsp;
			  </c:if>
			  <c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>
                <a style=cursor:pointer onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true)">
			      <c:out value="${boardVO.imgDelete}" escapeXml="false"/>
			    </a>&nbsp;
			  </c:if>
			  <c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
                <a style=cursor:pointer onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false)">
			      <c:out value="${boardVO.imgDelete}" escapeXml="false"/>
			    </a>&nbsp;
			  </c:if>
			</c:if>
            <%-- select best reply --%>
            <c:if test="${boardVO.boardType == 'C'}">
              <c:if test="${list.bltnGq != '0'}">
                <c:if test="${secPmsnVO.isLogin == 'true'}">
			      <%--점수를 건 원문 게시자와 관리자에게 어떤 레벨의 답변글을 선정할 권한을 줄 것인지를 여기서 결정해준다.--%>
                  <c:if test="${secPmsnVO.isAdmin == 'true'}">
                    <a style=cursor:pointer onclick="ebRead.actionBulletin('best',<c:out value="${list.bltnNo}"/>, '9')"><c:out value="${boardVO.imgBestAn9}" escapeXml="false"/></a> &nbsp;
                  </c:if>
                  <c:if test="${secPmsnVO.isAdmin == 'false'}">
                    <c:if test="${list.userId != secPmsnVO.loginId}">
                      <c:if test="${list.bestableUserId == secPmsnVO.loginId}">
                        <a style=cursor:pointer onclick="ebRead.actionBulletin('best',<c:out value="${list.bltnNo}"/>, '9')"><c:out value="${boardVO.imgBestAn9}" escapeXml="false"/></a> &nbsp;
                      </c:if> 
                    </c:if>
                  </c:if>
                </c:if>
              </c:if>
            </c:if>
          </td>
        </tr>
        <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
      </table>
    </td>
  </tr>
  <%-- Reply Bulletin List --%>
  <c:if test="${boardVO.readReplyCnttYn == 'Y'}">
  <tr>
    <td align="center">
      <div class="board">			
      <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="1" bgcolor="#E0E0E0" cellpadding="0">
        <c:if test="${empty list.replyList}">
        <tr><td align="center" colspan=20>등록된 답변이 존재하지 않습니다.</td></tr>
        </c:if>
        
		<c:set var="replyBltn" value="${list.replyList}"/>
		<%--jsp:useBean id="replyBltn" type="java.util.List"/--%>
        <c:if test="${!empty replyBltn}">
        <c:forEach items="${replyBltn}" var="rbList">
        <c:if test="${rbList.bltnGq != '0'}">
        <tr>
          <td>
            <table width=100% border=0 bgcolor='#FFFFFF' onMouseOver=this.style.backgroundColor='#F5F5F5'; onMouseOut=this.style.backgroundColor='#FFFFFF'; cellspacing=0 cellpadding=0>
              <tr height=22>
                <td width=20 align=center>
				  <c:if test="${rbList.bltnBestLevel == '9'}"><c:out value="${boardVO.imgBest9}" escapeXml="false"/></c:if>                
                  <c:if test="${rbList.bltnBestLevel == '8'}"><c:out value="${boardVO.imgBest8}" escapeXml="false"/></c:if>                
                  <c:if test="${rbList.bltnBestLevel == '7'}"><c:out value="${boardVO.imgBest7}" escapeXml="false"/></c:if>                
                </td>
                <td width=60 align=center>
				  <c:if test="${boardVO.cateYn == 'Y'}">
                    <c:out value="${rbList.cateNm}" escapeXml="false"/>
                  </c:if>
				</td>
                <td align=left>
                  <c:if test="${rbList.bltnIcon == 'A'}">
                    <c:if test="${rbList.bltnPermitYn == 'Y'}"><c:out value="${boardVO.imgDoc}" escapeXml="false"/></c:if>
                    <c:if test="${rbList.bltnPermitYn == 'N'}"><c:out value="${boardVO.imgProhibit}" escapeXml="false"/></c:if>
                  </c:if>
                  <c:if test="${rbList.bltnIcon == 'B'}"><c:out value="${boardVO.imgFile}" escapeXml="false"/></c:if>  
                  <c:if test="${rbList.bltnIcon == 'C'}"><c:out value="${boardVO.imgPoll}" escapeXml="false"/></c:if>  
                  <c:if test="${rbList.bltnIcon == 'D'}"><c:out value="${boardVO.imgSecret}" escapeXml="false"/></c:if>
                
                  <c:if test="${rbList.bltnLev != '1'}">
                  <span style=visibility:hidden><img src='' height=1 width=<c:out value="${rbList.bltnLevLen}"/>></span>
                  <c:out value="${boardVO.imgRe}" escapeXml="false"/>
                  </c:if>
                
                  <c:if test="${rbList.betPnt > '0'}">
                  <font color=#A51818>$<c:out value="${rbList.betPnt}"/></font>
                  </c:if>
                
                  <font onclick="ebList.readBulletin('<c:out value="${rbList.boardId}"/>','<c:out value="${rbList.bltnNo}"/>')" style=cursor:pointer OnMouseOver=this.style.textDecoration='underline' OnMouseOut=this.style.textDecoration='none'>
                  <c:out value="${rbList.bltnOrgSubj}" escapeXml="false"/> 
                  </font>
                
                  <c:if test="${rbList.bltnMemoCnt != '0'}">
                  <font color="#CC4848">(<c:out value="${rbList.bltnMemoCnt}"/>)</font>
                  </c:if>
                
                  <c:if test="${rbList.recentBltn == 'Y'}">
                  <c:out value="${boardVO.imgNew}" escapeXml="false"/>
                  </c:if> 
                </td>
                <td width=80>
                  <c:if test="${boardVO.anonYn == 'N'}">
				    <c:out value="${rbList.userNick}"/>
                  </c:if>
				</td>
                <td width=110 align=center><c:out value="${rbList.regDatimSF}"/></td>
                <td width=40 align=right><c:out value="${rbList.bltnReadCnt}"/>&nbsp;</td>
                <%-- select best reply --%>
                <c:if test="boardVO.boardType == 'C'}">
                  <c:if test="${rbList.bltnGq != '0'}">
                    <c:if test="secPmsnVO.isLogin == 'true'}">
					  <%--점수를 건 원문 게시자와 관리자에게 어떤 레벨의 답변글을 선정할 권한을 줄 것인지를 여기서 결정해준다.--%>
                      <c:if test="${secPmsnVO.isAdmin == 'true'}">
                        <td width=228 align=right>
                          <a style=cursor:pointer onclick="ebRead.actionBulletin('best',<c:out value="${rbList.bltnNo}"/>, '8')"><c:out value="${boardVO.imgBestAn8}" escapeXml="false"/></a> &nbsp;
                          <a style=cursor:pointer onclick="ebRead.actionBulletin('best',<c:out value="${rbList.bltnNo}"/>, '7')"><c:out value="${boardVO.imgBestAn7}" escapeXml="false"/></a> &nbsp;
                        </td>
                      </c:if>
					  <c:if test="${secPmsnVO.isAdmin == 'false'}">
                        <c:if test="${rbList.userId != secPmsnVO.loginId}">
                          <c:if test="${rbList.bestableUserId == secPmsnVO.loginId}">
                            <td width=228 align=right>
                              <a style=cursor:pointer onclick="ebRead.actionBulletin('best',<c:out value="${rbList.bltnNo}"/>, '8')"><c:out value="${boardVO.imgBestAn8}" escapeXml="false"/></a> &nbsp;
                              <a style=cursor:pointer onclick="ebRead.actionBulletin('best',<c:out value="${rbList.bltnNo}"/>, '7')"><c:out value="${boardVO.imgBestAn7}" escapeXml="false"/></a> &nbsp;
                            </td>
                          </c:if>
                        </c:if>
                      </c:if>
					</c:if>
				  </c:if>
				</c:if>
              </tr>
              <tr><td colspan=7 height=1 bgcolor='#E0E0E0' style='padding:0 20 0 20;'></td></tr>
              <tr>
                <td colspan=7 height="150" colspan="15" valign="top" class="content_text">
                  <c:out value="${rbList.bltnOrgCntt}" escapeXml="false"/>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </c:if>
        </c:forEach>
        </c:if>
      </table>
      </div>
    </td>
  </tr>
  </c:if>
  </table>
</c:forEach>

      </div>
    </td>
  </tr>
</table>

<br style="line-height:5px;" />
<%-- Bulletin List  --%>
<c:if test="${!empty bltnList && boardVO.readListYn == 'Y'}">
<table width=100% border=0 cellspacing=0 cellpadding=0>
  <%@ include file="list.jsp"%>
</table>
</c:if>
