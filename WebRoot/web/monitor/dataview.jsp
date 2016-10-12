<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>

<html lang="en">
<head>
        <meta charset="utf-8" />
        <title>${monitor_name} - 数据明细</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <link href="${ctx}/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
        
 		<script src="${ctx}/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
		<script src="${ctx}/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
		<script src="${ctx}/assets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>
		
    
    </head>

<body>
	<div id="main-content" class="col-md-12" style="width:100%;margin-top:10px;">
		 <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
            <thead>
                <tr>
                    <th>数据时间</th>
                    <th>净化后</th>
                    <th>风机</th>
                    <th>净化器</th>
                    <th>状态</th>
                </tr>
            </thead>
        </table>
	</div>
</body>


<script type="text/javascript">
$.ajaxSetup ({ 
    cache: false
}); 

$(document).ready(function() {
    $('#sample_1').dataTable( {
        "processing": true,
        "serverSide": true,
        "searching" : false,
        "orderClasses": false,
        "pagingType": "bootstrap_full_number",
        "columnDefs": [
              {
                  "targets": 2,
                  "orderable": true,
                  "searchable": false,
                  "render": function ( data, type, full, meta ) {
                	  if(data==1){
                		  return "<img src='${ctx}/assets/pages/img/fan_online.png' style='width:24px;height:24px;'/>";
                	  }else{
                		  return "<img src='${ctx}/assets/pages/img/fan_offline.png' style='width:24px;height:24px;'/>";
                	  }
                    }},
                {
                    "targets": 3,
                    "orderable": true,
                    "searchable": false,
                    "render": function ( data, type, full, meta ) {
                  	  if(data==1){
                  		  return "<img src='${ctx}/assets/pages/img/collect_online.png' style='width:24px;height:24px;'/>";
                  	  }else{
                  		  return "<img src='${ctx}/assets/pages/img/collect_offline.png' style='width:24px;height:24px;'/>";
                  	  }
                      }},
                 {
                     "targets": 4,
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
        "order": [[0, 'desc']],
        "language": {
            "emptyTable": "暂 无 数  据",
            "info": "显示从_START_到_END_条，共_TOTAL_条记录",
            "infoEmpty": "暂 无 数  据",
            "infoFiltered": "(filtered1 from _MAX_ total records)",
            "lengthMenu": "每页显示_MENU_条记录",
            "zeroRecords": "暂 无 数  据",
            "paginate": {
                "previous": "上一页",
                "next": "下一页",
                "last": "最后一页",
                "first": "第一页"
            }
        },
        "bStateSave": !0,
        "ajax": "/monitor/alldata?monitor_no="+"${monitor_no}"
    } );
    
} );


</script>
</html>
