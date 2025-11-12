package com.voidmain.pojo;

public class FileRequest {

	private int requestid;
	private int fileid;
	private String userid;
	private String requestedon;
	private String status;
	
	public int getRequestid() {
		return requestid;
	}
	public void setRequestid(int requestid) {
		this.requestid = requestid;
	}
	public int getFileid() {
		return fileid;
	}
	public void setFileid(int fileid) {
		this.fileid = fileid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getRequestedon() {
		return requestedon;
	}
	public void setRequestedon(String requestedon) {
		this.requestedon = requestedon;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
