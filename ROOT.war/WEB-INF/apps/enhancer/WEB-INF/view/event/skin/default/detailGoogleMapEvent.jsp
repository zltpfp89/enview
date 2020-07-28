<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head> 
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script> 
		<script type="text/javascript">  
			var Lat = '<c:out value="${GPS.LAT}"/>';
			var Lon = '<c:out value="${GPS.LON}"/>';
			function initialize() {
				var latlng = new google.maps.LatLng(Lat, Lon);     
				var myOptions = {zoom: 16 ,center: latlng ,mapTypeId: google.maps.MapTypeId.ROADMAP ,mapTypeControl: false ,streetViewControl:false};     
				var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
				var marker = new google.maps.Marker({
					position: latlng,
					map: map
				});   
			}			
		</script> 
	</head> 
	<body onload="initialize()">   
		<div id="map_canvas" style="width:217px; height:240px;"></div> 
	</body> 
</html>