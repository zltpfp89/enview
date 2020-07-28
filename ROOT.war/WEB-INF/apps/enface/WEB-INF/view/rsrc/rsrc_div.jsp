<%@page contentType="text/html; charset=utf-8"%>
<form id="reserve_frm">
<!-- GNB090506xx start -->
    <div class="sub_layer_popup" id="reserve_pop" style="width:600px; display:none; margin-top:-300px; margin-left:-300px;" >
        <div class="layer_popup_header">자원예약
            <a class="popup_close" title="닫기" >닫기</a>
        </div>
        <div class="layer_popup_white">
            <div class="layerpopup_top">
                <div class="layerpopup_L">
                    자원 [0-별관] KRC아트홀
                </div>
            </div>
            <table class="popup_board_table" summary="자원예약">
                <caption>자원예약</caption>
                <colgroup>
                    <col style="width:120px;" />
                    <col style="width:auto;" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">예약일시</th>
                        <td>
                            <script>
                            	$(function() {
                            		$( "#opr_strt_dt, #opr_end_tm" ).datepicker({
                           				dateFormat:'yy.mm.dd',
                           				showOn: "both",
                           				buttonImage: "${cPath }/sjpb/reference/images/icon_calendar.png",
                           				buttonImageOnly: true,
                           				buttonText: "일자선택"
                            		});
                            		
                            		// 시작일자를 지정하면 종료일자를 시작일자 이후로만 지정되도록 처리
                            		// 종료일자는 오늘 이전을 지정 할 수 없다.
                            		$("#opr_end_tm").datepicker("option", "minDate", $("#opr_strt_dt").val());
                            		$("#opr_strt_dt").datepicker("option", "onClose", function (date) {
                            			$("#opr_end_tm").datepicker("option", "minDate", date);
                            		});
                            	});
                            </script>
                            <label for="" class="cursor"><input type="text" id="opr_strt_dt" name="" readonly   class="w80" maxlength="" /> <img src="${cPath}/sjpb/reference/images/icon_calendar.png" alt="" /></label>
                            <select name="opr_strt_tm">
                                <option value="0900">09:00</option>
	                            <option value="0930">09:30</option>
	                            <option value="1000">10:00</option>
	                            <option value="1030">10:30</option>
	                            <option value="1100">11:00</option>
	                            <option value="1130">11:30</option>
	                            <option value="1200">12:00</option>
	                            <option value="1230">12:30</option>
	                            <option value="1300">13:00</option>
	                            <option value="1330">13:30</option>
	                            <option value="1400">14:00</option>
	                            <option value="1430">14:30</option>
	                            <option value="1500">15:00</option>
	                            <option value="1530">15:30</option>
	                            <option value="1600">16:00</option>
	                            <option value="1630">16:30</option>
	                            <option value="1700">17:00</option>
	                            <option value="1730">17:30</option>
	                            <option value="1800">18:00</option>
	                            <option value="1830">18:30</option>
                            </select>
                            ~ 
                            <label for="" class="cursor"><input type="text" id="opr_end_tm" name="" readonly   class="w80" maxlength="" /> <img src="${cPath}/sjpb/reference/images/icon_calendar.png" alt="" /></label>             
                            <select name="opr_end_tm">
                                <option value="0900">09:00</option>
                                <option value="0930">09:30</option>
                                <option value="1000">10:00</option>
                                <option value="1030">10:30</option>
                                <option value="1100">11:00</option>
                                <option value="1130">11:30</option>
                                <option value="1200">12:00</option>
                                <option value="1230">12:30</option>
                                <option value="1300">13:00</option>
                                <option value="1330">13:30</option>
                                <option value="1400">14:00</option>
                                <option value="1430">14:30</option>
                                <option value="1500">15:00</option>
                                <option value="1530">15:30</option>
                                <option value="1600">16:00</option>
                                <option value="1630">16:30</option>
                                <option value="1700">17:00</option>
                                <option value="1730">17:30</option>
                                <option value="1800">18:00</option>
                                <option value="1830">18:30</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">신청자</th>
                        <td><label id="req_usr_nm"></label></td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="opr_use_plc">사용장소</label></th>
                        <td><input type="text" name="opr_use_plc"  maxlength=""  class="w_p100" id="opr_use_plc" /></td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="opr_cntns">사용목적</label></th>
                        <td><input type="text" name=""  maxlength=""  class="w_p100" id="opr_cntns" /></td>
                    </tr>
