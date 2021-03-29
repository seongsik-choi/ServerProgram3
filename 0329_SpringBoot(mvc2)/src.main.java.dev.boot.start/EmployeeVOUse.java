/*
0329
8. VO(DTO) test class 제작
▷ /src/main/java/dev.boot.basic/EmployeeVOUse.java
 */
package dev.boot.basic;
public class EmployeeVOUse {
 
  public static void main(String[] args) {
    // 객체 생성
    EmployeeVO employeeVO  = new EmployeeVO();
    // sungjukVO.name = "주지훈"; // The field SungjukVO.name is not visible
    
    // setter 호출
    employeeVO.setName("주지훈");
    employeeVO.setTot(300);
    employeeVO.setAvg(100);
     
    // getter 호출
    String name = employeeVO.getName();
    int tot = employeeVO.getTot();
    int avg =employeeVO.getAvg();
   
    System.out.println("성명: "+ name); // employeeVO.getName()
    System.out.println("총점: "+ tot);
    System.out.println("평균: "+ avg);
    
  }
 
}