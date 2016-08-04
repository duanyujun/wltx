package com.wltx.model;

import java.util.Map;


/**
 * 
 */
public class Monitor extends Model<Monitor> {
	private static final long serialVersionUID = 1L;

	public static Monitor dao = new Monitor();
	
	public Map<String, Object> getAttrs(){
	    return super.getAttrs();
	}
	
}
