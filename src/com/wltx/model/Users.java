package com.wltx.model;

import java.util.Collection;


/**
 * 用户
 * 
 * @author java
 * 
 */
public class Users extends Model<Users> {
	private static final long serialVersionUID = 2920278340134539131L;

	public static Users dao = new Users();

	/** 用户名 */
	public String getUsername() {
		return this.getStr("username");
	}

	/** 密码 */
	public String getPassword() {
		return this.getStr("password");
	}

	public Collection<String> getRoleNameList() {
		return null;
	}
}
