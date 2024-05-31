<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>WithSports</title>
<script>
$(document).ready(function(){
	$("#btnWrite").on("click", function(){
		if($.trim($("#title").val()).length <= 0)
		{
			$("#title").val("");
			$("#title").focus();
			return;
		}
		
		if($.trim($("#content").val()).length <= 0)
		{
			$("#content").val("");
			$("#content").focus();
			return;
		}
		
		var form = $("#writeForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			type:"POST",
			url:"/board/revWriteProc",
			data:formData,
		    processData:false,							//formData를 string으로 변환하지 않음
		    contentType:false,							//content-type헤더가 multipart/form-data로 전송
		    cache:false,
		    timeout:600000,
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					location.href = "/board/revList";
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
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
  <main id="main">
    <section id="contact" class="contact mb-5">
      <div class="container" data-aos="fade-up">

        <div class="row">
          <div class="col-lg-12 text-center mb-5">
            <h3>게시글 작성</h3>
          </div>
        </div>

        <div class="form mt-5">
          <form id="writeForm" method="post" class="php-email-form">
            <div class="row">
              <div class="form-group col-md-8">
                <input type="text" class="form-control" name="title" id="title" value="" placeholder="제목" required>
              </div>
              <div class="form-group col-md-4">
              <c:choose>
              	<c:when test="${!empty cookieNmId}">
                <input type="text" class="form-control" name="nmId" id="nmId" value="${nmUser.getNmNickname()}" placeholder="${nmUser.getNmNickname()}" style="background-color:#F2F2F2;" readonly>
                </c:when>
                <c:when test="${!empty cookieCoId }">
                <input type="text" class="form-control" name="coId" id="coId" value="${coUser.getCoName()}" placeholder="${coUser.getCoName()}" style="background-color:#F2F2F2;" readonly>
                </c:when>
              </c:choose>
              </div>
            </div>
            <div class="form-group">
              <textarea class="form-control" name="content" id="content" rows="5" placeholder="내용" required></textarea>
            </div>
            <!-- 첨부파일 
                 이거 버튼 눌러서 첨부파일 입력할 수 있는 칸 늘어나게 하면 어떨까
                 아님 확장자 제한 둬서 이미지만 첨부 가능하게 하고 순서대로 보여주기-->
            <input type="file" id="revFile" name="revFile" class="form-control mb-2" placeholder="파일을 선택하세요." />
            <div class="text-center"><button id="btnWrite" name="btnWrite"type="submit">발행</button></div>
          </form>
        </div><!-- End Contact Form -->

      </div>
    </section>

  </main><!-- End #main -->

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  
</body>

</html>