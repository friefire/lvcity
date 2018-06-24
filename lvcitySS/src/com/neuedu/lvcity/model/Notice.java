package com.neuedu.lvcity.model;

public class Notice {
	private int nid;
	private int ntid;
	private String nname;
	private int aid;
	public Notice() {
		super();
	}
	public Notice(int nid, int ntid, String nname, int aid) {
		super();
		this.nid = nid;
		this.ntid = ntid;
		this.nname = nname;
		this.aid = aid;
	}
	public int getNid() {
		return nid;
	}
	public void setNid(int nid) {
		this.nid = nid;
	}
	public int getNtid() {
		return ntid;
	}
	public void setNtid(int ntid) {
		this.ntid = ntid;
	}
	public String getNname() {
		return nname;
	}
	public void setNname(String nname) {
		this.nname = nname;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	
	
}
