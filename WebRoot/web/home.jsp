<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    <head>
        <meta charset="utf-8" />
        <title>系统管理</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <link href="http://fonts.useso.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/css/components-md.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="${ctx}/assets/global/css/plugins-md.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/layouts/layout4/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/layouts/layout4/css/themes/light.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="${ctx}/assets/layouts/layout4/css/custom.min.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/assets/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
		<script src="${ctx}/assets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>
        <link rel="shortcut icon" href="favicon.ico" /> 
    	<style type="text/css">
    		.page-content-wrapper .page-content{padding:0 0 0 20px;}
    	</style>
    
    </head>
    <!-- END HEAD -->
    

    <body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo page-md">
        <div class="page-header navbar navbar-fixed-top">
            <div class="page-header-inner ">
                <div class="page-logo">
                    <a href="index.html">
                        <img src="${ctx}/assets/layouts/layout4/img/logo-light.png" alt="logo" class="logo-default" /> </a>
                    <div class="menu-toggler sidebar-toggler">
                    </div>
                </div>
                <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
                <div class="page-top">
                    <div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                            <li class="dropdown dropdown-user dropdown-dark">
                                <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                    <span class="username username-hide-on-mobile"> Nick </span>
                                    <img alt="" class="img-circle" src="${ctx}/assets/layouts/layout4/img/avatar9.jpg" /> </a>
                                <ul class="dropdown-menu dropdown-menu-default">
                                    <li>
                                        <a href="page_user_profile_1.html">
                                            <i class="icon-user"></i> My Profile </a>
                                    </li>
                                    <li>
                                        <a href="app_calendar.html">
                                            <i class="icon-calendar"></i> My Calendar </a>
                                    </li>
                                    <li>
                                        <a href="app_inbox.html">
                                            <i class="icon-envelope-open"></i> My Inbox
                                            <span class="badge badge-danger"> 3 </span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="app_todo_2.html">
                                            <i class="icon-rocket"></i> My Tasks
                                            <span class="badge badge-success"> 7 </span>
                                        </a>
                                    </li>
                                    <li class="divider"> </li>
                                    <li>
                                        <a href="page_user_lock_1.html">
                                            <i class="icon-lock"></i> Lock Screen </a>
                                    </li>
                                    <li>
                                        <a href="page_user_login_1.html">
                                            <i class="icon-key"></i> Log Out </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"> </div>
        <div class="page-container">
            <div class="page-sidebar-wrapper">
                <div class="page-sidebar navbar-collapse collapse">
                    <ul class="page-sidebar-menu   " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                        <li class="nav-model nav-item">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-settings"></i>
                                <span class="title">功能</span>
                                <span class="selected"></span>
                                <span class="arrow open"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item">
                                    <a href="/monitor" class="nav-link ">
                                        <span class="title">表格监控</span>
                                        <span class="selected"></span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="/monitor" class="nav-link ">
                                        <span class="title">地图监控</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="/monitor" class="nav-link ">
                                        <span class="title">数据管理</span>
                                    </a>
                                </li>
                                
                                <li class="nav-item  ">
                                    <a href="/monitor" class="nav-link ">
                                        <span class="title">数据统计</span>
                                    </a>
                                </li>
                                
                                <li class="nav-item  ">
                                    <a href="/monitor" class="nav-link ">
                                        <span class="title">实时数据</span>
                                    </a>
                                </li>
                                
                                <li class="nav-item  ">
                                    <a href="/monitor" class="nav-link ">
                                        <span class="title">历史数据</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        
                        <li class="nav-model nav-item">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-settings"></i>
                                <span class="title">系统管理</span>
                                <span class="selected"></span>
                                <span class="arrow open"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="/monitor" class="nav-link ">
                                        <span class="title">角色管理</span>
                                    </a>
                                </li>
                                
                                <li class="nav-item  ">
                                    <a href="/monitor" class="nav-link ">
                                        <span class="title">权限管理</span>
                                    </a>
                                </li>
                                
                                <li class="nav-item  ">
                                    <a href="/user" class="nav-link ">
                                        <span class="title">人员管理</span>
                                    </a>
                                </li>
                                
                            </ul>
                        </li>
                        
                    </ul>
                </div>
            </div>
            <div class="page-content-wrapper">
                <div class="page-content">
                    <div class="row">
                        <div id="main-content" class="col-md-12">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="page-footer">
            <div class="page-footer-inner"> 2016 &copy; CZF Co.
            </div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div>
        
        <input type="hidden" id="urlHidden" />
        
        <!-- END FOOTER -->
        <!--[if lt IE 9]>
<script src="${ctx}/assets/global/plugins/respond.min.js"></script>
<script src="${ctx}/assets/global/plugins/excanvas.min.js"></script> 
<![endif]-->
        <!-- BEGIN CORE PLUGINS -->
        <script src="${ctx}/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/global/scripts/app.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/layouts/layout4/scripts/layout.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/layouts/layout4/scripts/demo.min.js" type="text/javascript"></script>
        <script src="${ctx}/assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
    </body>

<script type="text/javascript">

$(function(){  
	init();
});

function init(){
	$('.sub-menu li a').click(function(e) {
        e.preventDefault();
        var url = this.href;
        if (url != null && url != 'javascript:;') {
        
        	$(".nav-model").removeClass("active");
        	$(".nav-model").removeClass("open");
        	
        	var subLi = $(".sub-menu li");
        	subLi.removeClass("active");
        	subLi.removeClass("open");
        	
        	var modelItem = $(this).parent().parent().parent();
        	modelItem.addClass("active");
        	modelItem.addClass("open");
        	
        	$(this).parent().addClass("active");
        	$(this).parent().addClass("open");
        
        	
        	$('#main-content').load(url);
        	$('#urlHidden').val(url);
        }
    });
}



</script>

</html>
