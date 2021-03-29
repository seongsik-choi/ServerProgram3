<%-- 
0329
10. JSP view 제작
▷ /src/main/webapp/WEB-INF/views/employee/employee.jsp
- http://localhost:9091/employee/employee.do
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="/css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV style='padding: 20px;
                   border: solid 1px #0000FF; 
                   font-size: 26px; 
                   width: 50%; 
                   background-color: #EEEEFF; 
                   margin: 50px auto;'>
    
    성명: ${employeeVO.name }       <br>
    기술 면접 총점: ${employeeVO.tot }<br>
    기술 면접 평균: ${employeeVO.avg }<br>
 
  </DIV>           
</body>
</html>