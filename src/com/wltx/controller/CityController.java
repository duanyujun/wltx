package com.wltx.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.wltx.model.City;
import com.wltx.utils.StringUtils;

public class CityController extends Controller {

	public void index(){
		render("city/cityList.jsp");
	}
	
	public void list(){
		String sumSql = "select count(*) from t_city";
		String sql = "select * from t_city";
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
		case 2:
			orderSql = " order by longitude "+sortType;
			break;
		case 3:
			orderSql = " order by latitude "+sortType;
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
		List<City> lstCity = new ArrayList<City>();
		Object[] data = null;
		if(recordsTotal!=0){
			lstCity = City.dao.find(sql+whereSql+orderSql+limitSql);
			data = new Object[lstCity.size()];
			for(int i=0; i<lstCity.size(); i++){
				Object[] obj = new Object[5];
				City city = lstCity.get(i);
				obj[0] = city.get("id");
				obj[1] = city.get("name");
				obj[2] = city.get("longitude");
				obj[3] = city.get("latitude");
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
			City city = City.dao.findById(id);
			setAttr("city", city);
		}
		
		render("city/cityForm.jsp");
	}
	
	public void save() throws UnsupportedEncodingException{
		String name = StringUtils.decode(getPara("name"));
		String longitude = getPara("longitude");
		String latitude = getPara("latitude");
		
		City city = new City();
		city.set("name", name);
		city.set("longitude", longitude);
		city.set("latitude",latitude);
		if(StringUtils.isNotBlank(getPara("id"))){
			city.set("id", getPara("id"));
			city.update();
		}else{
			city.save();
		}
		
		renderJson(1);
	}
	
	public void del(){
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String whereSql = " where id in (" + ids +")";
			Db.update("delete from t_city "+whereSql);
			renderJson(1);
		}else{
			renderJson(0);
		}
	}
}
