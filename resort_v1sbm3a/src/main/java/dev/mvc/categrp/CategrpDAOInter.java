/*
0401
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
   * 출력 순서별 목록
   * @return
   */
  public List<CategrpVO> list_seqno_asc();
}