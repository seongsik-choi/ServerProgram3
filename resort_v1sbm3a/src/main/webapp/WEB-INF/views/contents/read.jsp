<%-- 
[45][Contents] 조회 기능의 제작, 상품 구입 화면 
1) 조회
▷ /webapp/contents/read.jsp 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contentsno" value="${contentsVO.contentsno }" />
<c:set var="title" value="${contentsVO.title }" />
<c:set var="price" value="${contentsVO.price }" />
<c:set var="dc" value="${contentsVO.dc }" />
<c:set var="saleprice" value="${contentsVO.saleprice }" />
<c:set var="point" value="${contentsVO.point }" />
<c:set var="salecnt" value="${contentsVO.salecnt }" />
 
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
 
<DIV class='title_line'>
  <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../cate/list_by_categrpno.do?categrpno=${categrpVO.categrpno }" class='title_link'>${categrpVO.name }</A> >
  <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }" class='title_link'>${cateVO.name }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?cateno=${cateVO.cateno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }&now_page=${param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_grid.do?cateno=${cateVO.cateno }">갤러리형</A>
    <span class='menu_divide' >│</span>
    <A href="./update_text.do?contentsno=${contentsno}&now_page=${param.now_page}">수정</A>
    <span class='menu_divide' >│</span>
    <A href="./update_file.do?contentsno=${contentsno}&now_page=${param.now_page}">파일 수정</A>  
    <span class='menu_divide' >│</span>
    <A href="./delete.do?contentsno=${contentsno}&now_page=${param.now_page}">삭제</A>  
  </ASIDE> 
  
    <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search_paging.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <c:set var="file1saved" value="${contentsVO.file1saved.toLowerCase() }" />
        <c:if test="${file1saved.endsWith('jpg') || file1saved.endsWith('png') || file1saved.endsWith('gif')}">
          <DIV style="width: 50%; float: left; margin-right: 10px;">
            <IMG src="/contents/storage/${contentsVO.file1saved }" style="width: 100%;">
          </DIV>
          <DIV style="width: 47%; height: 260px; float: left; margin-right: 10px;">
            <span style="font-size: 1.5em; font-weight: bold;">${title }</span><br>
            <span style="color: #FF0000; font-size: 2.0em;">${dc} %</span>
            <span style="font-size: 1.5em; font-weight: bold;"><fmt:formatNumber value="${saleprice}" pattern="#,###" /> 원</span>
            <del><fmt:formatNumber value="${price}" pattern="#,###" /> 원</del><br>
            <span style="font-size: 1.2em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /> 원</span><br>
            <span style="font-size: 1.0em;">(보유수량: <fmt:formatNumber value="${salecnt}" pattern="#,###" /> 개)</span><br>
            <span style="font-size: 1.0em;">수량</span><br>
            <form>
            <input type='number' name='ordercnt' value='1' required="required" 
                       min="1" max="99999" step="1" class="form-control" style='width: 30%;'><br>
            <button type='button' onclick="" class="btn btn-info">장바 구니</button>           
            <button type='button' onclick="" class="btn btn-info">바로 구매</button>
            <button type='button' onclick="" class="btn btn-info">관심 상품</button>
            </form>
          </DIV> 
        </c:if> 
        <DIV>${contentsVO.content }</DIV>
      </li>
      <li class="li_none">
        <DIV style='text-decoration: none;'>
          검색어(키워드): ${contentsVO.word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${contentsVO.file1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/contents/storage&filename=${contentsVO.file1saved}&downname=${contentsVO.file1}'>${contentsVO.file1}</A> (${contentsVO.size1_label})  
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

