<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/assets/global/plugins/jquery.form.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>
<link href="${ctx}/assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/assets/global/plugins/bootstrap-select/js/bootstrap-select.min.js" type="text/javascript"></script>
<style>
.error{
	color:red;
}
</style>

<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase"> Managed Table</span>
        </div>
        
    </div>
    <div class="portlet-body">
        <form class="form-horizontal" role="form" id="form">
        	  <input type="hidden" name="id" value="${monitor.attrs.id}" />
		      <div class="form-body">
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>监控点名称：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="name" name="name" maxlength="100" required value="${monitor.attrs.name}" placeholder="请输入监控点名称">
		              </div>
		              <div class="col-md-3"><label for="name"></label></div>
		          </div>
		          <div class="form-group">
                      <label class="control-label col-md-3"><font color="red">*</font>所属企业：</label>
                      <div class="col-md-4">
                          <select class="bs-select form-control" data-live-search="true" name="company_id">
                          	  <c:forEach items="${lstCompany}" var="company">
                          	  		<option value="${company.attrs.id}">${company.attrs.name}</option>
                          	  </c:forEach>
                          </select>
                      </div>
                  </div>
                  <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>设备编号：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="monitor_no" name="monitor_no" maxlength="100" required value="${monitor.attrs.monitor_no}" placeholder="请输入设备编号">
		              </div>
		              <div class="col-md-3"><label for="monitor_no"></label></div>
		          </div>
                  <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>净化器型号：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="purifier_type" name="purifier_type" maxlength="100" required value="${monitor.attrs.purifier_type}" placeholder="请输入净化器型号">
		              </div>
		              <div class="col-md-3"><label for="purifier_type"></label></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>采集器型号：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="collector_type" name="collector_type" maxlength="100" required value="${monitor.attrs.collector_type}" placeholder="请输入采集器型号">
		              </div>
		              <div class="col-md-3"><label for="collector_type"></label></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>采集器编号：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="collector_numb" name="collector_numb" maxlength="100" required value="${monitor.attrs.collector_numb}" placeholder="请输入采集器编号">
		              </div>
		              <div class="col-md-3"><label for="collector_numb"></label></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>经度：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="longitude" name="longitude" maxlength="100" required value="${monitor.attrs.longitude}" placeholder="请输入经度">
		              </div>
		              <div class="col-md-3"><label for="longitude"></label></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>纬度：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="latitude" name="latitude" maxlength="100" required value="${monitor.attrs.latitude}" placeholder="请输入纬度">
		              </div>
		              <div class="col-md-3"><label for="latitude"></label></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>安装日期：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="create_date" name="create_date" maxlength="100" required value="${monitor.attrs.create_date}" placeholder="请输入安装日期">
		              </div>
		              <div class="col-md-3"><label for="create_date"></label></div>
		          </div>
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label">净化前：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="purify_pre" name="purify_pre" maxlength="100" value="${monitor.attrs.purify_pre}" placeholder="请输入净化前">
		              </div>
		              <div class="col-md-3"><label for="purify_pre"></label></div>
		          </div>
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label">净化后：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="purify_after" name="purify_after" maxlength="100"  value="${monitor.attrs.purify_after}" placeholder="请输入净化后">
		              </div>
		              <div class="col-md-3"><label for="purify_after"></label></div>
		          </div>
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label" >净化率（%）：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="purify_rate" name="purify_rate" maxlength="100"  value="${monitor.attrs.purify_rate}" placeholder="请输入净化率">
		              </div>
		              <div class="col-md-3"><label for="purify_rate"></label></div>
		          </div>
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label">是否超标：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="is_overproof" name="is_overproof" maxlength="1"  value="${monitor.attrs.is_overproof}" placeholder="请输入是否超标">
		              </div>
		              <div class="col-md-3"><label for="is_overproof"></label></div>
		          </div>
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label">净化器状态：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="purifier_status" name="purifier_status" maxlength="1"  value="${monitor.attrs.purifier_status}" placeholder="请输入净化器状态">
		              </div>
		              <div class="col-md-3"><label for="purifier_status"></label></div>
		          </div>
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label">风机状态：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="fan_status" name="fan_status" maxlength="1"  value="${monitor.attrs.fan_status}" placeholder="请输入风机状态">
		              </div>
		              <div class="col-md-3"><label for="fan_status"></label></div>
		          </div>
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label">采集器状态：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="collect_status" name="collect_status" maxlength="1"  value="${monitor.attrs.collect_status}" placeholder="请输入采集器状态">
		              </div>
		              <div class="col-md-3"><label for="collect_status"></label></div>
		          </div>
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label">是否离线：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="is_online" name="is_online" maxlength="1"  value="${monitor.attrs.is_online}" placeholder="请输入是否离线">
		              </div>
		              <div class="col-md-3"><label for="is_online"></label></div>
		          </div>
		          
		          <div class="form-group" style="display:none;">
		              <label class="col-md-3 control-label">刷新时间：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="refresh_time" name="refresh_time" maxlength="100"  value="${monitor.attrs.refresh_time}" placeholder="请输入刷新时间">
		              </div>
		              <div class="col-md-3"><label for="refresh_time"></label></div>
		          </div>
		          <div class="form-group" >
			          <div class="col-md-offset-3 col-md-9">
	                      <button type="button" class="btn green" onclick="save();">保 存</button>
	                      <button type="button" class="btn default" onclick="cancel();" style="margin-left:10px;">取 消</button>
	                  </div>
                  </div>
		      </div>
		</form>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	 $(".bs-select").selectpicker({
        noneSelectedText:'请选择',
        noneResultsText:"查询不到 {0}"
     });
	 
	 if('${monitor.attrs.company_id}'!=''){
		 $('.bs-select').selectpicker('val', '${monitor.attrs.company_id}');
	 }
	 
	 var validator = $("#form").validate({
			errorPlacement: function(error, element) {
				$( element )
					.closest( "form" )
						.find( "label[for='" + element.attr( "id" ) + "']" )
							.append( error );
			},
			errorElement: "span"
		});
	
});

function cancel(){
	$('#main-content').load($('#urlHidden').val());
}

function save(){
	var r = $("#form").valid(); 
	if(r==true){
		$.post(
			"/monitor/save",
			encodeURI(encodeURI(decodeURIComponent($('#form').formSerialize(),true))),
			function(result){
				$('#main-content').load($('#urlHidden').val());
				showToast(1, "保存成功！", "温馨提示");
				
        	}
		);
	}
}

</script>

