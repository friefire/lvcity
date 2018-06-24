package com.neuedu.lvcity.model;

public class Admin {
	private int adminid;
	private String adminname;
	private String passwd;
	
	public Admin() {
		super();
	}

	
	public Admin(int adminid, String adminname, String passwd) {
		super();
		this.adminid = adminid;
		this.adminname = adminname;
		this.passwd = passwd;
	}


	public int getAdminid() {
		return adminid;
	}


	public void setAdminid(int adminid) {
		this.adminid = adminid;
	}


	public String getAdminname() {
		return adminname;
	}


	public void setAdminname(String adminname) {
		this.adminname = adminname;
	}


	public String getPasswd() {
		return passwd;
	}


	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	
	
}
