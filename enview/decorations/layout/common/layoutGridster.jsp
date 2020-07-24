<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.saltware.enview.om.portlet.impl.PortletDefinitionImpl"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.List"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Locale"%>
<%@page import="com.saltware.enview.Enview"%>
<%@page import="com.saltware.enview.om.page.impl.FragmentImpl"%>
<%@page import="com.saltware.enview.util.json.JSONObject"%>
<%@page import="com.saltware.enview.util.json.JSONArray"%>
<%@page import="com.saltware.enview.userpreference.UserPreferenceManager"%>
<%@page import="com.saltware.enview.userpreference.service.UserPreferenceVO"%>
<%@page import="com.saltware.enview.userpreference.service.UserPreferenceService"%>
<%@page import="org.apache.pluto.container.om.portlet.InitParam"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="javax.portlet.WindowState"%>
<%@page import="org.apache.pluto.container.om.portlet.PortletDefinition"%>
<%@page import="com.saltware.enview.aggregator.PortletRenderer"%>
<%@page import="com.saltware.enview.aggregator.PortletContent"%>
<%@page import="com.saltware.enview.components.portletregistry.PortletRegistry"%>
<%@page import="com.saltware.enview.container.state.NavigationalState"%>
<%@page import="com.saltware.enview.om.page.FragmentLayout"%>
<%@page import="com.saltware.enview.om.page.Fragment"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%!
	/**
	* 속성값을 가져온다. 먼저 포틀릿의 설정(init-param)을 읽고 없으면 fragment의 preference를 읽는다. 둘다 없으면 defaultValue를 리턴한다.
	*/
	protected String getProperty( Fragment f, String key, String defaultValue) {
		String value = null;
		if( f.getPortlet() != null) {
			InitParam initParam = f.getPortlet().getInitParam( key);
			if( initParam != null) {
				value = initParam.getParamValue();
			}
		} else {
			value = f.getPreferenceValue(key);
		}
		return value != null ? value : defaultValue;
	}

	protected Locale getLocale( HttpServletRequest request) throws Exception {
		return new Locale(EnviewSSOManager.getLangKnd(request));
	}


	protected String getTitle( Fragment f, Locale locale) {
		String _pTitle = f.getPreferenceValue("TITLE");
		if( _pTitle == null ) {
			PortletDefinition portlet  = f.getPortlet();
			if( portlet != null ) {
				if( portlet.getDisplayName( locale ) != null) {
				_pTitle = portlet.getDisplayName( locale ).getDisplayName();
				}
			}
		}
		if( _pTitle==null) {
			_pTitle = f.getName();
		}
		return _pTitle;
	}
	
	
	static class FragmementComparator implements Comparator<JSONObject> {
		public int compare(JSONObject j1, JSONObject j2) {
			try {
				return  (j1.getInt("row") * 1000 + j1.getInt("col")) - (j2.getInt("row") * 1000 + j2.getInt("col"));
			} catch( Exception e) {
				return 0;
			}
		}
	}
	
	static class FragmementComparator2 implements Comparator<Object> {
		public int compare(Object o1, Object o2) {
			try {
				Fragment f1 = (Fragment)o1;
				Fragment f2 = (Fragment)o2;
				return  ( f1.getLayoutRow() * 1000 + f1.getLayoutColumn()) - ( f2.getLayoutRow() * 1000 + f2.getLayoutColumn());
			} catch( Exception e) {
				return 0;
			}
		}
	}	
	
	protected List sort( JSONArray layout) throws Exception {
		ArrayList list = new ArrayList();
		for( int i=0; i< layout.length();i++) {
			list.add( layout.getJSONObject(i));
		}
		Collections.sort(list, new FragmementComparator() );
		return list;
	}
	
	protected List sort( List list) throws Exception {
		Collections.sort(list, new FragmementComparator2() );
		return list;
	}

%>
<!-- gridster에서 자체적으로 마진을 잡으므로 마진을 없앤다. -->
<style type="text/css">
.p_11{margin:0px 0px;}
.p_21{margin:0px 0px;}
.p_10{margin:0px 0px;}
.p_13{margin:0px 0px;}
.p_20{margin:0px 0px;}

