<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
<script src="${ctx}/assets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>
<script src="${ctx}/assets/global/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>

<div class="portlet light bordered" id="mainDiv">
    <div class="portlet-body">
        
        <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
            <thead>
                <tr>
                    <th><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                    <th>监控点名称</th>
                    <th>设备编号</th>
                    <th>在线状态</th>
                    <th>实时值</th>
                    <th>风机</th>
                    <th>净化器</th>
                    <th>状态</th>
                    <th>所属区域</th>
                    <th>刷新时间</th>
                </tr>
            </thead>
        </table>
    </div>
</div>

<script type="text/javascript">
$.ajaxSetup ({ 
    cache: false
}); 

$(document).ready(function() {
    $('#sample_1').dataTable( {
        "processing": true,
        "serverSide": true,
        "orderClasses": false,
        "pagingType": "bootstrap_full_number",
        "columnDefs": [{
            "targets": 0,
            "orderable": false,
            "searchable": false,
            "render": function ( data, type, full, meta ) {
                return '<input type="checkbox" class="checkboxes" data-id='+data+' />';
              }},
              {
                  "targets": 1,
                  "orderable": true,
                  "searchable": true,
                  "render": function ( data, type, full, meta ) {
                      return '<a href="" class="editClass" >'+data+'</a>';
                    }},
              {
                  "targets": 3,
                  "orderable": true,
                  "searchable": false,
                  "render": function ( data, type, full, meta ) {
                	  if(data==1){
                		  return "<img src='assets/pages/img/online.png' style='width:24px;height:24px;'/>";
                	  }else{
                		  return "<img src='assets/pages/img/offline.png' style='width:24px;height:24px;'/>";
                	  }
                    }},
              {
                  "targets": 5,
                  "orderable": true,
                  "searchable": false,
                  "render": function ( data, type, full, meta ) {
                	  if(data==1){
                		  return "<img src='assets/pages/img/fan_online.png' style='width:24px;height:24px;'/>";
                	  }else{
                		  return "<img src='assets/pages/img/fan_offline.png' style='width:24px;height:24px;'/>";
                	  }
                    }},
                {
                    "targets": 6,
                    "orderable": true,
                    "searchable": false,
                    "render": function ( data, type, full, meta ) {
                  	  if(data==1){
                  		  return "<img src='assets/pages/img/collect_online.png' style='width:24px;height:24px;'/>";
                  	  }else{
                  		  return "<img src='assets/pages/img/collect_offline.png' style='width:24px;height:24px;'/>";
                  	  }
                      }},
                 {
                     "targets": 7,
                     "orderable": true,
                     "searchable": false,
                     "render": function ( data, type, full, meta ) {
                   	  if(data=='正常'){
                   		  return "<span style='color:green;'>正常</span>";
                   	  }else{
                   		return "<span style='color:red;'>"+data+"</span>";
                   	  }
                     }}
        
        ],
        "order": [[3, 'desc']],
        "language": {
            "emptyTable": "暂 无 数  据",
            "info": "显示从_START_到_END_条，共_TOTAL_条记录",
            "infoEmpty": "暂 无 数  据",
            "infoFiltered": "(filtered1 from _MAX_ total records)",
            "lengthMenu": "每页显示_MENU_条记录",
            "search": "搜索:",
            "zeroRecords": "暂 无 数  据",
            "paginate": {
                "previous": "上一页",
                "next": "下一页",
                "last": "最后一页",
                "first": "第一页"
            }
        },
        "bStateSave": !0,
        "ajax": "/monitor/tlist"
    } );
    
    $('#sample_1').find(".group-checkable").change(function() {
        var e = jQuery(this).attr("data-set"),
        a = jQuery(this).is(":checked");
        jQuery(e).each(function() {
            a ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active")) : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"))
        }),
        jQuery.uniform.update(e)
    });
    $('#sample_1').on("change", "tbody tr .checkboxes",
    function() {
        $(this).parents("tr").toggleClass("active")
    });
    
    $('#sample_1').on('draw.dt', function () {
    	 $(this).find(".editClass").click(function(event){
    	       event.preventDefault();
    	       var id = $(this).parent().prev().children(0).attr("data-id");
    	       var url='/monitor/dataview?id='+id;  
   	           var name='查看数据明细';                     
   	           var iWidth=900;                      
   	           var iHeight=600; 
   	           //获得窗口的垂直位置 
   	           var iTop = (window.screen.availHeight - 30 - iHeight) / 2; 
   	           //获得窗口的水平位置 
   	           var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; 
   	           window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no'); 
    	 });
    } );
    
} );

function goInsert(id){
	var url = "/monitor/edit";
	if(id){
		var timestamp=new Date().getTime();
		url = url + "?id="+id+"&timestamp="+timestamp;
	}
	$('#main-content').load(url);
}

function goDelete(){
	if($("input[class='checkboxes']:checked").length==0){
		showToast(2, "请选择记录！", "温馨提示");
	}else{
		var ids = '';
		$("input[class='checkboxes']:checked").each(function(){
			ids += $(this).attr("data-id")+",";
		});
		if(ids!=''){
			 bootbox.setLocale("zh_CN");
			 bootbox.confirm("确定要删除?",
           	 function(o) {
               	if(o==true){
               		ids = ids.substring(0, ids.length-1);
           			$.post( "/monitor/del",
           			       {ids, ids},
           					function(result){
           						$('#main-content').load($('#urlHidden').val());
           						showToast(1, "删除成功！", "温馨提示");
           					}
           			);
               	}
          	 });
		}
	}
}

</script>

