<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>


<style type="text/css">
	.font-12{
		font-size:12px;
	}
	.cursor-pointer{
		cursor:pointer;
	}
</style>

<div class="portlet light bordered">
    <div class="portlet-body" style="padding-top:0px;padding-bottom:0px;padding-left:5px;">
        <div class="row" >
        	<div class="col-md-10" id="map" style="min-height:610px;">
        		
        	</div>
        	<div class="col-md-2" style="height:610px;overflow-x:hidden; overflow-y:scroll; ">
        		<table class="table table-striped table-hover">
				  <caption>监控点列表</caption>
				  <tbody id="tbody" >
				    
				  </tbody>
				</table>
        	</div>
        </div>
    </div>
</div>

<script src="${ctx}/assets/pages/scripts/hashmap.js" type="text/javascript"></script>
<script type="text/javascript">
	var map;
	var hashmap = new HashMap(); 
	$(document).ready(function() {
		initMap();
		drawMarkers();
	});
	
	function initMap(){
		map = new BMap.Map("map");          
		var point = new BMap.Point(114.072005, 22.553989);
		map.centerAndZoom(point, 15);  
		map.addControl(new BMap.NavigationControl());    
		map.addControl(new BMap.ScaleControl());    
		map.addControl(new BMap.OverviewMapControl());    
		map.addControl(new BMap.MapTypeControl());    
		map.enableScrollWheelZoom();
		map.enableKeyboard();
	}
	
	function drawMarkers(){
		$.ajax({
			  url: "${ctx}/monitor/markers",
			  dataType: 'json',
			  success: function(data){
				  var tbody;
				  for(var i=0; i<data.length; i++){
					  tbody += "<tr class='cursor-pointer' onclick='setCenter("+data[i].longitude+","+data[i].latitude+", "+data[i].id+")'><td title='"+data[i].name+"'><nobr><span class=font-12>"+data[i].name+"</span></nobr></td></tr>";
					  var onePoint = new BMap.Point(data[i].longitude, data[i].latitude);
					  
					  addMarker(onePoint, i, data[i]);
				  }
				  $("#tbody").append(tbody);
			  }
		});
	}
	
	function addMarker(point, index, data){
		var myIcon = new BMap.Icon("${ctx}/assets/pages/img/marker.png", new BMap.Size(23, 25), {    
		   offset: new BMap.Size(10, 25)
		 });      
		 var marker = new BMap.Marker(point, {icon: myIcon});    
		 map.addOverlay(marker);    
		 hashmap.put(data.id,marker);
		 
		 marker.addEventListener("click", function(){   
				var opts = {    
						 width : 250,     // 信息窗口宽度    
						 height: 100,     // 信息窗口高度    
						 title : data.name  // 信息窗口标题   
						};
				var infoWindow = new BMap.InfoWindow(data.name, opts);  // 创建信息窗口对象    
				map.openInfoWindow(infoWindow, point); 
			 });
		
	}   
	
	function setCenter(longitude, latitude, id){
		var centerPoint = new BMap.Point(longitude, latitude);
		map.centerAndZoom(centerPoint, 17);  
		
		var centerIcon = new BMap.Icon("${ctx}/assets/pages/img/marker-checked.png", new BMap.Size(23, 25), {    
			   offset: new BMap.Size(10, 25)
		}); 
		var marker = hashmap.get(id);
		marker.setIcon(centerIcon);
	}
	
</script>

