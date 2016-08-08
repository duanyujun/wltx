package com.wltx.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.wltx.model.City;
import com.wltx.model.District;
import com.wltx.utils.StringUtils;

public class CompanyController extends Controller {

	public void index(){
		render("company/companyList.jsp");
	}
	
	public void list(){
		String sumSql = "select count(*) from t_company";
		String sql = "select * from t_company";
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
				District company = lstDistrict.get(i);
				obj[0] = company.get("id");
				obj[1] = company.get("district_id");
				obj[2] = company.get("address");
				obj[3] = company.get("contract");
				obj[4] = company.get("telephone");
				obj[5] = company.get("mobile");
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
			District company = District.dao.findById(id);
			setAttr("company", company);
		}
		List<City> lstCity = City.dao.find("select * from t_city");
		setAttr("lstCity", lstCity);
		render("company/companyForm.jsp");
	}
	
	public void save() throws UnsupportedEncodingException{
		String name = StringUtils.decode(getPara("name"));
		int cityId = getParaToInt("city_id");
		
		District company = new District();
		company.set("name", name);
		company.set("city_id", cityId);
		
		if(StringUtils.isNotBlank(getPara("id"))){
			company.set("id", getPara("id"));
			company.update();
		}else{
			company.save();
		}
		
		renderJson(1);
	}
	
	public void del(){
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String whereSql = " where id in (" + ids +")";
			Db.update("delete from t_company "+whereSql);
			renderJson(1);
		}else{
			renderJson(0);
		}
	}
}
