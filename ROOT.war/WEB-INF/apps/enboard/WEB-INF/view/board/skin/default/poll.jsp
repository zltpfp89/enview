
<link href="./css/board/skin/enboard/bbs.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
  body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>






<tr>
<td align=center >

<div class="board">
  
  <table width=800 border="0" cellspacing="0" cellpadding="0" >
  <form name="setSrch" OnSubmit="return ebList.srchBulletin()">
    <tr>
	  <td height="30" align="left" valign=bottom>
		
      </td>
	  
      <td width=100 align="center" valign="bottom">
        <select name="cateSel" style=font-size:9pt;width:110 onchange="ebList.cateList(this.value)">
          <option style=background-color:#444444;color:#dddddd value=-1>** Category **</option>
          
		    
              <option style=background-color:#dddddd value=t1 >t1</option>
			
		  
		    
              <option style=background-color:#dddddd value=t2 >t2</option>
			
		  
		    
              <option style=background-color:#dddddd value=t3 >t3</option>
			
		  
        </select>
      </td>
      
	  <td height="30" align="right" valign=bottom>
		
		
                 
          <input type="checkbox" name="srchType" id="srchType" value="Nick"  
		         
		  />작성자
                 
          <input type="checkbox" name="srchType" id="srchType" value="Subj"  
		         
		  />제목
        
        <input name="srchKey" class="tb_input" style="width:120px;height:18px" value=''  />
        
          <span style=cursor:pointer onClick=ebList.srchBulletin()><img src='/board/images/board/skin/default/imgSrch.gif' align='absmiddle'></span>
		
        
      </td>
    </tr>
    <tr>
      <td height="30" align="left" style="padding-left:5px;" valign=bottom>
        <img src='/board/images/board/skin/default/imgTotal.gif' align='absmiddle'>전체 <font color="blue"><b>2</b></font>건
      </td>
      
      <td></td>
      
      <td height="30" align="right" style="padding-right:5px;" valign=bottom>
        현재 1 페이지 / 전체 1 페이지
      </td>
    </tr>
    <tr hieght="5"><td colspan="3"><td></tr>
  </form>      
  </table>
  
  
  <table width=800 border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" >
      
	  <form name="frmlist" onsubmit="return false">
	  <table width=100% border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td height="2" colspan="28" bgcolor="blue"></td>
	    </tr>
	    <tr>
          <td width="40" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>번호</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
          <td width="60" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>Categroy</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
          <td width="20" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b></b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"></td>
	      <td align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>제목</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="100" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>작성자</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="1200" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>작성일</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="50" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>조회수</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="50" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>읽음여부</b></td>
		  
	    </tr>

        
        

        
                 
        <tr><td height="1" colspan="28" bgcolor="#dbdee7" ></td></tr>
        <tr onMouseOver=this.style.backgroundColor='#E8ECF9' onMouseOut=this.style.backgroundColor=''>
          
    
          
          <td class="table_list_c">
            
              
              2
              
            
            
          </td>
          <td width="3" nowrap></td>
          
    
          

          
          
          <td class="table_list_c">
		    
		      &nbsp;
			
		  </td>
          <td width="3" nowrap></td>
          
          

		  
	      
		  
          
	      

          
          <td class="table_list_c">
		    
			
              
              
                <img src='/board/images/board/skin/default/imgDoc.gif' align='absmiddle'>
                
                
                
			  
            
          </td>
          <td width="3" nowrap></td>
                    

          <td class="table_list_l">
            
			
              
			  <a style=cursor:pointer OnMouseOver=this.style.textDecoration='underline' OnMouseOut=this.style.textDecoration='none'
			    
			      
				  
			        onclick="ebList.readBulletin('test1','11401164168308')"
				  
				  
			    
			    
			  >
			    
			    테스트
				
				
              </a>
              
              
              
                
              
              
			
			
          </td>

	      

                
	      

          
          <td width="3" nowrap></td>
          <td class="table_list_c">
			
		      관리자                                                                                           
			
		  </td>
          
      
          
          <td width="3" nowrap></td>
          <td class="table_list_c">
			
		      2014.05.27
			
		  </td>
          
      
          
          <td width="3" nowrap></td>
          <td class="table_list_c">
			
              
              0&nbsp;
              
			
          </td>
          
		  
          <td width="3" nowrap></td>
          <td class="table_list_c">
			
		      
		      Y
			
		  </td>
		  
        </tr>
                 
        <tr><td height="1" colspan="28" bgcolor="#dbdee7" ></td></tr>
        <tr onMouseOver=this.style.backgroundColor='#E8ECF9' onMouseOut=this.style.backgroundColor=''>
          
    
          
          <td class="table_list_c">
            
              
              1
              
            
            
          </td>
          <td width="3" nowrap></td>
          
    
          

          
          
          <td class="table_list_c">
		    
		      &nbsp;
			
		  </td>
          <td width="3" nowrap></td>
          
          

		  
	      
		  
          
	      

          
          <td class="table_list_c">
		    
			
              
              
                
                <img src='/board/images/board/skin/default/imgFile.gif' align='absmiddle'>
                
                
			  
            
          </td>
          <td width="3" nowrap></td>
                    

          <td class="table_list_l">
            
			
              
			  <a style=cursor:pointer OnMouseOver=this.style.textDecoration='underline' OnMouseOut=this.style.textDecoration='none'
			    
			      
				  
			        onclick="ebList.readBulletin('test1','11401083360720')"
				  
				  
			    
			    
			  >
			    
			    이미지 테스트
				
				
              </a>
              
              
              
                
              
              
			
			
          </td>

	      

                
	      

          
          <td width="3" nowrap></td>
          <td class="table_list_c">
			
		      관리자                                                                                           
			
		  </td>
          
      
          
          <td width="3" nowrap></td>
          <td class="table_list_c">
			
		      2014.05.26
			
		  </td>
          
      
          
          <td width="3" nowrap></td>
          <td class="table_list_c">
			
              
              0&nbsp;
              
			
          </td>
          
		  
          <td width="3" nowrap></td>
          <td class="table_list_c">
			
		      
		      Y
			
		  </td>
		  
        </tr>
        
        
        <tr><td height="2" colspan="28" bgcolor="#dbdee7" ></td></tr>
      </table>
      </form>
      
    </td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  <tr>
    <td align="right">
      <table width=100% border="0" cellspacing="0" cellpadding="0">
        <tr>
          
          <td id="pageIndex" align="center" class="board_num"></td>
		  <td align="right" valign=middle>
				<a onClick=ebList.writeBulletin() style=cursor:pointer><img src='/board/images/board/skin/default/imgWrite.gif' align='absmiddle'></a>
		  </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  <tr>
    <td align=right>
	  <font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none' onclick=ebList.showExcelForm(true)>
		<b>Excel</b>
	  </font>&nbsp;
	  <font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none' onclick=ebList.showFeedURL('RSS')>
		<img src="./images/board/rss-icon.png"/><b>RSS</b>
	  </font>&nbsp;
	  <font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none' onclick=ebList.showFeedURL('ATOM')>
		<b>ATOM</b>
	  </font>&nbsp;
	  <font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none' onclick=ebList.xmlBulletin()>
		<b>XML</b>
	  </font>&nbsp;
	</td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  </table>
</div>


</td>
</tr>
