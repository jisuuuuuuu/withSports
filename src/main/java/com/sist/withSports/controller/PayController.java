package com.sist.withSports.controller;

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

import com.google.gson.JsonObject;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.StringUtil;
import com.sist.withSports.model.Join;
import com.sist.withSports.model.KakaoPayApprove;
import com.sist.withSports.model.KakaoPayOrder;
import com.sist.withSports.model.KakaoPayReady;
import com.sist.withSports.model.Prom;
import com.sist.withSports.model.Response;
import com.sist.withSports.service.NmUserService;
import com.sist.withSports.service.PayService;
import com.sist.withSports.service.PromService;

@Controller("payController")
public class PayController 
{
	private static Logger logger = LoggerFactory.getLogger(PayController.class);
	
	@Value("#{env['auth.cookie.nmuser']}")
	private String AUTH_COOKIE_NMNAME;
	
	@Autowired
	private PromService promService;
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private NmUserService nmUserService;
	
	@RequestMapping(value="/pay/pay")
	public String pay(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String nmId = HttpUtil.get(request, "nmId", "");
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		
		Prom prom = null;
		
		if(promSeq > 0)
		{
			prom = promService.promView(promSeq);
		}
		
		model.addAttribute("prom", prom);
		model.addAttribute("nmId", nmId);
		
		return "/pay/pay";
	}
	
	@RequestMapping(value="/pay/payReady", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> patReady(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String orderId = StringUtil.uniqueValue();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String itemCode = HttpUtil.get(request, "itemCode", "");
		String itemName = HttpUtil.get(request,"itemName", "");
		int quantity = HttpUtil.get(request, "quantity", 0);
		int totalAmount = HttpUtil.get(request, "totalAmount", 0);
		int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", 0);
		int vatAmount = HttpUtil.get(request, "vatAmount", 0);
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setItemName(itemName);
		kakaoPayOrder.setItemCode(itemCode);
		kakaoPayOrder.setQuantity(quantity);
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);
		
		KakaoPayReady kakaoPayReady = payService.kakaoPayReady(kakaoPayOrder);
		
		if(kakaoPayOrder != null)
		{
			logger.debug("[KakaoPayController] payReady : " + kakaoPayReady);
			
			kakaoPayOrder.settId(kakaoPayReady.getTid());
			
			JsonObject json = new JsonObject();
			
			json.addProperty("orderId", orderId);
			json.addProperty("tId", kakaoPayReady.getTid());
			json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
			json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());
			json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());
			
			ajaxResponse.setResponse(0, "Success", json);
		}
		else
		{
			ajaxResponse.setResponse(-1, "fail", null);
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/pay/payPopUp")
	public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String pcUrl = HttpUtil.get(request, "pcUrl", "");
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		
		logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		logger.debug("userId : " + userId);
		logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		
		model.addAttribute("pcUrl", pcUrl);
		model.addAttribute("orderId", orderId);
		model.addAttribute("tId", tId);
		model.addAttribute("userId", userId);
		
		return "/pay/payPopUp";
	}
	
	@RequestMapping(value="/pay/paySuccess")
	public String paySuccess(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String pgToken = HttpUtil.get(request, "pg_token", "");
		
		model.addAttribute("pgToken", pgToken);
		
		return "/pay/paySuccess";
	}
	
	@RequestMapping(value="/pay/payResult")
	public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		String pgToken = HttpUtil.get(request, "pgToken", "");
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		
		logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		logger.debug("userId : " + userId);
		logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.settId(tId);
		kakaoPayOrder.setPgToken(pgToken);
		
		kakaoPayApprove = payService.kakaoPayApprove(kakaoPayOrder);
		
		logger.debug("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
		logger.debug("itemcode : " + kakaoPayApprove.getItem_code());
		logger.debug("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
		
		String itemcode = kakaoPayApprove.getItem_code();
		
		Long promSeq = Long.parseLong(itemcode);
		
		Join join = new Join();
		
		join.setNmId(userId);
		join.setPromSeq(promSeq);
		
		nmUserService.joinPaySuccess(join);
		
		model.addAttribute("kakaoPayApprove", kakaoPayApprove);
		
		return "/pay/payResult";
	}
	
	@RequestMapping(value="/pay/payCancel")
	public String payCancel(HttpServletRequest request, HttpServletResponse response)
	{
		return "/pay/payCancel";
	}
	
	@RequestMapping(value="/pay/payFail")
	public String payFail(HttpServletRequest request, HttpServletResponse response)
	{
		return "/pay/payFail";
	}
}
