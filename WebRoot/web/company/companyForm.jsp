<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/assets/global/plugins/jquery.form.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>
<link href="${ctx}/assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/assets/global/plugins/bootstrap-select/js/bootstrap-select.min.js" type="text/javascript"></script>

<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase"> Managed Table</span>
        </div>
    </div>
    <div class="portlet-body">
        <form class="form-horizontal" role="form" id="form">
        	  <input type="hidden" name="id" value="${company.attrs.id}" />
		      <div class="form-body">
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>单位名称：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="name" value="${company.attrs.name}" placeholder="请输入单位名称">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
                      <label class="control-label col-md-3"><font color="red">*</font>所在片区：</label>
                      <div class="col-md-4">
                          <select class="bs-select form-control" data-live-search="true" name="district_id">
                          	  <c:forEach items="${lstDistrict}" var="district">
                          	  		<option value="${district.attrs.id}">${district.attrs.name}</option>
                          	  </c:forEach>
                          </select>
                      </div>
                  </div>
                  <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>地址：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="name" value="${company.attrs.name}" placeholder="请输入地址">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>联系人：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="name" value="${company.attrs.contract}" placeholder="请输入联系人">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>电话：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="name" value="${company.attrs.telephone}" placeholder="请输入电话">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>手机：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="name" value="${company.attrs.mobile}" placeholder="请输入手机">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>备注：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="name" value="${company.attrs.remark}" placeholder="请输入备注">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
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
	 /*
	 if('${existRoleIds}'!=''){
		 var array = '${existRoleIds}'.split(",");
		 $('.bs-select').selectpicker('val', array);
	 }
	*/
});

function cancel(){
	$('#main-content').load($('#urlHidden').val());
}

function save(){
	$.post(
		"/company/save",
		encodeURI(encodeURI(decodeURIComponent($('#form').formSerialize(),true))),
		function(result){
			$('#main-content').load($('#urlHidden').val());
			showToast(1, "保存成功！", "温馨提示");
			
		}
	);
}

</script>

