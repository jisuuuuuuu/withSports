package com.sist.withSports.model;

import java.io.Serializable;

public class RevFile implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long revSeq;
	private long revFileSeq;
	private String revFileOrgName;
	private String revFileName;
	private String revFileExt;
	private long revFileSize;
	private String revRegDate;

	public RevFile()
	{
		revSeq = 0;
		revFileSeq = 0;
		revFileOrgName = "";
		revFileName = "";
		revFileExt = "";
		revFileSize = 0;
		revRegDate = "";
	}

	public long getrevSeq() {
		return revSeq;
	}

	public void setrevSeq(long revSeq) {
		this.revSeq = revSeq;
	}

	public long getrevFileSeq() {
		return revFileSeq;
	}

	public void setrevFileSeq(long revFileSeq) {
		this.revFileSeq = revFileSeq;
	}

	public String getrevFileOrgName() {
		return revFileOrgName;
	}

	public void setrevFileOrgName(String revFileOrgName) {
		this.revFileOrgName = revFileOrgName;
	}

	public String getrevFileName() {
		return revFileName;
	}

	public void setrevFileName(String revFileName) {
		this.revFileName = revFileName;
	}

	public String getrevFileExt() {
		return revFileExt;
	}

	public void setrevFileExt(String revFileExt) {
		this.revFileExt = revFileExt;
	}

	public long getrevFileSize() {
		return revFileSize;
	}

	public void setrevFileSize(long revFileSize) {
		this.revFileSize = revFileSize;
	}

	public String getrevRegDate() {
		return revRegDate;
	}

	public void setrevRegDate(String revRegDate) {
		this.revRegDate = revRegDate;
	}
}
