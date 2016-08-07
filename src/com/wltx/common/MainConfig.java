package com.wltx.common;

import com.alibaba.druid.wall.WallFilter;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.ext.plugin.shiro.ShiroInterceptor;
import com.jfinal.ext.plugin.shiro.ShiroPlugin;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.JspRender;
import com.jfinal.render.ViewType;
import com.wltx.controller.CityController;
import com.wltx.controller.HomeController;
import com.wltx.controller.LoginController;
import com.wltx.controller.MonitorController;
import com.wltx.controller.PermissionController;
import com.wltx.controller.RoleController;
import com.wltx.controller.UserController;
import com.wltx.model.City;
import com.wltx.model.Company;
import com.wltx.model.District;
import com.wltx.model.Monitor;
import com.wltx.model.Permissions;
import com.wltx.model.Roles;
import com.wltx.model.RolesPermissions;
import com.wltx.model.Users;
import com.wltx.model.UsersRoles;


public class MainConfig extends JFinalConfig {
	
	private Routes routes;

	@Override
	public void configConstant(Constants me) {
		// TODO Auto-generated method stub
		me.setViewType(ViewType.JSP);
		PropKit.use("config.properties");
		me.setDevMode(false);
		
		me.setErrorView(401, "/web/error.jsp");
		me.setErrorView(403, "/web/error.jsp");
		me.setError404View("/web/error.jsp");
		me.setError500View("/web/error.jsp");
		
	}

	@Override
	public void configRoute(Routes me) {
		this.routes = me;
		
		me.add("/", LoginController.class, "web");
		me.add("/home", HomeController.class, "web");
		me.add("/monitor", MonitorController.class, "web");
		me.add("/user", UserController.class, "web");
		me.add("/role", RoleController.class, "web");
		me.add("/permission", PermissionController.class, "web");
		me.add("/city", CityController.class, "web");
		
	}

	@Override
	public void configPlugin(Plugins me) {
		
//		C3p0Plugin c3p0Plugin = new C3p0Plugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password"));
//		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		
		// Druid
		DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password"), PropKit.get("driverClass"));
		WallFilter wallFilter = new WallFilter();
		wallFilter.setDbType("mysql");
		druidPlugin.addFilter(wallFilter);
		me.add(druidPlugin);
	
		// ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		arp.setShowSql(true);
		arp.addMapping("users", Users.class);
		arp.addMapping("roles", Roles.class);
		arp.addMapping("permissions", Permissions.class);
		arp.addMapping("user_roles", UsersRoles.class);
		arp.addMapping("roles_permissions", RolesPermissions.class);
		arp.addMapping("t_city", City.class);
		arp.addMapping("t_district", District.class);
		arp.addMapping("t_monitor", Monitor.class);
		arp.addMapping("t_company", Company.class);
		me.add(arp);
		
		// 缓存插件
		me.add(new EhCachePlugin());
		
		// 加载Shiro插件
		ShiroPlugin shiroPlugin = new ShiroPlugin(routes);
		shiroPlugin.setLoginUrl("/web/login.jsp");
		shiroPlugin.setUnauthorizedUrl("/web/error.jsp");
		shiroPlugin.setSuccessUrl("/web/monitor/allMonitors.jsp");
		me.add(shiroPlugin);
	}

	@Override
	public void configInterceptor(Interceptors me) {
		me.add(new ShiroInterceptor());
	}

	@Override
	public void configHandler(Handlers me) {
		

	}
	
	public static void main(String[] args) {
		JFinal.start("WebRoot", 99, "/", 5);
	}

}



