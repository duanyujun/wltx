package com.wltx.model;

import java.util.Map;

import com.jfinal.plugin.activerecord.Model;


/**
 * 
 */
public class City extends Model<City> {
	private static final long serialVersionUID = 1L;

	public static City dao = new City();
	
	public Map<String, Object> getAttrs(){
	    return super.getAttrs();
	}
	
}
