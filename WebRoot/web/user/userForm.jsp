<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<form class="form-horizontal" role="form">
      <div class="form-body">
          <div class="form-group">
              <label class="col-md-3 control-label">Block Help</label>
              <div class="col-md-9">
                  <input type="text" class="form-control" placeholder="Enter text">
                  <span class="help-block"> A block of help text. </span>
              </div>
          </div>
          <div class="form-group">
              <label class="col-md-3 control-label">Inline Help</label>
              <div class="col-md-9">
                  <input type="text" class="form-control input-inline input-medium" placeholder="Enter text">
                  <span class="help-inline"> Inline help. </span>
              </div>
          </div>
      </div>
</form>

<script type="text/javascript">
$(document).ready(function() {
    
});
</script>

