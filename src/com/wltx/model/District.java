package com.wltx.model;

import java.util.Map;


/**
 * 
 */
public class District extends Model<District> {
	private static final long serialVersionUID = 1L;

	public static District dao = new District();
	
	public Map<String, Object> getAttrs(){
	    return super.getAttrs();
	}
	
}
