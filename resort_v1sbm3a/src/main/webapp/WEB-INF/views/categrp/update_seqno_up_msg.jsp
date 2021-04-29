<%-- 
0408(UPDATE)
7. View: JSP, 변경과 목록의 결합 / 우선순위 상향
1) 목록 출력 순서를 seqno 컬럼의 오름차순으로 정렬
▷ /webapp/categrp/list.jsp 
기존 소스 사용
-----------------------------------------------------------------------------------
2) 처리 결과 출력
- 삭제 실패 테스트: http://localhost:9090/resort/categrp/delete_msg.jsp?cnt=0
▷ /webapp/categrp/update_seqno_up_msg.jsp 
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
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">[${categrpVO.name }] 카테고리 그룹 우선순위 상향에 성공했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">
              [${categrpVO.name }] 카테고리 그룹 우선순위 상향에 실패했습니다.
            </span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:if test="${cnt != 1 }">
          <button type='button' onclick="history.back()" class="btn btn-info">다시 시도</button>
        </c:if>
        <button type='button' onclick="location.href='./list.do'" class="btn btn-info">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>