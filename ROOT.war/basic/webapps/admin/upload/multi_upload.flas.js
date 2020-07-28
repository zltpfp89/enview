stop();

// html로 부터 받은 변수 정리
var flashWidth:Number = (flash_width)?flash_width:400;
var listRows:Number = (list_rows)?list_rows:5;
var limitSize:Number = 1024*1024*limit_size;
var fileTypeName:String = (file_type_name)?file_type_name:"모든파일";
var allowFiletype:String = (allow_filetype)?allow_filetype:"*.*";
var denyFileType:Array = deny_filetype;
var uploadId:String = upload_id;
var browserId:String = browser_id;
var uploadExe:String = upload_exe+"?upload_id="+uploadId+"&browser_id="+browserId;
var jsObject:String = flashController;

var array_denyFileType = denyFileType.split(" ");
for(i=0;i<array_denyFileType.length;i++){
	array_denyFileType[i] = array_denyFileType[i].substring(array_denyFileType[i].lastIndexOf("."), array_denyFileType[i].length);
}
var array_allowFiletype = allowFiletype.split(" ");
var string_allowFiletype:String = "";
for(i=0;i<array_allowFiletype.length;i++){
	string_allowFiletype += array_allowFiletype[i]+"; ";
}

// 플래시 크기 조절
Stage.scaleMode = "noScale";
Stage.align = "TL";
_root.setSize(flashWidth,20*listRows+25);
_root["lstFiles"].setSize(flashWidth-90,20*listRows);
_root["statusText2"]._x = flashWidth-185;
_root["thisPg"]._y = 20*listRows+30;
_root["thisPg"].proBG._width = flashWidth-90-105;
_root["thisPg"].proFG._width = 0;
_root["thisPg"].percentText._x = flashWidth-130;
_root["totalPg"]._y = 20*listRows+50;
_root["totalPg"].proBG._width = flashWidth-90-105;
_root["totalPg"].proFG._width = 0;
_root["totalPg"].percentText._x = flashWidth-130;
_root["btnBrowse"]._x = flashWidth-80;
_root["btnDelete"]._x = flashWidth-80;

// 폼요소들의 색상 설정
btnBrowse.setStyle("themeColor", 0x666666);
btnDelete.setStyle("themeColor", 0x666666);
lstFiles.setStyle("rollOverColor", 0xF0F0F0);
lstFiles.setStyle("selectionColor", 0xE0E0E0);
lstFiles.setStyle("textSelectedColor", 0x003399);

// 임시변수들
var totalSize = 0; // 첨부 파일 총 사이즈
var loadSize = 0; // 업로드된 사이즈
var fileNumber = 0; // 업로드되는 파일의 배열넘버
var list:Array = new Array(); //파일객체 리스트
var startTime; // 업로드 시작 시간
var startMtime; // 업로드 시작 마이크로 시간

// 함수
function toFixed(num, pos){ 
	var math_num = Math.round(num*100)/100;
	if(!pos) pos=0;	
	math_num = String(math_num);
	if(math_num.lastIndexOf(".")==undefined) math_num += ".";	
	var under_dot = math_num.lastIndexOf(".")+1; 
	for(var i=math_num.length - under_dot;i<pos;i++) math_num += 0;
	return math_num;
} 

function humanSize(sizeNum,n){ // 휴먼 파일 사이즈
	var hfSize:String;
	if(sizeNum>0 && sizeNum>=1048576) hfSize = toFixed(sizeNum/1024/1024 ,n)+"MB";
	else if(sizeNum>0 && sizeNum<1048576) hfSize = toFixed(sizeNum/1024 ,n)+"KB";
	else hfSize = 0+"KB";
	return hfSize;
}

function inArray(arr, str){
    for (var i=0; i < arr.length; i++) {
        if (arr[i] === str) {
            return true;
        }
    }
    return false;
}

// 파일컨트롤러 호출
import flash.net.FileReferenceList;
import flash.net.FileReference;

 // 파일선택 클릭시 파일찾기 수행
var listener:Object = new Object();
var fileRef:FileReferenceList = new FileReferenceList();
fileRef.addListener(listener);
btnBrowse.addEventListener("click",
	function(){	
		var fileTypes:Array = [{description:fileTypeName+' ('+allowFiletype+')',extension:string_allowFiletype}];
		fileRef.browse( fileTypes ); 
	}
);

function showStatus1(){
	_root["statusText1"].text = "[총 "+lstFiles.length+"개] "+humanSize(totalSize,2)+" / "+humanSize(limitSize,0); 
}
showStatus1();

