<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
function kakaoPayResult(pgToken)
{
	$("#pgToken").val(pgToken);
	
	document.kakaoForm.action = "/pay/payResult";
	document.kakaoForm.submit();
}
</script>
</head>
<body>
<iframe width="100%" height="650" src="${pcUrl}" frameboder="0" allowfullscreen=""></iframe>
<form name="kakaoForm" id="kakaoForm" method="POST" target="kakaoPopUp" action="/pay/payPopUp">
	<input type="hidden" name="orderId" id="orderId" value="${orderId}"/>
	<input type="hidden" name="tId" id="tId" value="${tId}"/>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<input type="hidden" name="pgToken" id="pgToken" value=""/>
</form>
</body>
</html>