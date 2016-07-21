package com.wltx.controller;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;

import com.jfinal.core.Controller;
import com.wltx.constants.RolesConstants;

public class HomeController extends Controller {

	@RequiresRoles(value = { RolesConstants.ROLE_USER, RolesConstants.ROLE_ADMIN }, logical = Logical.OR)
	public void index() {

		render("home.jsp");
	}
	
}
