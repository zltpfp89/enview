<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--BEGIN::스킨/스킨--%>
<c:if test="${edForm.ggumMenu == 'skin'}">
	<c:if test="${edForm.ggumSubMenu == 'skin'}">
		<div id="menuControlMaster" class="remoteZindexM">
			<div id="SkinSetList">
				<ul class="ssl_block">
					<c:forEach items="${skinDecoInfoList }" var="deco">
						<li class="ssl_item">
							<div id="tplImg_<c:out value="${ deco.decoId }"/>" style="position: relative; height: 116px;">
								<a id="SkinIcon_20_1" class="ssl_lnk_dep1" style="cursor:pointer;" onclick="javascript:cfGGum.getTplMngr().onSelectSkin('<c:out value="${deco.decoId}"/>', '<c:out value="${deco.name}"/>')">
									<img id="skinTplImg_<c:out value="${ deco.decoId }"/>" class="ssl_thum" width="80" height="101" src="<c:out value="${deco.value }"/>" />
								</a>
							</div>
							<ul class="ssl_chip_area">
								<c:forEach items="${deco.colorSet }" var="color" varStatus="status">
									<li<c:if test="${status.first }"> class="first"</c:if>>
										<a style="background-color:<c:out value="${color}"/>; cursor:pointer;" 
											onclick="javascript:cfGGum.getTplMngr().onSelectSkin('<c:out value="${deco.decoId}"/>', '<c:out value="${deco.name}"/>', '<c:out value="${color}"/>', <c:out value="${status.count}"/>);"
											onmouseover="javascript:cfGGum.getTplMngr().onOverSkin('<c:out value="${deco.decoId}"/>', '<c:out value="${deco.name}"/>', <c:out value="${status.count}"/>);"
											onmouseout="javascript:cfGGum.getTplMngr().onOutSkin('<c:out value="${deco.decoId}"/>', '<c:out value="${deco.name}"/>');"
											></a>
									</li>
								</c:forEach>
							</ul>				
						</li>
					</c:forEach>
				</ul>
			</div>
			<input id="#CF0801_decoId" type="hidden" />
			<div id="CF0801_selectedBox" class="selectedBox2"></div>
			<div id="paging" align="center"><!--원래 align="center"는 없었다.좌측으로 정렬되어서 추가함.2012.04.25.KWShin.-->
				<table class="pg_area" align="center">
					<tbody>
					  <tr>
						<td>
							<span class="pg_btn prev_btn" onclick="javascript:cfGGum.onClickMenu('skin','skin','list',<c:out value="${page.currentBeforePage}"/>);">이전</span>
							<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
							<c:if test="${page.currentPage == i }"><span class="page_selected"><c:out value="${i}"/></span></c:if>
							<c:if test="${page.currentPage != i }"><a onclick="javascript:cfGGum.onClickMenu('skin','skin','image',<c:out value="${i}"/>); return false;" href="#"><c:out value="${i}"/></a></c:if>
							</c:forEach>
							<a class="pg_btn next_btn" onclick="javascript:cfGGum.onClickMenu('skin','skin','list',<c:out value="${page.currentNextPage}"/>);">다음</a>
						</td>
					  </tr>
					</tbody>
				</table>
			</div>
		</div>
	</c:if>
	<%--END::스킨/스킨--%>
	<%--BEGIN::스킨/배경--%>
	<c:if test="${edForm.ggumSubMenu == 'cafeBg'}">
		<div id="menuControlMaster" class="remoteZindexM">
			<%--BEGIN::스킨/배경(디자인)--%>
			<c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">
				<ul id="BackgroundSetList">
					<c:forEach items="${ skinBgDecoInfoList }" var="deco" varStatus="status">
					<li id="tplImg_<c:out value="${ deco.decoId }"/>" class="bgsb_item" style="cursor: pointer;">
					  <a class="bgsb_thum_area" onclick="javascript:cfGGum.getTplMngr().selectTemplate('<c:out value="${ deco.decoId }"/>');">
						<img class="bgsb_thum" width="82" height="82" alt="" src="<c:out value="${ deco.value }"/>">
					  </a>
					</li>
					</c:forEach>
				</ul>
				<div id="CF0802_selectedBox" class="selectedBox2"></div>
				<div id="paging" align="center"><!--원래 align="center"는 없었다.좌측으로 정렬되어서 추가함.2012.04.25.KWShin.-->
				  <table class="pg_area" align="center">
					<tbody>
					  <tr>
						<td>
							<span class="pg_btn prev_btn" onclick="javascript:cfGGum.onClickMenu('skin','cafeBg','image',<c:out value="${page.currentBeforePage}"/>);" href="#">이전</span>
							<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
							<c:if test="${page.currentPage == i }"><span class="page_selected"><c:out value="${i}"/></span></c:if>
							<c:if test="${page.currentPage != i }"><a onclick="javascript:cfGGum.onClickMenu('skin','cafeBg','image',<c:out value="${i}"/>); return false;" href="#"><c:out value="${i}"/></a></c:if>
							</c:forEach>
							<a class="pg_btn next_btn" onclick="javascript:cfGGum.onClickMenu('skin','cafeBg','image',<c:out value="${page.currentNextPage}"/>);" href="#">다음</a>
						</td>
					  </tr>
					</tbody>
				  </table>
				</div>
			</c:if>
			<%--END::스킨/배경(디자인)--%>
			<%--BEGIN::스킨/배경(색상)--%>
			<c:if test="${edForm.ggum3rdMenu == 'color'}">
				<div id="BackgroundColorList">
					<ul class="ce_list">
						<%--BEGIN::편한색--%>
						<c:if test="${empty edForm.ggum4thMenu || edForm.ggum4thMenu == '1'}">
							<li><a class="imgLink" style="background-color: #d96a6a;">#d96a6a</a></li>
							<li><a class="imgLink" style="background-color: #d98f6a;">#d98f6a</a></li>
							<li><a class="imgLink" style="background-color: #d9bb6a;">#d9bb6a</a></li>
							<li><a class="imgLink" style="background-color: #d9cc6a;">#d9cc6a</a></li>
							<li><a class="imgLink" style="background-color: #bad96a;">#bad96a</a></li>
							<li><a class="imgLink" style="background-color: #81ce7b;">#81ce7b</a></li>
							<li><a class="imgLink" style="background-color: #7bbfce;">#7bbfce</a></li>
							<li><a class="imgLink" style="background-color: #7b96ce;">#7b96ce</a></li>
							<li><a class="imgLink" style="background-color: #7d7bce;">#7d7bce</a></li>
							<li><a class="imgLink" style="background-color: #9b7bce;">#9b7bce</a></li>
							<li><a class="imgLink" style="background-color: #ce7bc3;">#ce7bc3</a></li>
							<li><a class="imgLink" style="background-color: #ce7ba4;">#ce7ba4</a></li>
							<li><a class="imgLink" style="background-color: #000000;">#000000</a></li>
							<li><a class="imgLink" style="background-color: #ffffff;">#ffffff</a></li>
							<li><a class="imgLink" style="background-color: #f5eded;">#f5eded</a></li>
							<li><a class="imgLink" style="background-color: #f5f0ed;">#f5f0ed</a></li>
							<li><a class="imgLink" style="background-color: #f5f3ed;">#f5f3ed</a></li>
							<li><a class="imgLink" style="background-color: #f5f4ed;">#f5f4ed</a></li>
							<li><a class="imgLink" style="background-color: #f2f5ed;">#f2f5ed</a></li>
							<li><a class="imgLink" style="background-color: #f2f8f2;">#f2f8f2</a></li>
							<li><a class="imgLink" style="background-color: #f2f6f8;">#f2f6f8</a></li>
							<li><a class="imgLink" style="background-color: #f2f3f8;">#f2f3f8</a></li>
							<li><a class="imgLink" style="background-color: #f2f2f8;">#f2f2f8</a></li>
							<li><a class="imgLink" style="background-color: #f4f2f8;">#f4f2f8</a></li>
							<li><a class="imgLink" style="background-color: #f8f2f7;">#f8f2f7</a></li>
							<li><a class="imgLink" style="background-color: #f8f2f4;">#f8f2f4</a></li>
							<li><a class="imgLink" style="background-color: #f6f6f6;">#f6f6f6</a></li>
							<li><a class="imgLink" style="background-color: #eaeaea;">#eaeaea</a></li>
							<li><a class="imgLink" style="background-color: #e1d1d1;">#e1d1d1</a></li>
							<li><a class="imgLink" style="background-color: #e1d6d1;">#e1d6d1</a></li>
							<li><a class="imgLink" style="background-color: #e1dcd1;">#e1dcd1</a></li>
							<li><a class="imgLink" style="background-color: #e1dfd1;">#e1dfd1</a></li>
							<li><a class="imgLink" style="background-color: #dde1d1;">#dde1d1</a></li>
							<li><a class="imgLink" style="background-color: #d2e1d1;">#d2e1d1</a></li>
							<li><a class="imgLink" style="background-color: #d1dee1;">#d1dee1</a></li>
							<li><a class="imgLink" style="background-color: #d1d6e1;">#d1d6e1</a></li>
							<li><a class="imgLink" style="background-color: #d1d1e1;">#d1d1e1</a></li>
							<li><a class="imgLink" style="background-color: #d8d1e1;">#d8d1e1</a></li>
							<li><a class="imgLink" style="background-color: #e1d1de;">#e1d1de</a></li>
							<li><a class="imgLink" style="background-color: #e1d1d9;">#e1d1d9</a></li>
							<li><a class="imgLink" style="background-color: #d5d5d5;">#d5d5d5</a></li>
							<li><a class="imgLink" style="background-color: #bdbdbd;">#bdbdbd</a></li>
							<li><a class="imgLink" style="background-color: #bfa5a5;">#bfa5a5</a></li>
							<li><a class="imgLink" style="background-color: #bfaea5;">#bfaea5</a></li>
							<li><a class="imgLink" style="background-color: #bfb8a5;">#bfb8a5</a></li>
							<li><a class="imgLink" style="background-color: #bfbca5;">#bfbca5</a></li>
							<li><a class="imgLink" style="background-color: #b8bfa5;">#b8bfa5</a></li>
							<li><a class="imgLink" style="background-color: #a8bfa5;">#a8bfa5</a></li>
							<li><a class="imgLink" style="background-color: #a5bbbf;">#a5bbbf</a></li>
							<li><a class="imgLink" style="background-color: #a5aebf;">#a5aebf</a></li>
							<li><a class="imgLink" style="background-color: #a5a5bf;">#a5a5bf</a></li>
							<li><a class="imgLink" style="background-color: #afa5bf;">#afa5bf</a></li>
							<li><a class="imgLink" style="background-color: #bfa5bc;">#bfa5bc</a></li>
							<li><a class="imgLink" style="background-color: #bfa5b2;">#bfa5b2</a></li>
							<li><a class="imgLink" style="background-color: #a6a6a6;">#a6a6a6</a></li>
							<li><a class="imgLink" style="background-color: #8c8c8c;">#8c8c8c</a></li>
							<li><a class="imgLink" style="background-color: #896a6a;">#896a6a</a></li>
							<li><a class="imgLink" style="background-color: #89746a;">#89746a</a></li>
							<li><a class="imgLink" style="background-color: #89806a;">#89806a</a></li>
							<li><a class="imgLink" style="background-color: #89856a;">#89856a</a></li>
							<li><a class="imgLink" style="background-color: #81896a;">#81896a</a></li>
							<li><a class="imgLink" style="background-color: #6d896a;">#6d896a</a></li>
							<li><a class="imgLink" style="background-color: #6a8489;">#6a8489</a></li>
							<li><a class="imgLink" style="background-color: #6a7589;">#6a7589</a></li>
							<li><a class="imgLink" style="background-color: #6a6a89;">#6a6a89</a></li>
							<li><a class="imgLink" style="background-color: #766a89;">#766a89</a></li>
							<li><a class="imgLink" style="background-color: #896a85;">#896a85</a></li>
							<li><a class="imgLink" style="background-color: #896a79;">#896a79</a></li>
							<li><a class="imgLink" style="background-color: #747474;">#747474</a></li>
							<li><a class="imgLink" style="background-color: #5d5d5d;">#5d5d5d</a></li>
							<li><a class="imgLink" style="background-color: #55403f;">#55403f</a></li>
							<li><a class="imgLink" style="background-color: #55473f;">#55473f</a></li>
							<li><a class="imgLink" style="background-color: #554f3f;">#554f3f</a></li>
							<li><a class="imgLink" style="background-color: #55533f;">#55533f</a></li>
							<li><a class="imgLink" style="background-color: #4f553f;">#4f553f</a></li>
							<li><a class="imgLink" style="background-color: #41553f;">#41553f</a></li>
							<li><a class="imgLink" style="background-color: #3f5155;">#3f5155</a></li>
							<li><a class="imgLink" style="background-color: #3f4655;">#3f4655</a></li>
							<li><a class="imgLink" style="background-color: #413f55;">#413f55</a></li>
							<li><a class="imgLink" style="background-color: #483f55;">#483f55</a></li>
							<li><a class="imgLink" style="background-color: #553f52;">#553f52</a></li>
							<li><a class="imgLink" style="background-color: #553f4a;">#553f4a</a></li>
							<li><a class="imgLink" style="background-color: #4c4c4c;">#4c4c4c</a></li>
							<li><a class="imgLink" style="background-color: #353535;">#353535</a></li>
							<li><a class="imgLink" style="background-color: #3f312f;">#3f312f</a></li>
							<li><a class="imgLink" style="background-color: #3f362f;">#3f362f</a></li>
							<li><a class="imgLink" style="background-color: #3f3b2f;">#3f3b2f</a></li>
							<li><a class="imgLink" style="background-color: #3f3e2f;">#3f3e2f</a></li>
							<li><a class="imgLink" style="background-color: #3b3f2f;">#3b3f2f</a></li>
							<li><a class="imgLink" style="background-color: #313f2f;">#313f2f</a></li>
							<li><a class="imgLink" style="background-color: #2f3c3f;">#2f3c3f</a></li>
							<li><a class="imgLink" style="background-color: #2f353f;">#2f353f</a></li>
							<li><a class="imgLink" style="background-color: #2f2f3f;">#2f2f3f</a></li>
							<li><a class="imgLink" style="background-color: #362f3f;">#362f3f</a></li>
							<li><a class="imgLink" style="background-color: #3f2f3d;">#3f2f3d</a></li>
							<li><a class="imgLink" style="background-color: #3f2f37;">#3f2f37</a></li>
							<li><a class="imgLink" style="background-color: #212121;">#212121</a></li>
							<li><a class="imgLink" style="background-color: #191919;">#191919</a></li>
						</c:if>
						<%--END::편한색--%>
						<%--BEGIN::선명한색--%>
						<c:if test="${edForm.ggum4thMenu == '2'}">
							<li><a class="imgLink" style="background-color: #ff0000;">#ff0000</a></li>
							<li><a class="imgLink" style="background-color: #ff5e00;">#ff5e00</a></li>
							<li><a class="imgLink" style="background-color: #ffbb00;">#ffbb00</a></li>
							<li><a class="imgLink" style="background-color: #ffe400;">#ffe400</a></li>
							<li><a class="imgLink" style="background-color: #abf200;">#abf200</a></li>
							<li><a class="imgLink" style="background-color: #1ddb16;">#1ddb16</a></li>
							<li><a class="imgLink" style="background-color: #00d8ff;">#00d8ff</a></li>
							<li><a class="imgLink" style="background-color: #0054ff;">#0054ff</a></li>
							<li><a class="imgLink" style="background-color: #0100ff;">#0100ff</a></li>
							<li><a class="imgLink" style="background-color: #5f00ff;">#5f00ff</a></li>
							<li><a class="imgLink" style="background-color: #ff00dd;">#ff00dd</a></li>
							<li><a class="imgLink" style="background-color: #ff007f;">#ff007f</a></li>
							<li><a class="imgLink" style="background-color: #000000;">#000000</a></li>
							<li><a class="imgLink" style="background-color: #ffffff;">#ffffff</a></li>
							<li><a class="imgLink" style="background-color: #ffd8d8;">#ffd8d8</a></li>
							<li><a class="imgLink" style="background-color: #fae0d4;">#fae0d4</a></li>
							<li><a class="imgLink" style="background-color: #faecc5;">#faecc5</a></li>
							<li><a class="imgLink" style="background-color: #faf4c0;">#faf4c0</a></li>
							<li><a class="imgLink" style="background-color: #e4f7ba;">#e4f7ba</a></li>
							<li><a class="imgLink" style="background-color: #cefbc9;">#cefbc9</a></li>
							<li><a class="imgLink" style="background-color: #d4f4fa;">#d4f4fa</a></li>
							<li><a class="imgLink" style="background-color: #d9e5ff;">#d9e5ff</a></li>
							<li><a class="imgLink" style="background-color: #dad9ff;">#dad9ff</a></li>
							<li><a class="imgLink" style="background-color: #e8d9ff;">#e8d9ff</a></li>
							<li><a class="imgLink" style="background-color: #ffd9fa;">#ffd9fa</a></li>
							<li><a class="imgLink" style="background-color: #ffd9ec;">#ffd9ec</a></li>
							<li><a class="imgLink" style="background-color: #f6f6f6;">#f6f6f6</a></li>
							<li><a class="imgLink" style="background-color: #eaeaea;">#eaeaea</a></li>
							<li><a class="imgLink" style="background-color: #ffa7a7;">#ffa7a7</a></li>
							<li><a class="imgLink" style="background-color: #ffc19e;">#ffc19e</a></li>
							<li><a class="imgLink" style="background-color: #ffe08c;">#ffe08c</a></li>
							<li><a class="imgLink" style="background-color: #faed7d;">#faed7d</a></li>
							<li><a class="imgLink" style="background-color: #cef279;">#cef279</a></li>
							<li><a class="imgLink" style="background-color: #b7f0b1;">#b7f0b1</a></li>
							<li><a class="imgLink" style="background-color: #b2ebf4;">#b2ebf4</a></li>
							<li><a class="imgLink" style="background-color: #b2ccff;">#b2ccff</a></li>
							<li><a class="imgLink" style="background-color: #b5b2ff;">#b5b2ff</a></li>
							<li><a class="imgLink" style="background-color: #d1b2ff;">#d1b2ff</a></li>
							<li><a class="imgLink" style="background-color: #ffb2f5;">#ffb2f5</a></li>
							<li><a class="imgLink" style="background-color: #ffb2d9;">#ffb2d9</a></li>
							<li><a class="imgLink" style="background-color: #d5d5d5;">#d5d5d5</a></li>
							<li><a class="imgLink" style="background-color: #bdbdbd;">#bdbdbd</a></li>
							<li><a class="imgLink" style="background-color: #f15f5f;">#f15f5f</a></li>
							<li><a class="imgLink" style="background-color: #f29661;">#f29661</a></li>
							<li><a class="imgLink" style="background-color: #f2cb61;">#f2cb61</a></li>
							<li><a class="imgLink" style="background-color: #e5d85c;">#e5d85c</a></li>
							<li><a class="imgLink" style="background-color: #bce55c;">#bce55c</a></li>
							<li><a class="imgLink" style="background-color: #86e57f;">#86e57f</a></li>
							<li><a class="imgLink" style="background-color: #5cd1e5;">#5cd1e5</a></li>
							<li><a class="imgLink" style="background-color: #6799ff;">#6799ff</a></li>
							<li><a class="imgLink" style="background-color: #6b66ff;">#6b66ff</a></li>
							<li><a class="imgLink" style="background-color: #a566ff;">#a566ff</a></li>
							<li><a class="imgLink" style="background-color: #f361dc;">#f361dc</a></li>
							<li><a class="imgLink" style="background-color: #f361a6;">#f361a6</a></li>
							<li><a class="imgLink" style="background-color: #a6a6a6;">#a6a6a6</a></li>
							<li><a class="imgLink" style="background-color: #8c8c8c;">#8c8c8c</a></li>
							<li><a class="imgLink" style="background-color: #cc3d3d;">#cc3d3d</a></li>
							<li><a class="imgLink" style="background-color: #cc723d;">#cc723d</a></li>
							<li><a class="imgLink" style="background-color: #cca63d;">#cca63d</a></li>
							<li><a class="imgLink" style="background-color: #c4b73b;">#c4b73b</a></li>
							<li><a class="imgLink" style="background-color: #9fc93c;">#9fc93c</a></li>
							<li><a class="imgLink" style="background-color: #47c83e;">#47c83e</a></li>
							<li><a class="imgLink" style="background-color: #3db7cc;">#3db7cc</a></li>
							<li><a class="imgLink" style="background-color: #4374d9;">#4374d9</a></li>
							<li><a class="imgLink" style="background-color: #4641d9;">#4641d9</a></li>
							<li><a class="imgLink" style="background-color: #8041d9;">#8041d9</a></li>
							<li><a class="imgLink" style="background-color: #d941c5;">#d941c5</a></li>
							<li><a class="imgLink" style="background-color: #d9418c;">#d9418c</a></li>
							<li><a class="imgLink" style="background-color: #747474;">#747474</a></li>
							<li><a class="imgLink" style="background-color: #5d5d5d;">#5d5d5d</a></li>
							<li><a class="imgLink" style="background-color: #980000;">#980000</a></li>
							<li><a class="imgLink" style="background-color: #993800;">#993800</a></li>
							<li><a class="imgLink" style="background-color: #997000;">#997000</a></li>
							<li><a class="imgLink" style="background-color: #998a00;">#998a00</a></li>
							<li><a class="imgLink" style="background-color: #6b9900;">#6b9900</a></li>
							<li><a class="imgLink" style="background-color: #2f9d27;">#2f9d27</a></li>
							<li><a class="imgLink" style="background-color: #008299;">#008299</a></li>
							<li><a class="imgLink" style="background-color: #003399;">#003399</a></li>
							<li><a class="imgLink" style="background-color: #050099;">#050099</a></li>
							<li><a class="imgLink" style="background-color: #3f0099;">#3f0099</a></li>
							<li><a class="imgLink" style="background-color: #990085;">#990085</a></li>
							<li><a class="imgLink" style="background-color: #99004c;">#99004c</a></li>
							<li><a class="imgLink" style="background-color: #4c4c4c;">#4c4c4c</a></li>
							<li><a class="imgLink" style="background-color: #353535;">#353535</a></li>
							<li><a class="imgLink" style="background-color: #670000;">#670000</a></li>
							<li><a class="imgLink" style="background-color: #662500;">#662500</a></li>
							<li><a class="imgLink" style="background-color: #664b00;">#664b00</a></li>
							<li><a class="imgLink" style="background-color: #665c00;">#665c00</a></li>
							<li><a class="imgLink" style="background-color: #476600;">#476600</a></li>
							<li><a class="imgLink" style="background-color: #22741c;">#22741c</a></li>
							<li><a class="imgLink" style="background-color: #005766;">#005766</a></li>
							<li><a class="imgLink" style="background-color: #002266;">#002266</a></li>
							<li><a class="imgLink" style="background-color: #030066;">#030066</a></li>
							<li><a class="imgLink" style="background-color: #2a0066;">#2a0066</a></li>
							<li><a class="imgLink" style="background-color: #660058;">#660058</a></li>
							<li><a class="imgLink" style="background-color: #660033;">#660033</a></li>
							<li><a class="imgLink" style="background-color: #212121;">#212121</a></li>
							<li><a class="imgLink" style="background-color: #191919;">#191919</a></li>
						</c:if>
						<%--END::선명한색--%>
					</ul>
				</div>
			</c:if>
			<%--END::스킨/배경(색상)--%>
			<%--BEGIN::스킨/배경(직접올리기)--%>
			<c:if test="${edForm.ggum3rdMenu == 'user'}">
				<div class="rmd2_sub_div"></div>
				<div id="BackgroundUpload">
					<div id="backgroundUpImg">
						<a id="delPhoto" class="imgLink" onclick="cfGGum.getTplMngr().delPreviewImage();">삭제</a>
						<img id="cafeBackgroundImageThumbnail" width="98" height="98" alt="배경썸네일" src="../cola/cafe/each/<c:out value="${cmntVO.cmntId }"/>/SKIN_CAFE_BG_IMG"/>
					</div>
					<div class="backgroundUpConfig">
						<ul class="configUl">
							<li class="configList configList_double" style="z-index: 4">
								<div>
									<label>이미지</label>
									<form id="skinBgFileForm" name="skinBgFileForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
										<input id="skinBgFile" class="skinBgFile" name="file" type="file" onchange="cfGGum.getTplMngr().uploadSkinBgImage();" />
									</form>
								</div>
								<iframe id="skinCafeBgIFrame" name="skinCafeBgIFrame" frameborder=0 width=0 height=0></iframe>
								<p class="backgroundUpHelp home_stxt_999">1MB 이하 / jpg, gif</p>
								<p class="backgroundUpNotice home_stxt_999">가로 1024px 이상</p>
							</li>
							<li class="configList" style="z-index: 3">
								<label>크기</label>
								<select id="cafeBackgroundImageRepeat" disabled="disabled">
									<option selected="selected" value="no-repeat">원래크기</option>
									<option value="repeat-x">가로반복</option>
									<option value="repeat-y">세로반복</option>
									<option value="repeat">전체반복</option>
								</select>
							</li>
							<li class="configList" style="z-index: 2">
								<label>정렬</label>
								<div id="CAFEBACKGROUND_bgImgPos" class="positionSelectBox_styled">
									<div id="CF0802_bgImgPos" class="positionSelectBox_viewer alignPickerPanel" style="background-position: center bottom;"></div>
									<div id="CF0802_bgImgPosMask" class="colorSelectDisabled"></div>
								</div>
							</li>
							<li class="configList" style="z-index: 1">
								<label>바탕색</label>
								<div id="CAFEBACKGROUND_bgcolor" class="colorSelectBox_styled" style="background-color: rgb(249, 250, 244);">
									  <div id="CF0802_bgColor" class="colorViewer"></div>
									  <div id="CF0802_bgColorMask" class="colorSelectDisabled"></div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</c:if>
			<%--END::스킨/배경(직접올리기)--%>
		</div>
	</c:if>
