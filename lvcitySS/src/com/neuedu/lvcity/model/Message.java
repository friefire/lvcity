package com.neuedu.lvcity.model;

public class Message {
	private int mid;
	private String tel;
	private String sex;
	private String name;
	private String message;
	public Message() {
		super();
	}
	public Message(int mid, String tel, String sex, String name, String message) {
		super();
		this.mid = mid;
		this.tel = tel;
		this.sex = sex;
		this.name = name;
		this.message = message;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
