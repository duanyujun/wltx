package com.wltx.model;

import java.util.Map;


/**
 * 权限（资源）
 * 
 * @author java
 * 
 */
public class Permissions extends Model<Permissions> {
	private static final long serialVersionUID = 1L;

	public static Permissions dao = new Permissions();
	
	public Map<String, Object> getAttrs(){
	    return super.getAttrs();
	}
}
