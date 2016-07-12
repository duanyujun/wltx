package com.wltx.controller;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;

import com.jfinal.core.Controller;

public class MonitorController extends Controller {

	@RequiresRoles(value = { "user", "admin" }, logical = Logical.OR)
	public void index() {
		render("monitor/table.jsp");
	}
	
}
