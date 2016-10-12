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
import com.wltx.model.MonitorData;
import com.wltx.utils.StringUtils;

public class MonitorController extends Controller {

	public void index(){
		render("monitor/monitorList.jsp");
	}
	
	public void mapview(){
		render("monitor/mapview.jsp");
	}
	
	public void tableview(){
		render("monitor/tableview.jsp");
	}
	
	public void dataview(){
		String id = getPara("id");
		if(StringUtils.isNotBlank(id)){
			Monitor monitor = Monitor.dao.findFirst("select * from t_monitor where id = ?", id);
			setAttr("monitor_name", monitor.get("name"));
			setAttr("monitor_no", monitor.get("monitor_no"));
		}
		render("monitor/dataview.jsp");
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
	
	public void tlist(){
		String sumSql = "select count(d.id) from t_monitor d, t_company c, t_district t where d.company_id=c.id and c.district_id = t.id";
		String sql = "select d.*, c.name company_name, t.name district_name from t_monitor d, t_company c, t_district t where d.company_id=c.id and c.district_id = t.id ";
		String orderSql = "";
		String whereSql = "";
		String limitSql = "";
		
		String search = getPara("search[value]");
		if(StringUtils.isNotBlank(search)){
			whereSql = " and ( d.name like '%"+search+"%'" + " or monitor_no like '%"+search+"%'"+ " or t.name like '%"+search+"%'" + ")";
		}
		
		int sortColumn = getParaToInt("order[0][column]");
		String sortType = getPara("order[0][dir]");
		switch (sortColumn) {
		case 1:
			orderSql = " order by name "+sortType;
			break;
		case 2:
			orderSql = " order by monitor_no "+sortType;
			break;
		case 3:
			orderSql = " order by is_online "+sortType;
			break;
		case 4:
			orderSql = " order by purify_after "+sortType;
			break;
		case 5:
			orderSql = " order by fan_status "+sortType;
			break;
		case 6:
			orderSql = " order by collect_status "+sortType;
			break;
		case 7:
			orderSql = " order by monitor_status "+sortType;
			break;
		case 8:
			orderSql = " order by district_name "+sortType;
			break;
		case 9:
			orderSql = " order by refresh_time "+sortType;
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
				Object[] obj = new Object[10];
				Monitor monitor = lstmonitor.get(i);
				obj[0] = monitor.get("id");
				obj[1] = monitor.get("name");
				obj[2] = monitor.get("monitor_no");
				obj[3] = monitor.get("is_online");
				obj[4] = monitor.get("purify_after");
				obj[5] = monitor.get("fan_status");
				obj[6] = monitor.get("collect_status");
				obj[7] = monitor.get("monitor_status");
				obj[8] = monitor.get("district_name");
				obj[9] = monitor.get("refresh_time");
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
	
	public void alldata(){
		String monitor_no = getPara("monitor_no");
		if(monitor_no!=null){
			List<MonitorData> lstMonitorData = MonitorData.dao.find("select * from t_monitor where monitor_no = ?", monitor_no);
			setAttr("lstData", lstMonitorData);
		}
		render("monitor/alldata.jsp");
		
		
		String sumSql = "select count(*) from t_monitor_data where monitor_no = '"+monitor_no+"'";
		String sql = "select * from t_monitor_data where monitor_no = '"+monitor_no+"'";
		String orderSql = "";
		String whereSql = "";
		String limitSql = "";
		
		String search = getPara("search[value]");
		if(StringUtils.isNotBlank(search)){
			//DO Nothing
		}
		
		int sortColumn = getParaToInt("order[0][column]");
		String sortType = getPara("order[0][dir]");
		switch (sortColumn) {
		case 0:
			orderSql = " order by refresh_time "+sortType;
			break;
		case 1:
			orderSql = " order by purify_after "+sortType;
			break;
		case 2:
			orderSql = " order by fan_status "+sortType;
			break;
		case 3:
			orderSql = " order by purifier_status "+sortType;
			break;
		case 4:
			orderSql = " order by monitor_status "+sortType;
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
		List<MonitorData> lstmonitorData = new ArrayList<MonitorData>();
		Object[] data = null;
		if(recordsTotal!=0){
			lstmonitorData = MonitorData.dao.find(sql+whereSql+orderSql+limitSql);
			data = new Object[lstmonitorData.size()];
			for(int i=0; i<lstmonitorData.size(); i++){
				Object[] obj = new Object[5];
				MonitorData monitor = lstmonitorData.get(i);
				obj[0] = monitor.get("refresh_time");
				obj[1] = monitor.get("purify_after");
				obj[2] = monitor.get("fan_status");
				obj[3] = monitor.get("purifier_status");
				obj[4] = monitor.get("monitor_status");
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
	
}