</c:if>
<%--END::스킨/배경--%>
<%--BEGIN::레이아웃/단구성--%>
<c:if test="${edForm.ggumMenu == 'layout'}">
		  <div id="ColumnViewContent" <c:if test="${edForm.ggumSubMenu != 'frame'}">style="display:none;"</c:if>>
			<ul class="layout_style layout_style1">
			  <li>
				<div id="LayoutIcon_ONE" class="layout_type gg_layout_type_ONE" onclick="cfGGum.getLayMngr().selectFrameLay('ONE'); return false;"></div>
				<a class="home_stxt_999" onclick="cfGGum.getLayMngr().selectFrameLay('ONE'); return false;" href="#"> 1컬럼 </a>
			  </li>
			  <li>
				<div id="LayoutIcon_TWO1" class="layout_type gg_layout_type_TWO1" onclick="cfGGum.getLayMngr().selectFrameLay('TWO1'); return false;"></div>
				<a class="home_stxt_999" onclick="cfGGum.getLayMngr().selectFrameLay('TWO1'); return false;" href="#"> 2컬럼1형 </a>
			  </li>
			  <li>
				<div id="LayoutIcon_THREE1" class="layout_type gg_layout_type_THREE1" onclick="cfGGum.getLayMngr().selectFrameLay('THREE1'); return false;"></div>
				<a class="home_stxt_999" onclick="cfGGum.getLayMngr().selectFrameLay('THREE1'); return false;" href="#"> 3컬럼1형 </a>
			  </li>
			  <li>
				<div id="LayoutIcon_THREE2" class="layout_type gg_layout_type_THREE2" onclick="cfGGum.getLayMngr().selectFrameLay('THREE2'); return false;"></div>
				<a class="home_stxt_999" onclick="cfGGum.getLayMngr().selectFrameLay('THREE2'); return false;" href="#"> 3컬럼2형 </a>
			  </li>
			</ul>
			<div class="clear_line"></div>
			<ul class="layout_style layout_style2">
			  <li>
				<div id="LayoutIcon_TWO2" class="layout_type gg_layout_type_TWO2" onclick="cfGGum.getLayMngr().selectFrameLay('TWO2'); return false;"></div>
				<a class="home_stxt_999" onclick="cfGGum.getLayMngr().selectFrameLay('TWO2'); return false;" href="#"> 2컬럼2형 </a>
			  </li>
			  <li>
				<div id="LayoutIcon_THREE3" class="layout_type gg_layout_type_THREE3" onclick="cfGGum.getLayMngr().selectFrameLay('THREE3'); return false;"></div>
				<a class="home_stxt_999" onclick="cfGGum.getLayMngr().selectFrameLay('THREE3'); return false;" href="#"> 3컬럼3형 </a>
			  </li>
			  <li>
				<div id="LayoutIcon_THREE4" class="layout_type gg_layout_type_THREE4" onclick="cfGGum.getLayMngr().selectFrameLay('THREE4'); return false;"></div>
				<a class="home_stxt_999" onclick="cfGGum.getLayMngr().selectFrameLay('THREE4'); return false;" href="#"> 3컬럼4형 </a>
			  </li>			
			</ul>
		  </div>
