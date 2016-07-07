package com.wltx.service;

import com.wltx.model.Permissions;


/**
 * @author java 权限service
 */
public class PermissionService extends Service<Permissions> {

	public static PermissionService service = new PermissionService(Permissions.dao);

	public PermissionService(Permissions dao) {
		super(dao);
	}
}
