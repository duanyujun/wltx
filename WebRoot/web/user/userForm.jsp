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
        	  <input type="hidden" name="id" value="${user.attrs['id']}" />
		      <div class="form-body">
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>用户名：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="username" value="${user.attrs['username']}" placeholder="请输入用户名">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>密码：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="password" value="${user.attrs['password']}"  placeholder="请输入密码">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>姓名：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="name" value="${user.attrs['name']}"  placeholder="请输入姓名">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>手机号：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="mobile_no" value="${user.attrs['mobile_no']}"  placeholder="请输入手机号">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label">QQ：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="qq" value="${user.attrs['qq']}"  placeholder="请输入QQ">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label">Email：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="email" value="${user.attrs['email']}"  placeholder="请输入Email">
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label">用户状态：</label>
		              <div class="col-md-6">
		                   <label class="checkbox-inline">
						      <input type="radio" name="ustatus" id="s1" 
						         value="0" ${user.attrs['ustatus']==0?"checked":""}> 未激活
						   </label>
						   <label class="checkbox-inline">
						      <input type="radio" name="ustatus" id="s2" 
						         value="1" ${user.attrs['ustatus']==1?"checked":""}> 已激活
						   </label>
						   <label class="checkbox-inline">
						      <input type="radio" name="ustatus" id="s3" 
						         value="2" ${user.attrs['ustatus']==2?"checked":""}> 已注销
						   </label>
		              </div>
		              <div class="col-md-3"></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label">备注：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" name="remark" value="${user.attrs['remark']}"  placeholder="请输入备注">
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