<%--END::레이아웃/단구성--%>
<%--BEGIN::레이아웃/홈게시판--%>
	<c:if test="${edForm.ggumSubMenu == 'board'}">
		  <div id="HomeBoardGroupLayout">
			<div class="homeBoardGroupView_top">
			  <div class="homeBoardGroupView_info">
				게시판 :
				<span id="curBoardCnt" class="numberCntSp">1</span>
				/ 7개
			  </div>
			  <!-- div id="HomeBoardGroupTip" class="tip_icon"></div-->
			</div>
			<p class="homeBoardGroup_help home_stxt_999">카페 홈에 추가할 게시판의 레이아웃을 선택해 주세요.</p>
			<ul class="homeboardgroup_layout">
			  <li class="first">
				<div id="BoardLayoutIcon_FLT10" class="layout_type gg_layout_FLT10" onclick="cfGGum.getLayMngr().selectBoardLay('FLT10');return false;"> layout_TYPE_1 </div>
			  </li>
			  <li>
				<div id="BoardLayoutIcon_MLT10_MRT10" class="layout_type gg_layout_MLT10_MRT10" onclick="cfGGum.getLayMngr().selectBoardLay('MLT10_MRT10');return false;"> layout_TYPE_2 </div>
			  </li>
			  <li>
				<div id="BoardLayoutIcon_FLT20" class="layout_type gg_layout_FLT20" onclick="cfGGum.getLayMngr().selectBoardLay('FLT20');return false;"> layout_TYPE_3 </div>
			  </li>
			  <li class="first">
				<div id="BoardLayoutIcon_MLT20_MRT20" class="layout_type gg_layout_MLT20_MRT20" onclick="cfGGum.getLayMngr().selectBoardLay('MLT20_MRT20');return false;"> layout_TYPE_4 </div>
			  </li>
			  <li>
				<div id="BoardLayoutIcon_MLT20_MRT10_MRB10" class="layout_type gg_layout_MLT20_MRT10_MRB10" onclick="cfGGum.getLayMngr().selectBoardLay('MLT20_MRT10_MRB10');return false;"> layout_TYPE_5 </div>
			  </li>
			  <li>
				<div id="BoardLayoutIcon_MLT10_MRT20_MLB10" class="layout_type gg_layout_MLT10_MRT20_MLB10" onclick="cfGGum.getLayMngr().selectBoardLay('MLT10_MRT20_MLB10');return false;"> layout_TYPE_6 </div>
			  </li>			
			</ul>
		  </div>
	</c:if>
