package com.neuedu.lvcity.model;

public class Contact {
	private int contactid;
	private String contactname;
	private String tel;
	private String qq;
	private String web;
	private String zipcode;
	private String fax;
	private String address;
	public Contact() {
		super();
	}
	public Contact(int contactid, String contactname, String tel, String qq, String web, String zipcode, String fax,
			String address) {
		super();
		this.contactid = contactid;
		this.contactname = contactname;
		this.tel = tel;
		this.qq = qq;
		this.web = web;
		this.zipcode = zipcode;
		this.fax = fax;
		this.address = address;
	}
	public int getContactid() {
		return contactid;
	}
	public void setContactid(int contactid) {
		this.contactid = contactid;
	}
	public String getContactname() {
		return contactname;
	}
	public void setContactname(String contactname) {
		this.contactname = contactname;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getWeb() {
		return web;
	}
	public void setWeb(String web) {
		this.web = web;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	
}
