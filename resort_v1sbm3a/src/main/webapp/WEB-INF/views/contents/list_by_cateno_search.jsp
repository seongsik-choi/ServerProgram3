<%-- 
7. View: JSP
1) 검색 기능이 추가된 목록 화면
▷ /webapp/contents/list_by_cateno_search.jsp
 - list_by_cateno.jsp 기반
http://localhost:9090/contents/list_by_cateno_search.do?cateno=1&word=스위스
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
    <A href="./list_by_cateno_grid1.do?cateno=${cateVO.cateno }">갤러리형</A>
  </ASIDE> 

<DIV style="text-align: right; clear: both;" >  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 공백이 아니면, 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }'  
                     style='width: 30%;' autofocus="autofocus"><%--value에 값 출력  --%>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우, value는 비어있어야함--%>
          <input type='text' name='word' id='word' value='' style='width: 30%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">  <%-- 검색 취소 부분 --%>
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>

 <DIV class='menu_line'></DIV>
    
  <table class="table table-striped" style='width: 100%;'>
  <colgroup>
    <col style="width: 10%;"></col>
    <col style="width: 60%;"></col>
    <col style="width: 20%;"></col>
    <col style="width: 10%;"></col>
  </colgroup>
  
  <%-- table 컬럼 --%>
<%--   <thead>
    <tr>
      <th style='text-align: center;'>파일</th>
      <th style='text-align: center;'>제목/내용</th>
      <th style='text-align: center;'>정가/할인율/판매가/포인트</th> 컬럼 합쳐서 표시, UI를 위함
      <th style='text-align: center;'>기타</th>
    </tr>
  </thead> --%>
    
  <%-- table 내용 --%>
  <tbody>
    <c:forEach var="contentsVO" items="${list }">
      <c:set var="contentsno" value="${contentsVO.contentsno }" />
      <c:set var="thumb1" value="${contentsVO.thumb1 }" />
      
      <tr> <%-- 레코드 들 (등록일 부터~ 기타까지) --%>
        
        <td style='vertical-align: middle; text-align: center;'>
          
          <%-- 이미지(파일) 출력 고정 소스  --%>
          <c:choose>
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
              <a href="./read.do?contentsno=${contentsno}"><IMG src="/contents/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
            </c:when>
            <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
              ${contentsVO.file1}
            </c:otherwise>
          </c:choose>  <%-- 이미지 출력 고정 소스 종료 --%>
        </td>  
       
        <td style='vertical-align: middle;'>
          <%-- ContentProc에서 content 컬럼은 200자 이상 시...으로 설정  --%>
          <%-- String tag 사용 강조 --%>
          <a href="./read.do?contentsno=${contentsno}"> <strong>${contentsVO.title}</strong> ${contentsVO.content }</a> 
        </td>   
        
        <%-- 컬럼 합친거 표현 td표현
        <td style='vertical-align: middle; text-align: center;'>${contentsVO.price}</td>
        <td style='vertical-align: middle; text-align: center;'>${contentsVO.dc}</td>
        <td style='vertical-align: middle; text-align: center;'>${contentsVO.saleprice}</td>
        <td style='vertical-align: middle; text-align: center;'>${contentsVO.point}</td>
         --%>
        
        <td style='vertical-align: middle; text-align: center;'> <%-- 컬럼 합친거 표현 td표현  --%>
            <del><fmt:formatNumber value="${contentsVO.price}" pattern="#,###" /> 원</del><BR>          <!-- del로 취소선 -->
            <span style= "color:#FF0000; font-size: 1.2em" >${contentsVO.dc} %</span> <!--  스타일적용 -->
            <Strong><fmt:formatNumber value='${contentsVO.saleprice}' pattern="#,###" />원</Strong><BR>
            <span style= "font-size: 0.8em" >
            <fmt:formatNumber value='${contentsVO.point}' pattern="#,###" /> point</span>
            </td>
            
<%--         <td style='vertical-align: middle; text-align: center;'>${contentsVO.rdate.substring(0, 10)}</td> --%>
        <td style='vertical-align: middle; text-align: center;'>수정/삭제<BR>상품정보</td>
      </tr>
    </c:forEach>
    
  </tbody>
 </table>
</DIV>

<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>