package com.wltx.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.wltx.model.Company;
import com.wltx.model.Monitor;
import com.wltx.utils.StringUtils;

public class MonitorController extends Controller {

	public void index(){
		render("monitor/monitorList.jsp");
	}
	
	public void mapview(){
		render("monitor/mapview.jsp");
	}
	
	public void list(){
		String sumSql = "select count(*) from t_monitor";
		String sql = "select d.*, c.name company_name from t_monitor d, t_company c where d.company_id=c.id ";
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
			orderSql = " order by company_name "+sortType;
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
		List<Monitor> lstmonitor = new ArrayList<Monitor>();
		Object[] data = null;
		if(recordsTotal!=0){
			lstmonitor = Monitor.dao.find(sql+whereSql+orderSql+limitSql);
			data = new Object[lstmonitor.size()];
			for(int i=0; i<lstmonitor.size(); i++){
				Object[] obj = new Object[5];
				Monitor monitor = lstmonitor.get(i);
				obj[0] = monitor.get("id");
				obj[1] = monitor.get("name");
				obj[2] = monitor.get("company_name");
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
			Monitor monitor = Monitor.dao.findById(id);
			setAttr("monitor", monitor);
		}
		List<Company> lstCompany = Company.dao.find("select * from t_company");
		setAttr("lstCompany", lstCompany);
		render("monitor/monitorForm.jsp");
	}
	
	public void save() throws UnsupportedEncodingException{
		String name = StringUtils.decode(getPara("name"));
		int companyId = getParaToInt("company_id");
		String purifier_type = StringUtils.decode(getPara("purifier_type"));
		String collector_type = StringUtils.decode(getPara("collector_type"));
		String collector_numb = StringUtils.decode(getPara("collector_numb"));
		String longitude = getPara("longitude");
		String latitude = getPara("latitude");
		String create_date = getPara("create_date");
		String purify_pre = getPara("purify_pre");
		String purify_after = getPara("purify_after");
		String purify_rate = getPara("purify_rate");
		
		int is_overproof = getParaToInt("is_overproof");
		int purifier_status = getParaToInt("purifier_status");
		int fan_status = getParaToInt("fan_status");
		int collect_status = getParaToInt("collect_status");
		int is_online = getParaToInt("is_online");
		String refresh_time = getPara("refresh_time");
		
		Monitor monitor = new Monitor();
		monitor.set("name", name);
		monitor.set("company_id", companyId);
		monitor.set("purifier_type", purifier_type);
		monitor.set("collector_type", collector_type);
		monitor.set("collector_numb", collector_numb);
		monitor.set("longitude", longitude);
		monitor.set("latitude", latitude);
		monitor.set("create_date", create_date);
		monitor.set("purify_pre", purify_pre);
		monitor.set("purify_after", purify_after);
		monitor.set("purify_rate", purify_rate);
		monitor.set("is_overproof", is_overproof);
		monitor.set("purifier_status", purifier_status);
		monitor.set("fan_status", fan_status);
		monitor.set("collect_status", collect_status);
		monitor.set("is_online", is_online);
		monitor.set("refresh_time", refresh_time);
		
		if(StringUtils.isNotBlank(getPara("id"))){
			monitor.set("id", getPara("id"));
			monitor.update();
		}else{
			monitor.save();
		}
		
		renderJson(1);
	}
	
	public void del(){
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String whereSql = " where id in (" + ids +")";
			Db.update("delete from t_monitor "+whereSql);
			renderJson(1);
		}else{
			renderJson(0);
		}
	}
	
	public void markers() {
		List<Monitor> listMonitor = Monitor.dao.find("select * from t_monitor ");
		renderJson(listMonitor);
	}
	
}