<%--END::레이아웃/홈게시판--%>
<%--BEGIN::레이아웃/컨텐츠--%>
	<c:if test="${edForm.ggumSubMenu == 'cntt'}">
		  <div id="HomContentsList">
			<ul class="contents_remocon">
			  <li>
				<img id="d2w_cb_ENTRANCE" class="img_checkbox cb_checked" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_ENTRANCE" class="checkradio_styled" type="checkbox" checked="checked" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('ENTRANCE')" value="대문">
				<label class="hand" for="cb_ENTRANCE">대문</label>
			  </li>
			  <li>
				<img id="d2w_cb_CAFEON" class="img_checkbox cb_checked" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_CAFEON" class="checkradio_styled" type="checkbox" checked="checked" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('CAFEON')" value="채팅">
				<label class="hand" for="cb_CAFEON">채팅</label>
				<span class="content_bar txt_999">|</span>
				<a id="cbs_CAFEON" class="home_stxt_999 contents_config" style="color:#DDD;" onclick="(new cube.controller.home.HomeContentsController()).onClickChatingToggle(); return false;" href="#">설정</a>
			  </li>
			  <li>
				<img id="d2w_cb_BGMPLAYER" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_BGMPLAYER" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('BGMPLAYER')" value="배경음악">
				<label class="hand" for="cb_BGMPLAYER">배경음악</label>
			  </li>
			  <li>
				<img id="d2w_cb_CAFERSS" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_CAFERSS" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('CAFERSS')" value="카페 RSS">
				<label class="hand" for="cb_CAFERSS">카페 RSS</label>
			  </li>
			  <li>
				<img id="d2w_cb_CAFESTAT" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_CAFESTAT" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('CAFESTAT')" value="카페 통계">
				<label class="hand" for="cb_CAFESTAT">카페 통계</label>
			  </li>
			  <li>
				<img id="d2w_cb_MEMBERNOTICE" class="img_checkbox cb_checked" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_MEMBERNOTICE" class="checkradio_styled" type="checkbox" checked="checked" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('MEMBERNOTICE')" value="회원알림">
				<label class="hand" for="cb_MEMBERNOTICE">회원알림</label>
			  </li>
			  <li>
				<span class="fl">
				  <img id="d2w_cb_CAFEWEBINSIDE" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				  <input id="cb_CAFEWEBINSIDE" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('CAFEWEBINSIDE')" value="카페인기검색어">
				  <label class="hand" for="cb_CAFEWEBINSIDE">카페인기검색어</label>
				</span>
				<span id="cafeWebInsideTip" class="tip_icon"></span>
			  </li>
			  <li>
				<span class="fl">
				  <img id="d2w_cb_BUSINESSINFO" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				  <input id="cb_BUSINESSINFO" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('BUSINESSINFO')" value="사업자 정보">
				  <label class="hand" for="cb_BUSINESSINFO">사업자 정보</label>
				  <span class="content_bar txt_999">|</span>
				  <a id="cbs_BUSINESSINFO" class="home_stxt_999 contents_config" style="color:#DDD;" onclick="(new cube.controller.home.HomeContentsController()).onClickBusinessInfoConfig(); return false;" href="#">설정</a>
				</span>
				<span id="businessInfoTip" class="tip_icon"></span>
			  </li>
			  <li>
				<img id="d2w_cb_FRIENDCAFE" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_FRIENDCAFE" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('FRIENDCAFE')" value="친구카페">
				<label class="hand" for="cb_FRIENDCAFE">친구카페</label>
				<span class="content_bar txt_999">|</span>
				<a id="cbs_FRIENDCAFE" class="home_stxt_999 contents_config" style="color:#DDD;" onclick="(new cube.controller.home.HomeContentsController()).onClickFriendCafeToggle(); return false;" href="#">설정</a>
			  </li>			
			</ul>
			<ul class="contents_remocon right_remocon">
			  <li>
				<img id="d2w_cb_BESTMEMBER" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_BESTMEMBER" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('BESTMEMBER')" value="지난주 활동 best 회원">
				<label class="hand" for="cb_BESTMEMBER">지난주 활동 best 회원</label>
			  </li>
			  <li>
				<img id="d2w_cb_BESTARTICLE" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_BESTARTICLE" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('BESTARTICLE')" value="지난주 인기글">
				<label class="hand" for="cb_BESTARTICLE">지난주 인기글</label>
			  </li>
			  <li>
				<img id="d2w_cb_FAVORITELINK" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_FAVORITELINK" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('FAVORITELINK')" value="자주가는 링크 설정">
				<label class="hand" for="cb_FAVORITELINK">자주가는 링크 </label>
				<span class="content_bar txt_999">|</span>
				<a id="cbs_FAVORITELINK" class="home_stxt_999 contents_config" style="color:#DDD;" onclick="(new cube.controller.home.HomeContentsController()).onClickFavoritLinkConfig(); return false;" href="#">설정</a>
			  </li>
			  <li>
				<span class="fl">
				  <img id="d2w_cb_RECENTCOMMENT" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				  <input id="cb_RECENTCOMMENT" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('RECENTCOMMENT')" value="최근 댓글 보기">
				  <label class="hand" for="cb_RECENTCOMMENT">최근 댓글 보기</label>
				</span>
				<span id="recentCommentTip" class="tip_icon"></span>
			  </li>
			  <li>
				<span class="fl">
				  <img id="d2w_cb_CAFEYOZM" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				  <input id="cb_CAFEYOZM" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('CAFEYOZM')" value="우리카페 요즘">
				  <label class="hand" for="cb_CAFEYOZM">우리카페 요즘</label>
				</span>
				<span id="cafeyozmTip" class="tip_icon"></span>
			  </li>
			  <li>
				<span class="fl">
				  <img id="d2w_cb_CAFEQA" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				  <input id="cb_CAFEQA" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('CAFEQA')" value="카페 Q&A">
				  <label class="hand" for="cb_CAFEQA">카페 Q&amp;A</label>
				</span>
				<span id="cafeqnaTip" class="tip_icon"></span>
			  </li>
			  <li>
				<span class="fl">
				  <img id="d2w_cb_CAFEFAVORBOARD" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				  <input id="cb_CAFEFAVORBOARD" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('CAFEFAVORBOARD')" value="카페인기게시판">
				  <label class="hand" for="cb_CAFEFAVORBOARD">카페인기게시판</label>
				</span>
				<span id="cafeFavorTip" class="tip_icon"></span>
			  </li>
			  <li>
				<img id="d2w_cb_CAFEGAME" class="img_checkbox" width="12" height="13" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" tabindex="0">
				<input id="cb_CAFEGAME" class="checkradio_styled" type="checkbox" onclick="(new cube.controller.home.HomeContentsController()).onClickToggleComponent('CAFEGAME')" value="카페게임">
				<label class="hand" for="cb_CAFEGAME">카페게임</label>
				<span class="content_bar txt_999">|</span>
				<a id="cbs_CAFEGAME" class="home_stxt_999 contents_config" style="color:#DDD;" onclick="(new cube.controller.home.HomeContentsController()).onClickGameToggle(); return false;" href="#">설정</a>
			  </li>			
			</ul>
		  </div>
	</c:if>
