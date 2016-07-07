package com.wltx.service;

import com.wltx.model.UsersRoles;


/**
 * @author java 权限service
 */
public class UsersRolesService extends Service<UsersRoles> {

	public static UsersRolesService service = new UsersRolesService(UsersRoles.dao);

	public UsersRolesService(UsersRoles dao) {
		super(dao);
	}
}
