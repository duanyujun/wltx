package com.wltx.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.wltx.model.District;
import com.wltx.utils.StringUtils;

public class DistrictController extends Controller {

	public void index(){
		render("district/districtList.jsp");
	}
	
	public void list(){
		String sumSql = "select count(*) from t_district";
		String sql = "select * from t_district";
		String orderSql = "";
		String whereSql = "";
		String limitSql = "";
		
		String search = getPara("search[value]");
		if(StringUtils.isNotBlank(search)){
			whereSql = " where name like '%"+search+"%'";
		}
		
		int sortColumn = getParaToInt("order[0][column]");
		String sortType = getPara("order[0][dir]");
		switch (sortColumn) {
		case 1:
			orderSql = " order by name "+sortType;
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
		List<District> lstDistrict = new ArrayList<District>();
		Object[] data = null;
		if(recordsTotal!=0){
			lstDistrict = District.dao.find(sql+whereSql+orderSql+limitSql);
			data = new Object[lstDistrict.size()];
			for(int i=0; i<lstDistrict.size(); i++){
				Object[] obj = new Object[5];
				District district = lstDistrict.get(i);
				obj[0] = district.get("id");
				obj[1] = district.get("name");
				obj[2] = district.get("longitude");
				obj[3] = district.get("latitude");
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
			District district = District.dao.findById(id);
			setAttr("district", district);
		}
		
		render("district/districtForm.jsp");
	}
	
	public void save() throws UnsupportedEncodingException{
		String name = StringUtils.decode(getPara("name"));
		int cityId = getParaToInt("city_id");
		
		District district = new District();
		district.set("name", name);
		district.set("city_id", cityId);
		
		if(StringUtils.isNotBlank(getPara("id"))){
			district.set("id", getPara("id"));
			district.update();
		}else{
			district.save();
		}
		
		renderJson(1);
	}
	
	public void del(){
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String whereSql = " where id in (" + ids +")";
			Db.update("delete from t_district "+whereSql);
			renderJson(1);
		}else{
			renderJson(0);
		}
	}
}
