<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
 <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
 <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<title>AJAX 탭</title>
<script type="text/javascript">
    $(document).ready(function() {
        
        // 탭 li 선언
        var tabTemplate = "<li><a href='<%="#"%>{href}'><%="#"%>{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>";
        // 탭 선언
        var tabs = $( "#tabs" ).tabs();
        
        // documents의 a태그들 중 원하는 a태그 클릭 했을때 실행 
        $("#documents a").click(function() {
            // 현재 눌린 a 태그 가져오기
            var link = $(this);
            alert("link:"+link);
            // tabs_id 선언
            var tabs_id = "tabs-" + $(link).attr("id");
            // find_id 선언
            var find_id = $("[id= " + tabs_id + "]").attr("id");
            alert("find_id:"+find_id);
            // tab_id 선언
            var tab_id = "#" + tabs_id;
            alert("tab_id:"+tab_id);
            // a태그에 해당하는 탭이 열려 있을 경우
            if(find_id == tabs_id){
                // 열려있는 탭으로 이동
                tabs.tabs("option","active", id2Index("#tabs",tab_id));
            // 아닐경우
            }else{
                // 탭을 추가
                addTab(link);
            }
        });
        
        
        
        // 선택한 documents a 태그의 해당하는 tab index 찾기
        function id2Index(tabsId, srcId){
            // index 값 -1로 설정
            var index = -1;
            // i 값 선언, tbH : 해당하는 탭의 a 태그 찾기
            var i = 0, tbH = $(tabsId).find("li a");
            // tbH 길이 선언
            var lntb = tbH.length;
            alert(lntb);
            // lntb가 0보다 클경우
            if(lntb>0){
                for(i=0;i<lntb;i++){
                    o=tbH[i];
                    if(o.href.search(srcId)>0){
                        index = i;
                    }
                }
            }
            // index값 리턴
            return index;
        }
        
        // 해당 탭 지우기
        tabs.on( "click", "span.ui-icon-close", function() {
            var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
            // 해당하는 탭 제거
            $( "#" + panelId ).remove();
            // 탭 refresh
            tabs.tabs( "refresh" );
          });
        // 탭 추가
        function addTab(link){
            // 탭 라벨 선언
            var label = $(link).text();
            // id 값을 tabs-? 로 선언
            var id = "tabs-" + $(link).attr("id");
            // rel : link의 속성 중 rel을 찾는다 (ajax로 탭에 보여줄 내용을 가져올 html의 주소가 들어간다)
            var rel = $(link).attr("rel");
            var name = $(link).attr("name");
            // li replace
            var li = $( tabTemplate.replace( /#\{href\}/g, "#" + id ).replace( /#\{label\}/g, label ) );
            // tab내용 선언
            var tabContentHtml = "";
           
            tabContentHtml = '<iframe scrolling="auto" frameborder="0"  src="'+rel+'" style="width:800px;height:800px;"></iframe>';
            // 탭의 ui-tabs-nav 찾아서 li를 append 시킨다
            tabs.find(".ui-tabs-nav").append(li);
            // 추가된 탭의 내용을 삽입
            tabs.append( "<div id='" + id + "'><p>" + tabContentHtml + "</p></div>" );
            // 탭 새로고침
            tabs.tabs( "refresh" );
            // 생성 된 탭으로 바로 가게 한다.
            tabs.tabs( "option", "active", $("#tab_header").index());
        }
    });
</script>
</head>
<body>
<div id="doclist">
	<ul id="documents">
		<li><a href="#" id = "1" rel="/sjpb/E/E0101.face">수기수사</a></li>
		<li><a href="#" id = "2" rel="/sjpb/F/F0101.face">범죄자료</a></li>
		<li><a href="#" id = "3" rel="/sjpb/B/B0101.face" >사건</a></li>
		<li><a href="#" id = "4" rel="readPage4">탭4</a></li>
		<li><a href="#" id = "5" rel="readPage5">탭5</a></li>
	</ul>
</div>
<div id="tabs">
  <ul>
    <li><a href="#tabs-0">intro</a> <span class="ui-icon ui-icon-close" role="presentation">삭제</span></li>
  </ul>
  <div id="tabs-0">
    <p>탭 구현</p>
  </div>
  
</div>

</body>

</html></html>