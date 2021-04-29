/*
VOJoin -> MYbatis 기반
 */
package dev.mvc.cate;
/*
  <select id="list_all_join" resultType="dev.mvc.cate.Categrp_CateVO">
    SELECT r.categrpno AS r_categrpno, r.name AS r_name,
                c.cateno, c.categrpno, c.name, c.rdate, c.cnt
    FROM categrp r, cate c
    WHERE r.categrpno = c.categrpno
    ORDER BY cateno ASC
  </select>
 */
public class Categrp_CateVO {
  
  // -------------------------------------------------------------------
  // Categrp table
  // -------------------------------------------------------------------
  /** 부모 테이블 카테고리 그룹 번호 */
  private int r_categrpno;
  /** 부모 테이블 카테고리 그룹 이름 */
  private String r_name;
  
  // -------------------------------------------------------------------
  // Cate table
  // -------------------------------------------------------------------  
  /** 카테고리 번호 */
  private int cateno;  
  /** 카테고리 그룹 번호 */
  private int categrpno;
  /**  카테고리 이름 */
  private String name;
  /** 등록일 */
  private String rdate;
  /** 등록된 글 수 */
  private int cnt;
  
  // getter setter
  public int getR_categrpno() {
    return r_categrpno;
  }
  public void setR_categrpno(int r_categrpno) {
    this.r_categrpno = r_categrpno;
  }
  public String getR_name() {
    return r_name;
  }
  public void setR_name(String r_name) {
    this.r_name = r_name;
  }
  public int getCateno() {
    return cateno;
  }
  public void setCateno(int cateno) {
    this.cateno = cateno;
  }
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
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  
  // toString()
  @Override
  public String toString() {
    return "[r_categrpno=" + r_categrpno + ", r_name=" + r_name + ", cateno=" + cateno + ", categrpno="
        + categrpno + ", name=" + name + ", rdate=" + rdate + ", cnt=" + cnt + "]";
  }
  
}