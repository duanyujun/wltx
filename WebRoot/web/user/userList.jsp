<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>


<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase"> Managed Table</span>
        </div>
        
    </div>
    <div class="portlet-body">
        <div class="table-toolbar">
            <div class="row">
                <div class="col-md-6">
                    <div class="btn-group">
                        <button id="sample_editable_1_new" onclick="goInsert();" class="btn sbold green"> Add New
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="btn-group pull-right">
                        <button class="btn green  btn-outline dropdown-toggle" data-toggle="dropdown">Tools
                            <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu pull-right">
                            <li>
                                <a href="javascript:;">
                                    <i class="fa fa-print"></i> Print </a>
                            </li>
                            <li>
                                <a href="javascript:;">
                                    <i class="fa fa-file-pdf-o"></i> Save as PDF </a>
                            </li>
                            <li>
                                <a href="javascript:;">
                                    <i class="fa fa-file-excel-o"></i> Export to Excel </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
            <thead>
                <tr>
                    <th>
                        <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /> </th>
                    <th> 用户名 </th>
                    <th> 姓名 </th>
                    <th> 电话 </th>
                    <th> QQ </th>
                    <th> 邮件 </th>
                    <th> 状态 </th>
                </tr>
            </thead>
        </table>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    $('#sample_1').dataTable( {
        "processing": true,
        "serverSide": true,
        "pagingType": "bootstrap_full_number",
        "columnDefs": [{
            "targets": 0,
            "orderable": false,
            "searchable": false,
            "render": function ( data, type, full, meta ) {
                return '<input type="checkbox" data-id='+data+' />';
              }
        }],
        "order": [[1, 'asc']],
        "language": {
            "emptyTable": "暂 无 数  据",
            "info": "显示从_START_到_END_  共_TOTAL_条记录",
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
        "ajax": "/user/list"
    } );
} );

function goInsert(){
	$('#main-content').load("/user/edit");
}

</script>

