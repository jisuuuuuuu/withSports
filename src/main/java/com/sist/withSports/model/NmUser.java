package com.sist.withSports.model;

import java.io.Serializable;

public class NmUser implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String nmId;
	private String nmPwd;
	private String nmName;
	private String nmNickname;
	private String nmEmail;
	private String nmTel;
	private String nmDate;
	private String nmStatus;
	
	private String sameChkNum;
	private String nmValue;
	
	public NmUser()
	{
		nmId = "";
		nmPwd = "";
		nmName = "";
		nmNickname = "";
		nmEmail = "";
		nmTel = "";
		nmDate = "";
		nmStatus = "";
		
		sameChkNum = "";
		nmValue = "";
	}

	public String getNmId() {
		return nmId;
	}

	public void setNmId(String nmId) {
		this.nmId = nmId;
	}

	public String getNmPwd() {
		return nmPwd;
	}

	public void setNmPwd(String nmPwd) {
		this.nmPwd = nmPwd;
	}

	public String getNmName() {
		return nmName;
	}

	public void setNmName(String nmName) {
		this.nmName = nmName;
	}

	public String getNmNickname() {
		return nmNickname;
	}

	public void setNmNickname(String nmNickname) {
		this.nmNickname = nmNickname;
	}

	public String getNmEmail() {
		return nmEmail;
	}

	public void setNmEmail(String nmEmail) {
		this.nmEmail = nmEmail;
	}

	public String getNmTel() {
		return nmTel;
	}

	public void setNmTel(String nmTel) {
		this.nmTel = nmTel;
	}

	public String getNmDate() {
		return nmDate;
	}

	public void setNmDate(String nmDate) {
		this.nmDate = nmDate;
	}

	public String getNmStatus() {
		return nmStatus;
	}

	public void setNmStatus(String nmStatus) {
		this.nmStatus = nmStatus;
	}

	public String getSameChkNum() {
		return sameChkNum;
	}

	public void setSameChkNum(String sameChkNum) {
		this.sameChkNum = sameChkNum;
	}

	public String getNmValue() {
		return nmValue;
	}

	public void setNmValue(String nmValue) {
		this.nmValue = nmValue;
	}

}
