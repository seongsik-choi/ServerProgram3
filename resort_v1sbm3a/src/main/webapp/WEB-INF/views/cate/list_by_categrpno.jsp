<%-- 
0412
7. View: JSP
 http://localhost:9091/cate/list_by_categrpno.do?categrpno=1
1)목록 화면
▷ /webapp/WEB-INF/views/cate/list_by_categrpno.jsp 
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
 
<DIV class='title_line'>
<A href="../categrp/list.do" class='title_link'>
          카테고리 그룹</A> > ${categrpVO.name }(${categrpVO.categrpno }) </DIV>

<DIV class='content_body'>
   <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      
      <!-- value에 param(GET으로 전달받은 값을 기본 값으로 사용. ex) 여행-> 1 자동 입력 -->
      <!-- disable를 설정하여 값 설정 변경을 못하게 설정이 가능하나
       가장 큰 문제 ) 값 전달을 못함 : 무결성 제약 조건 위배
       해결) hidden type을 사용해 사용자에게 보이지않게 설정 + 실제 값 보여주기만 -> 
      -->
      <label>카테고리 그룹 번호 : </label>
       <input type='hidden' name='categrpno' value='${param.categrpno }'> <!-- 출력 용도 -->
       ${param.categrpno }&nbsp; <!--  공백한칸  -->
        
      <label>카테고리 이름</label>
      <input type='text' name='name' value='' required="required" style='width: 25%;' autofocus="autofocus">
  
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
      </FORM>
  </DIV>
  

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
      <TH class="th_bs">카테고리 번호</TH>
      <TH class="th_bs">카테고리 그룹 번호</TH>
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
        <TD class="td_bs_left">
<%--         <!-- 1) 검색하지않는 목록 -->
        <A href="../contents/list_by_cateno.do?cateno=${cateno }">${cateVO.name }</A> --%>
<%--         <!--  2) 검색한 목록 -->
        <A href="../contents/list_by_cateno_search.do?cateno=${cateno }">${cateVO.name }</A> --%>
        <!--  3) 검색 + 페이징 목록  -->
        <A href="../contents/list_by_cateno_search_paging.do?cateno=${cateno }&now_page=${now_page=1}">${cateVO.name }</A>
        </TD>
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