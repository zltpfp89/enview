$(document).ready(function(){
	pageInit();
});

var z9050VOMap = new Object();
var isInitStyleQcell = false;
var rowIdx ;	//선택한 인덱스 전역변수관리
var qcell;

//화면 진입시 동작함
function pageInit(){
	selectList();
	
	//이벤트바인딩
	eventSetup();
}

//리스트
function selectList(){
	
}

//이벤트 세팅
function eventSetup() {
	
}