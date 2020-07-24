<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="cntt_extraInfo_wrap CF0501_nmBrdrColor">
	<!-- content start -->  
	<div class="cntt_extraInfo_title CF0501_nmBrdrColor">
		<span class="CF0501_nmFontColor">내 정보 수정</span>
	</div>
	<div class="cntt_updMyInfo_box">
		<div class="myinfo_wrap">
			<fieldset class="myinfo_field">
				<legend>기본정보</legend>
				<dl class="reg_form">
					<dt>ㆍ 닉네임</dt>
					<dd>
						<input name="userNick" class="inp" id="userNick" type="text" maxLength="30" value="<c:out value="${mmbrVO.userNick}"/>" size="36"
							onfocus="cfCntt.dupCheckUserNickReset()" onblur="cfCntt.dupCheckUserNick(this)" 
						/>
						<input type="hidden" id="cafeUrl" name="cafeUrl" value="<c:out value="${mmbrVO.cmntVO.cmntUrl}"/>"/>
						<input type="hidden" id="userId" name="userId" value="<c:out value="${mmbrVO.userId}"/>" />
						<input type="hidden" id="userNickValidted" name="userNickValidted" value="false" />
						<span id="userNickRslt" class="userNickRslt"></span>
					</dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ 아이디 공개</dt>
					<dd>
						<select id="umInfo_openId" name="umInfo_openId" class="inp">
							<c:forEach items="${openList}" var="open">
								<option value="<c:out value="${open.code}"/>"<c:if test="${mmbrVO.openId == open.code}"> selected="selected"</c:if>>
									<c:out value="${open.codeName}"/>
								</option>
							</c:forEach>
						</select>
					</dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ 이름 공개</dt>
					<dd>
						<select id="umInfo_openNm" name="umInfo_openNm" class="inp">
							<c:forEach items="${openList}" var="open">
								<option value="<c:out value="${open.code}"/>"<c:if test="${mmbrVO.openNm == open.code}"> selected="selected"</c:if>>
									<c:out value="${open.codeName}"/>
								</option>
							</c:forEach>
						</select>
					</dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ 성별 공개</dt>
					<dd>
						<select id="umInfo_openSex" name="umInfo_openSex" class="inp">
							<c:forEach items="${openList}" var="open">
								<option value="<c:out value="${open.code}"/>"<c:if test="${mmbrVO.openSex == open.code}"> selected="selected"</c:if>>
									<c:out value="${open.codeName}"/>
								</option>
							</c:forEach>
						</select>
					</dd>
				</dl>
			</fieldset>
			<fieldset class="myinfo_field lineT CF0501_nmBrdrColor"><legend>기타정보</legend>
				<!-- 
				<dl class="reg_form">
					<dt>ㆍ 수신설정</dt>
					<dd>
						<input name="mailrcvyntmp" class="check" id="mailrcvyntmp" onclick="changeMailRcvyn();" type="checkbox" checked=""> <label for="mailrcvyntmp">전체메일</label>
						<input name="mailrcvyn" type="hidden" value="">
						<input name="scrappermyn" type="hidden" value="">
						<input name="msgrcvyntmp" class="check" id="msgrcvyntmp" onclick="changeMsgRcvyn();" type="checkbox" checked=""> <label for="msgrcvyntmp">전체쪽지</label>
						<input name="msgrcvyn" id="msgrcvyn" type="hidden" value="">
						<input name="mypeoplercvyn" class="check" id="mypeopleCafeChannel" type="checkbox"> <label for="mypeopleCafeChannel">마이피플 Daum 카페 채널</label>
						<img width="14" height="14" class="tip_icon" id="mypeopleTip" alt="" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif">
						<p style="display: none;">우리 카페의 쪽지나 Daum카페의<br>유용한 정보를 마이피플로 간편하게 받아볼 수 있습니다.</p>
					</dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ 이미지</dt>
					<dd>
						<div class="menu_img_type_wrap">
							<p class="menu_img_type">
								<input name="profile" class="check" id="imgType1" onclick="imgType(1);" type="radio" checked="checked" value="2"><label for="imgType1">블로그 프로필 이미지</label>
								<input name="profile" class="check" id="imgType0" onclick="imgType(0);" type="radio" value="0" selected="selected"><label for="imgType0">직접 올리기</label>                                
							</p>
							<div class="preiview_area">
								<div id="img_blog" style="display: none;">
									<p class="blank_thumb">
										<img width="70" height="70" id="preview_blog_img" alt="" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif">
										<a class="del_thum" id="delThumBlog" style="display: none;" onclick="delImg(); return false;" href="javascript:;"><util:message key="ev.title.remove"/></a>
										<em class="p11 txt_sub message_noimage">등록된 이미지가 없습니다.</em>
									</p>
									<p class="img_upload">
										<span class="p11 txt_sub blog_msg"><a class="u" href="http://blog.daum.net/_blog/myBlog.do" target="_blank">내 블로그</a>의 프로필 이미지를 불러옵니다.</span>
										<a onclick="blog_uploader(); return false;" href="javascript:;"><img width="56" height="21" class="blog_import" alt="불러오기" src="http://i1.daumcdn.net/cafeimg/cf_img4/design/common/btn_import.gif"></a>
									</p> 
								</div>
								<div id="img_direct" style="display: block;">                            
									<p class="blank_thumb" id="preview_img_wrap">
										<img width="70" height="70" id="preview_img" alt="" src="http://cfile285.uf.daum.net/C150x150/152B2D49513D8BFF325607">
										<a class="del_thum" id="delThumDirect" style="display: block;" onclick="delImg(); return false;" href="javascript:;"><util:message key="ev.title.remove"/></a>
										<em class="p11 txt_sub message_noimage" style="display: none;">등록된<br>이미지가<br>없습니다.</em>
									</p>	                        
									<p class="img_upload">
										<span class="p11 txt_sub" id="imgsize_msg"> 최적 사이즈 150*150 <strong id="limit" class="txt_point">0</strong>KB  / 최대 500KB </span>	
										<object name="cocaUploader" width="56" height="25" id="cocaUploader" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"><PARAM NAME="_cx" VALUE="1482"><PARAM NAME="_cy" VALUE="661"><PARAM NAME="FlashVars" VALUE="coca_service=CafeWebzineCubeCoca&amp;coca_ctx=&amp;service=cafe&amp;sname=cafe&amp;sid=cafe&amp;coca_skin=http://i1.daumcdn.net/cafeimg/cf_img4/design/common/bt_search.gif&amp;single_selection=false"><PARAM NAME="Movie" VALUE="http://editor.daum.net/coca_service/1.1.18/coca.swf"><PARAM NAME="Src" VALUE="http://editor.daum.net/coca_service/1.1.18/coca.swf"><PARAM NAME="WMode" VALUE="Transparent"><PARAM NAME="Play" VALUE="0"><PARAM NAME="Loop" VALUE="-1"><PARAM NAME="Quality" VALUE="High"><PARAM NAME="SAlign" VALUE="LT"><PARAM NAME="Menu" VALUE="0"><PARAM NAME="Base" VALUE=""><PARAM NAME="AllowScriptAccess" VALUE="always"><PARAM NAME="Scale" VALUE="NoScale"><PARAM NAME="DeviceFont" VALUE="0"><PARAM NAME="EmbedMovie" VALUE="0"><PARAM NAME="BGColor" VALUE=""><PARAM NAME="SWRemote" VALUE=""><PARAM NAME="MovieData" VALUE=""><PARAM NAME="SeamlessTabbing" VALUE="1"><PARAM NAME="Profile" VALUE="0"><PARAM NAME="ProfileAddress" VALUE=""><PARAM NAME="ProfilePort" VALUE="0"><PARAM NAME="AllowNetworking" VALUE="all"><PARAM NAME="AllowFullScreen" VALUE="false"><PARAM NAME="AllowFullScreenInteractive" VALUE=""><PARAM NAME="IsDependent" VALUE="0"><param name="allowscriptaccess" value="always"><param name="quality" value="high"><param name="menu" value="false"><param name="wmode" value="transparent"><param name="swliveconnect" value="true"><param name="scale" value="noscale"><param name="salign" value="tl"><param name="flashvars" value="coca_service=CafeWebzineCubeCoca&amp;coca_ctx=&amp;service=cafe&amp;sname=cafe&amp;sid=cafe&amp;coca_skin=http://i1.daumcdn.net/cafeimg/cf_img4/design/common/bt_search.gif&amp;single_selection=false"><param name="movie" value="http://editor.daum.net/coca_service/1.1.18/coca.swf"></object>
										<input name="uploadfile" id="uploadfile" type="hidden"> 
									</p>
								</div>
							</div>
						</div>
					</dd>                       
				</dl>
				
				<dl class="reg_form">
					<dt>ㆍ 게시물 건수</dt>                     
					<dd><c:out value="${mmbrVO.bltnCntCF}"/> 건</dd>
				</dl>
				-->
				<dl class="reg_form">
					<dt>ㆍ 가입일</dt>
					<dd><c:out value="${mmbrVO.regDatimPF}"/></dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ 방문횟수</dt>
					<dd><c:out value="${mmbrVO.visitCntCF}"/> 회</dd>
				</dl>
			</fieldset>
			<div class="cl">&nbsp;</div>
		</div>  <!-- end myinfo_wrap -->
	</div>
	<!-- content end -->     
	<div class="btn_center">
		<a onclick="cfCntt.m_updMyInfo.update()"><img alt="수정" src="/enview/cola/cafe/images/each/encafe/cntt/btn_modify.gif"></a>
		<a onclick="cfCntt.m_updMyInfo.cancel()"><img alt="취소" src="/enview/cola/cafe/images/each/encafe/cntt/btn_cancel.gif"></a>
	</div>
</div>