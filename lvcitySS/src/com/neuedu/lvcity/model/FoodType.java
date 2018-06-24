package com.neuedu.lvcity.model;

public class FoodType {
	private int ftid;
	private String ft;
	public FoodType() {
		super();
	}
	public FoodType(int ftid, String ft) {
		super();
		this.ftid = ftid;
		this.ft = ft;
	}
	public int getFtid() {
		return ftid;
	}
	public void setFtid(int ftid) {
		this.ftid = ftid;
	}
	public String getFt() {
		return ft;
	}
	public void setFt(String ft) {
		this.ft = ft;
	}

}
