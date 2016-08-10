package com.wltx.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.wltx.model.Company;
import com.wltx.model.District;
import com.wltx.utils.StringUtils;

public class CompanyController extends Controller {

	public void index(){
		render("company/companyList.jsp");
	}
	
	public void list(){
		String sumSql = "select count(*) from t_company";
		String sql = "select c.*, d.name district_name from t_company c, t_district d where c.district_id=d.id ";
		String orderSql = "";
		String whereSql = "";
		String limitSql = "";
		
		String search = getPara("search[value]");
		if(StringUtils.isNotBlank(search)){
			whereSql = " and name like '%"+search+"%'";
		}
		
		int sortColumn = getParaToInt("order[0][column]");
		String sortType = getPara("order[0][dir]");
		switch (sortColumn) {
		case 1:
			orderSql = " order by name "+sortType;
			break;
		case 2:
			orderSql = " order by district_name "+sortType;
			break;
		case 3:
			orderSql = " order by address "+sortType;
			break;
		case 4:
			orderSql = " order by contract "+sortType;
			break;
		case 5:
			orderSql = " order by telephone "+sortType;
			break;
		case 6:
			orderSql = " order by mobile "+sortType;
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
		List<Company> lstCompany = new ArrayList<Company>();
		Object[] data = null;
		if(recordsTotal!=0){
			lstCompany = Company.dao.find(sql+whereSql+orderSql+limitSql);
			data = new Object[lstCompany.size()];
			for(int i=0; i<lstCompany.size(); i++){
				Object[] obj = new Object[7];
				Company company = lstCompany.get(i);
				obj[0] = company.get("id");
				obj[1] = company.get("name");
				obj[2] = company.get("district_name");
				obj[3] = company.get("address");
				obj[4] = company.get("contract");
				obj[5] = company.get("telephone");
				obj[6] = company.get("mobile");
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
			Company company = Company.dao.findById(id);
			setAttr("company", company);
		}
		List<District> lstDistrict = District.dao.find("select d.*, c.name city_name from t_district d, t_city c where d.city_id = c.id order by c.name ");
		setAttr("lstDistrict", lstDistrict);
		render("company/companyForm.jsp");
	}
	
	public void save() throws UnsupportedEncodingException{
		String name = StringUtils.decode(getPara("name"));
		int district_id = getParaToInt("district_id");
		String address = StringUtils.decode(getPara("address"));
		String contract = StringUtils.decode(getPara("contract"));
		String telephone = StringUtils.decode(getPara("telephone"));
		String mobile = StringUtils.decode(getPara("mobile"));
		String remark = StringUtils.decode(getPara("remark"));
		
		Company company = new Company();
		company.set("name", name);
		company.set("district_id", district_id);
		company.set("address", address);
		company.set("contract", contract);
		company.set("telephone", telephone);
		company.set("mobile", mobile);
		company.set("remark", remark);
		
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
