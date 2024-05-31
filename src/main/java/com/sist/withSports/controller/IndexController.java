package com.sist.withSports.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.withSports.model.Prom;
import com.sist.withSports.model.Rev;
import com.sist.withSports.service.PromService;
import com.sist.withSports.service.RevService;

@Controller("indexController")
public class IndexController 
{	
	@Value("#{env['auth.cookie.couser']}")
	private String AUTH_COOKIE_CONAME;
	
	@Value("#{env['auth.cookie.nmuser']}")
	private String AUTH_COOKIE_NMNAME;
	
	@Autowired
	private PromService promService;
	
	@Autowired
	private RevService revService;
	
	@RequestMapping(value="/index")
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//게시물 리스트(메인)
		List<Prom> list = null;
		//조회 겍체
		Prom search = new Prom();
		//총 게시물 수
		long totalCount = 0;
		
		totalCount = promService.promListCnt(search);
		
		if(totalCount > 0 )
		{
			search.setStartRow(1);
			search.setEndRow(6);
			
			list = promService.promList(search);

		}
		
		model.addAttribute("list", list);
		
		//자유게시물 리스트
		List<Rev> list2 = null;
		//조회 겍체
		Rev search2 = new Rev();
		//총 게시물 수
		long totalCount2 = 0;
		
		totalCount2 = revService.revListCnt(search2);
		
		if(totalCount > 0 )
		{
			search2.setStartRow(1);
			search2.setEndRow(5);
			
			list2 = revService.revList(search2);
		}
		
		model.addAttribute("list2", list2);

		
		return "/index";
	}
	
	@RequestMapping(value="/user/logOut")
	public String logOut(HttpServletRequest request, HttpServletResponse response)
	{
		if(CookieUtil.getCookie(request, AUTH_COOKIE_CONAME) != null || CookieUtil.getCookie(request, AUTH_COOKIE_NMNAME) != null)
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_CONAME);
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NMNAME);
		}
		
		return "redirect: /";
	}
	
	//후에 삭제
	@RequestMapping(value="/user/login")
	public String login(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/login";
	}
	@RequestMapping(value="/user/signUp")
	public String signUp(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/signUp";
	}
	@RequestMapping(value="/user/nmFind")
	public String nmFind(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/nmFind";
	}
	
}
