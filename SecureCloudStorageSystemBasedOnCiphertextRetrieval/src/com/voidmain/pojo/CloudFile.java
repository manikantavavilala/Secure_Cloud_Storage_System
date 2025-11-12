package com.voidmain.pojo;

public class CloudFile {

	private int fileid;
	private String filename;
	private String filedescription;
	private String uploadedon;
	private String ownerid;
	private String filekey;
	private String uploadstatus;
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFiledescription() {
		return filedescription;
	}
	public void setFiledescription(String filedescription) {
		this.filedescription = filedescription;
	}
	public String getUploadedon() {
		return uploadedon;
	}
	public void setUploadedon(String uploadedon) {
		this.uploadedon = uploadedon;
	}
	public String getOwnerid() {
		return ownerid;
	}
	public void setOwnerid(String ownerid) {
		this.ownerid = ownerid;
	}
	public String getFilekey() {
		return filekey;
	}
	public void setFilekey(String filekey) {
		this.filekey = filekey;
	}
	public int getFileid() {
		return fileid;
	}
	public void setFileid(int fileid) {
		this.fileid = fileid;
	}
	public String getUploadstatus() {
		return uploadstatus;
	}
	public void setUploadstatus(String uploadstatus) {
		this.uploadstatus = uploadstatus;
	}
	
}
