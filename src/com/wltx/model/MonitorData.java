package com.wltx.model;

import java.util.Map;

import com.jfinal.plugin.activerecord.Model;


/**
 * 
 */
public class MonitorData extends Model<MonitorData> {
	private static final long serialVersionUID = 1L;

	public static MonitorData dao = new MonitorData();
	
	public Map<String, Object> getAttrs(){
	    return super.getAttrs();
	}
	
}
