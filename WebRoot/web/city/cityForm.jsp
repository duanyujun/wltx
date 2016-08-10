<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/assets/global/plugins/jquery.form.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>
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
        	  <input type="hidden" name="id" value="${city.attrs.id}" />
		      <div class="form-body">
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>城市名称：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="name" name="name" required value="${city.attrs.name}" placeholder="请输入城市名称">
		              </div>
		              <div class="col-md-3"><label for="name"></label></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>经度：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="longitude" name="longitude" required value="${city.attrs.longitude}"  placeholder="请输入经度">
		              </div>
		              <div class="col-md-3"><label for="longitude"></label></div>
		          </div>
		          <div class="form-group">
		              <label class="col-md-3 control-label"><font color="red">*</font>纬度：</label>
		              <div class="col-md-6">
		                  <input type="text" class="form-control" id="latitude" name="latitude" required value="${city.attrs.latitude}"  placeholder="请输入纬度">
		              </div>
		              <div class="col-md-3"><label for="latitude"></label></div>
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
 				"/city/save",
 				encodeURI(encodeURI(decodeURIComponent($('#form').formSerialize(),true))),
 				function(result){
 					$('#main-content').load($('#urlHidden').val());
 					showToast(1, "保存成功！", "温馨提示");
 					
 				}
 			);
	}
}

</script>

