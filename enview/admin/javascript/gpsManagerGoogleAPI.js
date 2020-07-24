	var opts=
	{
		enableHighAccuracy:true,
		timeout:10000,
		maximumAge:6000
	}
	
    function googlemap(latiTude, longiTude)
	{
       var latLng = new google.maps.LatLng(latiTude,longiTude);
	   var option=
	   {
	   	zoom:16,
		center:latLng,
		mapTypeId:google.maps.MapTypeId.ROADMAP
	   }
	   var myMap=document.getElementById("map");
	   var map=new google.maps.Map(myMap,option);
	   
	   var marker=new google.maps.Marker({
	   	position:latLng,
		title:'hello',
		map:map,
		icon:'/admin/gps/iconb1.png'

	   })
	}
	
	function error()
	 {
	  	alert('error');
	 }