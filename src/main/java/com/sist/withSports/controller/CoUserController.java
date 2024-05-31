package com.sist.withSports.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.JsonUtil;
import com.sist.common.util.StringUtil;
import com.sist.withSports.model.CoUser;
import com.sist.withSports.model.Paging;
import com.sist.withSports.model.Prom;
import com.sist.withSports.model.Response;
import com.sist.withSports.service.CoUserService;
import com.sist.withSports.service.PromService;

@Controller("coUserController")
public class CoUserController {
	
	private Logger logger = LoggerFactory.getLogger(NmUserController.class);
	
	@Autowired
	private CoUserService coUserService;
	
	@Autowired
	private PromService promService;
	
	@Value("#{env['auth.cookie.couser']}")
	private String AUTH_COOKIE_CONAME;
	
	@Value("#{env['auth.cookie.nmuser']}")
	private String AUTH_COOKIE_NMNAME;
	
	private static final int LIST_COUNT = 5;		
	private static final int PAGE_COUNT = 5;
	
	@RequestMapping(value="/user/coLogin", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> coLogin(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String coId = HttpUtil.get(request, "coId");
		String coPwd = HttpUtil.get(request, "coPwd");
		
		CoUser coUser = null;
		
		if(!StringUtil.isEmpty(coId) && !StringUtil.isEmpty(coPwd))
		{
			coUser = coUserService.coUserSelect(coId);
			
			if(coUser != null)
			{
				if(StringUtil.equals(coUser.getCoPwd(), coPwd))
				{
					if(StringUtil.equals(coUser.getCoStatus(), "Y"))
					{
						if(CookieUtil.getCookie(request, AUTH_COOKIE_NMNAME) != null)
						{
							CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NMNAME);
						}
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_CONAME, CookieUtil.stringToHex(coId));
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(300, "Stopped");
					}
				}
				else
				{
					ajaxResponse.setResponse(-1, "PassWord Error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/coSCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> coSCheck(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String coValue = HttpUtil.get(request, "coValue");
		String ildan = HttpUtil.get(request, "ildan");
		
		CoUser coUser = new CoUser();
		
		if(!StringUtil.isEmpty(coUser) && !StringUtil.isEmpty(ildan))
		{
			if(StringUtil.equals(ildan, "1"))
			{
				coUser.setCoId(coValue);
				
				if(coUserService.coSameCheck(coUser) <= 0)
				{
					ajaxResponse.setResponse(10, "Success");
				}
				else
				{
					ajaxResponse.setResponse(11, "NmId Same");
				}
			}
			else if(StringUtil.equals(ildan, "2"))
			{
				coUser.setCoEmail(coValue);
				
				if(coUserService.coSameCheck(coUser) <= 0)
				{
					ajaxResponse.setResponse(20, "Success");
				}
				else
				{
					ajaxResponse.setResponse(13, "NmEmail Same");
				}
			}
			else
			{
				ajaxResponse.setResponse(500, "Server Error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /user/nmLogin response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/coSignUp", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> coSignUp(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String coId = HttpUtil.get(request, "coId");
		String coPwd = HttpUtil.get(request, "coPwd");
		String coName = HttpUtil.get(request, "coName");
		String coCeo = HttpUtil.get(request, "coCeo");
		String coNum = HttpUtil.get(request, "coNum");
		String coAddr = HttpUtil.get(request, "coAddr");
		String coTel = HttpUtil.get(request, "coTel");
		String coEmail = HttpUtil.get(request, "coEmail");
		String musa =  HttpUtil.get(request, "musa");
		
		
		CoUser coUser = new CoUser();
		
		if(!StringUtil.isEmpty(coId) && !StringUtil.isEmpty(coPwd) && !StringUtil.isEmpty(coName) && !StringUtil.isEmpty(coCeo) && !StringUtil.isEmpty(coNum)
				&& !StringUtil.isEmpty(coAddr) && !StringUtil.isEmpty(coEmail) && !StringUtil.isEmpty(coTel) && !StringUtil.isEmpty(musa))
		{
			if(StringUtil.equals(musa, "musa"))
			{
				coUser.setCoId(coId);
				coUser.setCoPwd(coPwd);
				coUser.setCoName(coName);
				coUser.setCoCeo(coCeo);
				coUser.setCoNum(coNum);
				coUser.setCoAddr(coAddr);
				coUser.setCoTel(coTel);
				coUser.setCoEmail(coEmail);
				coUser.setCoStatus("Y");
				
				if(coUserService.coInsert(coUser) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Deplicate");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/coMyPage")
	public String coMyPage(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//게시물 리스트(메인)
		List<Prom> list = null;
		//조회 겍체
		Prom search = new Prom();
		//페이징 객체
		Paging paging = null;
		//총 게시물 수
		long totalCount = 0;
		
		totalCount = promService.myCoPromListCnt(cookieCoId);
		
		if(totalCount > 0 )
		{
			paging = new Paging("/user/coMyPage", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			search.setCoId(cookieCoId);
			
			list = promService.myCoPromList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("cookieCoId", cookieCoId);
		
		return "/user/coMyPage";
	}
}
