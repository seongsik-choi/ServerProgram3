/*
0329
7. VO(DTO) 생성
▷ /src/main/java/dev.boot.basic/EmployeeVO.java
 */
package dev.boot.basic;
public class EmployeeVO {
  private String name;
  private int tot;
  private int avg;
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public int getTot() {
    return tot;
  }
  public void setTot(int tot) {
    this.tot = tot;
  }
  public int getAvg() {
    return avg;
  }
  public void setAvg(int avg) {
    this.avg = avg;
  }
  
  
}