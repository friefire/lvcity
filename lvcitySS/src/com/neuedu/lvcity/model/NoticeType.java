package com.neuedu.lvcity.model;

public class NoticeType {
	private int ntid;
	private String nt;
	
	
	public NoticeType() {
		super();
	}
	public NoticeType(int ntid, String nt) {
		super();
		this.ntid = ntid;
		this.nt = nt;
	}
	public int getNtid() {
		return ntid;
	}
	public void setNtid(int ntid) {
		this.ntid = ntid;
	}
	public String getNt() {
		return nt;
	}
	public void setNt(String nt) {
		this.nt = nt;
	}
	
	
}
