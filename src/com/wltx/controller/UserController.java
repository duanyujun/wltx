package com.wltx.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.wltx.model.Users;

public class UserController extends Controller {

	public void index(){
		List<Users> users = Users.dao.find("select * from users");
		setAttr("users", users);
		System.err.println(users.size());
		render("user/userList.jsp");
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