<!--                     <tr> -->
<!--                         <th scope="row"><label for="opr_use_cntns">참석대상</label></th> -->
<!--                         <td><input type="text" name="opr_use_cntns"  maxlength=""  class="w_p100" id="opr_use_cntns" placeholder="(입력 예 : ooo외 00명)" /></td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th scope="row">자원위치</th> -->
<!--                         <td><label id="rsrc_lctn"></label></td> -->
<!--                     </tr> -->
                    <tr>
                        <th scope="row">자원설명</th>
                        <td><label id="rsrc_cntns"></label></td>
                    </tr>
<!--                     <tr> -->
<!--                         <th scope="row">좌석수</th> -->
<!--                         <td><label id="rsrc_cnt"></label></td> -->
<!--                     </tr> -->
                    <tr>
                        <th scope="row">운영자</th>
                        <td><label id="rsrc_mgt_nm"></label></td>
                    </tr>
                    <tr>
                        <th scope="row">신청가능일</th>
                        <td><label id="rsrc_ddcnt"></label></td>
                    </tr>
                </tbody>
            </table>
            <div class="layerpopup_bottom tx_c">
                <a href="#" class="btn_black">신청</a>
                <a href="#" class="btn_orange">닫기</a>
                <a href="#" class="btn_black">수정</a>
                <a href="#" class="btn_black">삭제</a>
                <a href="#" class="btn_orange">닫기</a>
                <!-- //사용관리등록 -->
            </div>
        </div>
    </div>
    <div class="sub_layer_popup" id="resource_reg_pop" style="width:600px; display:block; margin-top:-500px; margin-left:-300px;">
        <div class="layer_popup_header">자원관리
            <a class="popup_close" title="닫기" >닫기</a>
        </div>
        <div class="layer_popup_white">
            <table class="popup_board_table " summary="자원관리">
                <caption>자원관리</caption>
                <colgroup>
                    <col style="width:140px" />
                    <col style="auto" />
                </colgroup>
                <tbody>
                    <tr>
                        <th class="" scope="row"><label for="">자원구분</label></th>
                        <td>
                            <select name=""  >
                                <option>지역선택</option>
                            </select>
                            <select name=""   >
                                <option>자원종류선택</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="">자원부서</label></th>
                        <td>
                            <div>
                                <select name=""  >
                                    <option>지역선택</option>
                                </select>
                            </div>
                            <ul class="label_list">
                                <li><label><input type="checkbox" name="" value="" /> 운영자1</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자2</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자3</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자4</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자5</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자6</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자7</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자8</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자9</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자10</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자11</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자12</label></li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="ResourcesName">자원명</label></th>
                        <td><input type="text" name=""  maxlength=""  class="w_p100" id="ResourcesName" /></td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="ResourcesPos">위치</label></th>
                        <td><input type="text" name=""  maxlength=""  class="w_p100" id="ResourcesPos" /></td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="">좌석수</label></th>
                        <td><input type="text" name=""  maxlength=""  id="" class="w60"/></td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="ResourcesTxt">자원설명</label></th>
                        <td><textarea class="" id="ResourcesTxt"></textarea></td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="ResourcesResv">예약신청가능일</label></th>
                        <td><input type="text" name=""  maxlength="3"  id="ResourcesResv"  class="w60"/> 일전</td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="file">사진</label></th>
                        <td>
                            <div class="file_list">
                                <div>최대개수 <span>1개까지</span> 제한(0:무한대)｜파일용량:<span>10Byte</span></div>
                                <ul>
                                    <li><img src="images/icon_file_small.gif" alt="업무소식지_1.hwp" /> 업무소식지_1.hwp(12KB)</li>
                                    <li><img src="images/icon_file_small.gif" alt="업무소식지_1.hwp" /> 업무소식지_2.hwp(12KB)</li>
                                    <li><img src="images/icon_file_small.gif" alt="업무소식지_1.hwp" /> 업무소식지_3.hwp(12KB)</li>
                                    <li><img src="images/icon_file_small.gif" alt="업무소식지_1.hwp" /> 업무소식지_4.hwp(12KB)</li>
                                </ul>
                            </div>
                            <input type="file" name=""  maxlength=""  id="file"/>
                            <a href="#" class="btn_white">+ 추가</a>
                            <a href="#" class="btn_white">- 삭제</a>
                        </td>
                    </tr>

                </tbody>
            </table>
            <div class="layerpopup_bottom tx_c">
                <a href="#" class="btn_black">저장</a>
                <a href="#" class="btn_orange">닫기</a>
            </div>
        </div>
    </div>
</form>
