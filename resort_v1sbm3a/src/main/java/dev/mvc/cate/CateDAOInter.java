package dev.mvc.cate;

import java.util.List;

public interface CateDAOInter {

  /**
   * [26][Cate] Cate 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
   * 등록
   * @param cateVO
   * @return 등록된 갯수
   */
  public int create(CateVO cateVO);
 
  /**
   * [27][Cate] Categrp 전체목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~)
   *  목록
   * @return
   */
  public List<CateVO> list_all();  
  
  /**
   * [28][Cate] categrpno별 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작 
   *  categrpno 별 목록
   * @return
   */
  public List<CateVO> list_by_categrpno(int categrpno);  

  /**
   * [29][Cate] Categrp + Cate join 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), Categrp_CateVO.java 사용
   * JOIN 목록
   * @return
   */
  public List<Categrp_CateVO> list_all_join();  
    
  /**
   *  [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
   * 조회, 수정폼
   * @param cateno 카테고리 번호, PK
   * @return
   */
  public CateVO read(int cateno);
  
  /**
   *  [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
   * 수정 처리
   * @param cateVO
   * @return
   */
  public int update(CateVO cateVO);  
  
  /**
   * [31][Cate] Cate 삭제 기능의 제작(DELETE ~ WHERE)~
   * 삭제 처리 
   * @param cateno
   * @return
   */
  public int delete(int cateno);
}
