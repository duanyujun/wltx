package com.wltx.service;

import com.wltx.model.RolesPermissions;

/**
 * @author java 权限service
 */
public class RolesPermissionService extends Service<RolesPermissions> {

	public static RolesPermissionService service = new RolesPermissionService(RolesPermissions.dao);

	public RolesPermissionService(RolesPermissions dao) {
		super(dao);
	}
}
