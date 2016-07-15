package com.wltx.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.wltx.model.Users;

public class UserController extends Controller {

	public void index(){
		//List<Users> users = Users.dao.find("select * from users");
		//setAttr("users", users);
		//System.err.println(users.size());
		render("user/userList.jsp");
	}
	
	public void list(){
		List<Users> lstUsers = Users.dao.find("select * from users");
		Long recordsTotal = Db.queryLong("select count(*) from users");
		Object[] data = new Object[lstUsers.size()];
		for(int i=0; i<lstUsers.size(); i++){
			Object[] obj = new Object[7];
			Users users = lstUsers.get(i);
			obj[0] = users.get("id");
			obj[1] = users.get("username");
			obj[2] = users.get("name");
			obj[3] = users.get("mobile_no");
			obj[4] = users.get("qq");
			obj[5] = users.get("email");
			obj[6] = users.get("status");
			data[i] = obj;
		}
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("draw", 1);
		map.put("recordsTotal", recordsTotal);
		map.put("recordsFiltered", recordsTotal);
		map.put("data", data);
		
		renderJson(map);
	}
	
	public void form(){
		render("form.jsp");
	}
	
	public void submit(){
		Users user = getModel(Users.class, "user");
		if(user.get("id")==null){
			user.save();
		}else{
			user.update();
		}
		redirect("/user");
	}
	
	public void edit(){
		String id = getPara(0);
		if(id!=null){
			Users user = Users.dao.findById(id);
			setAttr("user", user);
		}
		
		form();
	}
	
	public void del(){
		//index();
		String id = getPara(0);
		Users.dao.deleteById(id);
		redirect("/user");
	}
	
}
