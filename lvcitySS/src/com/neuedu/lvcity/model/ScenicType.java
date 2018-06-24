package com.neuedu.lvcity.model;

public class ScenicType {
	private int stid;
	private String st;
	
	
	
	public ScenicType() {
		super();
	}
	public ScenicType(int stid, String st) {
		super();
		this.stid = stid;
		this.st = st;
	}
	public int getStid() {
		return stid;
	}
	public void setStid(int stid) {
		this.stid = stid;
	}
	public String getSt() {
		return st;
	}
	public void setSt(String st) {
		this.st = st;
	}
	
}
