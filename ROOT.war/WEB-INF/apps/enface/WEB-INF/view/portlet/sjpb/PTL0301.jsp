<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="portlet_02 fixation">
	<h2>(본인)사건현황</h2>
	<div class="sub_status"> 
		<a href="#" class="internal"><span class="txt">내사 <br /><em>${vo.secinv }건</em></span></a>
		<a href="#" class="recognition"><span class="txt">인지 <br /><em>${vo.papstmp }건</em></span></a>
		<a href="#" class="qings"><span class="txt">입건 <br /><em>${vo.prsct }건</em></span></a>
		<a href="#" class="numeral"><span class="txt">수사 <br /><em>${vo.invst }건</em></span></a>
		<a href="#" class="command_case"><span class="txt">수사지휘권 <br /><em>${vo.invstCmnd }건</em></span></a>
		<a href="#" class="songchi"><span class="txt">송치 <br /><em>${vo.trnsr }건</em></span></a>
		<a href="#" class="disposition"><span class="txt">처분 <br /><em>${vo.dsps }건</em></span></a>
	</div>    
	<a href="#" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
</div>