<%--END::레이아웃/컨텐츠--%>
<%--BEGIN::레이아웃/위젯--%>
	<c:if test="${edForm.ggumSubMenu == 'portlet'}">
		  <div id="WidgetListRemoconTop">
			<div class="useWidget">
			  위젯
			  <span id="widgetCounter" class="numberCntSp">0</span>
			  / 20개
			</div>
			<div id="widgetCntTip" class="tip_icon"></div>
			<a id="linkMyWidget" class="home_stxt555" onclick="(new cube.controller.home.WidgetController()).onChangeWidgetViewmode(); return false;" href="#">사용중인 위젯 보기 </a>
		  </div>
		  <div id="WidgetListRemoconContent">
			<div id="WidgetListRemocon">
			  <p class="noList home_stxt999">데이터가 존재하지 않습니다.</p>
			</div>
			<div id="paging" align="center"><!--원래 align="center"는 없었다.좌측으로 정렬되어서 추가함.2012.04.25.KWShin.-->
			  <table class="pg_area" align="center">
				<tbody>
				  <tr>
					<td> </td>
				  </tr>
				</tbody>
			  </table>
			</div>
		  </div>
	</c:if>
</c:if>
<%--END::레이아웃/위젯--%>
<%--BEGIN::영역별꾸미기/카페정보--%>
<c:if test="${edForm.ggumMenu == 'ggumigi'}">
	<c:if test="${edForm.ggumSubMenu == 'info'}">
		  <div id="cafeInfoBoxContents" class="remoteZindexM">
			<%--BEGIN::영역별꾸미기/카페정보(디자인)--%>
		<c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">
			<div id="InfoSetList">
			  <ul class="info_set_block">
			  	<c:forEach items="${ infoDecoInfoList }" var="deco" varStatus="status">
				<li id="tplImg_<c:out value="${ deco.decoId }"/>" class="isb_item sub_tplImg" style="cursor: pointer;">
				  <a class="isb_thum_area" onclick="javascript:cfGGum.getTplMngr().selectTemplate('<c:out value="${ deco.decoId }"/>');">
					<img class="isb_thum" width="132" height="120" alt="" src="<c:out value="${ deco.value }"/>">
				  </a>
				</li>
				</c:forEach>
			  </ul>
			  <div id="CF0301_selectedBox" class="selectedBox"></div>
			</div>
			<div id="paging" align="center"><!--원래 align="center"는 없었다.좌측으로 정렬되어서 추가함.2012.04.25.KWShin.-->
				<input type="hidden" name="currentPage" id="currentPage" value="<c:out value="${page.currentPage}"/>">
				<table class="pg_area" align="center">
					<tbody>
						<tr>
							<td>
								<span class="pg_btn prev_btn" onclick="javascript:goPage(<c:out value="${page.currentBeforePage}"/>);" href="#">이전</span>
								<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
								<c:if test="${page.currentPage == i }"><span class="page_selected"><c:out value="${i}"/></span></c:if>
								<c:if test="${page.currentPage != i }"><a onclick="javascript:cfGGum.onClickMenu('ggumigi','info','image',<c:out value="${i}"/>); return false;" href="#"><c:out value="${i}"/></a></c:if>
								</c:forEach>
								<a class="pg_btn next_btn" onclick="javascript:goPage(<c:out value="${page.currentNextPage}"/>);" href="#">다음</a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</c:if>
			<%--END::영역별꾸미기/카페정보(디자인)--%>
			<%--BEGIN::영역별꾸미기/카페정보(색상)--%>
		<c:if test="${edForm.ggum3rdMenu == 'color'}">
			<div class="rmd2_sub_div"></div>
			<div id="CustomEditer">
			  <ul class="ce_list" style="z-index: 2">
				<li class="custom">
				  <span class="color_label_b left_nogab">바탕색</span>
				  <div id="CAFEINFOBOX_bgColor2" class="colorSelectBox_styled" style="background-image: url(../../images/editor/ggum/color_chip_clear2.gif); background-color: transparent;">
					<div id="CF0301_bgColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>
				<li class="custom">
				  <span class="color_label_b">테두리색</span>
				  <div id="CAFEINFOBOX_bgColor1" class="colorSelectBox_styled" style="background-image: url(../../images/editor/ggum/color_chip_clear2.gif); background-color: transparent;">
					<div id="CF0301_brdrColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>
			  </ul>
			  <ul class="ce_list" style="z-index: 1">
				<li class="custom">
				  <span class="color_label_b left_nogab">버튼색</span>
				  <div id="CAFEINFOBOX_buttonColor" class="colorSelectBox_styled" style="background-image: url(../../images/editor/ggum/color_chip_clear2.gif); background-color: transparent;">
					<div id="CF0301_btnBgColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				  <div class="colorPickerSl"></div>
				  <div id="CAFEINFOBOX_buttonFontColor" class="colorSelectBox_styled" style="background-color: rgb(0, 0, 0);">
					<div id="CF0301_btnFontColor" class="textColorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>
			  </ul>
			</div>
		</c:if>
		  </div>
	</c:if>
