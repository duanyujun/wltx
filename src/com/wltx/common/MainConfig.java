package com.wltx.common;

import com.alibaba.druid.wall.WallFilter;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.render.ViewType;
import com.wltx.controller.IndexController;
import com.wltx.controller.UserController;
import com.wltx.model.Permissions;
import com.wltx.model.Roles;
import com.wltx.model.RolesPermissions;
import com.wltx.model.Users;
import com.wltx.model.UsersRoles;


public class MainConfig extends JFinalConfig {

	@Override
	public void configConstant(Constants me) {
		// TODO Auto-generated method stub
		me.setViewType(ViewType.JSP);
		PropKit.use("config.properties");
	}

	@Override
	public void configRoute(Routes me) {
		// TODO Auto-generated method stub
		me.add("/", IndexController.class);
		me.add("/user", UserController.class);
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
		
		me.add(arp);
	}

	@Override
	public void configInterceptor(Interceptors me) {
		// TODO Auto-generated method stub

	}

	@Override
	public void configHandler(Handlers me) {
		

	}
	
	public static void main(String[] args) {
		JFinal.start("WebRoot", 80, "/", 5);
	}

}



