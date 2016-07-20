<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/assets/global/plugins/jquery.form.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>

<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase"> Managed Table</span>
        </div>
        
    </div>
    <div class="portlet-body">
        <form class="form-horizontal" role="form" id="form">
        	  <input type="hidden" name="id" value="${user.id}" />
		      <div class="form-body">
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>用户名：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="username" value="${user.username}" placeholder="请输入用户名">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>密码：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="password" value="${user.password}"  placeholder="请输入密码">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>姓名：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="name" value="${user.name}"  placeholder="请输入姓名">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>手机号：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="mobile_no" value="${user.mobile_no}"  placeholder="请输入手机号">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label">QQ：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="qq" value="${user.qq}"  placeholder="请输入QQ">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label">Email：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="email" value="${user.email}"  placeholder="请输入Email">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label">备注：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="remark" value="${user.remark}"  placeholder="请输入备注">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
			          <div class="col-md-offset-3 col-md-9">
	                      <button type="button" class="btn green" onclick="save();">提 交</button>
	                      <button type="button" class="btn default" onclick="cancel();" style="margin-left:10px;">取 消</button>
	                  </div>
                  </div>
		      </div>
		</form>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	
});

function cancel(){
	$('#main-content').load($('#urlHidden').val());
}

function showToast(type, title, content){
	toastr.options = {
			  "closeButton": true,
			  "debug": false,
			  "positionClass": "toast-top-right",
			  "onclick": null,
			  "showDuration": "1000",
			  "hideDuration": "1000",
			  "timeOut": "5000",
			  "extendedTimeOut": "1000",
			  "showEasing": "swing",
			  "hideEasing": "linear",
			  "showMethod": "fadeIn",
			  "hideMethod": "fadeOut"
			};
	
	if(type==1){
		toastr.success(title, content);
	}else if(type==2){
		
		toastr.info(title, content);
	}else if(type==3){
		
		toastr.warning(title, content);
	}else if(type==4){
		
		toastr.error(title, content);
	}
	
}

function save(){
	$.post(
		"/user/save",
		encodeURI(encodeURI(decodeURIComponent($('#form').formSerialize(),true))),
		function(result){
			$('#main-content').load($('#urlHidden').val());
			showToast(1, "保存成功！", "温馨提示");
			
		}
	);
}

</script>

