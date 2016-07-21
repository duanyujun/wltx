package com.wltx.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.wltx.model.Roles;
import com.wltx.utils.StringUtils;

public class RoleController extends Controller {

	public void index(){
		render("role/roleList.jsp");
	}
	
	public void list(){
		String sumSql = "select count(*) from roles";
		String sql = "select * from roles";
		String orderSql = "";
		String whereSql = "";
		String limitSql = "";
		
		String search = getPara("search[value]");
		if(StringUtils.isNotBlank(search)){
			whereSql = " where role_name like '%"+search+"%'"+" OR role_name_cn like '%"+search+"%'"+" OR description like '%"+search+"%'";
		}
		
		int sortColumn = getParaToInt("order[0][column]");
		String sortType = getPara("order[0][dir]");
		switch (sortColumn) {
		case 1:
			orderSql = " order by role_name "+sortType;
			break;
		case 2:
			orderSql = " order by role_name_cn "+sortType;
			break;
		case 3:
			orderSql = " order by description "+sortType;
			break;
		default:
			break;
		}
		
		int start = getParaToInt("start");
		int length = getParaToInt("length");
		if(length!=-1){
			limitSql = " limit "+start+","+length;
		}
		Long recordsTotal = Db.queryLong(sumSql+whereSql);
		List<Roles> lstRoles = new ArrayList<Roles>();
		Object[] data = null;
		if(recordsTotal!=0){
			lstRoles = Roles.dao.find(sql+whereSql+orderSql+limitSql);
			data = new Object[lstRoles.size()];
			for(int i=0; i<lstRoles.size(); i++){
				Object[] obj = new Object[4];
				Roles roles = lstRoles.get(i);
				obj[0] = roles.get("id");
				obj[1] = roles.get("role_name");
				obj[2] = roles.get("role_name_cn");
				obj[3] = roles.get("description");
				data[i] = obj;
			}
		}
		if(data==null){
			data = new Object[0];
		}
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("draw", getParaToInt("draw"));
		map.put("recordsTotal", recordsTotal);
		map.put("recordsFiltered", recordsTotal);
		map.put("data", data);
		
		renderJson(map);
	}
	
	public void edit(){
		String id = getPara("id");
		if(id!=null){
			Roles roles = Roles.dao.findById(id);
			setAttr("roles", roles);
		}
		
		render("role/roleForm.jsp");
	}
	
	public void save() throws UnsupportedEncodingException{
		String role_name = getPara("role_name");
		String role_name_cn = StringUtils.decode(getPara("role_name_cn"));
		String description = StringUtils.decode(getPara("description"));
		
		Roles roles = new Roles();
		roles.set("role_name", role_name);
		roles.set("role_name_cn", role_name_cn);
		roles.set("description",description);
		if(StringUtils.isNotBlank(getPara("id"))){
			roles.set("id", getPara("id"));
			roles.update();
		}else{
			roles.save();
		}
		
		renderJson(1);
	}
	
	public void del(){
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String whereSql = " where id in (" + ids +")";
			Db.update("delete from users "+whereSql);
			renderJson(1);
		}else{
			renderJson(0);
		}
	}
}
