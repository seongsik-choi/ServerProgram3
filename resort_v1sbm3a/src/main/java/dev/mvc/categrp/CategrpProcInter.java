/*
0401(CREATE) + 0406(LIST) + 0407(READ, DELETE) + 0408(UPDATE)
4. Process interface
- 신규로 추가도 되지만 DAO Interface의 많은 메소드가 Process Interface에서 재사용
 ▷ dev.mvc.categrp.CategrpProcInter.java
 */
package dev.mvc.categrp;

import java.util.List;

public interface CategrpProcInter {
  /**
   * 등록
   * @param categrpVO
   * @return 등록된 레코드 갯수
   */
  public int create(CategrpVO categrpVO);
 
  /**
   * 등록 순서별 목록([22] seqno에 의한 list 출력 순서 변경))
   * @return
   */
  public List<CategrpVO> list_seqno_asc();
    
  /**
   * 출력 순서별 목록
   * @return
   */
  public List<CategrpVO> list_categrpno_asc();
  
  /**
   * 조회, 수정폼, 삭제폼
   * @param categrpno 카테고리 그룹 번호, PK
   * @return
   */
  public CategrpVO read(int categrpno);

  /**
   * 수정 처리
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(CategrpVO categrpVO);

  /**
   * 삭제 처리
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int delete(int categrpno);
 
  /**
   * 출력 순서 상향
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_up(int categrpno);
 
  /**
   * 출력 순서 하향
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_down(int categrpno);   
  
  /**
   * visible 수정
   * @param categrpVO
   * @return
   */
  public int update_visible(CategrpVO categrpVO);
 
}