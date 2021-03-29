<%--
0329
[06] JSP 실행
- Context Path의 값은 없음.
 --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
request.setCharacterEncoding("utf-8"); 
String root = request.getContextPath(); // 절대 경로
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
  Context Path: <%=root %><br>
  <%
  int su1 = 100;
  int su2 = 200;
  out.println(su1+su2);
  %>
  <br>
  <!-- JSTL을 이용해 값을 할당 -->
  <c:set var="season" value="여름입니다." />
  JSTL 사용: ${season }
   
</body>
</html>