<%--END::영역별꾸미기/카페정보--%>
<%--BEGIN::영역별꾸미기/카페메뉴--%>
	<c:if test="${edForm.ggumSubMenu == 'menu'}">
		  <div id="menuControlMaster" class="remoteZindexM">
			<%--BEGIN::영역별꾸미기/카페메뉴(디자인)--%>
		<c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">
			<div id="MenuSetList">
			  <ul class="menu_set_block">
			  	<c:forEach items="${ menuDecoInfoList }" var="deco" varStatus="status">
				<li id="tplImg_<c:out value="${ deco.decoId }"/>" class="msb_item sub_tplImg" style="cursor: pointer;">
				  <a class="msb_thum_area" onclick="javascript:cfGGum.getTplMngr().selectTemplate('<c:out value="${ deco.decoId }"/>');">
					<img class="msb_thum" width="132" height="120" alt="" src="<c:out value="${ deco.value }"/>">
				  </a>
				</li>
				</c:forEach>
			  </ul>
			  <div id="CF0401_selectedBox" class="selectedBox"></div>
			</div>
			<div id="paging" align="center"><!--원래 align="center"는 없었다.좌측으로 정렬되어서 추가함.2012.04.25.KWShin.-->
			  <table class="pg_area" align="center">
				<tbody>
				  <tr>
					<td>
						<span class="pg_btn prev_btn" onclick="javascript:cfGGum.onClickMenu('ggumigi','menu','image',<c:out value="${page.currentBeforePage}"/>);" href="#">이전</span>
						<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
						<c:if test="${page.currentPage == i }"><span class="page_selected"><c:out value="${i}"/></span></c:if>
						<c:if test="${page.currentPage != i }"><a onclick="javascript:cfGGum.onClickMenu('ggumigi','menu','image',<c:out value="${i}"/>); return false;" href="#"><c:out value="${i}"/></a></c:if>
						</c:forEach>
						<a class="pg_btn next_btn" onclick="javascript:cfGGum.onClickMenu('ggumigi','menu','image',<c:out value="${page.currentNextPage}"/>);" href="#">다음</a>
					</td>
				  </tr>
				</tbody>
			  </table>
			</div>
		</c:if>
			<%--END::영역별꾸미기/카페메뉴(디자인)--%>
			<%--BEGIN::영역별꾸미기/카페메뉴(색상)--%>
		<c:if test="${edForm.ggum3rdMenu == 'color'}">
			<div class="rmd2_sub_div"></div>
			<div id="CustomEditer">
			  <ul class="ce_list" style="z-index: 2">
				<li class="custom">
				  <span class="color_label_b left_nogab" style="width: 48px">바탕색</span>
				  <div id="CAFEMENU_bgcolor" class="colorSelectBox_styled" style="background-image: url(../../images/editor/ggum/color_chip_clear2.gif); background-color: transparent;">
					<div id="CF0401_bgColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>
				<li class="custom">
				  <span class="color_label_a">테두리</span>
				  <div id="CAFEMENU_borderstyle" class="border_styler border_styler_MODEL border_styler_MODEL_CAFEMENU" style="background-position: 0px 0px; z-index: 9986;">
				  	<div id="menuBrdrDesign" class="menuBrdrDesignPicker"></div>
					<input id="CF0401_brdrDesign" type="hidden">
				  </div>
				  <div class="colorPickerSl"></div>
				  <div id="CAFEMENU_bordertype" class="border_styler border_styler_LINE_1 border_styler_MODEL_CAFEMENU" style="background-position: 0px 0px; z-index: 9985;">
				  	<div id="menuBrdrStyle" class="menuBrdrStylePicker"></div>
				  	<input id="CF0401_brdrWidth" type="hidden">
				  	<input id="CF0401_brdrStyle" type="hidden">
				  	<input id="CF0401_brdrStyle2" type="hidden">
				  	
				  </div>
				  <div class="colorPickerSl"></div>
				  <div id="CAFEMENU_bordercolor" class="colorSelectBox_styled" style="background-image: url(../../images/editor/ggum/color_chip_clear2.gif); background-color: transparent;">
					<div id="CF0401_brdrColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>			  
			  </ul>
			  <ul class="ce_list" style="z-index: 1">
				<li class="custom">
				  <span class="color_label_b left_nogab">메뉴그룹</span>
				  <div id="CAFEMENU_menugroupbgcolor" class="colorSelectBox_styled" style="background-image: url(../../images/editor/ggum/color_chip_clear2.gif); background-color: transparent;">
					<div id="CF0401_menuGrpBgColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>
				<li class="custom">
				  <span class="color_label_a">구분선</span>
				  <div id="CAFEMENU_divlinetype" class="border_styler border_styler_LINE_1" style="background-position: 0px 0px; z-index: 9984;">
					<div id="sepBrdrStyle" class="sepBrdrStylePicker"></div>
					<input id="CF0401_sepBrdrWidth" type="hidden">
				  	<input id="CF0401_sepBrdrStyle" type="hidden">
				  </div>
				  <div class="colorPickerSl"></div>
				  <div id="CAFEMENU_divlinecolor" class="colorSelectBox_styled" style="background-color: rgb(0, 0, 0);">
					<div id="CF0401_sepBrdrColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>			  
			  </ul>
			</div>
		</c:if>
			<%--END::영역별꾸미기/카페메뉴(색상)--%>
			<%--BEGIN::영역별꾸미기/카페메뉴(직접올리기)--%>
		<c:if test="${edForm.ggum3rdMenu == 'user'}">
			<div class="rmd2_sub_div"></div>
			<div id="BackgroundUpload">
			  <div class="backgroundUpImg">
				<div id="backgroundUpImg">
				  <a id="delPhoto" class="imgLink" onclick="javascript:(new cube.controller.home.CafeMenuController()).onChangeBackgroundImage('');return false;" href="#">삭제</a>
				  <img id="cafeBackgroundImageThumbnail" width="98" height="98" alt="배경썸네일" src="">
				</div>
			  </div>
			  <div class="backgroundUpConfig">
				<ul class="configUl">
				  <li class="configList configList_double" style="z-index: 5">
					<div>
					  <label>이미지</label>
					  <object id="cocacafeBackgroundImageThumbnail" class="coca_uploader" width="60" height="30" type="application/x-shockwave-flash" name="cocacafeBackgroundImageThumbnail" data="http://editor.daum.net/coca_service/1.1.13/coca.swf?ver=13">
						<param name="quality" value="high">
						<param name="menu" value="false">
						<param name="swLiveConnect" value="true">
						<param name="allowScriptAccess" value="always">
						<param name="scale" value="noscale">
						<param name="salign" value="LT">
						<param name="wmode" value="transparent">
						<param name="flashvars" value="coca_service=CafeWebzineCubeCoca&sid=cafe&service=cafe&sname=cafe&coca_ctx=cafeBackgroundImageThumbnail&jscall_prefix=CocaOption.cafeBackgroundImageThumbnail&coca_skin=../../images/editor/ggum/bt_search.gif&single_selection=true">
					  </object>
					</div>
					<p class="backgroundUpHelp home_stxt_999">1MB 이하 / jpg, gif</p>
					<p class="backgroundUpNotice home_stxt_999">가로 183px</p>
				  </li>
				  <li class="configList" style="z-index: 4">
					<label>크기</label>
					<a id="d2w_CAFEMENU_backgroundImageRepeat" class="img_selectbox_disabled" tabindex="0" style="width: 57px;">원래크기</a>
					<select id="CAFEMENU_backgroundImageRepeat" class="selectbox_styled" disabled="disabled" onchange="javascript:(new cube.controller.home.CafeMenuController()).onChangeBackgroundImageRepeat(this);">
					  <option value="no-repeat">원래크기</option>
					  <option value="repeat">전체반복</option>
					  <option value="repeat-y">세로 반복</option>
					  <option value="repeat-x">가로 반복</option>
					</select>
				  </li>
				  <li class="configList" style="z-index: 3">
					<label>정렬</label>
					<div id="CAFEMENU_backgroundImagePosition" class="positionSelectBox_styled">
					  <div id="d2w_CAFEMENU_backgroundImagePosition" class="positionSelectBox_viewer" style="background-position: right bottom;"></div>
					  <div id="d2w_CAFEMENU_backgroundImagePosition_layer" class="layer" style="display: none; background-position: right bottom;"></div>
					  <div class="__disable_layer" style="background-color: rgb(255, 255, 255); left: 0pt; top: 0pt; position: absolute; width: 19px; height: 18px; opacity: 0.5; z-index: 1;"></div>
					</div>
				  </li>
				  <li class="configList" style="z-index: 2">
					<label>바탕색</label>
					<div id="CAFEMENU_bgcolor" class="colorSelectBox_styled" style="background-image: url("../../images/editor/ggum/color_chip_clear2.gif"); background-color: transparent;">
					  <div id="d2w_CAFEMENU_bgcolor" class="colorViewer"></div>
					  <div class="colorSelectDisabled"></div>
					</div>
				  </li>
				  <li class="configList" style="z-index: 1">
					<label>구분선</label>
					<div id="CAFEMENU_divlinetype" class="border_styler border_styler_LINE_1 boardStylerDimmed" style="background-position: 0px 0px; z-index: 9983;">
					  <ul id="dw_CAFEMENU_divlinetype_targetLayer" style="display: none;">
						<li style="background-position: 0px 0px;">0px none</li>
						<li style="background-position: 0px -22px;">1px solid</li>
						<li style="background-position: 0px -44px;">2px solid</li>
						<li style="background-position: 0px -66px;">3px solid</li>
						<li style="background-position: 0px -88px;">1px dashed</li>
						<li style="background-position: 0px -110px;">1px dotted</li>
						<li style="background-position: 0px -132px;">2px dotted</li>
						<li style="background-position: 0px -154px;">3px dashed</li>
					  </ul>
					</div>
					<div class="colorPickerSl"></div>
					<div id="CAFEMENU_divlinecolor" class="colorSelectBox_styled" style="background-color: rgb(0, 0, 0);">
					  <div id="d2w_CAFEMENU_divlinecolor" class="colorViewer"></div>
					  <div class="colorSelectDisabled"></div>
					</div>
				  </li>
				</ul>
			  </div>
			</div>			
		</c:if>
			<%--END::영역별꾸미기/카페메뉴(직접올리기)--%>
		  </div>
	</c:if>
