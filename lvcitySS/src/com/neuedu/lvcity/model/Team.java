package com.neuedu.lvcity.model;

public class Team {
	private int teamid;
	private String content;
	
	
	public Team() {
		super();
	}
	public Team(int teamid, String content) {
		super();
		this.teamid = teamid;
		this.content = content;
	}
	public int getTeamid() {
		return teamid;
	}
	public void setTeamid(int teamid) {
		this.teamid = teamid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
