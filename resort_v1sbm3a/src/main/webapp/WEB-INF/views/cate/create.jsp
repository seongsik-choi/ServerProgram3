<%-- 
0409
7. View: JSP
- 등록폼에서 FK 컬럼인 categrpno 컬럼의 값을 <input type='hidden' ...> 태그로 전달해야함
  예) <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
      <!-- categrp 테이블로부터 값을 전달받지 못한 경우는 값을 직접 지정하여 개발 -->
      <input type="hidden" name="categrpno" value="1">
  
1) 입력 화면
- http://localhost:9091/cate/create.do?categrpno=1
▷ /webapp/WEB-INF/views/cate/create.jsp 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>카테고리 등록</DIV>
 
<DIV class='content_body'>
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
    <!-- 
    부모테이블 categrpno PK 컬럼 값 이용, hidden으로 FK 선언
    http://localhost:9090/cate/create.do?categrpno=1
     -->
    <input type="hidden" name="categrpno" value="${param.categrpno }"> 
    
    <div class="form-group">
       <label class="control-label col-md-3">카테고리 이름</label>
       <div class="col-md-9">
         <input type='text' name='name' value='' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 50%;'>
          (부모 카테고리 번호(categrpno): ${param.categrpno })    <BR>   
          (부모 카테고리 번호(categrpno) 2에 해당하는 레코드 등록 시 : GET /url..?categrpno=2)  
       </div>
    </div>
    <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list_all.do'" class="btn btn-primary">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>