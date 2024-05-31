<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>WithSports</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
	$("#btnFileDelete").on("click", function() {
		   if(confirm("첨부파일을 삭제하시겠습니까? (삭제가 완료되면 첨부파일은 찾을 수 없습니다.)") == true)
		   {
			   $("#file1212").hide();
			   $("#btnFileDeleteClick").val("Y");
		   }
	  });
	
	$("#btnUpdate").on("click", function(){
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
		
		var form = $("#updateForm")[0];
		var formData = new FormData(form);
		
		fn_update(formData);
	});
});

function fn_update(formData)
{
	$.ajax({
		type:"POST",
		url:"/board/revUpdateProc",
		enctype:"multipart/form-data",
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
				  alert("게시물이 수정되었습니다.");
				  document.updateForm.action = "/board/revView";
				  document.updateForm.submit();
			}
			else if(response.code == 400)
			{
				alert("파라미터 값이 잘못 되었습니다.");
			}
			else if(response.code == 404)
			  {
				  alert("게시물이 존재하지 않습니다.");
				  location.href = "/board/revList";
			  }
			  else if(response.code == 403)
			  {
				  alert("사용자가 올바르지 않습니다.");
				  location.href = "/board/revList";
			  }
			else
			{
				alert("오류가 발생했습니다.");
			}
		},
		error:function(xhr, status, error){
			icia.common.error(error);
		}
	});
}
</script>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
  <main id="main">
    <section id="contact" class="contact mb-5">
      <div class="container" data-aos="fade-up">

        <div class="row">
          <div class="col-lg-12 text-center mb-5">
            <h3>게시글 수정</h3>
          </div>
        </div>

<form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
        <div class="form mt-5">
          <div class="php-email-form">
            <div class="row">
              <div class="form-group col-md-8">
                <input type="text" class="form-control" name="title" id="title" value="${rev.getRevTitle()}" placeholder="${rev.getRevTitle()}" required>
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
              <textarea class="form-control" name="content" id="content" rows="5" placeholder="${rev.getRevContent()}" required>${rev.getRevContent()}</textarea>
            </div>
            <!-- 첨부파일 
                 이거 버튼 눌러서 첨부파일 입력할 수 있는 칸 늘어나게 하면 어떨까
                 아님 확장자 제한 둬서 이미지만 첨부 가능하게 하고 순서대로 보여주기-->
            <input type="file" id="revFile" name="revFile" class="form-control mb-2" placeholder="파일을 선택하세요." />
            <c:if test="${!empty rev.getRevFile()}" >
		      <div id="file1212" style="margin-bottom:0.3em;">[첨부파일 : ${rev.getRevFile().getrevFileOrgName()}]
		      <input type="button" id="btnFileDelete" value="첨부파일 삭제"/>
		      </div>
			</c:if>	
            <div class="my-3">
            </div>
            <div class="text-center"><button id="btnUpdate" type="button">완료</button></div>
            <input type="hidden" id="btnFileDeleteClick" name="btnFileDeleteClick" value="N" />
            <input type="hidden" id="revSeq" name="revSeq" value="${rev.getRevSeq()}" />
          </div>
        </div><!-- End Contact Form -->
</form>
      </div>
    </section>
  </main><!-- End #main -->

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>
