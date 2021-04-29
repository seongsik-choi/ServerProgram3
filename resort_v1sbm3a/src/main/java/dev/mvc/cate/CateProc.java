package dev.mvc.cate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.cate.CateProc")
public class CateProc implements CateProcInter {

  @Autowired
  private CateDAOInter cateDAO; // 인터페이스를 자동 구현 -> Mybatis로 호출
 
  public CateProc() {
    System.out.println("--> CateProc created");
  }
  
  // [26][Cate] Cate 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
  @Override
  public int create(CateVO cateVO) {
    int cnt = this.cateDAO.create(cateVO);
    return cnt;
  }
  
  // [27][Cate] Categrp 전체목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~)
  @Override
  public List<CateVO> list_all() {
   List<CateVO> list = this.cateDAO.list_all();
   return list;
  }

  // [28][Cate] categrpno별 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작
  @Override
  public List<CateVO> list_by_categrpno(int categrpno) {
    List<CateVO> list = this.cateDAO.list_by_categrpno(categrpno);
    return list;
  }

  // [29][Cate] Categrp + Cate join 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~),  Categrp_CateVO.java 사용
  @Override
  public List<Categrp_CateVO> list_all_join() {
    List<Categrp_CateVO> list = this.cateDAO.list_all_join();
    return list;
  }

  // [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
  @Override
  public CateVO read(int cateno) {
    CateVO cateVO = this.cateDAO.read(cateno);
    return cateVO;
  }

  // [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
  @Override
  public int update(CateVO cateVO) {
    int cnt = this.cateDAO.update(cateVO);
    return cnt;
  }
  
  // [31][Cate] Cate 삭제 기능의 제작(DELETE ~ WHERE)~
  @Override
  public int delete(int cateno) {
    int cnt = this.cateDAO.delete(cateno);
    return cnt;
  }  
}
