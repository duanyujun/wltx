package com.wltx.model;

import java.util.Map;

import com.jfinal.plugin.activerecord.Table;
import com.jfinal.plugin.activerecord.TableMapping;

public class Model<M extends Model<M>> extends com.jfinal.plugin.activerecord.Model<M> {

	private static final long serialVersionUID = 1L;
	
	private Table tableInfo = TableMapping.me().getTable(getClass());
	
	private String[] pk = tableInfo.getPrimaryKey(); // 主键的名称

	private String tableName = tableInfo.getName();

	public String getTableName() {
		return tableName;
	}

	public String getName() {
		return this.getStr("name");
	}

	/**
	 * 主键的名称
	 */
	public String[] getPK() {
		return pk;
	}

	public Map<String, Object> getAttrs() {

		return super.getAttrs();
	}

	public Table getTableInfo() {

		return tableInfo;
	}

}
