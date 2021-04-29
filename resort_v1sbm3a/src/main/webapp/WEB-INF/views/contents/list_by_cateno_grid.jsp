<%-- 
7. View: JSP
1) GRID 목록 화면
▷ /webapp/WEB-INF/views/cate/list_all.jsp기반
/contents/list_by_cateno 기반
/contents/list_by_cateno_grid.jsp
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      
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
 
<DIV class='title_line'>
  <A href="../categrp/list.do" class='title_link'>카테고리 그룹 전체</A> > 
  <A href="../cate/list_by_categrpno.do?categrpno=${categrpVO.categrpno }" class='title_link'>${categrpVO.name }</A> > 
  <A href="./list_by_cateno.do?cateno=${cateVO.cateno }" class='title_link'>${cateVO.name }</A> 
  </DIV>
  
<DIV class='content_body'>
  <ASIDE class="aside_right"> <!-- 서브 메뉴 -->
    <A href="./create.do?cateno=${cateVO.cateno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>    <%-- 앵커 태그를 사용해 javaSript 사용  --%>
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }">기본 목록형</A>
  </ASIDE> 

 <DIV class='menu_line'></DIV>

  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="contentsVO" items="${list }" varStatus="status"> <%-- Controller의 addobject--%>
      <c:set var="contentsno" value="${contentsVO.contentsno }" />
      <c:set var="thumb1" value="${contentsVO.thumb1 }" />
      <c:set var="file1" value="${contentsVO.file1 }" />
      <c:set var="size1" value="${contentsVO.size1 }" />
      <c:set var="title" value="${contentsVO.title }" />
      <c:set var="content" value="${contentsVO.content }" />
      
      <c:set var="price" value="${contentsVO.price }" />
      <c:set var="dc" value="${contentsVO.dc }" />
      <c:set var="saleprice" value="${contentsVO.saleprice }" />
      <c:set var="point" value="${contentsVO.point }" />

      <%--하나의 행에 이미지를 4개씩 출력후 행 변경 --%>
      <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if>
      
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV style='width: 24%; 
              float: left; 
              margin: 0.5%; padding: 0.5%; background-color: #EEEFFF; text-align: center;' > <!-- 반응형 웹 표현, 가변적인 위치 -->
        <c:choose>
          <c:when test="${size1 > 0}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <!-- 이미지 인경우 -->
                <a href="./read.do?contentsno=${contentsno}">               
                  <IMG src="./storage/${thumb1 }" style='width: 100%; height: 150px;'> <!-- width는 %, 높이는 px로 고정 -->
                </a>
                
              <DIV class='menu_line2'><strong>${title}</strong></DIV>
               <del><fmt:formatNumber value="${price}" pattern="#,###" />원</del>
               <span style= "color:#FF0000; font-size: 1.0em" >${dc} %</span> <!--  스타일적용 --> 
               <Strong><fmt:formatNumber value='${saleprice}' pattern="#,###" />원</Strong><BR>
                 
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                    <a href="./read.do?contentsno=${contentsno}">${file1}</a><br>
                  </DIV>
                </DIV>
                ${title} (${cnt})              
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise> <%-- 파일이 없는 경우 기본 이미지 출력 --%>
            <a href="./read.do?contentsno=${contentsno}">
              <img src='/contents/images/none2.png' style='width: 100%; height: 150px;'>
            </a><br>
            이미지를 등록해주세요.
          </c:otherwise>
        </c:choose>         
      </DIV>  
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
  </div>    
</DIV> <!--  contente body end -->

<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>