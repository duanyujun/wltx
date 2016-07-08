<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<%@include file="/common/include.jsp" %>

<!DOCTYPE>
<html>
<head>
<title>监控系统</title>

<style type="text/css">
	.clear{ clear: both;}
	*{padding: 0px; margin: 0px;}
	 input:focus{outline: none;}
	 a{text-decoration: none;}
	 ul,li{ padding: 0px; margin: 0px; list-style: none;}
	 html{width: 100%; height: 100%; background: url(${ctx}/assets/images/login_background.png) center no-repeat; overflow: hidden;}
	.container{width: 834px; height: 100%; margin: 0 auto; overflow: hidden;display: table;}
	.system_name{margin-top: 50px;width: 100%; height: auto; padding: 0px 0px 70px 0px; text-align: center; color:#42C3B3; font-size: 36px; font-family: "微软雅黑"; letter-spacing: 4px; overflow: hidden;}
	.login_box{width: auto; height: auto; padding:0px 72px; overflow: hidden;display: table-cell;vertical-align: middle;}
	.box_left{float: left;}
	.box_right{ margin:0 auto; width: 370px; height:255px; padding:30px 30px 15px 30px; background: white; overflow: hidden;}
	.right_title{padding-bottom: 20px; color: #42C3B3; font-size: 24px; font-family:"微软雅黑";}
	.right_title span{padding-left: 6px; color: #B4C2BF; font-size: 14px;}
	.user_name,.password{height: 40px; margin-bottom: 14px; border-radius:6px; background: #E8F2F0;}
	.user_name input,.password input{width: 308px; height:40px; border: none; background: transparent; font-size: 14px;}
	.user_name input::-webkit-input-placeholder,.password input::-webkit-input-placeholder{ color: #B4C2BF; font-family: "微软雅黑";}
	.user_name span{background: url(${ctx}/assets/images/icon_user.png) center no-repeat;}
	.password span{background: url(${ctx}/assets/images/icon_password.png) center no-repeat;}
	.user_name span,.password span{ float: left; display: inline-block; width: 62px; height: 40px;}
	.submit_box{padding: 22px 0px 20px 0px;}
	.submit_box input{width: 175px; height: 40px; line-height: 40px; color: white; border: none; border-radius: 4px; font-size: 16px; font-family: "微软雅黑"; letter-spacing: 4px; cursor: pointer; overflow: hidden;}
	.submit_box input[type=reset]{float: left; background: #42C3B3;}
	.submit_box input[type=submit]{float: right; background: #D9534F;}
	.wj_pwd{text-align: right; color: #6C7D7A; font-size: 14px; font-family: "微软雅黑";}
	.wj_pwd a{color: #428BCA; text-decoration: underline;}
	.footer_fun_box{padding-top: 66px; text-align: center;font-family: "微软雅黑";}
	.footer_fun_box li{float: left; margin-right:6px; font-size: 14px; font-family: "微软雅黑";}
	.footer_fun_box a{display: inline-block; padding: 6px 6px 6px 26px; color: white; border-radius: 3px; background:url(${ctx}/resources/images/login/icon_list.png) 10px center no-repeat rgba(0,0,0,0.2); overflow: hidden;}
</style>

<script src="${ctx}/assets/dwz/js/jquery-2.1.4.min.js" type="text/javascript"></script>

</head>
<body style="height:100%;">
	<div class="container" id="container">
			<div class="login_box">
				<div class="from_box">
					<div class="box_left"></div>
					<div class="box_right">
						<form action="${ctx}/login" method="post" >
							<div class="right_title">用户登录<span>USER LOGIN</span></div>
							<div class="input_box">
								<div class="user_name"><span></span>
									<input type="text" name="username" value="" placeholder="请输入用户民">
								</div>
								<div class="password"><span></span>
									<input type="password" name="password" value="" placeholder="请输入密码">
								</div>
								<div class="submit_box">
									<input class="red" type="reset" name="" value="重置" />
									<input class="blue" type="submit" name="" value="登录" />
									<div class="clear"></div>
								</div>
								<div class="wj_pwd">
									<c:if test="${not empty error}">
										<span style="color: red;">${error}</span>	
									</c:if>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

</body>
</html>