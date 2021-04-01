/*
0401
4. Process interface
- 신규로 추가도 되지만 DAO Interface의 많은 메소드가 Process Interface에서 재사용
 ▷ dev.mvc.categrp.CategrpProcInter.java
 */
package dev.mvc.categrp;

public interface CategrpProcInter {
  /**
   * 등록
   * @param categrpVO
   * @return 등록된 레코드 갯수
   */
  public int create(CategrpVO categrpVO);
 
}