/*
0401
[02] VO, MyBATIS 설정
1. VO
▷ dev.mvc.categrp.CategrpVO.java
-> Getter와 Setter 생성
 */
package dev.mvc.categrp;
/*
    categrpno      NUMBER(10)     NOT NULL    PRIMARY KEY,
    name            VARCHAR2(50)     NOT NULL,
    seqno            NUMBER(7)    DEFAULT 0     NOT NULL,
    visible           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate              DATE     NOT NULL 
 */

public class CategrpVO {
  /** 카테고리 그룹 번호 */
  private int categrpno;
  /**  카테고리 이름 */
  private String name;
  /** 출력 순서 */
  private int seqno;
  /** 출력 모드 */
  private String visible;
  /** 등록일 */
  private String rdate;
  
  // Default Constructor
  public CategrpVO() {
  }
  
  // Parameter Constructor
  public CategrpVO(int categrpno, String name, int seqno, String visible, String rdate) {
    this.categrpno = categrpno;
    this.name = name;
    this.seqno = seqno;
    this.visible = visible;
    this.rdate = rdate;
  }

  // Getter, Setter 생성
  public int getCategrpno() {
    return categrpno;
  }
  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }
  public String getVisible() {
    return visible;
  }
  public void setVisible(String visible) {
    this.visible = visible;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  // 구현하려는 클래스에 값을 확인해보기 위한 메소드 toString()호출만으로 출력
  @Override
  public String toString() {
    return "[categrpno=" + categrpno + ", name=" + name + ", seqno=" + seqno + ", visible=" + visible
        + ", rdate=" + rdate + "]";
  }
 
  
}