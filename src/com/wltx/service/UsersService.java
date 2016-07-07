package com.wltx.service;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.plugin.activerecord.Db;
import com.wltx.model.Users;
import com.wltx.model.UsersRoles;

/**
 * @author java 用户service
 */
public class UsersService extends Service<Users> {

	public static UsersService service = new UsersService(Users.dao);

	public UsersService(Users dao) {
		super(dao);
	}

	/**
	 * 根据用户名查询用户
	 * 
	 * @param userName
	 * @return
	 */
	public Users getByUsername(String userName) {
		return this.findFirstByPropertity("username", userName);
	}

	/**
	 * 保存用户-角色关系
	 * 
	 * @param request
	 */
	public void saveur(HttpServletRequest request) {
		Db.update("delete from user_roles;");
		Enumeration<String> paraNames = request.getParameterNames();
		while (paraNames.hasMoreElements()) {
			String params = (String) paraNames.nextElement();
			if (params.startsWith("user_")) {
				int userId = Integer.valueOf(params.replace("user_", ""));
				String[] roleIds =  request.getParameterValues(params);

				for (String rid : roleIds) {
					UsersRoles rp = new UsersRoles();
					rp.set("role_id", rid);
					rp.set("user_id", userId);
					rp.save();
				}
			}
		}
	}

}
