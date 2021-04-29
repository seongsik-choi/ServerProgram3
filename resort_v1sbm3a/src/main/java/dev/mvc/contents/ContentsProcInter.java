package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

public interface ContentsProcInter {
  /**
   * [36][Contents] 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
   * 등록
   * @param contentsVO
   * @return
   */
  public int create(ContentsVO contentsVO);

  /**
   * [37][Contents] 테이블 이미지 기반 cateno별 목록 출력 변경(list_by_cateno.do)
   *  [41][Contents] Grid 이미지 기반 cateno별 내용 요약 목록 출력
   * 특정 카테고리의 등록된 글목록
   * @return
   */
  public List<ContentsVO> list_by_cateno(int cateno);

  /**
   * [38][Contents] 검색 기능을 지원하는 목록
   * 카테고리별 검색 목록
   * @param hashMap
   * @return
   */
  public List<ContentsVO> list_by_cateno_search(HashMap<String, Object> hashMap);

  /**
   * [38][Contents] 검색된 레코드의 갯수
   * 카테고리별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * [40][Contents] 페이징, SQL, DAO, Process, list_by_cateno_search_paging.jsp 
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public List<ContentsVO> list_by_cateno_search_paging(HashMap<String, Object> map);
  
  /**
   * 페이지 목록 문자열 생성, Box 형태
   * @param list_File 목록 파일명 
   * @param categrpno 카테고리번호
   * @param search_count 검색 갯수
   * @param now_Page 현재 페이지, now_Page는 1부터 시작
   * @param word 검색어
   * @return
   */
  public String pagingBox(String list_File, int categrpno, int search_count, int now_Page, String word);
  
  /**
   * [42, 45][Contents] 조회 기능의 제작
   * 조회
   * @param contentsno
   * @return
   */
  public ContentsVO read(int contentsno);  
  
  /**
   * [43][Contents] 등록 기능 제작 응용 상품 정보의 등록(연속입력)
   * 상품 정보 수정 처리
   * @param contentsVO
   * @return
   */
  public int product_update(ContentsVO contentsVO);  
  
  /**
   * [46] 텍스트 정보 수정
   * @param contentsVO
   * @return
   */
  public int update_text(ContentsVO contentsVO);

  /**
   * [46] 텍스트 수정용 조회
   * ContentsDAOInter interface에 존재하지 않는 메소드 선언 -> 태그 출력 문제 해결
   */
  ContentsVO read_update_text(int contentsno);
  
  /**
   * [47] 파일 정보 수정
   * @param contentsVO
   * @return
   */
  public int update_file(ContentsVO contentsVO);  
  
  /**
   * [48] 삭제 기능 제작
   * @param contentsno
   * @return
   */
  public int delete(int contentsno);
     
}
 