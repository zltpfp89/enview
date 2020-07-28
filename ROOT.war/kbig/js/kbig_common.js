//enboard paging
function fn_enboardPaging(currentPageS, totalPageS, setSizeS){
	var currentPage = currentPageS;
	var totalPage   = totalPageS;
	var setSize     = setSizeS;
	var imgUrl      = "/board/images/board/skin/enboard/";
	
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
		firstP = "<a onclick=ebList.next('1') style='cursor:pointer' href='#' class='page prev_02'>맨처음</a>";
	    cursor = startPage - 1;
		prevSet = "<a onclick=ebList.next('"+cursor+"') style='cursor:pointer' href='#' class='page prev_01'>이전</a>"; 
	} else {
		firstP = "<a href='#' class='page prev_02'>맨처음</a>";
		prevSet = "<a href='#' class='page prev_01'>이전</a>"; 
	}
		
	cursor = startPage;
	while( cursor <= endPage ) {
		if( cursor == currentPage ) 
	   		curList += "<a class='paging_click'>"+currentPage+"</a>";
		else {
	    	curList += "<a onclick=ebList.next('"+cursor+"') style='cursor:pointer'>"+cursor+"</a>";
		}
		
		cursor++;
	}
	if ( totalPage > endPage) {
		lastP = "<a onclick=ebList.next('"+totalPage+"') style='cursor:pointer' href='#' class='page next_02'>맨뒤</a>";
		cursor = endPage + 1;  
		nextSet = "<a onclick=ebList.next('"+cursor+"') style='cursor:pointer' href='#' class='page next_01'>다음</a>";
	} else {
		lastP = "<a href='#' class='page next_02'>맨뒤</a>";
		nextSet = "<a href='#' class='page next_01'>다음</a>";
	}
	
	curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
	
	document.getElementById("pageIndex").innerHTML = curList;
}


//일반 페이지
function fn_paging(currentPageS, totalPageS, setSizeS){
	var currentPage = currentPageS;
	var totalPage   = totalPageS;
	var setSize     = setSizeS;
	var imgUrl      = "/board/images/board/skin/enboard/";
	
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
		firstP = "<a onclick=fn_next('1') style='cursor:pointer' href='#' class='page prev_02'>맨처음</a>";
	    cursor = startPage - 1;
		prevSet = "<a onclick=fn_next('"+cursor+"') style='cursor:pointer' href='#' class='page prev_01'>이전</a>"; 
	} else {
		firstP = "<a href='#' class='page prev_02'>맨처음</a>";
		prevSet = "<a href='#' class='page prev_01'>이전</a>"; 
	}
		
	cursor = startPage;
	while( cursor <= endPage ) {
		if( cursor == currentPage ) 
	   		curList += "<a class='paging_click'>"+currentPage+"</a>";
		else {
	    	curList += "<a onclick=fn_next('"+cursor+"') style='cursor:pointer'>"+cursor+"</a>";
		}
		
		cursor++;
	}
	if ( totalPage > endPage) {
		lastP = "<a onclick=fn_next('"+totalPage+"') style='cursor:pointer' href='#' class='page next_02'>맨뒤</a>";
		cursor = endPage + 1;  
		nextSet = "<a onclick=fn_next('"+cursor+"') style='cursor:pointer' href='#' class='page next_01'>다음</a>";
	} else {
		lastP = "<a href='#' class='page next_02'>맨뒤</a>";
		nextSet = "<a href='#' class='page next_01'>다음</a>";
	}
	
	curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
	
	document.getElementById("pageIndex").innerHTML = curList;
}


function Josa(txt, josa)
{
	var code = txt.charCodeAt(txt.length-1) - 44032;
	var cho = 19, jung = 21, jong=28;
	var i1, i2, code1, code2;

	// 원본 문구가 없을때는 빈 문자열 반환
	if (txt.length == 0) return '';

	// 한글이 아닐때
	if (code < 0 || code > 11171) return txt;

	if (code % 28 == 0) return txt + Josa.get(josa, false);
	else return txt + Josa.get(josa, true);
}
Josa.get = function (josa, jong) {
	// jong : true면 받침있음, false면 받침없음
	if (josa == '을' || josa == '를') return (jong?'을':'를');
	if (josa == '이' || josa == '가') return (jong?'이':'가');
	if (josa == '은' || josa == '는') return (jong?'은':'는');
	if (josa == '와' || josa == '과') return (jong?'와':'과');

	// 알 수 없는 조사
	return '**';
}		


//유효성검사
function fn_valChk(form,alias){
	if(form.value==""){
		alert(alias+ Josa(alias, '을') + " 입력해주세요.");
		form.focus();
		return false;
	}
	return true;
}

function href(url){
	location.href = url
}

/*function fn_ftndate_diff(date1,date2) {
   tmp_date1 = split("-",	date1);
   tmp_date2 = split("-", 	date2);
   tmp1 = mktime(0,0,0,$tmp_date1[1], $tmp_date1[2], $tmp_date1[0]);
   tmp2 = mktime(0,0,0,$tmp_date2[1], $tmp_date2[2], $tmp_date2[0]);
 
   $return_date = ($tmp1 - $tmp2) / 86400;
 
   return $return_date;
}

function dateAdd($orgDate,$mth)
{ 
	$cd = strtotime($orgDate); 
	$retDAY = date('Y-m-d', mktime(0,0,0,date('m',$cd),date('d',$cd)+$mth,date('Y',$cd))); 
	return $retDAY; 
}

function ftndate_week($dateValue, $type){
	$weekday1 = array("일","월","화","수","목","금","토");
	$weekday2 = array("일요일","월요일","화요일","수요일","목요일","금요일","토요일");
	$weekday3 = array("SUN","MON","TUE","WED","THU","FRI","SAT");

	if($type == "a"){
		$week_name = $weekday1[date('w', strtotime($dateValue))];	
	} elseif ($type == "b") {
		$week_name = $weekday2[date('w', strtotime($dateValue))];		
	} elseif ($type == "c") {
		$week_name = $weekday3[date('w', strtotime($dateValue))];		
	} elseif ($type == "d") {
		$week_name = date('w', strtotime($dateValue));		
	}
		
	return $week_name ;
}*/

function fn_checkEmpty( id) {
	var v = $("#" + id).val();
	if( v=='') {
		var title = $("#" + id).attr('title');
		if( title==null) {
			alert( '필수 입력항목입니다')
		} else {
			alert( Josa( title, '을') + ' 입력하십시오');
		}
		
		$("#" + id).focus();
		return false;
	}
	return true;
}

function iframe_autoresize(){
	try {
		parent.iframe_autoresize();			
	} catch(e) {
		alert(e);
	}
	
}


function All_Check_dru(form_name,check_name,self){
	var form_name;
	var check_name;

	var form = eval("document.listform");
	if(self.checked==true){//전체선택.
		for(var i=0;i<form.elements.length;i++){
			if(form.elements[i].name==check_name){
				form.elements[i].checked=true;
			}
		}
	}else if(self.checked==false){//선택해제.

		for(var i=0;i<form.elements.length;i++){
			if(form.elements[i].name==check_name){
				form.elements[i].checked=false;
			}
		}
	}
}

function All_Check_Num(form,check_name,num,alias){
	var check_name;
	var j=0;
	var ls_msg = alias+"을(를) " + num + "개 이상선택해주세요";
	//alert(form);
	for(var i=0;i<form.elements.length;i++){
		if(form.elements[i].name==check_name){
			if(form.elements[i].checked==true){
				j++;
			}
		}
	}
	if(j<num){
		alert(ls_msg);
		return false;
	}else{
		return true;
	}
}
