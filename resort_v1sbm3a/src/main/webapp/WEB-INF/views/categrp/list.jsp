<%-- 
0406
7. View: JSP, 등록과 목록의 결합
- <TABLE><TH><TD>는 Bootstrap에 기본 속성이 설정되어 있음
▷ /webapp/categrp/list.jsp 
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
 
<DIV class='title_line'>카테고리 그룹</DIV>

<DIV class='content_body'>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
        
      <label>그룹 이름</label>
      <input type='text' name='name' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>순서</label>
      <input type='number' name='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
      </FORM>
  </DIV>
   
  <TABLE class='table table-striped'>
    <colgroup>
    <col style='width: 10%;'/>  <!-- /는 close 태그 == body 없이 태그의 속성만 사용 -->
    <col style='width: 40%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>    
    <col style='width: 20%;'/>
  </colgroup>
  
  <thead>  
  <TR>
    <TH class="th_bs">출력 순서</TH>
    <TH class="th_bs">카테고리 그룹 이름</TH>
    <TH class="th_bs">그룹 생성일</TH>
    <TH class="th_bs">출력 모드</TH>
    <TH class="th_bs">기타</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="categrpVO" items="${list}">
    <c:set var="categrpno" value="${categrpVO.categrpno }" />
    <TR>
      <TD class="td_bs">${categrpVO.seqno }</TD>
      <TD class="td_bs_left" style='font-weight: bold'>
      <A href="../cate/list_by_categrpno.do?categrpno=${categrpno }">${categrpVO.name }</A></TD>
      <TD class="td_bs">${categrpVO.rdate.substring(0, 10) }</TD> <!-- subString으로 년, 월일만 잘라내기  -->
       
     <%--   
     <TD class="td_bs">
        <c:choose>
          <c:when test="${categrpVO.visible == 'Y'}">
            <A href="./update_visible.do?categrpno=${categrpno }&visible=${categrpVO.visible }">Y</A>
          </c:when>
          <c:otherwise>
            <A href="./update_visible.do?categrpno=${categrpno }&visible=${categrpVO.visible }">N</A>
          </c:otherwise>
        </c:choose>
       </TD>    --%>
       
        <TD class="td_bs">
          <c:choose>
            <c:when test="${categrpVO.visible == 'Y'}">
              <A href="./update_visible.do?categrpno=${categrpno }&visible=${categrpVO.visible }"><IMG src="/categrp/images/open.png" style='width: 18px;'></A>
            </c:when>
            <c:otherwise>
              <A href="./update_visible.do?categrpno=${categrpno }&visible=${categrpVO.visible }"><IMG src="/categrp/images/close.png" style='width: 18px;'></A>
            </c:otherwise>
          </c:choose>
        </TD>   
        
      <TD class="td_bs">
        <A href="./read_update.do?categrpno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
        <A href="./read_delete.do?categrpno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        <A href="./update_seqno_up.do?categrpno=${categrpno }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
        <A href="./update_seqno_down.do?categrpno=${categrpno }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
      </TD>   
    </TR>   
  </c:forEach> 
  </tbody>
   
  </TABLE>

</DIV><!-- content body end -->

<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>