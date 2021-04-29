package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

public interface ContentsDAOInter {
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