package com.sist.withSports.controller;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.StringUtil;
import com.sist.common.util.JsonUtil;
import com.sist.withSports.model.Join;
import com.sist.withSports.model.Like;
import com.sist.withSports.model.NmUser;
import com.sist.withSports.model.Paging;
import com.sist.withSports.model.Prom;
import com.sist.withSports.model.Response;
import com.sist.withSports.model.Rev;
import com.sist.withSports.service.NmUserService;
import com.sist.withSports.service.PromService;
import com.sist.withSports.service.RevService;

@Controller("nmUserController")
public class NmUserController 
{
	private Logger logger = LoggerFactory.getLogger(NmUserController.class);
	
	@Autowired
	private NmUserService nmUserService;
	
	@Autowired
	private RevService revService;
	
	@Autowired
	private PromService promService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Value("#{env['auth.cookie.nmuser']}")
	private String AUTH_COOKIE_NMNAME;
	
	@Value("#{env['auth.cookie.couser']}")
	private String AUTH_COOKIE_CONAME;
	
	private static final int LIST_COUNT = 5;		
	private static final int PAGE_COUNT = 5;
	
	@RequestMapping(value="/user/nmLogin", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nmLogin(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String nmId = HttpUtil.get(request, "nmId");
		String nmPwd = HttpUtil.get(request, "nmPwd");
		
		NmUser nmUser = null;
		
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmPwd))
		{
			nmUser = nmUserService.nmUserSelect(nmId);
			
			if(nmUser != null)
			{
				if(StringUtil.equals(nmUser.getNmPwd(), nmPwd))
				{
					if(StringUtil.equals(nmUser.getNmStatus(), "Y"))
					{
						if(CookieUtil.getCookie(request, AUTH_COOKIE_CONAME) != null)
						{
							CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_CONAME);
						}
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NMNAME, CookieUtil.stringToHex(nmId));
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
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /user/nmLogin response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/nmSCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nmSCheck(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String sameChkNum = HttpUtil.get(request, "sameChkNum");
		String nmValue = HttpUtil.get(request, "nmValue");
		
		NmUser nmUser = new NmUser();
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug(sameChkNum);
		logger.debug(nmValue);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		if(!StringUtil.isEmpty(sameChkNum) && !StringUtil.isEmpty(nmValue))
		{
			nmUser.setSameChkNum(sameChkNum);
			nmUser.setNmValue(nmValue);
			
			logger.debug("3333333333333333333333333333333333333333333333333333");
			logger.debug(nmUser.getSameChkNum());
			logger.debug(nmUser.getNmValue());
			logger.debug("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			
			if(nmUserService.nmSameCheck(nmUser) <= 0)
			{
				ajaxResponse.setResponse(0, "Success");
			}
			else
			{
				if(StringUtil.equals(sameChkNum, "q"))
				{
					ajaxResponse.setResponse(11, "NmId Same");
				}
				else if(StringUtil.equals(sameChkNum, "w"))
				{
					ajaxResponse.setResponse(12, "NmNickName Same");
				}
				else if(StringUtil.equals(sameChkNum, "e"))
				{
					ajaxResponse.setResponse(13, "NmEmail Same");
				}
				else if(StringUtil.equals(sameChkNum, "r"))
				{
					ajaxResponse.setResponse(14, "NmTel Same");
				}
				else
				{
					ajaxResponse.setResponse(500, "Server Error");
				}
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /user/nmSCheck response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/nmSignUp", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nmSignUp(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String nmId = HttpUtil.get(request, "nmId");
		String nmPwd = HttpUtil.get(request, "nmPwd");
		String nmName = HttpUtil.get(request, "nmName");
		String nmNickname = HttpUtil.get(request, "nmNickname");
		String nmEmail = HttpUtil.get(request, "nmEmail");
		String nmTel = HttpUtil.get(request, "nmTel");
		String musa =  HttpUtil.get(request, "musa");
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug(nmId);
		logger.debug(nmPwd);
		logger.debug(nmName);
		logger.debug(nmNickname);
		logger.debug(nmEmail);
		logger.debug(nmTel);
		logger.debug(musa);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		NmUser nmUser = new NmUser();
		
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmPwd) && !StringUtil.isEmpty(nmName) && !StringUtil.isEmpty(nmNickname) && !StringUtil.isEmpty(nmEmail)
				&& !StringUtil.isEmpty(nmTel) && !StringUtil.isEmpty(musa))
		{
			if(StringUtil.equals(musa, "musa"))
			{
				nmUser.setNmId(nmId);
				nmUser.setNmPwd(nmPwd);
				nmUser.setNmName(nmName);
				nmUser.setNmNickname(nmNickname);
				nmUser.setNmEmail(nmEmail);
				nmUser.setNmTel(nmTel);
				nmUser.setNmStatus("Y");
				
				if(nmUserService.nmInsert(nmUser) > 0)
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
	
	@RequestMapping(value="/user/nmMyPage")
	public String nmMyPage(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug(cookieId);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		NmUser nmUser = null;
		
		if(cookieId != null)
		{
			nmUser = nmUserService.nmUserSelect(cookieId);
			
			if(nmUser != null)
			{
				model.addAttribute("nmUser", nmUser);
			}
		}
		return "/user/nmMyPage";
	}
	
	@RequestMapping(value="/user/nmUpdate")
	public String nmUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		
		NmUser nmUser = null;
		
		if(cookieId != null)
		{
			nmUser = nmUserService.nmUserSelect(cookieId);
			
			if(nmUser != null)
			{
				model.addAttribute("nmUser", nmUser);
			}
		}
		
		return "/user/nmUpdate";
	}
	
	@RequestMapping(value="/user/nmUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nmUpdateProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String nmId = HttpUtil.get(request, "nmId");
		String nmPwd = HttpUtil.get(request, "nmPwd");
		String nmName = HttpUtil.get(request, "nmName");
		String nmNickname = HttpUtil.get(request, "nmNickname");
		String nmEmail = HttpUtil.get(request, "nmEmail");
		String nmTel = HttpUtil.get(request, "nmTel");
		String musa =  HttpUtil.get(request, "musa");
		
		NmUser nmUser = new NmUser();
		
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmPwd) && !StringUtil.isEmpty(nmName) && !StringUtil.isEmpty(nmNickname) && !StringUtil.isEmpty(nmEmail)
				&& !StringUtil.isEmpty(nmTel) && !StringUtil.isEmpty(musa))
		{
			if(StringUtil.equals(cookieNmId, nmId))
			{
				if(StringUtil.equals(musa, "musa"))
				{
					nmUser.setNmId(nmId);
					nmUser.setNmPwd(nmPwd);
					nmUser.setNmName(nmName);
					nmUser.setNmNickname(nmNickname);
					nmUser.setNmEmail(nmEmail);
					nmUser.setNmTel(nmTel);
					
					if(nmUserService.nmUpdate(nmUser) > 0)
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
				ajaxResponse.setResponse(404, "NotFound");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /user/nmSCheck response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/nmTaltuie", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nmTaltuie(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String nmId = HttpUtil.get(request, "nmId");
		
		NmUser nmUser = new NmUser();
		
		if(!StringUtil.isEmpty(nmId))
		{
			if(StringUtil.equals(cookieNmId, nmId))
			{	
				if(nmUserService.nmTaltuie(nmId) > 0)
				{
					CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NMNAME);
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "NotFound");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /user/nmSCheck response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/nmJoinList")
	public String nmJoinList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//게시물 리스트
		List<Join> list = null;
		//조회 겍체
		Join search = new Join();
		//페이징 객체
		Paging paging = null;
		//총 게시물 수
		long totalCount = 0;
		
		if(cookieNmId != null && cookieNmId != "")
		{
			totalCount = nmUserService.myJoinCnt(cookieNmId);
			search.setNmId(cookieNmId);
		}
		
		if(totalCount > 0)
		{
			paging = new Paging("/user/nmLikeList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = nmUserService.myJoinList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("cookieNmId", cookieNmId);
		
		return "/user/nmJoinList";
	}
	
	@RequestMapping(value="/user/nmLikeList")
	public String nmLikeList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//게시물 리스트
		List<Like> list = null;
		//조회 겍체
		Like search = new Like();
		//페이징 객체
		Paging paging = null;
		//총 게시물 수
		long totalCount = 0;
		
		if(cookieNmId != null && cookieNmId != "")
		{
			totalCount = nmUserService.myLikeListcNT(cookieNmId);
			search.setNmId(cookieNmId);
		}
		
		if(totalCount > 0)
		{
			paging = new Paging("/user/nmLikeList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = nmUserService.myLikeList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("cookieNmId", cookieNmId);
		
		return "/user/nmLikeList";
	}
	
	@RequestMapping(value="/user/nmRevList")
	public String nmRevList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//게시물 리스트
		List<Rev> list = null;
		//조회 겍체
		Rev search = new Rev();
		//페이징 객체
		Paging paging = null;
		//총 게시물 수
		long totalCount = 0;
		
		if(cookieNmId != null && cookieNmId != "")
		{
			totalCount = revService.revNmListCnt(cookieNmId);
			search.setNmId(cookieNmId);
		}
		
		if(totalCount > 0)
		{
			paging = new Paging("/user/nmRevList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = revService.myRevList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("cookieNmId", cookieNmId);
		
		return "/user/nmRevList";
	}
	
	@RequestMapping(value="/user/joinDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> joinDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String nmId = HttpUtil.get(request, "nmId");
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		
		Join join = new Join();
		
		if(promSeq > 0)
		{
			Prom prom = promService.promView(promSeq);
			
			if(prom != null)
			{
				if(StringUtil.equals(cookieNmId, nmId))
				{
					join.setNmId(nmId);
					join.setPromSeq(promSeq);
					
					if(nmUserService.promJoinSelect(join) != null)
					{
						if(nmUserService.joinDelete(join) > 0)
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
						ajaxResponse.setResponse(503, "No Data");
					}
				}
				else
				{
					ajaxResponse.setResponse(403, "Server Error");
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
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /user/joinDelete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/findId", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> findId(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String nmName = HttpUtil.get(request, "nmName", "");
		String nmEmail = HttpUtil.get(request, "nmEmail", "");
		
		if(!StringUtil.isEmpty(nmName) && !StringUtil.isEmpty(nmEmail))
		{
			NmUser nmUser = nmUserService.nmFind(nmEmail);
			
			if(nmUser != null)
			{
				if(StringUtil.equals(nmName, nmUser.getNmName()))
				{
					if(StringUtil.equals(nmUser.getNmStatus(), "Y"))
					{
						String setFrom = "jsu000723@gmail.com";
						String title = "withsports 아이디 안내문자 입니다.";
						String content = nmName + "님의 아이디는 " + nmUser.getNmId() + "입니다. 해당 아이디로 로그인 하세요.";
						
						try
						{
							MimeMessage message = mailSender.createMimeMessage();
							MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
							helper.setFrom(setFrom);
							helper.setTo(nmEmail);
							helper.setSubject(title);
							helper.setText(content);
							mailSender.send(message);
							
							ajaxResponse.setResponse(0, "Success");
						}
						catch(Exception e)
						{
							logger.debug("[NmUserController] findId Exception", e);
							ajaxResponse.setResponse(500, "Sttoped User");
						}
					}
					else
					{
						ajaxResponse.setResponse(408, "Sttoped User");
					}
				}
				else
				{
					ajaxResponse.setResponse(407, "Name Error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "BadRequest");
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/findPwd", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> findPwd(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String nmName = HttpUtil.get(request, "nmName", "");
		String nmEmail = HttpUtil.get(request, "nmEmail", "");
		String nmId = HttpUtil.get(request, "nmId", "");
		
		if(!StringUtil.isEmpty(nmName) && !StringUtil.isEmpty(nmEmail) && !StringUtil.isEmpty(nmId))
		{
			NmUser nmUser = nmUserService.nmFind(nmEmail);
			
			if(nmUser != null)
			{
				if(StringUtil.equals(nmId, nmUser.getNmId()))
				{
					if(StringUtil.equals(nmName, nmUser.getNmName()))
					{
						if(StringUtil.equals(nmUser.getNmStatus(), "Y"))
						{
							Random random = new Random();
							String pwdTemporary = Integer.toString(random.nextInt(88888888) + 11111111);
							
							String setFrom = "jsu000723@gmail.com";
							String title = "withsports 비밀번호 안내문자 입니다.";
							String content = nmName + "님의 임시비밀번호는 " + pwdTemporary + " 입니다. 해당 비밀번호(8자리숫자)로 로그인하세요.";
							
							try
							{
								MimeMessage message = mailSender.createMimeMessage();
								MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
								helper.setFrom(setFrom);
								helper.setTo(nmEmail);
								helper.setSubject(title);
								helper.setText(content);
								mailSender.send(message);
								
								NmUser user = new NmUser();
								
								user.setNmId(nmId);
								user.setNmPwd(pwdTemporary);
								
								if(nmUserService.nmPwdFindIm(user) > 0)
								{
									ajaxResponse.setResponse(0, "Success");
								}
								else
								{
									ajaxResponse.setResponse(500, "Internal Server Error");
								}
							}
							catch(Exception e)
							{
								logger.debug("[NmUserController] findId Exception", e);
								ajaxResponse.setResponse(500, "Sttoped User");
							}
						}
						else
						{
							ajaxResponse.setResponse(408, "Sttoped User");
						}
					}
					else
					{
						ajaxResponse.setResponse(407, "Name Error");
					}
				}
				else
				{
					ajaxResponse.setResponse(409, "Not Found");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "BadRequest");
		}
		
		return ajaxResponse;
	}
}
