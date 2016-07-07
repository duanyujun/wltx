package com.wltx.service;

import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.TableInfo;
import com.jfinal.plugin.activerecord.TableInfoMapping;
import com.jfinal.plugin.activerecord.tx.Tx;

public abstract class Service<M extends Model<M>> {

	public M model = null;
	public TableInfo table = null;
	public String tableName = null;

	public Service() {
	}

	public Service(M dao) {
		model = dao;

		table = TableInfoMapping.me().getTableInfo(model.getClass());

		tableName = table.getTableName();
	}

	/**
	 * 查询所有数据
	 * 
	 * @return
	 */
	public List<M> findAll() {
		return model.find("select * from " + table.getTableName());
	}

	public M find(Object id) {
		return (M) model.findById(id);
	}

	public List<M> findByPropertity(String propertity, Object value) {
		return model.find("select * from " + table.getTableName() + " where " + propertity + " = ? ", value);
	}

	public M findFirstByPropertity(String propertity, Object value) {
		return (M) model.findFirst("select * from " + table.getTableName() + " where " + propertity + " = ? ", value);
	}

	public boolean save(M record) {
		return record.save();
	}

	public boolean delete(M record) {
		return record.delete();
	}

	public boolean deleteById(Object id) {
		return model.deleteById(id);
	}

	@Before(Tx.class)
	public Integer deleteByIds(Object[] ids) {
		int c = 0;

		for (Object id : ids) {
			if (model.deleteById(id)) {
				c++;
			}
		}

		return c;
	}

	public boolean update(M record) {
		return record.update();
	}

	public TableInfo getTableInfo() {
		return table;
	}

	public List<M> findAll(String sql, Object... paras) {

		return model.find(sql, paras);
	}

	public M findFirst(String sql, Object... paras) {

		return model.findFirst(sql, paras);
	}
}
