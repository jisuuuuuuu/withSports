<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
.mol {
   font-family: 'Montserrat', sans-serif;
   background: white;
}

.container {
   display: block;
   max-width: 680px;
   width: 80%;
   margin: 120px auto;
}

h1 {
   color: #e91e63;
   font-size: 48px;
   letter-spacing: -3px;
   text-align: center;
   margin: 120px 0 80px 0;
   transition: .2s linear;
}

.links {
   list-style-type: none;
}

.links li {
   display: inline-block;
   margin: 0 20px 0 0;
   transition: .2s linear;
}

.links li:nth-child(2) {
   opacity: .6;
}

.links li:nth-child(2):hover {
   opacity: 1;
}

.links li:nth-child(3) {
   opacity: .6;
   float: right;
}

.links li:nth-child(3):hover {
   opacity: 1;
}

.links li a {
   text-decoration: none;
   color: #0f132a;
   font-weight: bolder;
   text-align: center;
   cursor: pointer;
}

div {
   width: 100%;
   max-width: 680px;
   margin: 40px auto 10px;
}

div .input__block {
   margin: 20px auto;
   display: block;
   position: relative;
}

div .input__block.first-input__block::before {
   content: "";
   position: absolute;
   top: -15px;
   left: 50px;
   display: block;
   width: 0;
   height: 0;
   background: transparent;
   border-left: 15px solid transparent;
   border-right: 15px solid transparent;
   border-bottom: 15px solid rgba(15, 19, 42, 0.1);
   transition: .2s linear;
}

div .input__block.signup-input__block::before {
   content: "";
   position: absolute;
   top: -15px;
   left: 150px;
   display: block;
   width: 0;
   height: 0;
   background: transparent;
   border-left: 15px solid transparent;
   border-right: 15px solid transparent;
   border-bottom: 15px solid rgba(15, 19, 42, 0.1);
   transition: .2s linear;
}

div .ws_input input {
   display: block;
   float:left;
   width: 72%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   border: none;
   background: rgba(15, 19, 42, 0.1);
   color: rgba(15, 19, 42, 0.3);
   padding: 0 0 0 15px;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   position: relative;
}

div .ws_input{
	margin-bottom:20px;
	margin-left: 62px;
	margin-right: 62px;
	display:flex;
	jsutify-content:between;
	margin: 20px;
}

.ws_nmUpdate_msg{
	display:flex;
	justify-content:center;
	margin-bottom: 30px;
}

.ws_msg{
	text-decoration:underline;
	color:#e91e63;
	float:right;
	margin-right:25px;
}

.ws_msgq{
    margin-left: 26px;
	text-decoration:underline;
	color:#e91e63;
	float:left;
	margin-right:25px;
}

.ws_nmUpdate_t{
	margin-bottom:0px;
}

div .ws_nmUpdate_btn{
   background: white;
   color: #e91e63;
   display: block;
   width: 20%;
   height: 48px;
   border-radius: 8px;
   border: solid 1px #e91e63;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   transition: .2s linear;
   margin-left: 10px;
   box-shadow: 0 1px 5px rgba(0, 0, 0, 0.36);
}