</style>
<%  

	Log log = LogFactory.getLog("com.saltware.enface");

	try {
		PortletRenderer renderer = (PortletRenderer)request.getAttribute("renderer");
		PortletRegistry registry = (PortletRegistry)request.getAttribute("registry");
		boolean isRoot = (Boolean)request.getAttribute("isRoot");
		Fragment layoutFragment = (Fragment)request.getAttribute("currentFragment");
		String layoutId = layoutFragment.getId();
		
		String classSuffixMypage = "my";
		String layoutClass = "gridster";
		String columnClass = "column";
		String portletClass = "portlet-" + classSuffixMypage;
		String portletHeaderClass = "portlet-header-" + classSuffixMypage;
		String portletContentClass = "portlet-content-" + classSuffixMypage;
		
		JSONObject userLayout = null;
		if( !isEditPage) {
			UserPreferenceManager userPreferenceManager = (UserPreferenceManager) Enview.getComponentManager().getComponent("com.saltware.enview.userpreference.UserPreferenceManager");
			String userLayoutData = userPreferenceManager.getPreference( request,  "MY",currentPage.getPath());
			if( userLayoutData!=null) {
				userLayout = new JSONObject( userLayoutData) ;
			}
		}
//		out.println( "userLayout=" + userLayout);
		
%>
		<style type="text/css">
		.layout2 {width:49%;position:initial;display:inline-block; margin:4px  !important}
		.layout1 {width:99%;position:initial;display:inline-block; margin:4px  !important}
		.layout {position:initial;display:inline-block; margin:4px  !important}
		</style>

		<script type="text/javascript" src="${cPath}/face/javascript/portlet.js"></script>
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/decorations/layout/css/jquery.gridster.min.css" />
		<script type="text/javascript" src="${cPath}/decorations/layout/scripts/jquery.gridster.min.js"></script>
		<script type="text/javascript">
			var gridster;
			//----------------------------
			//  페이지 잠금 초기값. true : 잠금상태(조회모드)에서 시작. false 잠기지 않는 상태(편집모드)에서 시작  
			//----------------------------
			var gridsterLocked = false;
			//----------------------------
			var isEditPage = ${isEditPage};
			$(function(){ //DOM Ready

				<c:if test="${isEditPage==true}">
		        var serializer =  function($w, wgd) {
		        	var id = wgd.el[0].id.split('_')[2];
		        	var name = $w.attr('name');
		            return {
		            id: id,
		            col: wgd.col - 1,
		            row: wgd.row - 1
		            }
		        };
		        </c:if>
				<c:if test="${isEditPage!=true}">
		        var serializer =  function($w, wgd) {
		        	var id = wgd.el[0].id.split('_')[2];
		        	var name = $w.attr('name');
		            return {
		            id: id,
		            name: name,
		            col: wgd.col - 1,
		            row: wgd.row - 1
		            }
		        };
		        </c:if>
		        
			    gridster = $(".gridster").gridster({
			        widget_margins: [7, 4],
			        widget_base_dimensions: [257, 132],
			        min_rows : 4,
			        max_rows : 4,
			    	min_cols : 3,
			    	max_cols : 3,
			        widget_selector : ".portlet-my",
			        serialize_params: serializer,
			        draggable: {
			            stop: function(event, ui) {
			            	var fragments = JSON.stringify(gridster.serialize());
		    				var param = 'page_path=' + portalPage.getPath() +'&fragments=' + fragments;
		    				if( isEditPage) {
			    				portalPage.getAjax().send("POST", portalPage.getContextPath() + "/page/reorderMyPagePortletForAjax.face", param, false, {
			    					success: function(data){
	    							}
		    					}
			    				);
		    				} else {
		    					saveUserPage();
		    				}
			            }
			        }			        
			    }).data( 'gridster');
			    
			    if( gridsterLocked) {
			    	gridster.disable();
			    	$(".portlet-toolbar .ui-icon-locked").css({ opacity: 1.0 });
			    	$(".portlet-toolbar .ui-icon-unlocked").css({ opacity: 0.5 });
			    } else {
			    	$(".portlet-toolbar .ui-icon-locked").css({ opacity: 0.5 });
			    	$(".portlet-toolbar .ui-icon-unlocked").css({ opacity: 1.0 });
			    }
			
				  // 삭제 버튼 클릭 시 포틀릿 삭제 처리 
				  $(".portlet-header-my-icon .ui-icon-close").click(function() {
					if( confirm(portalPage.getMessageResource("ev.info.remove")) ) {
						var portlet = $(this).parents(".portlet-my:first" );
						
						var p1 = portlet.attr("id").split('_');
						if( p1[0] != 'Enview') return;
						if( p1[1] != 'Portlet') return;
						var portletId = p1[2];
						
						var param = 'page_path=' + portalPage.getPath() +'&fragment_id=' + portletId;
						if( isEditPage) {
							// delete current portlet;
							portalPage.getAjax().send("POST", portalPage.getContextPath() + "/page/removeMyPagePortletForAjax.face", param, false, {
								success: function(data){
									gridster.remove_widget( portlet );	
								}});
						} else {
							// 먼저 삭제
							gridster.remove_widget( portlet );
							// 전체 저장
							saveUserPage();
						}
					}
				  });
				
				var saveUserPage = function( handler) {
					// 전체 저장
	            	var fragments = JSON.stringify(gridster.serialize());
					var layoutFragment = "{ name:\"gridster\", fragmentLayout : " + fragments + "}";
					var param = 'page_path=' + portalPage.getPath() +'&fragments=' + layoutFragment;
    				portalPage.getAjax().send("POST", portalPage.getContextPath() + "/page/saveUserPageForAjax.face", param, false, {
    					success: function(data){
    						if( handler!=null) {
    							handler();
    						}
						}
					});
				} ;
				
				var showPortletSelector = function() {
					portalPage.getPortletSelector().doShow(null, 'university');
				}
				
				$(".portlet-header-my-icon .ui-icon-plus").click(function() {
					var userPreferenceIsEmpty = <%= userLayout == null ? "true" : "false" %>;
					if( userPreferenceIsEmpty && !isEditPage) {
						saveUserPage( showPortletSelector);
					} else {
						showPortletSelector;
					}
				});
				
				$(".portlet-toolbar .ui-icon-plus").click(function() {
					var userPreferenceIsEmpty = <%= userLayout == null ? "true" : "false" %>;
					if( userPreferenceIsEmpty && !isEditPage) {
						saveUserPage( showPortletSelector);
					} else {
						showPortletSelector();
					}
				});
				
				$(".portlet-toolbar .ui-icon-locked").click(function() {
			    	$(".portlet-toolbar .ui-icon-locked").css({ opacity: 1.0 });
			    	$(".portlet-toolbar .ui-icon-unlocked").css({ opacity: 0.5 });
					gridsterLocked = true;
					gridster.disable();
				});
				
				$(".portlet-toolbar .ui-icon-unlocked").click(function() {
			    	$(".portlet-toolbar .ui-icon-locked").css({ opacity: 0.5 });
			    	$(".portlet-toolbar .ui-icon-unlocked").css({ opacity: 1.0 });
					gridsterLocked = false;
					gridster.enable();
				});
			
				
				$(".portlet-toolbar .ui-icon-refresh").click(function() {
					if( confirm(portalPage.getMessageResource("ev.info.reset")) ) {
						var param = 'page_path=' + portalPage.getPath();
	    				portalPage.getAjax().send("POST", portalPage.getContextPath() + "/page/removeUserPageForAjax.face", param, false, {
	    					success: function(data){
	    						document.location.reload();
   							}
    					}
	    				);
					}
				});
				
				$(".portlet-my").hover( function() {
					var header = $(this).children(".portlet-header-my:first" ).children(".portlet-header-my-icon:first" );
					portletHeader = header;
					setTimeout( showPortletHeader, 1000);
				}, function() {
					portletHeader = $(this).children(".portlet-header-my:first" ).children(".portlet-header-my-icon:first" );
					hidePortletHeader();
				})
				
				
			});
			var portletHeader;
			function showPortletHeader() {
				if( portletHeader != null && ! gridsterLocked) {
					portletHeader.show();
				}
			}
			function hidePortletHeader() {
				if( portletHeader != null) {
					portletHeader.hide();
					portletHeader = null;
				}
			}
			
			/*
			var mainLayout=4;
			function changeLayout()  {
				var w = $(window).width();
				var layout = 4; // 기본레이아웃
				if( w < 550 ) {	// 1열 레이아웃 
					layout=1;
				} else if( w < 725) { // 2열 레이아웃 
					layout=2;
				} else if( w < 1100) { // 3열 레이아웃 
					layout=3;
				}
				}
				if(isEditPage){	// 관리자 페이지로 접근했을 때 화면 길게 보이려고
					mainLayout = 4;
					layout = 4;
				}
				if( mainLayout != layout) {
					if( layout==4) {
//						$(".portlet-my").removeClass("layout1");
//						$(".portlet-my").removeClass("layout2");
						$(".portlet-my").addClass("gs-w");
						$(".portlet-toolbar").show();
						$(".gridster").width(1080);
					} else if( layout==3) {
						$(".portlet-my").addClass("layout");
						
						$(".portlet-my").removeClass("gs-w");
//						$(".portlet-my").removeClass("layout1");
//						$(".portlet-my").addClass("layout2");
						$(".portlet-toolbar").hide();
						$(".gridster").width('810px');
					} else if( layout==2) {
						$(".portlet-my").addClass("layout");
						
						$(".portlet-my").removeClass("gs-w");
//						$(".portlet-my").removeClass("layout1");
//						$(".portlet-my").addClass("layout2");
						$(".portlet-toolbar").hide();
						$(".gridster").width('540px');
					} else {
						$(".portlet-my").addClass("layout");
						
						$(".portlet-my").removeClass("gs-w");
//						$(".portlet-my").removeClass("layout2");
//						$(".portlet-my").addClass("layout1");
						$(".portlet-toolbar").hide();
						$(".gridster").width('100%');
					}
					mainLayout = layout;
				}
			}
			*/
			/*
			$(function(){
				$(window).on('resize', function(){
					changeLayout();
				});				
				changeLayout();
			})
			*/;
			

		</script>

		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/decorations/layout/css/gridster.css"  />
		<div class="portlet-toolbar">
		<span class='ui-icon ui-icon-unlocked' title="이동"></span>
		<span class='ui-icon ui-icon-locked' title="이동금지"></span>
		<span class='ui-icon ui-icon-plus' title="포틀릿 추가"></span>
		<span class='ui-icon ui-icon-refresh' title="원상복구"></span>
		<c:if test="${isEditPage==true}">
		<img src='<%=request.getContextPath()%>/decorations/layout/images/edit.gif' border='0' align='absmiddle' title='<util:message key="ev.info.icon.editPortlet"/>' style='border:none; cursor:hand;'/> 
		</c:if>
		<c:if test="${isEditPage!=true}">
		</c:if>
		</div>
		
		<div id="Enview_Layout_<%=layoutId%>" class="<%=layoutClass%>" style="float:left">
<%
	if( userLayout==null) {
		FragmentLayout fragmentLayout = layoutFragment.getFragmentLayout();
		if( fragmentLayout != null ) {
			List fragments = new ArrayList();
			Iterator it = fragmentLayout.getColumns().iterator();
			for(int columnIndex=0; it.hasNext(); columnIndex++) {
				Collection column = (Collection)it.next();
				Iterator it2 = column.iterator();
				for(int rowIndex=0; it2.hasNext(); rowIndex++) {
					Fragment f = (Fragment)it2.next();
					fragments.add( f);
				}
			}
			sort( fragments);
			for( int i =0 ;i < fragments.size(); i++) {
			
					Fragment f = (Fragment)fragments.get(i);
					
					String col = (f.getLayoutColumn() + 1) + "";;
					String row = (f.getLayoutRow()+1) + "";
					
					if( "portlet".equals(f.getType()) ) {
						boolean isPortletRemovable = (f.getActionMask() & 0x00000001) > 0;
						boolean isPortletMovable = (f.getActionMask() & 0x00000010) > 0 ;						
						
						NavigationalState nav = _rc.getPortalURL().getNavigationalState();
						WindowState _ws = nav.getMappedState(f.getId());

						PortletDefinition portlet = f.getPortlet();
						if( portlet == null ) {
							portlet = registry.getPortletDefinitionByUniqueName(f.getName());
							f.setPortlet(portlet);
						}

						String _pTitle = getTitle( f, getLocale( request));
						String _pName = f.getName();
						
						//-- 포틀릿의 상대적인 너비. 1 = 정사각형
						String _pSizex = getProperty(f, "SIZEX", "1");
						//-- 포틀릿의 상대적인  높이. 1 = 정사각형 포틀릿의 절반 높이
						String _pSizey = getProperty(f, "SIZEY", "2");
						
						Map contentBuffer = new HashMap();
						renderer.renderNow(f, _rc, contentBuffer); // 20120224 Modified
						String content = "";

						if( f.getOverriddenContent() != null && f.getOverriddenContent().length() > 0) {
							content = f.getOverriddenContent(); // 20120224 Modified
						} else {
							PortletContent portletContent = (PortletContent)contentBuffer.get("content");
							if( portletContent != null ) {
								content=  portletContent.getContent(); // 20120224 Modified
							}
						}
						
						if( content.length() > 0 ) { // 20120224 Modified
							String style = f.getPreferenceValue("STYLE");
							portletClass = "portlet-my";
							%>
							<div id="Enview_Portlet_<%=f.getId()%>" class="<%=portletClass%>" <%= style !=null ? "style='" + style + "'" : "" %> name="<%=_pName %>" data-row="<%=row%>" data-col="<%=col%>" data-sizex="<%=_pSizex%>" data-sizey="<%=_pSizey%>">
							<div class="<%=portletHeaderClass%>">
							<div class="portlet-header-my-icon">
							<span class='ui-icon ui-icon-close' title='포틀릿 삭제'></span>
							<span class='ui-icon ui-icon-plus' title="포틀릿 추가"></span>
							</div>
							&nbsp;
							<!-- 
							<% if( isPortletRemovable ) { %><span class='ui-icon ui-icon-close' title="포틀릿 삭제"></span><%}%>
							<span class='ui-icon ui-icon-plus' title="포틀릿 추가"></span>
							<span style="margin-left:5px;margen-right:5px"><%=_pTitle %></span>
							 -->
							</div>
							<%
								if( "minimized".equals(_ws.toString()) == false) { %><div id="Enview_Portlet_Content_<%=f.getId()%>" class="<%=portletContentClass%>"><%= content %></div><%
								}
							%></div> <!-- portlet end -->
<%		    			}
				} %>
<%			}
		} 
		
	} else {
//		System.out.println( userLayout);
		JSONObject p;
		Fragment f;
		JSONArray fragmentLayout = userLayout.getJSONArray("fragmentLayout");
		// 레이아웃을 소트해서 순서를 만든다.
		List layouts = sort( fragmentLayout );

		//-----------------------------------
		// 포틀릿 권한 체크  - 사용가능한 포틀릿 셋을 만든다.
		Set portletSet = new HashSet();
        Collection allPortlets = registry.getAccessablePortlets(EnviewSSOManager.getUserInfoMap(request), "", EnviewSSOManager.getLangKnd(request));
        Iterator it = allPortlets.iterator();
    	log.debug( "---------------------");
    	log.debug( "avail portlet list");
        for(; it.hasNext(); ) {
        	PortletDefinitionImpl portlet = (PortletDefinitionImpl)it.next();
        	portletSet.add( portlet.getUniqueName());
        	log.debug( portlet.getUniqueName());
        }
    	log.debug( "---------------------");
		
		for( int i=0; i < layouts.size(); i++) {
			p  = (JSONObject)layouts.get(i);
			String _pName = p.getString("name");

			if( !portletSet.contains( _pName)) {
				// 사용가능한 포틀릿이 아니면 건너뛴다.
		    	log.debug( "unavail portlet " + _pName);
				continue; 
			}
			
			String _pId;
			try {
				_pId = p.getString("id");
			} catch(Exception e) {
				_pId = System.currentTimeMillis()+"";
			}
//			System.out.println( p);
			PortletDefinition pd = registry.getPortletDefinitionByUniqueName( _pName);
			
			f = new FragmentImpl();
			f.setType( f.PORTLET);
			f.setId( _pId);
			f.setName(_pName);
			f.setPortlet( pd);
			NavigationalState nav = _rc.getPortalURL().getNavigationalState();
			WindowState _ws = nav.getMappedState(f.getId());
			
			String _pTitle = getTitle(f, getLocale( request));
			//-- 포틀릿의 상대적인 너비. 1 = 정사각형
			String sizex = getProperty(f, "SIZEX", "1");
			//-- 포틀릿의 상대적인  높이. 1 = 정사각형 포틀릿의 절반 높이
			String sizey = getProperty(f, "SIZEY", "2");
			String col = (p.getInt("col") + 1) + "";
			String row = (p.getInt("row") + 1) + "";
			
			Map contentBuffer = new HashMap();
			renderer.renderNow( f, _rc, contentBuffer); // 20120224 Modified
			String content = "";
			PortletContent portletContent = (PortletContent)contentBuffer.get("content");
			if( portletContent != null ) {
				content=  portletContent.getContent(); // 20120224 Modified
			}
			
			if( content.length() > 0 ) { // 20120224 Modified
				%>
				<div id="Enview_Portlet_<%=f.getId()%>" class="<%=portletClass%>" name="<%=_pName %>" data-row="<%=row%>" data-col="<%=col%>" data-sizex="<%=sizex%>" data-sizey="<%=sizey%>">
				<div class='portlet-header-my'>
				<div class="portlet-header-my-icon">
				<span class='ui-icon ui-icon-close' title='포틀릿 삭제'></span>
				<span class='ui-icon ui-icon-plus' title="포틀릿 추가"></span>
				</div>&nbsp;
				</div>
				<div id="Enview_Portlet_Content_<%=_pId%>" class="<%=portletContentClass%>"><%= content %></div>
				</div> <!-- portlet end -->
				<%
   			}
		}
	}
		%>
		</div> <!--portal-layout-->
<%	}
	catch(Exception e) {
		log.error( e, e);
	}
%>