<%--END::영역별꾸미기/카페메뉴--%>
<%--BEGIN::영역별꾸미기/검색창--%>
	<c:if test="${edForm.ggumSubMenu == 'srch'}">
		  <div id="menuControlMaster" class="remoteZindexM">
			<ul id="SearchSetList">
				<c:forEach items="${ srchDecoInfoList }" var="deco" varStatus="status">
					<li id="tplImg_<c:out value="${ deco.decoId }"/>" class="ssb_item">
						<a class="ssb_thum_area" onclick="javascript:cfGGum.getTplMngr().selectTemplate('<c:out value="${ deco.decoId }"/>');">
							<img class="ssb_thum" width="284" height="50" alt="" src="<c:out value="${ deco.value }"/>">
						</a>
					</li>
				</c:forEach>
			</ul>
			<div id="CF0601_selectedBox" class="selectedBox"></div>
			<div id="paging" align="center"><!--원래 align="center"는 없었다.좌측으로 정렬되어서 추가함.2012.04.25.KWShin.-->
			  <table class="pg_area" align="center">
				<tbody>
				  <tr>
					<td>
						<span class="pg_btn prev_btn" onclick="javascript:goPage(<c:out value="${page.currentBeforePage}"/>);" href="#">이전</span>
						<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
						<c:if test="${page.currentPage == i }"><span class="page_selected"><c:out value="${i}"/></span></c:if>
						<c:if test="${page.currentPage != i }"><a onclick="javascript:cfGGum.onClickMenu('ggumigi','srch','image',<c:out value="${i}"/>); return false;" href="#"><c:out value="${i}"/></a></c:if>
						</c:forEach>
						<a class="pg_btn next_btn" onclick="javascript:goPage(<c:out value="${page.currentNextPage}"/>);" href="#">다음</a>
					</td>
				  </tr>
				</tbody>
			  </table>
			</div>
		  </div>
	</c:if>
