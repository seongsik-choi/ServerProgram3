<%-- 
0330
2. 화면 상단 메뉴
- 자주 사용되는 EL 값의 활용: <c:set var="root" value="${pageContext.request.contextPath}" />
                                       ${root}
▷ /webapp/WEB-INF/views/menu/top.jsp
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<DIV class='container_main'> 
  <%-- 화면 상단 메뉴 --%>
  <DIV class='top_img'>
    <DIV class='top_menu_label'>Resort 0.1 영화와 여행이있는 리조트</DIV>
    <NAV class='top_menu'>
      <span style='padding-left: 0.5%;'></span>
      <A class='menu_link'  href='/' >힐링 리조트</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/categrp/list.do'>카테고리 그룹</A><span class='top_menu_sep'> </span>    
            
    </NAV>
  </DIV>
  
  <%-- 내용 --%> 
  <DIV class='content'>
