package com.wltx.service;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.plugin.activerecord.Db;
import com.leon.model.Roles;
import com.leon.model.RolesPermissions;
import com.leon.model.Users;

/**
 * @author java 用户service
 */
public class RolesService extends Service<Roles> {

	public static RolesService service = new RolesService(Roles.dao);

	public RolesService(Roles dao) {
		super(dao);
	}

	/**
	 * 客户的角色列表
	 * 
	 * @param user
	 * @return
	 */
	public List<Roles> getRoleList(Users user) {
		return this.findAll("SELECT r.* FROM roles r LEFT JOIN `user_roles` ur on ur.role_id=r.id where ur.user_id=?", user.getId());
	}

	/**
	 * 客户的角色列表
	 * 
	 * @param user
	 * @return
	 */
	public List<String> getRoleNameList(Users user) {
		return Db.query("SELECT r.role_name FROM roles r LEFT JOIN `user_roles` ur on ur.role_id=r.id where ur.user_id=?", user.getId());
	}

	/**
	 * 保存角色-权限关系
	 * 
	 * @param request
	 */
	public static void saverp(HttpServletRequest request) {
		Db.update("delete from roles_permissions;");

		Enumeration<String> paraNames = request.getParameterNames();
		while (paraNames.hasMoreElements()) {
			String params = (String) paraNames.nextElement();
			if (params.startsWith("role_")) {
				int roleId = Integer.valueOf(params.replace("role_", ""));
				String[] permissionsId = request.getParameterValues(params);

				for (String pid : permissionsId) {
					RolesPermissions rp = new RolesPermissions();
					rp.set("role_id", roleId);
					rp.set("permission_id", pid);
					rp.save();
				}
			}
		}

	}
}
