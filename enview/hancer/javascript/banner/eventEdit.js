//<!--
if( ! window.enboard )
    window.enboard = new Object();

String.prototype.trim = function() {
	  return this.replace(/(^\s*)|(\s*$)/gi, "");
}

enboard.edit = function() {
	this.limitCount  = 0;
	this.cmd         = '';
	this.sizeSF      = '';
	this.isCancel    = true;
	this.fileList    = '';
	this.totDelFileList = '';
	this.userType = '';
	this.langKnd = '';
}

enboard.edit.prototype = {

	limitCount  : null,
	cmd         : null,
	sizeSF      : null,
	isCancel    : null,
	fileList    : null,
	totDelFileList : null, // 업로드된 파일 목록에서 빼온 삭제한다고 선택된 파일 목록 
	userType : null,
	langKnd : null,
	////////////////////////////////////////////
	// 1. 편집화면 window.onload시 호출된다.  //
	////////////////////////////////////////////
	edit_init : function() {
		ebEdit.limitCount  = 5;
		ebEdit.cmd         = document.setTransfer.mngMode.value; //-->WRITE/MODIFY/DELETE
		ebEdit.userType = document.setTransfer.userType.value;   //-->NORMAL/ADMIN
		ebEdit.langKnd =  document.setTransfer.langKnd.value;
		ebEdit.maskOn(document.getElementById("date1").id);
		ebEdit.maskOn(document.getElementById("date2").id);	
		ebEdit.maskOn(document.getElementById("date3").id);
		ebEdit.maskOn(document.getElementById("date4").id);
		var msg = document.setTransfer.msgYn.value;
		var stuYn = document.setTransfer.studentYn.value;
		var msgTp = document.setTransfer.msgType.value;
		var movePath = document.setTransfer.movePath.value;
		if(msg!=null && msg!="" && msg!="null" && msg!=undefined){
			if(stuYn == 'Y' && msgTp == 'add'){
				if(ebEdit.langKnd=='ko')
					alert("신청이 완료되었습니다.\n담당자 승인 전까지 수정이 가능합니다.");
				if(ebEdit.langKnd=='en')
					alert("Event registration is complete.\n It may be modified before approval.");
				top.location.href = movePath;
			}
			if(stuYn == 'N' && msgTp == 'add'){
				if(ebEdit.langKnd=='ko')
					alert("등록 되었습니다.");
				if(ebEdit.langKnd=='en')
					alert("Has been registered.");
				top.location.href = movePath;
			}
			if(msgTp == 'mod'){
				if(ebEdit.langKnd=='ko')
					alert("수정 되었습니다.");
				if(ebEdit.langKnd=='en')
					alert("Has been modified.");
			}
		}
		if(msg==null || msg=="" || msg=="null" || msg==undefined){
			if(ebEdit.langKnd=='ko')
				document.setTransfer.msgYn.value = "메세지셋팅";
			if(ebEdit.langKnd=='en')
				document.setTransfer.msgYn.value = "setMessage";
		}
	},
	maskOn : function(objId, flag){//기간입력창에 delimeter삽입
		var len = 0;
		
		if(flag == null) flag = "DAY";
		
		if(flag == "DAY") len = 8;
		else if(flag == "MONTH") len = 6;
		
		var str = (document.getElementById(objId).value).trim();
		if( str != "" && (!isDate(str,"") || str.length != len) ){
			alert("날짜 형식에 맞지 않습니다.");
			document.getElementById(objId).focus();
			return;
		}
		if(flag == "DAY"){
			document.getElementById(objId).value = str.substring(0,4)+"-"+str.substring(4,6)+"-"+str.substring(6,8);
		}else if(flag == "MONTH"){
			document.getElementById(objId).value = str.substring(0,4)+"-"+str.substring(4,6);
		}
	},
	maskOff : function(objId){//기간입력창에 delimeter삭제
		var str = (document.getElementById(objId).value).trim();
		if(str.length == 10){
			document.getElementById(objId).value = str.substring(0,4)+str.substring(5,7)+str.substring(8,10);
		}else if(str.length == 7){
			document.getElementById(objId).value = str.substring(0,4)+str.substring(5,7);		
		}
	},
	chkValue : function( obj, msg, isSet ) {
		if( obj.value.trim() == '' ) {
			alert( msg );
			if (isSet == 'true') obj.focus();
			return false;
		}
		return true;
	},
	edit_destroy : function() {
		var unDelFileList = '';
		// 취소시
		if( ebEdit.isCancel && ebEdit.limitCount > 0) {
			for( var i = 1; i < document.setFileList.list.options.length; i++ ) {
				if( document.setFileList.list.options[i].value.length > 0 ) {
					if( ebEdit.cmd == 'MODIFY' ) {
						if (ebEdit.fileList.indexOf( document.setFileList.list.options[i].value) == -1)
							unDelFileList += document.setFileList.list.options[i].value + '|';
					} else
						unDelFileList += document.setFileList.list.options[i].value + '|';
				}
			}

			document.setFileList.delList.value = unDelFileList;
			document.setFileList.unDelList.value = unDelFileList;
			//alert("취소: "+document.setFileList.delList.value+" : "+document.setFileList.unDelList.value);
		} 
		//저장시
		else if (!ebEdit.isCancel && ebEdit.limitCount > 0) {
			document.setFileList.delList.value = ebEdit.totDelFileList;
			//document.setFileList.unDelList.value = ebEdit.totDelFileList;
			//alert("저장: "+document.setFileList.delList.value+" : "+document.setFileList.unDelList.value);
		}
		
		if (document.setFileList.delList.value.length > 0) {
		//alert("setFileList.submit()");
			document.setFileList.vaccum.value = 'INDIRECT';//최종 저장할때 첨부파일삭제했을경우
			document.setFileList.submit();
		}
	},
	//얼로드프로그레스바 중지
	closeUpload : function() {
		//document.getElementById('uploading').style.display = 'none';
	},
	//////////////////////////////////////////////////////////////////////
	// 업로드 제한 파일 갯수를 체크하고, Progress bar 를 보이도록 한 뒤,// 
	// setUpload 폼을 서브밋한다.										//
	//////////////////////////////////////////////////////////////////////
	uploadFile : function() {
		if( ebEdit.limitCount > 0 ) {
			var uploadCount = 0;
			for (var i = 1; i < document.setFileList.list.length; i++) {
				if (document.setFileList.list.options[i].value.length > 0) uploadCount++;
			}

			if( ebEdit.limitCount <= uploadCount ) {
				alert('업로드파일제한갯수'+ebEdit.limitCount+'를 초과하였습니다.');
				return;
			}

			if(!this.chkValue(document.setUpload.filename, '파일명에 오류가 있습니다.' , 'true')) return;

			//업로드프로그래스바 시작
			//document.getElementById('uploading').style.display = 'inline';
			document.setUpload.submit();
		}
	},
	//////////////////////////////////////////////////////////////
	// 현재 선택된 파일을 전체 선택된 파일 목록에 추가하고,     //
	// 전체 선택된 파일 목록과 선택되지 않은 파일 목록을 서브밋.//
	//////////////////////////////////////////////////////////////
	deleteFile : function() {
		var isSelected = false;
		var curDelFileList = '';
		var unDelFileList = '';
		for (var i = 1; i < document.setFileList.list.length; i++) {
			if (document.setFileList.list.options[i].value.length > 0 &&
				document.setFileList.list.options[i].selected) {
				if( ebEdit.fileList.indexOf( document.setFileList.list.options[i].value ) > -1 )
					// 방금 선택된 파일들을 전체 삭제 파일 리스트에 추가.(기존에 있던 파일중에)
					curDelFileList += document.setFileList.list.options[i].value + '|';
				else
					unDelFileList += document.setFileList.list.options[i].value + '|';//(파일만 올리고 최종저장을 하지않은상태에서 선택)
				isSelected = true;
			}
		}	
		if (isSelected) {
			if (confirm('선택된파일을 삭제하시겠습니까?')) {
				ebEdit.totDelFileList += curDelFileList;
				document.setFileList.vaccum.value   = 'DIRECT';//사용자가 직접파일을삭제할때
				document.setFileList.delList.value   = ebEdit.totDelFileList;//(기존에 있던 파일삭제)
				document.setFileList.unDelList.value = unDelFileList;//(신규추가한파일중 최종저장안한상태에서 삭제)		
			//alert(ebEdit.fileList);				
			//alert(document.setFileList.delList.value+" : "+document.setFileList.unDelList.value);				
				document.setFileList.submit();
			}
		} else
			alert('삭제하고자 하는 파일을 선택하세요');
	},
	///////////////////////////////
	// '저장' 버튼을 눌렀을 때.  //
	///////////////////////////////
	save : function() {
		//폼에 데이터 셋팅
		document.setTransfer.cateCd.value = document.getElementById("category").options[document.getElementById("category").selectedIndex].value;	//카테고리
		document.setTransfer.stdTime.value = document.getElementById("startHour").options[document.getElementById("startHour").selectedIndex].value 
										   + document.getElementById("startMin").options[document.getElementById("startMin").selectedIndex].value;	//시작시간
		document.setTransfer.endTime.value = document.getElementById("endHour").options[document.getElementById("endHour").selectedIndex].value 
										   + document.getElementById("endMin").options[document.getElementById("endMin").selectedIndex].value;		//종료시간
		document.setTransfer.stdDate.value = document.getElementById('date1').value;		//시작일
		document.setTransfer.endDate.value = document.getElementById('date2').value; 		//종료일
		document.setTransfer.placeSubNm.value = document.getElementById('placeSub').value;  //장소세부명(2012.01.28)
		document.setTransfer.eventNmKor.value = document.getElementById("subject").value;   //제목(국문)
		document.setTransfer.eventNmEng.value = document.getElementById("subject_en").value;//제목(영문)
		document.setTransfer.targetLink.value = document.getElementById('link').value; 		//링크
		document.setTransfer.feeKor.value = document.getElementById('eventFeeKor').value;	//참가비(국문)
		document.setTransfer.feeEng.value = document.getElementById('eventFeeEng').value;	//참가비(영문)
		document.setTransfer.ownerName.value = document.getElementById('name').value; 		//담당자이름
		document.setTransfer.ownerPhone.value = document.getElementById('phone').value;		//담당자전화
		document.setTransfer.ownerEmail.value = document.getElementById('email').value;		//담당자이메일
		document.setTransfer.eventCnttKor.value = FCKeditorAPI.GetInstance('content_ko').GetData();	//내용(국문)
		document.setTransfer.eventCnttEng.value = FCKeditorAPI.GetInstance('content_en').GetData();	//내용(영문)
		

		document.setTransfer.EventStdTime.value = document.getElementById("startEventHour").options[document.getElementById("startEventHour").selectedIndex].value 
		   + document.getElementById("startEventMin").options[document.getElementById("startEventMin").selectedIndex].value;	//시작시간
		document.setTransfer.EventEndTime.value = document.getElementById("endEventHour").options[document.getElementById("endEventHour").selectedIndex].value 
		   + document.getElementById("endEventMin").options[document.getElementById("endEventMin").selectedIndex].value;		//종료시간		
		document.setTransfer.EventStdDate.value = document.getElementById('date3').value;		//시작일
		document.setTransfer.EventEndDate.value = document.getElementById('date4').value; 		//종료일
		
		
		var priorty = "";
		if(this.userType == 'ADMIN'){
			if(document.getElementById("banner").checked)
				priorty = "Y";
			else
				priorty = "N";

		document.setTransfer.priorty.value = priorty;//주요이벤트여부
		}
		//작성자는 페이지로딩시 세션의 사용자 정보를 읽어서 셋팅
		//장소는 검색팝업 닫을때 폼에 데이터 셋팅	
		//대상그룹은 검색팝업 닫을때 폼에 데이터 셋팅

		//첨부파일 관련내용 폼에셋팅
		document.setTransfer.fileName.value = "";
		document.setTransfer.fileMask.value = "";
		document.setTransfer.fileSize.value = "";
		if( ebEdit.limitCount > 0 ) {
			if( document.setFileList.list ) {
				for( var i=1; i<document.setFileList.list.options.length; i++ ) {
					if( document.setFileList.list.options[i].value.length > 0 ) {
						var ary = document.setFileList.list.options[i].value.split("-");
						document.setTransfer.fileMask.value += ary[0] + "/";
						document.setTransfer.fileSize.value += ary[1] + "/";
						// 파일명 뒤에 붙은 파일크기 정보를 잘라내고 순수한 파일명만 서버로 올린다.
						var manuFileNm = document.setFileList.list.options[i].text;
						//manuFileNm = manuFileNm.substring(0, manuFileNm.lastIndexOf("(")-1);
						document.setTransfer.fileName.value += manuFileNm + "/";
					}
				}
			}
		}
		
		ebEdit.isCancel = false;
		document.setTransfer.submit();
	}
}
var ebEdit = new enboard.edit();
//-->