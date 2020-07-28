<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
<title>서울시립대학교 포털 이벤트</title>
<link>http://</link>
<description>uos-event-rss</description>
<copyright>Copyright (c)All rights reserved</copyright>
<language>ko</language>
<generator>event-rss</generator>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map"%>
<%@ page import="com.saltware.enhancer.admin.event.model.EventMngVO" %>			
<%
				List eventList = (java.util.List)request.getAttribute("eventList");
				int len = eventList.size();
				for(int i=0;i<len;i++){
					EventMngVO eventMngVO = (com.saltware.enhancer.admin.event.model.EventMngVO)eventList.get(i);
					//RSS화면에 보여지는 요소
					//String title = "["+eventMngVO.getCATEGORY_NM()+"]"+eventMngVO.getTITLE_KOR();	//카테고리명+이벤트제목
					String title = eventMngVO.getTITLE_KOR();	//카테고리명+이벤트제목
					String category = eventMngVO.getCATEGORY_NM();								//카테고리명
					String author = eventMngVO.getREG_USER_NM();									//등록자명
					String content  = eventMngVO.getCONTENTS_KOR();								//이벤트내용(국문)	
					String period = eventMngVO.getREG_DATIM();									//이벤트 등록일시
					String link = eventMngVO.getTARGET_LINK();									//이벤트 정보더보기 링크
					if(link == null || link.equals("") || link.equals("http://"))
				link="";

					//추가로 xml소스코드로 제공하는 이벤트 원본정보
					String eventSeq = eventMngVO.getEVENT_SEQ();		//이벤트번호
					String titleKor = eventMngVO.getTITLE_KOR();		//이벤트제목(국문)
					String titleEng = eventMngVO.getTITLE_ENG();		//이벤트제목(영문)
					String categoryCd = eventMngVO.getCATEGORY_SEQ();	//카테고리 코드
					String categoryNm = eventMngVO.getCATEGORY_NM();	//카테고리명
					String place = eventMngVO.getPLACE_BUILDING_KOR();//이벤트장소
					String placeSub = eventMngVO.getPLACE_NM();		//장소추가정보
					String ownerNm = eventMngVO.getOWNER_USER_ID();	//담당자명
					String ownerPhone = eventMngVO.getOWNER_PHONE();	//담당자전화번호
					String ownerEmail = eventMngVO.getOWNER_EMAIL();	//담당자이메일
					String stdDate = eventMngVO.getSTART_DATE();		//이벤트시작일
					String endDate = eventMngVO.getEND_DATE();		//이벤트종료일
					String eventStdDate = eventMngVO.getEVENT_START_DATE();		//이벤트시작일
					String evenEndDate = eventMngVO.getEVENT_END_DATE();		//이벤트종료일
			%>
<item>
 <title><![CDATA[<%=title%>]]></title>
 <author><![CDATA[<%=author%>]]></author>
 <EventLink><![CDATA[/event/detailEventByGuest.hanc?EVENT_SEQ=<%=eventSeq%>]]></EventLink>
 <link><![CDATA[<%=link%>]]></link>
 <description><![CDATA[<%=content%>]]></description>
 <pubDate><![CDATA[<%=period%>]]></pubDate>
 <category><![CDATA[<%=category%>]]></category>
 <eventSeq><![CDATA[<%=eventSeq%>]]></eventSeq>
 <titleKor><![CDATA[<%=titleKor%>]]></titleKor>
 <titleEng><![CDATA[<%=titleEng%>]]></titleEng>
 <categoryCd><![CDATA[<%=categoryCd%>]]></categoryCd>
 <categoryNm><![CDATA[<%=categoryNm%>]]></categoryNm>
 <place><![CDATA[<%=place%>]]></place>
 <placeSub><![CDATA[<%=placeSub%>]]></placeSub>
 <ownerNm><![CDATA[<%=ownerNm%>]]></ownerNm>
 <ownerEmail><![CDATA[<%=ownerEmail%>]]></ownerEmail>
 <stdDate><![CDATA[<%=stdDate%>]]></stdDate>
 <endDate><![CDATA[<%=endDate%>]]></endDate>
 <eventStdDate><![CDATA[<%=eventStdDate%>]]></eventStdDate>
 <eventEndDate><![CDATA[<%=evenEndDate%>]]></eventEndDate>
</item>
<%}%>
		
</channel>
</rss>