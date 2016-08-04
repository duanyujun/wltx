package com.wltx.model;

import java.util.Map;


/**
 * 
 */
public class Company extends Model<Company> {
	private static final long serialVersionUID = 1L;

	public static Company dao = new Company();
	
	public Map<String, Object> getAttrs(){
	    return super.getAttrs();
	}
	
}
