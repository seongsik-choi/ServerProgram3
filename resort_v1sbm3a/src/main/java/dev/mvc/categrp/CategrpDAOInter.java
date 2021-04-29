/*
0401(CREATE) + 0406(LIST) + 0407(READ, DELETE) + 0408(UPDATE)
3. DAO interface
- Spring은 MyBATIS에 선언된 <insert id="create" parameterType="CategrpVO"> 태그를
  참조하여 자동으로 DAO class 생성
- 자동으로 생성된 DAO class는 MyBATIS를 호출하는 역활
-> DB 연결을 Spring에서 담당.
▷ dev.mvc.categrp.CategrpDAOInter.java 
 */
package dev.mvc.categrp;

import java.util.List;

// MyBATIS의 <mapper namespace="dev.mvc.categrp.CategrpDAOInter">에 선언
// 스프링이 자동으로 구현
public interface CategrpDAOInter {
 /**
  * 
  * @param categrpVO
  * @return 등록 갯수
  */
  
  // Method 이름 create -> categrp.xml과 mapping
  // XMl의 ID = DAD의 Method,    parameterType 값 = Method의 Types
  // <insert id="create" parameterType="dev.mvc.categrp.CategrpVO">
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
  // List(결과가 여러개)인 이유는 categrp.xml의 대응되는 구문이 SELECT이고, generic type은 VO class
  // 1) SELECT 사용 시 LIST(결과 레코드 여러개)인 경우 ArrayList Return
  public List<CategrpVO> list_categrpno_asc();
  
  
  /**
   * 조회, 수정폼, 삭제폼
   * @param categrpno 카테고리 그룹 번호, PK
   * @return
   */
  // 2) SELECT 사용 시 READ(결과 레코드 한개)인 경우 VO가 Return
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