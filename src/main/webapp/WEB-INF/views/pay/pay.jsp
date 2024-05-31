<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#btnPay").on("click", function(){
		$("#btnPay").prop("disabled", true);
		
		$.ajax({
			type:"POST",
			url:"/pay/payReady",
			data:{
				itemCode:$("#itemCode").val(),
			   	itemName:$("#itemName").val(),
			    quantity:$("#quantity").val(),
			    totalAmount:$("#totalAmount").val()
			},
			dataType:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				icia.common.log(response);
				
				if(response.code == 0)
				{
					var orderId = response.data.orderId;
					var tId = response.data.tId;
					var pcUrl = response.data.pcUrl;
					
					 $("#orderId").val(orderId);
					 $("#tId").val(tId);
					 $("#pcUrl").val(pcUrl);
					 
					 var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=500,left=100,top=100');
					 
					 document.kakaoForm.action="/pay/payPopUp"
					 document.kakaoForm.submit();
				   
				     $("#btnPay").prop("disabled", false);
				}
				else
				{
					alert("오류가 발생하였습니다.");
					$("#btnPay").prop("disabled", false);
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
<body style="background-color:#F9DD0F">
<div class="container">
   <h2 style="font-weight:bold;">카카오페이</h2>
   <form name="payForm" id="payForm" method="post" style="background-color:#FFFFFF">
   	<table>
   		<tr>
   		 <td>코드 : </td>
   		 <td><a>&nbsp;${prom.promSeq}</a></td>
   		</tr>
   		<tr>
   		 <td>행사명 : </td>
   		 <td><a>&nbsp;${prom.promTitle}</a></td>
   		</tr>
   		<tr>
   		 <td>수량 : </td>
   		 <td><a>&nbsp;1</a></td>
   		</tr>
   		<tr>
   		 <td>행사진행일 : </td>
   		 <td><a>&nbsp;${prom.promCoSdate} ~ ${prom.promCoEdate}</a></td>
   		</tr>
   		<tr>
   		 <td>금액 : </td>
   		 <td><a>&nbsp;${prom.promPrice} 원</a></td>
   		</tr>
   	</table>
      <input type="hidden" name="itemCode" id="itemCode" maxlength="32" class="form-control mb-2" placeholder="상품코드" value="${prom.promSeq}" />
      <input type="hidden" name="itemName" id="itemName" maxlength="50" class="form-control mb-2" placeholder="상품명" value="${prom.promTitle}" />
      <input type="hidden" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="1" />
      <input type="hidden" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="${prom.promCoSdate} ~ ${prom.promCoEdate}" />
      <input type="hidden" name="totalAmount" id="totalAmount" maxlength="10" class="form-control mb-2" placeholder="금액" value="${prom.promPrice}" />
      <div class="form-group row">
         <div class="col-sm-12" style="text-align:center;">
            <button type="button" id="btnPay" class="btn btn-primary" title="카카오페이">카카오페이</button>
         </div>
      </div>
   </form>
<form name="kakaoForm" id="kakaoForm" method="POST" target="kakaoPopUp">
	<input type="hidden" name="orderId" id="orderId" value=""/>
	<input type="hidden" name="tId" id="tId" value=""/>
	<input type="hidden" name="pcUrl" id="pcUrl" value=""/>
</form>
</div>
</body>
</html>