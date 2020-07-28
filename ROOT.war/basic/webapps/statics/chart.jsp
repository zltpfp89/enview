<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
var chartid="pie2d_2";
</script>
<script type="text/javascript" src="/javascript/jquery/jquery-1.10.2.min.js"></script>
<script language="JavaScript" src="/chart/JSClass/FusionCharts.js"></script>
<script type="text/javascript" src="/lib/js/gallery-lib.js" defer="defer"></script>
<script type="text/javascript" src="/lib/jquery/prettify/prettify.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/jquery/prettify/prettify.css" />
<link rel="stylesheet" href="/theme/style.css" type="text/css" />
<script type="text/javascript" src="/lib/js/flash_detect.js"></script>
<style type="text/css">
	body
	{
		background-color:#FFFFFF;
	}
</style>
</head>
<body>
<div class="charts-wrapper">
    <h1>2D Pie Chart</h1>
	<div class="chart-container" id="getChartProps"> 
    <!--<div id="loading-msg" style="position: absolute; top: 48%; left: 48%; font-size:11px; z-index: 999999">Loading...</div>-->
    	<div class="chart-slider">   
		<iframe id="dragNodeXMLFrame" name='dragNodeXMLFrame' scrolling="no"  style="height:0px; width:0px;display:none; z-index:2000;  background:rgba(255,255,255,.95); position:absolute; top:0; left:0;" frameborder="0" src=""></iframe>	
            <div id="chart1div">
            <noscript>
	<!-- START Code Block for Chart sampleChart -->
	<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="400" height="300" id="sampleChart">
		<param name="allowScriptAccess" value="always" />
		<param name="movie" value="/demos/gallery/Charts/Pie2D.swf?registerWithJS=1"/>		
		<param name="FlashVars" value="&chartWidth=400&chartHeight=300&debugMode=0&dataURL=/demos/gallery/Data/Pie2D2.xml" />
		<param name="quality" value="high" />
		<embed src="/demos/gallery/Charts/Pie2D.swf?registerWithJS=1" FlashVars="&chartWidth=400&chartHeight=300&debugMode=0&dataURL=/demos/gallery/Data/Pie2D2.xml" quality="high" width="400" height="300" name="sampleChart" allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	</object>
	<!-- END Code Block for Chart sampleChart -->
	</noscript>
              <p>&nbsp;</p>
              <!--p>FusionCharts needs Adobe Flash Player(for Flash Based charts) or JavaScript(for pure JavaScript (HTML5) based charts) to run. If you're unable to see the charts here, it means that your browser does not seem to have the Flash Player Installed or JavaScript enabled with proper support. You can downloaded Flash Player <a href="http://www.adobe.com/products/flashplayer/" target="_blank"><u>here</u></a> for free. For JavaScript you need to check upgrade your browser version.</p-->
            </div>
            <!--div class="chartdiv"><img src="../../theme/charts.jpg" width="542" height="257"  /></div-->
            <div class="data-wrapper">  
            <pre id="data-container" class="prettyprint lang-json" ></pre>
            </div> 
        </div>
       
   	</div>	
     <script type="text/javascript">
		//console.log(1);
		var currentRenderer = 'javascript';	 		
		
		if(!FlashDetect.installed && currentRenderer == 'flash')
		{
			currentRenderer = 'javascript';
			//jQuery('.chart-nav-left').css('display',"block");
	    }
		if(!FlashDetect.installed )
		{			
			jQuery('.chart-nav-left').css('display',"none");
		}
		
		
	//	console.log(currentRenderer);
	//console.log(currentRenderer);
	 var imageUrl = "images/gallery-icons/Pie2D2.jpg";
	 	
		if(imageUrl.toLowerCase().indexOf("widgets")>-1)
		{
			function FC_Loaded(DOMId)	
			{
				jQuery("#loading-msg").hide();
				if(!FlashDetect.installed )
				{					
					jQuery('.chart-nav-left').css('display',"none");
				}
				else
				{
					jQuery('.chart-nav-left').css('display',"block");
				}
			}
			
		}
		else
		{
		 	FusionCharts.addEventListener('loaded', function () {
				if(!FlashDetect.installed )
				{
					
					jQuery('.chart-nav-left').css('display',"none");
				}
				else
				{
					jQuery('.chart-nav-left').css('display',"block");
				}
				jQuery("#loading-msg").hide()
			});
		}
	   var chartObj;
	 	 window.onload = function() { 
	   FusionCharts.setCurrentRenderer(currentRenderer);
	  
        chartObj = new FusionCharts({
           swfUrl: "/chart/charts/Pie2D.swf",
           width: "400", height: "300",
           id: 'sampleChart',
           dataSource: "/statics/chart.xml",
           dataFormat: FusionChartsDataFormats.XMLURL,           
           renderAt: 'chart1div'
        }).render();
	   
	   rendererAfterToggle  = FusionCharts.getCurrentRenderer();
	   
		// Slide easing effect
		jQuery.extend (jQuery.easing, {
			easeInOutExpo: function (x, t, b, c, d) {
				if (t==0) return b;
				if (t==d) return b+c;
				if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
				return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
			}
		});

   
		
		
	
	   jQuery("#fancybox-wrap #fancybox-title").css({'width': 450});	   	
       jQuery(".charts-wrapper").css({'width': 450});		
	   jQuery(".chart-container").css({'width': 450, 'height':300});
	   jQuery(".chart-slider").css({'width': 450 + 450  });	   
	   jQuery('#chart1div').css({'height':300, 'width':450});
	   jQuery(".data-wrapper").css({'height':300, 'width':450});	  
	   jQuery("#data-container").css({'height':280, 'width':450-20});
	   	  
	 
	   
	   var chartFrame = $("#fancybox-content", parent.document.body);	   
	   
	   chartFrame.css({'height': 550});
	   
	   
	  }
	   
		</script>
    <div class="chart-info-holder">
		<div class="reloadChart">
				<a onClick="return reloadChart(450);"  title="Reload Chart" class="reload" style="display:none;"><span class="underline">Reload Chart</span></a>
		</div>
			
        <p>With pie sliced out initially.</p>
        
        <div class="chart-nav-holder">
            <div class="chart-nav-left" style="display:none;">
			
			
			View chart in: 
			
			
			<span>
           
		   
		   
             <a id="render-flash-button" href="javascript:swapRenderer('flash')" title="View Flash Chart" class="flash 
			 
			 "><span>Flash</span></a>
			
				
			<a id="render-javascript-button" href="javascript:swapRenderer('javascript')" title="View JavaScript Chart" class="js
			 render-active-chart
			
			"><span>JavaScript</span></a>
			
			</span></div>
			<div class="chart-nav-right">View data in: <span><a onClick="return viewData('xml');" href="/demos/gallery/Data/Pie2D2.xml" title="View XML" class="xml"><span>XML</span></a> | <a href="javascript:void(0);" onClick="return viewData('json');"  title="View JSON" class="json"><span>JSON</span></a></span></div>
        </div>
            
        
    </div>
    
</div>
  </body>
</html>