div .ws_nmUpdate_subBtn{
   background: #e91e63;
   color: white;
   display: block;
   width: 92.5%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   margin: 0 0 30px 30px;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

div .input__block input {
   display: block;
   width: 90%;
   max-width: 680px;
   height: 50px;
   margin: 0 auto;
   border-radius: 8px;
   border: none;
   background: rgba(15, 19, 42, 0.1);
   color: rgba(15, 19, 42, 0.3);
   padding: 0 0 0 15px;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
}

div .input__block input:focus, div .input__block input:active {
   outline: none;
   border: none;
   color: #0f132a;
}

div .input__block input.repeat__password {
   opacity: 0;
   display: none;
   transition: .2s linear;
}

div .signin__btn {
   background: #e91e63;
   color: white;
   display: block;
   width: 92.5%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   margin: 0 auto;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

div .signup__btn {
   background: #e91e63;
   color: white;
   display: block;
   width: 92.5%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   margin: 0 auto;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

div .signin__btn:hover {
   box-shadow: 0 0 0 rgba(233, 30, 99, 0);
}

div .signup__btn:hover {
   box-shadow: 0 0 0 rgba(233, 30, 99, 0);
}

div .ws_input input {
   display: block;
   float:left;
   width: 72%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   border: none;
   background: rgba(15, 19, 42, 0.1);
   color: rgba(15, 19, 42, 0.3);
   padding: 0 0 0 15px;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   position: relative;
}

div .ws_input{
	margin-bottom:20px;
	margin-left: 26px;
	width: 655px;
	display:flex;
	jsutify-content:between;
}

.ws_nmUpdate_msg{
	display:flex;
	justify-content:center;
	margin-bottom: 30px;
}

.ws_msg{
	text-decoration:underline;
	color:#e91e63;
	float:right;
	margin-right:25px;
}

.ws_nmUpdate_t{
	margin-bottom:0px;
}

div .ws_nmUpdate_btn{
   background: white;
   color: #e91e63;
   display: block;
   width: 20%;
   height: 48px;
   border-radius: 8px;
   border: solid 1px #e91e63;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   transition: .2s linear;
   margin-left: 10px;
   box-shadow: 0 1px 5px rgba(0, 0, 0, 0.36);
}

div .ws_nmUpdate_subBtn{
   background: #e91e63;
   color: white;
   display: block;
   width: 92.5%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   margin: 0 0 30px 30px;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

.separator {
   display: block;
   margin: 30px auto 10px;
   text-align: center;
   height: 40px;
   position: relative;
   background: transparent;
   color: rgba(15, 19, 42, 0.4);
   font-size: 13px;
   width: 90%;
   max-width: 680px;
}

.separator::before {
   content: "";
   position: absolute;
   top: 8px;
   left: 0;
   background: rgba(15, 19, 42, 0.2);
   height: 1px;
   width: 30%;
}

.separator::after {
   content: "";
   position: absolute;
   top: 8px;
   right: 0;
   background: rgba(15, 19, 42, 0.2);
   height: 1px;
   width: 30%;
}

.google__btn,
.github__btn {
   display: block;
   width: 90%;
   max-width: 680px;
   margin: 20px auto;
   height: 50px;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   border-radius: 8px;
   border: none;
   line-height: 40px;
}

.google__btn.google__btn,
.github__btn.google__btn {
   background: #5b90f0;
   color: white;
   box-shadow: 0 15px 30px rgba(91, 144, 240, 0.36);
   transition: .2s linear;
}

.google__btn.google__btn .fa,
.github__btn.google__btn .fa {
   font-size: 20px;
   padding: 0 5px 0 0;
}

.google__btn.google__btn:hover,
.github__btn.google__btn:hover {
   box-shadow: 0 0 0 rgba(91, 144, 240, 0);
}

.google__btn.github__btn,
.github__btn.github__btn {
   background: #25282d;
   color: white;
   box-shadow: 0 15px 30px rgba(37, 40, 45, 0.36);
   transition: .2s linear;
}

.google__btn.github__btn .fa,
.github__btn.github__btn .fa {
   font-size: 20px;
   padding: 0 5px 0 0;
}

.google__btn.github__btn:hover,
.github__btn.github__btn:hover {
   box-shadow: 0 0 0 rgba(37, 40, 45, 0);
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
var nic = 0;
var email = 0;
var tel = 0;

$(document).ready(function(){
    let signup = $(".links").find("li").find("#signup") ; 
    let signin = $(".links").find("li").find("#signin") ;
    let reset  = $(".links").find("li").find("#reset")  ; 
    let first_input = $("div").find(".first-input");
    let hidden_input = $("div").find(".input__block").find("#repeat__password");
    let signin_btn  = $("div").find(".signin__btn");
  
    //----------- sign up ---------------------
    signup.on("click",function(e){
      e.preventDefault();
      $(this).parent().parent().siblings("h1").text("로그인");
      $(this).parent().css("opacity","1");
      $(this).parent().siblings().css("opacity",".6");
      first_input.removeClass("first-input__block").addClass("signup-input__block");
      hidden_input.css({
        "opacity" : "1",
        "display" : "block"
      });
    });
    
  
   //----------- sign in ---------------------
   signin.on("click",function(e){
      e.preventDefault();
      $(this).parent().parent().siblings("h1").text("로그인");
      $(this).parent().css("opacity","1");
      $(this).parent().siblings().css("opacity",".6");
      first_input.addClass("first-input__block")
        .removeClass("signup-input__block");
      hidden_input.css({
        "opacity" : "0",
        "display" : "none"
      });
    });
   
   //----------- reset ---------------------
   reset.on("click",function(e){
     e.preventDefault();
     $(this).parent().parent().siblings("div")
     .find(".input__block").find(".input").val("");
   });
	
	$("#nmNickname").change(function(){
		nic = 0;
	});
	
	$("#nmEmail").change(function(){
		email = 0;
	});
	
	$("#nmTel").change(function(){
		tel = 0;
	});
  
 $("#btnNmNicknameChk").on("click", function(){
	  if($.trim($("#nmNickname").val()).length <= 0)
		{
			alert("닉네임를 입력하세요.");
			$("#nmNickname").val("");
			$("#nmNickname").focus();
			return;
		}
	  
	  var a = $("#nmNickname").val();
	  var b = "w";
	  nic = 1;
	  
	  if("${nmUser.getNmNickname()}" != $("#nmNickname").val())
	  {
		  fn_nmSame(a, b);
	  }
	  else
	  {
		  alert("기존 닉네임과 동일합니다. 수정을 진행하세요.");
	  }
	  
  });
  
 $("#btnNmEmailChk").on("click", function(){
	  if($.trim($("#nmEmail").val()).length <= 0)
		{
			alert("이메일를 입력하세요.");
			$("#nmEmail").val("");
			$("#nmEmail").focus();
			return;
		}
	   
	   if(!fn_validateEmail($("#nmEmail").val()))
		{
			alert("이메일 형식으로 입력하세요.");
			$("#nmEmail").val("");
			$("#nmEmail").focus();
			return;
		}
	  
	  var a = $("#nmEmail").val();
	  var b = "e";
	  email = 1;
	  
	  if("${nmUser.getNmEmail()}" != $("#nmEmail").val())
	  {
		  fn_nmSame(a, b);
	  }
	  else
	  {
		  alert("기존 이메일과 동일합니다. 수정을 진행하세요.");
	  }
 });

 $("#btnNmTelChk").on("click", function(){
	   if($.trim($("#nmTel").val()).length <= 0)
		{
			alert("전화번호를 입력하세요.");
			$("#nmTel").val("");
			$("#nmTel").focus();
			return;
		}
		
		if(!fn_checktel($("#nmTel").val()))
		{
			alert("전화번호 형식으로 입력하세요.(010-1111-1111)");
			$("#nmTel").val("");
			$("#nmTel").focus();
			return;
		}
	  
	  var a = $("#nmTel").val();
	  var b = "r";
	  tel = 1;
	  
	  if("${nmUser.getNmTel()}" != $("#nmTel").val())
	  {
		  fn_nmSame(a, b);
	  }
	  else
	  {
		  alert("기존 전화번호와 동일합니다. 수정을 진행하세요.");
	  }
 });
  
  $("#btnNmUpdate").on("click", function(){
		if($.trim($("#nmPwd").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#nmPwd").val("");
			$("#nmPwd").focus();
			return;
		}
		
		if(fn_emptCheck($("#nmPwd").val()))
		{
			alert("비밀번호에 공백을 포함할 수 없습니다.");
			$("#nmPwd").val("");
			$("#nmPwd").focus();
			return;
		}
	   
	   if(!fn_idpwCheck($("#nmPwd").val()))
		{
			alert("비밀번호는 4~12자의 영문 대소문자와 숫자로만 입력하세요.");
			$("#nmPwd").val("");
			$("#nmPwd").focus();
			return;
		}
	   
	   if($("#nmPwd").val() != $("#nmPwd2").val())
		{
			alert("비밀번호가 다릅니다.");
			$("#nmPwd2").val("");
			$("#nmPwd2").focus();
			return;
		}
	   
	   if($.trim($("#nmName").val()).length <= 0)
		{
			alert("이름를 입력하세요.");
			$("#nmName").val("");
			$("#nmName").focus();
			return;
		}
	   
	   if(nic != 1)
	   {
		   alert("닉네임 중복 확인을 진행해 주세요.");
		   return;
	   }
	   
	   if(email != 1)
	   {
		   alert("이메일 중복 확인을 진행해 주세요.");
		   return;
	   }
	   
	   if(tel != 1)
	   {
		   alert("전화번호 중복 확인을 진행해 주세요.");
		   return;
	   }
	   
	   var musa = "musa";
	   
	 //일반회원 정보수정
		$.ajax({
			type:"POST",
			url:"/user/nmUpdateProc",
			data:{
				nmId:$("#nmId").val(),
				nmPwd:$("#nmPwd").val(),
				nmName:$("#nmName").val(),
				nmNickname:$("#nmNickname").val(),
				nmEmail:$("#nmEmail").val(),
				nmTel:$("#nmTel").val(),
				musa:musa
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("수정되었습니다.");
					location.href = "/user/nmMyPage";
				}
				else if(response.code == 100)
				{
					alert("제대로 된 경로로 가입을 하지 않으셨습니다.");
					$("#nmId").focus();
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 잘못 되었습니다.");
					$("#nmNickName").focus();
				}
				else
				{
					alert("오류가 발생했습니다.");
					$("#nmId").focus();
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
		});
  });
});

function fn_emptCheck(value)
{
	//공백체크
	var emptCheck = /\s/g;
	
	return emptCheck.test(value);
}

function fn_idpwCheck(value)
{
	//영어 대소문자, 숫자로만 이루어진 4~12자리 정규식
	var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
	
	return idPwCheck.test(value);
}

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}

function fn_checktel(value) 
{
	var tnn = /^0\d{1,2}(-|\))\d{3,4}-\d{4}$/;
	
	return tnn.test(value)
}

function fn_nmSame(a, b)
{
	//중복 체크
	$.ajax({
		type:"POST",
		url:"/user/nmSCheck",
		data:{
			nmValue:a,
			sameChkNum:b
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{
				alert("회원가입 가능.");
			}
			else if(response.code == 12)
			{
				alert("중복된 닉네임이 있습니다.");
				nic = 0;
				$("#nmNickName").focus();
			}
			else if(response.code == 13)
			{
				alert("중복된 이메일이 있습니다.");
				$("#nmEmail").focus();
				email = 0;
			}
			else if(response.code == 14)
			{
				alert("중복된 전화번호가 있습니다.");
				$("#nmTel").focus();
				tel = 0;
			}
			else
			{
				alert("오류가 발생했습니다.");
				$("#nmId").focus();
				nic = 0;
				email = 0;
				tel = 0;
				
			}
		},
		error:function(xhr, status, error){
			icia.common.error(error);
		}
	});
}

function fn_byebye()
{
	if(confirm("정말로 저희를 떠나시겠어요??") == true)
	{
		//일반회원 탈퇴
		$.ajax({
			type:"POST",
			url:"/user/nmTaltuie",
			data:{
				nmId:$("#nmId").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("탈퇴되었습니다.");
					location.href = "/index";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 잘못 되었습니다.");
					$("#nmNickName").focus();
				}
				else
				{
					alert("오류가 발생했습니다.");
					$("#nmId").focus();
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
		});
	}
}
</script>

</head>
<body>
<div class="container">
  <!-- Heading -->
  <h1 class="mol ws_nmUpdate_t" style="font-weight:bold;">회원정보 수정</h1>
  <p class="mol ws_nmUpdate_msg">기업회원 정보 수정은 관리자에게 문의 바랍니다.</p>
  
  <!-- div -->
  <div>
    <!-- ID input -->
    <div class="first-input input__block">
       <input type="text" placeholder="${nmUser.getNmId()}" value="${nmUser.getNmId()}" class="input" id="nmId" readonly />
    </div>
    <!-- password input -->
    <div class="input__block">
       <input type="password" placeholder="비밀번호" class="input" id="nmPwd" />
    </div>
    <div class="input__block">
       <input type="password" placeholder="비밀번호 확인" class="input" id="nmPwd2" />
    </div>
    <div class="input__block">
       <input type="text" placeholder="${nmUser.getNmName()}" value="${nmUser.getNmName()}" class="input" id="nmName" style="color: #757575;" />
    </div>
    <div class="ws_input">
       <input type="text" placeholder="${nmUser.getNmNickname()}" value="${nmUser.getNmNickname()}" class="input" id="nmNickname" style="color: #757575;" />
       <button id="btnNmNicknameChk" type="button" class="ws_nmUpdate_btn">중복확인</button>
    </div>
    
    <div class="ws_input">
       <input type="text" placeholder="${nmUser.getNmEmail()}" value="${nmUser.getNmEmail()}" class="input" id="nmEmail" style="color: #757575;" />
       <button id="btnNmEmailChk" type="button" class="ws_nmUpdate_btn">중복확인</button>
    </div>
    
    <div class="ws_input">
       <input type="text" placeholder="${nmUser.getNmTel()}" value="${nmUser.getNmTel()}" class="input" id="nmTel" style="color: #757575;" />
       <button id="btnNmTelChk" type="button" class="ws_nmUpdate_btn">중복확인</button>
    </div>

    <button id="btnNmUpdate" class="ws_nmUpdate_subBtn">수정</button>
    
    <div><a href="/user/nmMyPage" class="mol ws_nmUpdate_msg ws_msgq" >이전화면으로</a></div>
    
    <div><a onclick="fn_byebye()" class="mol ws_nmUpdate_msg ws_msg">회원탈퇴</a></div>
  </div>
</div>
</body>
</html>