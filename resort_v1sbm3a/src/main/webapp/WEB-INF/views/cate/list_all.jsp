<%-- 
0412
7. View: JSP
 
1)목록 화면
▷ /webapp/WEB-INF/views/cate/list_all.jsp 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'><A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 전체 카테고리</DIV>

<DIV class='content_body'>
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">카테고리 번호<BR></TH>
      <TH class="th_bs">카테고리 그룹 번호<BR></TH>
      <TH class="th_bs">카테고리 이름</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">관련 자료수</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="cateVO" items="${list}">
      <c:set var="cateno" value="${cateVO.cateno }" />
      <c:set var="categrpno" value="${cateVO.categrpno }" />
      <TR>
        <TD class="td_bs">${cateVO.cateno }</TD>
        <TD class="td_bs">${cateVO.categrpno }</TD>
        <TD class="td_bs">${cateVO.name }</TD>
        <TD class="td_bs">${cateVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${cateVO.cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?cateno=${cateno }&categrpno=${categrpno} " title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?cateno=${cateno }&categrpno=${categrpno} " title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>