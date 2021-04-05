<%-- 
0405
- Pay.java -> PayCode.java -> CodeTable.java의 객체를 호출.
1. forEach문 사용, list가 CodeTable의 ArrayList 객체 이름

▷ /sts_basic/src/main/webapp/jstl/enum.jsp
--%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dev.mvc.pay.PayCode" %>
<%@ page import="dev.mvc.pay.CodeTable" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>JSTL enum 출력</title>
<style type="text/css">
  *{ font-size: 36px; }
</style>
</head>
<body>

<%
// 사용, Controller에서 선언 할 것.
ArrayList<PayCode> list = CodeTable.getPayCode();
request.setAttribute("list", list);
%>

주문 1:<br>
  <!--forEach문 사용, list가 CodeTable의 ArrayList 객체 이름-->
  <c:forEach var="code" items="${list }" varStatus="info">
    ${info.count }. ${code.pay }: ${code.value }<br>
  </c:forEach>

<br>
<!-- forEach문 사용, Option 선택 -->
주문 2:
  <select name='order'>
  <c:forEach var="code" items="${list }" varStatus="info">
      <option value="${code.value }">${code.pay }</option>
  </c:forEach>
  </select>

<br>
<!-- forEach문 사용, Option 선택, 결재(A03) 기본값 선택 -->
주문 3:
  <select name='order'>
  <c:forEach var="code" items="${list }" varStatus="info">
      <option value="${code.value }" ${code.value=='A03' ? "selected='selected'":"" }>${code.pay }</option>
  </c:forEach>
  </select>

</body>
</html>