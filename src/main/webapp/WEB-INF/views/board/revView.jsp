<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<body>
<script type="text/javascript">
$(document).ready(function(){
      $("#btnList").on("click", function(){
    	  document.revForm.action = "/board/revList";
    	  document.revForm.submit();
      });
      
      $("#btnRevUpdate").on("click", function(){
    	  document.revForm.action = "/board/revUpdate";
    	  document.revForm.submit();
      });
      
      $("#btnRevDelete").on("click", function(){
    	  if(confirm("게시물을 삭제 하시겠습니까?") == true)
    	  {
    		  alert("seq : " + $("#revSeq").val());
    		  $.ajax({
    			  type:"post",
    			  url:"/board/revDelete",
    			  data:{
    				  revSeq:$("#revSeq").val()
    			  },
    			  datatype:"JSON",
    			  beforeSend:function(xhr){
    				  xhr.setRequestHeader("AJAX", "true");
    			  },
    			  success:function(response){
    				  if(response.code == 0)
    				  {
    					  document.revForm.action = "/board/revList";
    			    	  document.revForm.submit();
    				  }
    				  else if(response.code == 403)
    				  {
    					  alert("내 게시물이 아닙니다.");
    					  document.revForm.action = "/board/revList";
    			    	  document.revForm.submit();
    				  }
    				  else if(response.code == 404)
    				  {
    					  alert("게시물을 찾을 수 없습니다.");
    					  location.href = "/board/revList";
    				  }
    				  else if(response.code == 400)
    				  {
    					  alert("잘못된 요청입니다.");
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
      });
      
      $("#revReply").on("click", function(){
    	 if($.trim($("#comment-message").val()).length <= 0)
    	 {
    		 alert("내용을 입력하세요.");
    		 $("#comment-message").val("");
    		 $("#comment-message").focus();
    		 return;
    	 }
    	 
    	 $.ajax({
    		type:"post",
    		url:"/board/replyProc",
    		data:{
    			revSeq:$("#revSeq").val(),
    			replyContent:$("#comment-message").val()
    		},
    		datatype:"JSON",
    		beforeSend:function(xhr){
    			xhr.setRequestHeader("AJAX", "true");
    		},
    		success:function(response){
    			if(response.code == 0)
    			{
    				document.revForm.action = "/board/revView";
			    	document.revForm.submit();
    			}
    			else if(response.code == 400)
    			{
    				alert("파라미터값이 올바르지 않습니다.");
    				$("#comment-message").focus();
    			}
    			else
    			{
    				alert("오류가 발생하였습니다.");
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

    <section class="single-post-content">
      <div class="container">
        <div class="row">
          <div class="post-content" data-aos="fade-up">

            <!-- ======= 게시글 내용 시작 ======= -->
            <div class="single-post border-bottom" >
              <div class="post-meta"><span class="date">작성일 : ${rev.getRevRegDate()} </span> <span class="mx-1">&bullet;</span> <span>조회수 : ${rev.getRevReadCnt()}</span></div>
              <h1>${rev.getRevTitle()}</h1>
	         <div class="d-flex align-items-center author">
                <c:choose>
	              <c:when test='${rev.nmNickname ne "1"}'>
                  	<div><i class="bi bi-person-circle"></i></div>
		              <div class="name">
		                <h3 class="m-0 p-0">${rev.getNmNickname()}</h3> 
		              </div>
	              </c:when>
	              <c:when test='${rev.nmId eq "co"}'>
		              <div><i class="bi bi-buildings"></i></div>
			              <div class="name">
			                <h3 class="m-0 p-0">${rev.getCoName()}</h3>
			              </div>
	              </c:when>
	            </c:choose>
              </div>
<c:if test="${!empty rev.getRevFile()}" >
			  <div class="border-top border-bottom"  style="color:#000; text-align:right;">
              &nbsp;&nbsp;&nbsp;<a href="/board/downloadRev?revSeq=${rev.getRevSeq()}">[첨부파일 : <c:out value="${rev.getRevFile().getrevFileOrgName()}" />]</a>
              <br />
              </div>
</c:if> 
<br />
              <p><c:out value="${rev.getRevContent()}" /></p>
			<br/>

			  <!-- 이미지 첨부 -->
              <c:if test="${rev.getRevFile().getrevFileExt() eq 'jpg' or rev.getRevFile().getrevFileExt() eq 'png' or rev.getRevFile().getrevFileExt() eq 'jpeg' 
              				or rev.getRevFile().getrevFileExt() eq 'gif'}">
              <figure class="my-4">
              	<img src="../resources/revUpload/${rev.getRevFile().getrevFileName()}" alt="" class="img-fluid"><br />
              </figure>
              </c:if> 
              <c:if test="${rev.getRevFile().getrevFileExt() eq 'mp4'}">
			    <video controls poster="videos/Clouds.png" style="max-width: 80%; display: block; margin: 20px auto;">
			      <source src="../resources/revUpload/${rev.getRevFile().getrevFileName()}" type="video/mp4">
			      <strong>Your browser does not support the video tag.</strong>
			    </video>
              </c:if> 
              <div class="mb-2 border-bottom d-flex justify-content-beetween">
              <div class="col-md-10">
              <input type="button" name="btnList" id="btnList" class="btn btn-primary" value="리스트" />
              </div>
<c:if test="${rev.getNmId() eq cookieNmId or rev.getCoId() eq cookieCoId}">              
              <div class="col-md-10">
              <input type="button" name="btnRevUpdate" id="btnRevUpdate" class="btn btn-primary" value="수정" style="height:38px;" />&nbsp;
              <input type="button" name="btnRevDelete" id="btnRevDelete" class="btn btn-primary" value="삭제" style="height:38px;" />
              </div>
</c:if>
            <br /><br />
			</div><!-- 게시글 내용 끝 -->
<c:if test="${!empty cookieNmId or !empty cookieCoId}">
            <!-- ======= 댓글 시작 ======= -->
            <div class="comments border-bottom">
              <h5 class="comment-title py-4">댓글 목록</h5>
 <c:if test="${!empty listRe}">      
 	<c:forEach var="reply" items="${listRe}" varStatus="status">
 	<c:set var="i" value="${i + 1}" />
 	<c:set var="j" value="${j + 1}" />
 	<c:choose>
		 <c:when test="${reply.replyIndent eq 0}">
		     <div class="comment d-flex mb-4">
                <div class="flex-grow-1 ms-2 ms-sm-3">
                  <div class="comment-meta d-flex align-items-baseline justify-content-beetween" style="height:40px">
                  <div class="col-md-11">
                  <c:choose>
		              <c:when test='${reply.coId eq "nm"}'>
		               <i class="bi bi-person-circle"></i>&nbsp;&nbsp;<a class="me-2">${reply.nmNickname}</a>
		              </c:when>
		              <c:when test='${reply.nmId eq "co"}'>
			           <i class="bi bi-buildings"></i>&nbsp;&nbsp;<a class="me-2">${reply.coName}</a>
		              </c:when>
			      </c:choose>
                    <a class="text-muted">${reply.replyRegDate}</a>
                  </div>
<c:if test="${reply.nmId eq cookieNmId or reply.coId eq cookieCoId}">
					<div class="col-md-11">
					<a onclick='fn_replyUpdate($("#replySeq${i}").val(), "${reply.replyContent}")' class="text-muted">수정</a>&nbsp;
					<a onclick='fn_replyDelete($("#replySeq${i}").val())' class="text-muted">삭제</a>
					</div>
</c:if>
                  </div>
                  <div class="comment-body">
					${reply.replyContent}
					<!-- 답댓글 이미지 클릭하면 해당 댓글 아래에 바로 작성 할 수 있는 폼이 보였다 안보였다 하게 설정 -->
					<a href="javascript:void(0)" onclick='fn_reply(${i}, $("#replySeq${i}").val())'>
					<i class="bi bi-arrow-return-right" style="float:right;"></i></a>
					<input type="hidden" id="replySeq${i}" value="${reply.replySeq}" />
					<input type="hidden" id="eiei${i}" value="${i}" />
					</div>
                </div>
                </div>
         </c:when>
         <c:when test="${reply.replyIndent ne 0}">
         	<div class="comment-replies bg-light p-3 mt-3 rounded">
                    <div class="reply d-flex mb-4">
                      <div class="flex-grow-1 ms-2 ms-sm-3">
                        <div class="reply-meta  d-flex align-items-baseline">
                        	<div class="col-md-11">
	                        <i class="bi bi-arrow-return-right" style="margin-left:${reply.replyIndent}em"></i>
	                        <c:choose>
				              <c:when test='${reply.coId eq "nm"}'>
				               <i class="bi bi-person-circle"></i>&nbsp;&nbsp;<a class="me-2">${reply.nmNickname}</a>
				              </c:when>
				              <c:when test='${reply.nmId eq "co"}'>
					           <i class="bi bi-buildings"></i>&nbsp;&nbsp;<a class="me-2">${reply.coName}</a>
				              </c:when>
						    </c:choose>
						    <a class="text-muted" style="font-size: 12px;">${reply.replyRegDate}</a>
						    </div>
<c:if test="${reply.nmId eq cookieNmId or reply.coId eq cookieCoId}">
					<div class="col-md-11" style="font-size: 12px;">
					<a onclick='fn_replyUpdate($("#replySeq${i}").val(), "${reply.replyContent}")' class="text-muted">수정</a>&nbsp;
					<a onclick='fn_replyDelete($("#replySeq${i}").val())' class="text-muted">삭제</a>
					</div>
</c:if>
                        </div>
                        <div class="reply-body">
                          <a style="margin-left:${reply.replyIndent}em"></a>${reply.replyContent}
						<!-- 답댓글 이미지 클릭하면 해당 댓글 아래에 바로 작성 할 수 있는 폼이 보였다 안보였다 하게 설정 -->
						<a href="javascript:void(0)" onclick='fn_reply(${i}, $("#replySeq${i}").val())'>
						<i class="bi bi-arrow-return-right" style="float:right;"></i></a>
						<input type="hidden" id="replySeq${i}" value="${reply.replySeq}" />
						<input type="hidden" id="eiei${i}" value="${i}" />
						</div>
                      </div>
                    </div>
         	</div>
         </c:when>
    </c:choose>
                <div id="popup" class="popup-overlay">
                	<div class="popup-content">
					  <h5 class="comment-title"><i class="bi bi-arrow-return-right"></i>대댓글 작성</h5>
					  <div class="row">
					    <div class="col-12 mb-3">
					      <textarea class="form-control" id="reply-message" placeholder="내용을 입력하세요." cols="30" rows="10" maxlength="300" style="height:62px;"></textarea>
					    </div>
					    <div class="col-12">
					      <input type="button" onclick="closePopup()" class="btn btn-primary" style="float:left;" value="닫기">
					      <input type="button" id="btnrereply" class="btn btn-primary" style="float:right;" value="댓글 작성">
					    </div>
					  </div>
					</div>
                </div>
                
                <div id="popup2" class="popup-overlay">
                	<div class="popup-content">
					  <h5 class="comment-title"><i class="bi bi-arrow-return-right"></i>댓글 수정</h5>
					  <div class="row">
					    <div class="col-12 mb-3">
					      <textarea class="form-control" id="update-message" placeholder="수정할 내용을 입력하세요." cols="30" rows="10" maxlength="300" style="height:62px;"></textarea>
					    </div>
					    <div class="col-12">
					      <input type="button" onclick="closePopup()" class="btn btn-primary" style="float:left;" value="닫기">
					      <input type="button" id="btnUpdate" class="btn btn-primary" style="float:right;" value="댓글 수정">
					    </div>
					  </div>
					</div>
                </div>
                
                <style>
	                .popup-overlay {
						position: fixed;
						top: 0;
						left: 0;
						width: 100%;
						height: 100%;
						background-color: rgba(0, 0, 0, 0.5);
						display: flex;
						justify-content: center;
						align-items: center;
						visibility: hidden;
						opacity: 0;
						transition: visibility 0s, opacity 0.3s ease;
					}
					.popup-content {
						width: 400px;
						padding: 20px;
						background-color: #fff;
						border-radius: 5px;
						box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
					}
                </style>
                
                <script>
					function fn_reply(num, seq) {
						var popup = document.getElementById("popup");
						popup.style.visibility = "visible";
						popup.style.opacity = "1";
						
						$("#btnrereply").on("click", function(){
							if($.trim($("#reply-message").val()).length <= 0)
					    	 {
					    		 alert("내용을 입력하세요.");
					    		 $("#reply-message").val("");
					    		 $("#reply-message").focus();
					    		 return;
					    	 }
							$.ajax({
					    		type:"post",
					    		url:"/board/rereplyProc",
					    		data:{
					    			revSeq:$("#revSeq").val(),
					    			replySeq:seq,
					    			replyContent:$("#reply-message").val()
					    		},
					    		datatype:"JSON",
					    		beforeSend:function(xhr){
					    			xhr.setRequestHeader("AJAX", "true");
					    		},
					    		success:function(response){
					    			if(response.code == 0)
					    			{
					    				document.revForm.action = "/board/revView";
								    	document.revForm.submit();
					    			}
					    			else if(response.code == 400)
					    			{
					    				alert("파라미터값이 올바르지 않습니다.");
					    				$("#comment-message").focus();
					    			}
					    			else
					    			{
					    				alert("오류가 발생하였습니다.");
					    			}
					    		},
					    		error:function(xhr, status, error){
					    			icia.common.error(error);
					    		}
					    	 });
						});
					}
					
					function closePopup() {
						var popup = document.getElementById("popup");
						popup.style.visibility = "hidden";
						popup.style.opacity = "0";
						document.revForm.action = "/board/revView";
				    	document.revForm.submit();
					}
					
					function fn_replyUpdate(num, content){
						var popup2 = document.getElementById("popup2");
						popup2.style.visibility = "visible";
						popup2.style.opacity = "1";
						
						$("#update-message").val(content);
						
						$("#btnUpdate").on("click", function(){
							if($.trim($("#update-message").val()).length <= 0)
					    	 {
					    		 alert("내용을 입력하세요.");
					    		 $("#update-message").val("");
					    		 $("#update-message").focus();
					    		 return;
					    	 }
							$.ajax({
					    		type:"post",
					    		url:"/board/revReplyUpdate",
					    		data:{
					    			replySeq:num,
					    			replyContent:$("#update-message").val()
					    		},
					    		datatype:"JSON",
					    		beforeSend:function(xhr){
					    			xhr.setRequestHeader("AJAX", "true");
					    		},
					    		success:function(response){
					    			if(response.code == 0)
					    			{
					    				document.revForm.action = "/board/revView";
								    	document.revForm.submit();
					    			}
					    			else if(response.code == 400)
					    			{
					    				alert("파라미터값이 올바르지 않습니다.");
					    				$("#update-message").focus();
					    			}
					    			else
					    			{
					    				alert("오류가 발생하였습니다.");
					    			}
					    		},
					    		error:function(xhr, status, error){
					    			icia.common.error(error);
					    		}
					    	 });
						});
					}
					
					function fn_replyDelete(num){
						if(confirm("댓글을 삭제 하시겠습니까?") == true)
				    	  {
				    		  $.ajax({
				    			  type:"post",
				    			  url:"/board/revReplyDelete",
				    			  data:{
				    				  replySeq:num
				    			  },
				    			  datatype:"JSON",
				    			  beforeSend:function(xhr){
				    				  xhr.setRequestHeader("AJAX", "true");
				    			  },
				    			  success:function(response){
				    				  if(response.code == 0)
				    				  {
				    					  alert("삭제되었습니다.");
				    					  document.revForm.action = "/board/revView";
									      document.revForm.submit();
				    				  }
				    				  else if(response.code == -5)
				    				  {
				    					  alert("대댓글이 있는 댓글은 삭제하실 수 없습니다.");
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
					}
				</script>
	</c:forEach>
</c:if>              
              </div>  
</c:if>
            </div><!-- End Comments -->

<c:if test="${!empty cookieNmId or !empty cookieCoId}">
            <!-- ======= 새 댓글 작성 시작 ======= -->
            <div class="row justify-content-center mt-5">

              <div class="col-lg-12">
                <h5 class="comment-title">새 댓글 작성</h5>
                <div class="row">
                  <div class="col-lg-6 mb-3">
                  	<c:choose>
		              <c:when test='${!empty cookieNmId}'>
	                  	<input type="text" class="form-control" id="comment-name" value="${cookieNmId}" placeholder="" style="background-color:#F2F2F2;" readonly>
		              </c:when>
		              <c:when test='${!empty cookieCoId}'>
			             <input type="text" class="form-control" id="comment-name" value="${cookieCoId}" placeholder="" style="background-color:#F2F2F2;" readonly>
		              </c:when>
		            </c:choose>
                  </div>
                  <div class="col-12 mb-3">
                    <textarea class="form-control" id="comment-message" placeholder="내용을 입력하세요." cols="30" rows="10" maxlength="300" style="height:86px;"></textarea>
                  </div>
                  <div class="col-12">
                    <input type="button" id="revReply" class="btn btn-primary" style="float:right;" value="댓글 작성">
                  </div>
                </div>
              </div>
            </div><!-- 새 댓글 작성 끝 -->
</c:if>
          </div>

        </div>
      </div>
    </section>
    <form name="revForm" id="revForm" method="post">
		<input type="hidden" id="revSeq" name="revSeq" value="${revSeq}" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>
  </main><!-- End #main -->

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>