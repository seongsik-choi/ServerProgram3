<%-- 
0414
7. View: JSP
- 등록폼에서 FK 컬럼인 categrpno 컬럼의 값을 <input type='hidden' ...> 태그로
  전달해야합니다.
1) 입력 화면
▷ /webapp/cate/read_update.jsp 
 ★★★★★list_by_categrpno를 복사★★★★★
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
  <A href="../categrp/list.do" class='title_link'> 카테고리 그룹</A> >
   <A href="./list_by_categrpno.do?categrpno=${param.categrpno }" class='title_link'>${categrpVO.name }</A> >
    (${cateVO.name }) 수정</DIV>

<DIV class='content_body'>
   <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./update.do'>   <!--  read_update 수정 필요!! -->
      
      <!-- value에 param(GET으로 전달받은 값을 기본 값으로 사용. ex) 여행-> 1 자동 입력 -->
      <!-- disable를 설정하여 값 설정 변경을 못하게 설정이 가능하나
       가장 큰 문제 ) 값 전달을 못함 : 무결성 제약 조건 위배
       해결) hidden type을 사용해 사용자에게 보이지않게 설정 + 실제 값 보여주기만 -> 
      -->
      <!-- 0414 PKKey 받아와야지 가능 -->
      <input type="hidden" name="cateno" value='${param.cateno }'>
      
      <label>카테고리 그룹 번호 : </label>
       <input type='number' name='categrpno' value='${param.categrpno }' required="required" 
                  min="1" max="100" step="1" autofocus="autofocus"><BR> 
        
      <label>카테고리 이름</label>
      <input type='text' name='name' value='${cateVO.name }' required="required" 
                  style='width: 25%;'><BR> 
      
      <label>등록 자료수</label>
      <input type='text' name='cnt' value='${cateVO.cnt }' required="required" 
                  min="0" max="10000000" step="1"><BR> 
  
      <button type="submit" id='submit'>수정</button>
      <button type="button" onclick="location.href='./list_by_categrpno.do?categrpno=${cateVO.categrpno} '">취소</button> <!-- JAVAScript로 이전페이지로 -->
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
      <TR>
        <TD class="td_bs">${cateVO.cateno }</TD>
        <TD class="td_bs">${cateVO.categrpno }</TD>
        <TD class="td_bs_left">${cateVO.name }</TD>
        <TD class="td_bs">${cateVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${cateVO.cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?cateno=${cateno }&categrpno=${cateVO.categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?cateno=${cateno }&categrpno=${cateVO.categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>