<%--END::영역별꾸미기/검색창--%>
<%--BEGIN::영역별꾸미기/게시판--%>
	<c:if test="${edForm.ggumSubMenu == 'board'}">
		  <div id="menuControlMaster" class="remoteZindexM">
			<%--BEGIN::영역별꾸미기/게시판(디자인)--%>
		<c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">
			<div id="BoardSetList">
			  <ul class="board_set_block">
			  	<c:forEach items="${ cnttDecoInfoList }" var="deco" varStatus="status">
				<li id="tplImg_<c:out value="${ deco.decoId }"/>" class="bsb_item sub_tplImg" style="cursor: pointer;">
				  <a class="bsb_thum_area" onclick="javascript:cfGGum.getTplMngr().selectTemplate('<c:out value="${ deco.decoId }"/>');">
					<img class="bsb_thum" width="132" height="95" alt="" src="<c:out value="${ deco.value }"/>">
				  </a>
				</li>
				</c:forEach>
			  </ul>
			  <div id="CF0501_selectedBox" class="selectedBox2"></div>
			</div>
			<div id="paging" align="center"><!--원래 align="center"는 없었다.좌측으로 정렬되어서 추가함.2012.04.25.KWShin.-->
			  <table class="pg_area" align="center">
				<tbody>
				  <tr>
					<td>
					  <span class="pg_btn prev_btn" onclick="javascript:cfGGum.onClickMenu('ggumigi','board','image',<c:out value="${page.currentBeforePage}"/>);" href="#">이전</span>
					  <c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
					  <c:if test="${page.currentPage == i }"><span class="page_selected"><c:out value="${i}"/></span></c:if>
					  <c:if test="${page.currentPage != i }">
					  <a onclick="javascript:cfGGum.onClickMenu('ggumigi','board','image',<c:out value="${i}"/>); return false;" href="#"><c:out value="${i}"/></a></c:if>
					  </c:forEach>
					  <a class="pg_btn next_btn" onclick="javascript:cfGGum.onClickMenu('ggumigi','board','image',<c:out value="${page.currentNextPage}"/>);" href="#">다음</a>
					</td>
				  </tr>
				</tbody>
			  </table>
			</div>
		</c:if>
			<%--END::영역별꾸미기/게시판(디자인)--%>
			<%--BEGIN::영역별꾸미기/게시판(색상)--%>
		<c:if test="${edForm.ggum3rdMenu == 'color'}">
			<div class="rmd2_sub_div"></div>
			<div id="CustomEditer">
			  <ul class="ce_list" style="z-index: 2">
				<li class="custom">
				  <span class="color_label_b left_nogab" style="width: 76px">테두리 종류</span>
				  <div id="CAFEBOARD_linetype1" class="border_styler" style="background-position: 0px 0px; z-index: 9976;">
					<div id="boardBrdrKind" class="boardBrdrKindPicker"></div>
				  	<input id="boardStyleIndex" type="hidden">
				  	<input id="CF0501_nmBrdrStyle" type="hidden">
				  	<input id="CF0501_nmBrdrWidth" type="hidden">
				  </div>
				</li>
			  </ul>
			  <ul class="ce_list" style="z-index: 1">
				<li class="custom">
				  <span class="color_label_b left_nogab">테두리 디자인</span>
				  <div id="CAFEBOARD_linetype2" class="border_styler" style="background-position: 0px 0px; z-index: 9975;">
					<div id="boardBrdrDesign" class="boardBrdrDesignPicker"></div>
					<input id="CF0501_sepBrdrWidth" type="hidden">
				  </div>
				  <span class="colorChipGab"></span>
				  <div id="CAFEBOARD_linecolor" class="colorSelectBox_styled" style="background-color: rgb(0, 0, 0);">
					<div id="CF0501_nmBrdrColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>
			  </ul>
			  <p>
			  게시판 타이틀바의 테두리를 디자인 하는 옵션입니다.
			  <br>
			  현재 설정은 카페 홈에만 적용됩니다.
			  </p>
			</div>
		</c:if>
			<%--END::영역별꾸미기/게시판(색상)--%>
		  </div>
	</c:if>
<%--END::영역별꾸미기/게시판--%>
<%--BEGIN::영역별꾸미기/부가컨텐츠--%>
	<c:if test="${edForm.ggumSubMenu == 'buga'}">
		  <div id="AccessaryGroupContents" class="remoteZindexM">
			<%--BEGIN::영역별꾸미기/부가컨텐츠(디자인)--%>
		<c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">
			<ul id="AccessarySetList">
			  <li id="accssaryDesignSet10649" class="asb_item">
				<a class="asb_thum_area" onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onApplyDesignSet('10649');return false;" href="#">
				  <img class="asb_thum" width="82" height="85" alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/component/b03_4_comp.gif">
				</a>
			  </li>
			  <li id="accssaryDesignSet10645" class="asb_item">
				<a class="asb_thum_area" onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onApplyDesignSet('10645');return false;" href="#">
				  <img class="asb_thum" width="82" height="85" alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/component/b03_5_comp.gif">
				</a>
			  </li>
			  <li id="accssaryDesignSet10415" class="asb_item">
				<a class="asb_thum_area" onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onApplyDesignSet('10415');return false;" href="#">
				  <img class="asb_thum" width="82" height="85" alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/component/b04_2_comp.gif">
				</a>
			  </li>
			  <li id="accssaryDesignSet10467" class="asb_item">
				<a class="asb_thum_area" onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onApplyDesignSet('10467');return false;" href="#">
				  <img class="asb_thum" width="82" height="85" alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/component/b04_5_comp.gif">
				</a>
			  </li>
			  <li id="accssaryDesignSet10381" class="asb_item">
				<a class="asb_thum_area" onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onApplyDesignSet('10381');return false;" href="#">
				  <img class="asb_thum" width="82" height="85" alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/component/b02_4_comp.gif">
				</a>
			  </li>
			  <li id="accssaryDesignSet10393" class="asb_item">
				<a class="asb_thum_area" onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onApplyDesignSet('10393');return false;" href="#">
				  <img class="asb_thum" width="82" height="85" alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/component/b02_5_comp.gif">
				</a>
			  </li>
			</ul>
			<div id="paging" align="center"><!--원래 align="center"는 없었다.좌측으로 정렬되어서 추가함.2012.04.25.KWShin.-->
			  <table class="pg_area" align="center">
				<tbody>
				  <tr>
					<td>
					  <span class="pg_btn prev_btn">이전</span>
					  <span class="page_selected">1</span>
					  <a onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onPageSelected('10649', '10393', '2', '1');return false;" href="#">2</a>
					  <a onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onPageSelected('10649', '10393', '3', '1');return false;" href="#">3</a>
					  <a onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onPageSelected('10649', '10393', '4', '1');return false;" href="#">4</a>
					  <a onclick="javascript:(new cube.controller.home.AccessaryGroupController()).onPageSelected('10649', '10393', '5', '1');return false;" href="#">5</a>
					  <span class="pg_btn next_btn">다음</span>
					</td>
				  </tr>
				</tbody>
			  </table>
			</div>
		</c:if>
			<%--END::영역별꾸미기/부가컨텐츠(디자인)--%>
			<%--BEGIN::영역별꾸미기/부가컨텐츠(색상)--%>
		<c:if test="${edForm.ggum3rdMenu == 'color'}">
			<div class="rmd2_sub_div"></div>
			<div id="CustomEditer">
			  <ul class="ce_list" style="z-index: 2">
				<li class="custom">
				  <span class="color_label_b left_nogab" style="width: 36px">바탕색</span>
				  <div id="ACCESSARY_bgColor" class="colorSelectBox_styled" style="background-image: url("../../images/editor/ggum/color_chip_clear2.gif"); background-color: transparent;">
					<div id="d2w_ACCESSARY_bgColor" class="colorViewer"></div>
					<div class="colorSelectEnabled"></div>
				  </div>
				</li>
			  </ul>
			  <ul class="ce_list" style="z-index: 1">
				<li class="custom">
				  <span class="color_label_b left_nogab">테두리</span>
				  <div id="ACCESSARY_borderStyle" class="border_styler border_styler_LINE_1" style="background-position: 0px 0px; z-index: 9971;">
					<ul id="dw_ACCESSARY_borderStyle_targetLayer" style="display: none;">
					  <li style="background-position: 0px 0px;">0px none</li>
					  <li style="background-position: 0px -22px;">1px solid</li>
					  <li style="background-position: 0px -44px;">2px solid</li>
					  <li style="background-position: 0px -66px;">3px solid</li>
					  <li style="background-position: 0px -88px;">1px dashed</li>
					  <li style="background-position: 0px -110px;">1px dotted</li>
					  <li style="background-position: 0px -132px;">2px dotted</li>
					  <li style="background-position: 0px -154px;">3px dashed</li>
					</ul>
				  </div>
				  <div class="colorPickerSl"></div>
				  <div id="ACCESSARY_borderColor" class="colorSelectBox_styled" style="background-color: rgb(0, 0, 0);">
					<div id="d2w_ACCESSARY_borderColor" class="colorViewer"></div>
					<div class="colorSelectDisabled"></div>
				  </div>
				</li>
			  </ul>
			  <p>
			  색상을 이용하여 직접 꾸미는 방식입니다.
			  <br>
			  리모컨 하단의 미리보기를 확인하면서 사용하시면 편리합니다.
			  </p>
			</div>
		</c:if>
			<%--END::영역별꾸미기/부가컨텐츠(색상)--%>
		  </div>
	</c:if>
</c:if>
<%--END::영역별꾸미기/부가컨텐츠--%>
<%--END::영역별꾸미기/카페정보(색상)--%>
<div id="decoTemplates">
	<input type="hidden" id="decoPrefs" name="decoPrefs" value="[ 
		<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
		{ clazz:'<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	]"/>
</div>