<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
.mol{
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
   font-family: 'Montserrat', sans-serif;
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

	$("#btnSignup").on("click", function(){
		location.href = "/user/signUp";
	});
	
	$("#btnFind").on("click", function(){
		location.href = "/user/nmFind";
	});
	
	$("#btnNmLogin").on("click", function(){
		if($.trim($("#nmId").val()).length <= 0)
		{
			alert("아이디를 입력하세요.");
			$("#nmId").val("");
			$("#nmId").focus();
			return;
		}
		
		if($.trim($("#nmPwd").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#nmPwd").val("");
			$("#nmPwd").focus();
			return;
		}
		
		$.ajax({
			type:"post",
			url:"/user/nmLogin",
			data:{
				nmId:$("#nmId").val(),
				nmPwd:$("#nmPwd").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					location.href = "/";
				}
				else if(response.code == -1)
				{
					alert("비밀번호가 올바르지 않습니다.");
					$("#nmPwd").focus();
				}
				else if(response.code == 404)
				{
					alert("아이디와 일치하는 사용자가 없습니다.");
					$("#nmId").focus();
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#nmId").focus();
				}
				else
				{
					alert("오류가 발생하였습니다");
					$("#nmId").focus();
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
		});
	});
		
	$("#btnCoLogin").on("click", function(){
		if($.trim($("#coId").val()).length <= 0)
		{
			alert("아이디를 입력하세요.");
			$("#coId").val("");
			$("#coId").focus();
			return;
		}
		
		if($.trim($("#coPwd").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#coPwd").val("");
			$("#coPwd").focus();
			return;
		}
		
		$.ajax({
			type:"post",
			url:"/user/coLogin",
			data:{
				coId:$("#coId").val(),
				coPwd:$("#coPwd").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					location.href = "/";
				}
				else if(response.code == -1)
				{
					alert("비밀번호가 올바르지 않습니다.");
					$("#coPwd").focus();
				}
				else if(response.code == 300)
				{
					alert("정지된 사용자입니다.");
					$("#coId").focus();
				}
				else if(response.code == 404)
				{
					alert("아이디와 일치하는 사용자가 없습니다.");
					$("#coId").focus();
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#coId").focus();
				}
				else
				{
					alert("오류가 발생하였습니다");
					$("#coId").focus();
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
		});
	});
	
});
</script>

</head>
<body>

<%@ include file="/WEB-INF/views/include/header.jsp" %>

<div class="container">
  <!-- Heading -->
  <h1 class="mol" style="font-weight:bold;">로그인</h1>
  
  <ul class="links">
	  <li>
	  	<a><input id="tab-1" type="radio" name="mmm" class="nm" value="1" checked><label for="tab-1" class="mol tab">개인회원</label></a>
	  </li>
	  <li>
	  	<a><input id="tab-2" type="radio" name="mmm" class="co" value="2" ><label for="tab-2" class="mol tab">기업회원</label></a>
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
  <div id="tab1" class="tab">
    <!-- ID input -->
    <div class="first-input input__block first-input__block">
       <input type="text" placeholder="개인회원" class="input" id="nmId" name="nmId" />
    </div>
    <!-- password input -->
    <div class="input__block">
       <input type="password" placeholder="개인회원" class="input" id="nmPwd" name="nmPwd" />
    </div>
    <!-- sign in button -->
    <button class="signin__btn" id="btnNmLogin">
      로그인(개인)
    </button>
    <div class="mol separator">
    <p>회원이 아니라면?</p>
  	</div>
    <button class="signup__btn" id="btnSignup">
      회원가입(개인)
    </button>
  </div>
  <!-- separator -->
  <div class="mol separator">
    <p>아이디 또는 비밀번호가 생각이 안나시나요?</p>
  </div>
  <!-- google button -->
  <button class="google__btn" id="btnFind"> 
    <i class="fa fa-google"></i>
    아이디 찾기
  </button>
</div>

<div id='tab22' style="display:none;">
<div id="tab2" class="tab">
    <!-- ID input -->
    <div class="first-input input__block first-input__block signup-input__block">
       <input type="text" placeholder="기업회원" class="input" id="coId" name="coId" />
    </div>
    <!-- password input -->
    <div class="input__block">
       <input type="password" placeholder="기업회원" class="input" id="coPwd" name="coPwd" />
    </div>
    <!-- sign in button -->
    <button class="signin__btn" id="btnCoLogin">
      로그인(기업)
    </button>
    <div class="mol separator">
    <p>회원이 아니라면?</p>
  	</div>
    <button class="signup__btn" id="btnSignup">
      회원가입(기업)
    </button>
  </div>
</div>

</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>