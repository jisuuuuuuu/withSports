<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.mol{
   font-family: "Montserrat", sans-serif;
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

.links .nm,
.links .co{
  top:0;
  left:0;
  right:0;
  bottom:0;
  position:absolute;
  transform:rotateY(180deg);
  backface-visibility:hidden;
  transition:all .4s linear;
}
.links .nm,
.links .co,{
  display:none;
}

.links .nm + .tab,
.links .co + .tab{
  color:gray;
  border-color:#1161ee;
}

.links .nm:checked + .tab,
.links .co:checked + .tab{
  color:#0f132a;
  border-color:#1161ee;
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

div .tab{
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
   font-family: "Montserrat", sans-serif;
}

div .input__block input:focus, form .input__block input:active {
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
   font-family: "Montserrat", sans-serif;
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
   font-family: "Montserrat", sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

div .signin__btn:hover {
   box-shadow: 0 0 0 rgba(233, 30, 99, 0);
}

div .signup__btn:hover {
   box-shadow: 0 0 0 rgba(233, 30, 99, 0);
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
   width: 92.5%;
   max-width: 680px;
   margin: 0 auto;
   height: 50px;
   cursor: pointer;
   font-size: 14px;
   font-family: "Montserrat", sans-serif;
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
</head>
<body>
<script type="text/javascript">
$(document).ready(function(){
   $('input[type=radio][name=mmm]').on("click", function(){
      
      var chkValue = $('input[type=radio][name=mmm]:checked').val();
      
      if(chkValue == '1'){
         $('#tab11').css('display', 'block');
         $('#tab22').css('display', 'none');
      }
      else if(chkValue == '2'){
         $('#tab22').css('display', 'block');
         $('#tab11').css('display', 'none');
      }
   });
   
   $("#nmUserFindId").on("click", function(){
	   if($.trim($("#nmUserNameId").val()).length <= 0)
		{
			alert("이름을 입력하세요.");
			$("#nmUserNameId").val("");
			$("#nmUserNameId").focus();
			return;
		}
	   
	   if($.trim($("#nmUserEmailId").val()).length <= 0)
		{
			alert("이메일를 입력하세요.");
			$("#nmUserEmailId").val("");
			$("#nmUserEmailId").focus();
			return;
		}
	   
	   if(!fn_validateEmail($("#nmUserEmailId").val()))
		{
			alert("이메일 형식으로 입력하세요.");
			$("#nmUserEmailId").val("");
			$("#nmUserEmailId").focus();
			return;
		}
	   
	   $.ajax({
		   type:"post",
		   url:"/user/findId",
		   data:{
			   nmEmail:$("#nmUserEmailId").val(),
			   nmName:$("#nmUserNameId").val()
		   },
		   async: false,
		   beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("이메일이 발송되었습니다.");
				}
				else if(response.code == 404)
				{
					alert("해당 이메일로 가입하신 정보가 없습니다.");
					$("#nmUserEmailId").val("");
					$("#nmUserEmailId").focus();
				}
				else if(response.code == 407)
				{
					alert("가입하신 정보와 일치하지 않습니다.");
					$("#nmUserNameId").val("");
					$("#nmUserNameId").focus();
				}
				else if(response.code == 0)
				{
					alert("정지된 회원입니다.");
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
	   });
   });
   
   $("#nmUserFindPwd").on("click", function(){
	   if($.trim($("#nmUserId").val()).length <= 0)
		{
			alert("아이디를 입력하세요.");
			$("#nmUserId").val("");
			$("#nmUserId").focus();
			return;
		}
	   
	   if($.trim($("#nmUserNamePwd").val()).length <= 0)
		{
			alert("이름을 입력하세요.");
			$("#nmUserNamePwd").val("");
			$("#nmUserNamePwd").focus();
			return;
		}
	   
	   if($.trim($("#nmUserEmailPwd").val()).length <= 0)
		{
			alert("이메일를 입력하세요.");
			$("#nmUserEmailPwd").val("");
			$("#nmUserEmailPwd").focus();
			return;
		}
	   
	   if(!fn_validateEmail($("#nmUserEmailPwd").val()))
		{
			alert("이메일 형식으로 입력하세요.");
			$("#nmUserEmailPwd").val("");
			$("#nmUserEmailPwd").focus();
			return;
		}
	   
	   $.ajax({
		   type:"post",
		   url:"/user/findPwd",
		   data:{
			   nmEmail:$("#nmUserEmailPwd").val(),
			   nmName:$("#nmUserNamePwd").val(),
			   nmId:$("#nmUserId").val()
		   },
		   async: false,
		   beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("이메일이 발송되었습니다.");
				}
				else if(response.code == 404)
				{
					alert("해당 이메일로 가입하신 정보가 없습니다.");
					$("#nmUserEmailId").val("");
					$("#nmUserEmailId").focus();
				}
				else if(response.code == 409)
				{
					alert("해당 아이디로 가입하신 정보가 없습니다.");
					$("#nmUserId").val("");
					$("#nmUserId").focus();
				}
				else if(response.code == 407)
				{
					alert("가입하신 정보와 일치하지 않습니다.");
					$("#nmUserNameId").val("");
					$("#nmUserNameId").focus();
				}
				else if(response.code == 0)
				{
					alert("정지된 회원입니다.");
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
	   });
   });
   
});

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}
</script>

</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="container">
  <!-- Heading -->
  <h1 class="mol">아이디/비밀번호 찾기</h1>
  
  <ul class="links">
     <li>
        <a><input id="tab-1" type="radio" name="mmm" class="nm" value="1" checked><label for="tab-1" class="mol tab">아이디</label></a>
     </li>
     <li>
        <a><input id="tab-2" type="radio" name="mmm" class="co" value="2" ><label for="tab-2" class="mol tab">비밀번호</label></a>
     </li>
  </ul>
  
  <!-- Links 
  <ul class="links">
    <li>
      <a href="#" id="signin">개인회원</a>
    </li>
    <li>
      <a href="#" id="signup">기업회원</a>
    </li>
    
  </ul>-->
  
  <div id='tab11'>
  <!-- Form -->
  <div id="tab1" name="tab" action="" method="post">
    <!-- ID input -->
    <div class="first-input input__block first-input__block">
       <input type="text" placeholder="개인회원 이름" class="input" id="nmUserNameId"   />
    </div>
    <!-- password input -->
    <div class="input__block">
       <input type="text" placeholder="개인회원 이메일" class="input" id="nmUserEmailId"    />
    </div>
    <!-- sign in button -->
    <button class="signin__btn" id="nmUserFindId" name="nmUserFindId">
      아이디 찾기
    </button>
    </div>
</div>

<div id='tab22' style="display:none;">
<div id="tab2" name="tab" action="" method="post">
    <!-- ID input -->
    <div class="first-input input__block first-input__block signup-input__block">
       <input type="text" placeholder="개인회원 아이디" class="input" id="nmUserId"   />
    </div>
    <!-- password input -->
    <div class="input__block">
       <input type="text" placeholder="개인회원 이름" class="input" id="nmUserNamePwd"    />
    </div>
    <div class="input__block">
       <input type="text" placeholder="개인회원 이메일" class="input" id="nmUserEmailPwd"    />
    </div>
    <!-- sign in button -->
    <button class="signin__btn" id="nmUserFindPwd" name="nmUserFindPwd">
      비밀번호 찾기
    </button>
  </div>
</div>

</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>