listener.onSelect = function(fileRefList:FileReferenceList){ //파일선택 이벤트
	var tempList:Array = fileRefList.fileList;
	var item:FileReference;
	for(var i:Number=0;i<tempList.length;i++){
		item = tempList[i];
		var fileName = item.name;
		var fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length);
		for(var j:Number=0;j<array_denyFileType.length;j++){ //파일타입 체크
			if(fileType.toUpperCase()==array_denyFileType[j].toUpperCase()){
				totalSize -= item.size;				
				getURL("javascript:" + jsObject+ ".fileTypeError('"+array_denyFileType+"')");
				tempList[i] = null;
			}
		}		
		if(totalSize+item.size>limitSize){ //업로드 제한크기
			getURL("javascript:" + jsObject+ ".overSize('" + humanSize(limitSize,0) + "');");
			tempList[i] = null; // null 삽입
		}else{
			totalSize += item.size;
		}			
		if(item.size==0) tempList[i] = null;
	}
	
	for(var i:Number=0;i<tempList.length;i++){
		if(tempList[i] != null){
			item = tempList[i];
			var fileName = "["+humanSize(item.size,2)+"] "+item.name;
			lstFiles.addItem(fileName);			
			showStatus1();
			item.addListener(this);
			list.push(item);
		}
	}	
	lstFiles.setSelectedIndex(0);
}

btnDelete.addEventListener("click", //파일삭제
	function(){
		if(lstFiles.selectedIndex!=undefined){			
			totalSize = 0;
			var selected_Items = lstFiles.getSelectedIndices();
			for(var i=list.length-1;i>-1;i--){
				if(inArray(selected_Items,i)){
					lstFiles.removeItemAt(i);
					list[i] = null;
				}else{
					totalSize += list[i].size;					
				}
			}
			var temp = new Array();			
			for(var i=0;i<list.length;i++){
				if(list[i]!=null) temp.push(list[i]);
			}
			list = temp;	
			showStatus1();
			lstFiles.setSelectedIndex(0);
		}
	}
);

function fileUpload(){ //업로드 함수
	startTime = new Date();
	startMtime = startTime.getTime();
	var item:FileReference;
	var strVersion:String = getVersion(); //버전체크
	strVersion = strVersion.split(" ")[1].split(",")[0];
	var version:Number = parseInt(strVersion);
	if(version < 8){
		btnBrowse.enabled = false;
		btnDelete.enabled = false;
		getURL("javascript:" + jsObject+ ".versionError()");
	}
	if(list.length>0){ //업로드된 파일이 있을 경우.
		btnBrowse.enabled = false;
		btnDelete.enabled = false;		
		item = list[fileNumber];
		lstFiles.setSelectedIndex(0);
		item.upload(uploadExe);		
	}
}

listener.onComplete = function(file:FileReference):Void{
	//trace("onComplete: "+file.name);
	loadSize += file.size;
	lstFiles.removeItemAt(0);
	fileNumber++;
	if(lstFiles.length){
		var item:FileReference;
		item = list[fileNumber];
		lstFiles.setSelectedIndex(0);
		item.upload(uploadExe);
	}else{
		getURL("javascript:" + jsObject+ ".swfUploadComplete();");	
	}
}

listener.onCancel = function():Void{
	//trace("onCancel");
}

listener.onOpen = function(file:FileReference):Void{
	//trace("onOpen: "+file.name);
}

listener.onProgress = function(file:FileReference,bytesLoaded:Number,bytesTotal:Number):Void{
	//trace("onProgress with bytesLoaded: "+bytesLoaded+" bytesTotal: "+bytesTotal);
	_root["thisPg"].proFG._width = (_root["thisPg"].proBG._width * bytesLoaded) / bytesTotal;
	_root["thisPg"].percentText.text = Math.round((bytesLoaded / bytesTotal) * 100) + "%";
	_root["totalPg"].proFG._width = (_root["totalPg"].proBG._width * (loadSize + bytesLoaded)) / totalSize;
	_root["totalPg"].percentText.text = Math.round(((loadSize + bytesLoaded) / totalSize) * 100) + "%";
	var thisTime = new Date();
	var thisMtime = thisTime.getTime();
	_root["statusText2"].text = humanSize((loadSize + bytesLoaded)/((thisMtime - startMtime) / 1000),2) + "/Sec";
}

listener.onHTTPError = function(file:FileReference,httpError:Number):Void{ //HTTP 에러
	//trace("onHTTPError: " + file.name + " httpError: " + httpError);
	getURL("javascript:" + jsObject+ ".httpError();");
}

listener.onIOError = function(file:FileReference):Void{ //입출력 에러
	//trace("onIOError: " + file.name);	
	getURL("javascript:" + jsObject+ ".ioError();");	
}

listener.onSecurityError = function(file:FileReference,errorString:String):Void{ //보안에러
	//trace("onSecurityError: " + file.name + " errorString: " + errorString);
	getURL("javascript:" + jsObject+ ".onSecurityError();");
}

// 자바 스크립트에서 호출 가능토록 설정
this.watch("startUpload",fileUpload,null);
