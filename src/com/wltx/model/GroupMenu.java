package com.wltx.model;

import java.util.List;

public class GroupMenu {

	private String groupName;
	
	private List<Permissions> lstMenu;

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public List<Permissions> getLstMenu() {
		return lstMenu;
	}

	public void setLstMenu(List<Permissions> lstMenu) {
		this.lstMenu = lstMenu;
	}
	
}
