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
		var infoColor;
		$.ajax({
			  url: "${ctx}/monitor/markers",
			  dataType: 'json',
			  success: function(data){
				  var tbody;
				  for(var i=0; i<data.length; i++){
					  if(data[i].purify_after>=2){
						  infoColor = " style='color:red;'";
					  }else{
						  infoColor = '';
					  }
					  tbody += "<tr class='cursor-pointer' onclick='setCenter("+data[i].longitude+","+data[i].latitude+", "+data[i].id+")'><td title='"+data[i].name+"'><nobr><span class=font-12 "+infoColor+">"+data[i].name+"</span></nobr></td></tr>";
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
		 hashmap.put(data.id,data);
		 
		 marker.addEventListener("click", function(){
			map.openInfoWindow(getInfoWindow(data), point); 
		 });
	}   
	
	function setCenter(longitude, latitude, id){
		var centerPoint = new BMap.Point(longitude, latitude);
		map.centerAndZoom(centerPoint, 17);  
		var data = hashmap.get(id);
		map.openInfoWindow(getInfoWindow(data), centerPoint); 
	}
	
	function getInfoWindow(data){
		var titleHTML = "<span style='color:red;'>详细信息</span>"
		var opts = {    
				 width : 325,     // 信息窗口宽度    
				 height: 180,     // 信息窗口高度    
				 title : titleHTML  // 信息窗口标题   
				};
		
		var nameColor = "<span>";
		if(data.purify_after>=2){
			nameColor = "<span style='color:red;'>";
		}
		var contentHTML = "监控点名称："+nameColor+data.name+"</span>";
		contentHTML += "<br>设备号："+data.collector_numb;
		contentHTML += "<br>刷新时间："+data.refresh_time;
		contentHTML += "<br><table class='table table-bordered'><thead><tr><th style='width:100px;'>油烟浓度</th><th style='width:100px;'>净化器状态</th><th style='width:100px;'>风机状态</th></tr></thead>";
		var purifyData = data.purify_after>=2?(data.purify_after+"<span style='color:red;'>（已超标）</span>"):data.purify_after;
		var purifierStatus = data.purifier_status==1?'<span style="color:green;">在线</span>':'<span style="color:red;">离线</span>';
		var fanStatus = data.fan_status==1?'<span style="color:green;">在线</span>':'<span style="color:red;">离线</span>';
		contentHTML += "<tbody><tr><td>"+purifyData+"</td><td>"+purifierStatus+"</td><td>"+fanStatus+"</td></tr></tbody></table>";
		var infoWindow = new BMap.InfoWindow(contentHTML, opts);  // 创建信息窗口对象    
		return infoWindow;
	}
	
</script>

