package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cate.CateProcInter;
import dev.mvc.cate.CateVO;
import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
//import dev.mvc.member.MemberProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ContentsCont {
  
  // Contents 테이블은 Catrgrp, Cate 테이블에 대한 권한
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc")
  private CategrpProcInter categrpProc;
  
  @Autowired
  @Qualifier("dev.mvc.cate.CateProc")
  private CateProcInter cateProc;
  
  @Autowired
  @Qualifier("dev.mvc.contents.ContentsProc")
  private ContentsProcInter contentsProc;
   
  public ContentsCont() {
    System.out.println("--> ContentsCont created.");
  }
  
  /**
   * 새로고침 방지
   * @return
   */
  @RequestMapping(value="/contents/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    mav.setViewName(url); // forward
    return mav; // forward
  }
  
  /**
   * [36][Contents] 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
   * 등록폼
   * 사전 준비된 레코드: adminno(관리자) 1번, cateno(카테고리) 1번, 
   * categrpno(카테고리 그룹) 1번을 사용하는 경우 테스트 URL
   * http://localhost:9091/contents/create.do?&cateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/contents/create.do", method = RequestMethod.GET)
  public ModelAndView create(int cateno) {
    
    // int cateno = Integer.parseInt(request.getParameter("cateno")); //  자동으로 수행
    ModelAndView mav = new ModelAndView();
    
    CateVO cateVO = this.cateProc.read(cateno); // Cate(부모) 정보를 읽어옴
    CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno()); // Categrp에 대한 정보도 읽어옴.
    
    mav.addObject("cateVO", cateVO);  // ==request.setAttritube("cateVO", cateVO);
    mav.addObject("categrpVO", categrpVO);
    
    mav.setViewName("/contents/create"); // /webapp/WEB-INF/views/categrp/create.jsp
    // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
    // mav.addObject("content", content);

    return mav; // forward
  }
  
  /**
   * [36][Contents] 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
   * 등록 처리 http://localhost:9091/contents/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/contents/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, ContentsVO contentsVO) {
    
    ModelAndView mav = new ModelAndView();
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String file1 = "";     // 원본 파일명, image
    String file1saved = "";     // 저장된 파일명, image
    String thumb1 = ""; // preview image

    // 기준 경로 확인
    String user_dir = System.getProperty("user.dir");
    System.out.println("--> User dir: " + user_dir);
    //  --> User dir: F:\ai6\ws_frame\resort_v1sbm3a
    
    // 파일 접근이기에 절대 경로 지정 필요
    // 외부에서 파일의 접근이기에 resource/static dic로 지정 필요
    // 완성된 경로 F:/ai6/ws_frame/resort_v1sbm3a/src/main/resources/static/contents/storage
    String upDir =  user_dir + "/src/main/resources/static/contents/storage"; // 절대 경로
    
    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    // <input type='file' class="form-control" name='file1MF' id='file1MF' 
    //           value='' placeholder="파일 선택">
    MultipartFile mf = contentsVO.getFile1MF(); // VO에 추가된 파일저장 변수
    
    file1 = mf.getOriginalFilename(); // 원본 파일명
    long size1 = mf.getSize();  // 파일 크기
    if (size1 > 0) { // 파일 크기 체크
      
      // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
      file1saved = Upload.saveFileSpring(mf, upDir);  // 저장된 파일명
      
      if (Tool.isImage(file1saved)) { // 이미지인지 검사, Tool.java(Componet)의 메소드 사용.
        // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
        thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
      }
    }    
    contentsVO.setFile1(file1);
    contentsVO.setFile1saved(file1saved);
    contentsVO.setThumb1(thumb1);
    contentsVO.setSize1(size1);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    
    // Call By Reference: 메모리 공유, Hashcode 전달
    int cnt = this.contentsProc.create(contentsVO); 
    
    // -------------------------------------------------------------------
    // PK의 return
    // -------------------------------------------------------------------
    // System.out.println("--> contentsno: " + contentsVO.getContentsno());
    // mav.addObject("contentsno", contentsVO.getContentsno()); // redirect parameter 적용
    // -------------------------------------------------------------------
    
//    if (cnt == 1) {
//      cateProc.increaseCnt(contentsVO.getCateno()); // 글수 증가
//    }
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    // System.out.println("--> cateno: " + contentsVO.getCateno());
    // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
    mav.addObject("cateno", contentsVO.getCateno()); // redirect parameter 적용
    mav.addObject("url", "/contents/create_msg"); // create_msg.jsp, redirect parameter 적용
    
    // 연속 입력 추가 : url 주소 받기
    // 연속 입력 지원용 변수, Call By Reference에 기반하여 contentsno를 전달 받음.
    mav.addObject("contentsno", contentsVO.getContentsno()); 
    
    mav.setViewName("redirect:/contents/msg.do");  //webapp/WEB-INF/views/
    
    return mav; // forward
  }
  
  
  /**
   * [37][Contents] 테이블 이미지 기반 cateno별 목록 출력 변경(list_by_cateno.do)
   * [41][Contents] Grid 이미지 기반 cateno별 내용 요약 목록 출력
   * cateno별 목록 http://localhost:9091/contents/list_by_cateno.do?cateno=1
   * 
   * @return
   */
 @RequestMapping(value = "/contents/list_by_cateno.do", method = RequestMethod.GET)
  public ModelAndView list_by_cateno(int cateno) { 
    ModelAndView mav = new  ModelAndView();   
    
    CateVO cateVO = this.cateProc.read(cateno); 
    mav.addObject("cateVO", cateVO);
    
    CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
    mav.addObject("categrpVO", categrpVO);
    
    List<ContentsVO> list = this.contentsProc.list_by_cateno(cateno);
    mav.addObject("list", list);
    
    // 테이블 이미지 기반, list_by_cateno.jsp
    mav.setViewName("/contents/list_by_cateno"); // /webapp/WEB-INF/views/contents/list_by_cateno.jsp
    return mav; // forward 
  }
   
 /**
  * [38][Contents] 검색 기능을 지원하는 목록 + 검색된 레코드의 갯수
  * 목록 + 검색 지원
  * http://localhost:9091/contents/list_by_cateno_search.do?cateno=1&word=스위스
  * @param cateno
  * @param word
  * @return
  */
   @RequestMapping(value = "/contents/list_by_cateno_search.do", method = RequestMethod.GET)
   public ModelAndView list_by_cateno_search(@RequestParam(value="cateno", defaultValue="1") int cateno,
                                                                   @RequestParam(value="word", defaultValue="") String word ) {
   ModelAndView mav = new ModelAndView(); 
   
   // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용 
   HashMap<String, Object> map = new HashMap<String, Object>(); 
   map.put("cateno", cateno); // #{cateno}
   map.put("word", word); // #{word}
   
   // 검색 목록 
   List<ContentsVO> list = contentsProc.list_by_cateno_search(map);
   mav.addObject("list", list);
   
   // 검색된 레코드 갯수 
   int search_count = contentsProc.search_count(map);
   mav.addObject("search_count", search_count);
   
   CateVO cateVO = cateProc.read(cateno); 
   mav.addObject("cateVO", cateVO);
   
   CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
   mav.addObject("categrpVO", categrpVO);
   
   mav.setViewName("/contents/list_by_cateno_search");   // /contents/list_by_cateno_search.jsp
   return mav; 
 }

   /**
    * [40][Contents] 페이징, SQL, DAO, Process, list_by_cateno_search_paging.jsp 
    * 목록 + 검색 + 페이징 지원
    * http://localhost:9091/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
    * @param cateno
    * @param word
    * @param now_page
    * @return
    */
   @RequestMapping(value = "/contents/list_by_cateno_search_paging.do", method = RequestMethod.GET)
   public ModelAndView list_by_cateno_search_paging(
       @RequestParam(value = "cateno", defaultValue = "1") int cateno,
       @RequestParam(value = "word", defaultValue = "") String word,
       @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
     System.out.println("--> now_page: " + now_page);

     ModelAndView mav = new ModelAndView();

     // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("cateno", cateno); // #{cateno}
     map.put("word", word); // #{word}
     map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

     // 검색 목록
     List<ContentsVO> list = contentsProc.list_by_cateno_search_paging(map);
     mav.addObject("list", list);

     // 검색된 레코드 갯수
     int search_count = contentsProc.search_count(map);
     mav.addObject("search_count", search_count);

     CateVO cateVO = cateProc.read(cateno);
     mav.addObject("cateVO", cateVO);

     CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
     mav.addObject("categrpVO", categrpVO);

     /*
      * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
      * 18 19 20 [다음]
      * @param list_file 목록 파일명
      * @param cateno 카테고리번호
      * @param search_count 검색(전체) 레코드수
      * @param now_page 현재 페이지
      * @param word 검색어
      * @return 페이징 생성 문자열
      */
     String paging = contentsProc.pagingBox("list_by_cateno_search_paging.do", cateno, search_count, now_page, word);
     mav.addObject("paging", paging);

     mav.addObject("now_page", now_page);

     // /contents/list_by_cateno_table_img1_search_paging.jsp
     mav.setViewName("/contents/list_by_cateno_search_paging");

     return mav;
   }

  /**
   * [41][Contents] Grid 이미지 기반 cateno별 내용 요약 목록 출력
   * Grid 형태의 화면 구성 http://localhost:9091/contents/list_by_cateno_grid.do?cateno=13
   * 
   * @return
   */
  @RequestMapping(value = "/contents/list_by_cateno_grid.do", method = RequestMethod.GET)
  public ModelAndView list_by_cateno_grid(int cateno) {
    ModelAndView mav = new ModelAndView();
    
    CateVO cateVO = this.cateProc.read(cateno);
    mav.addObject("cateVO", cateVO);
    
    CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
    mav.addObject("categrpVO", categrpVO);
    
    List<ContentsVO> list = this.contentsProc.list_by_cateno(cateno);
    mav.addObject("list", list);

    // 테이블 이미지 기반, /webapp/contents/list_by_cateno_grid.jsp
    mav.setViewName("/contents/list_by_cateno_grid");

    return mav; // forward
  }

  /**
   * [43][Contents] 등록 기능 제작 응용 상품 정보의 등록(연속 입력) 
   * 상품 정보 수정폼
   * http://localhost:9091/contents/create.do?&cateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/contents/product_update.do", method = RequestMethod.GET)
  public ModelAndView product_update(int cateno, int contentsno) {
    
    // int cateno = Integer.parseInt(request.getParameter("cateno")); //  자동으로 수행
    ModelAndView mav = new ModelAndView();
    
    CateVO cateVO = this.cateProc.read(cateno); // Cate(부모) 정보를 읽어옴
    CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno()); // Categrp에 대한 정보도 읽어옴.
    ContentsVO contentsVO = this.contentsProc.read(contentsno);
    
    mav.addObject("cateVO", cateVO);  // ==request.setAttritube("cateVO", cateVO);
    mav.addObject("categrpVO", categrpVO);
    mav.addObject("contentsVO", contentsVO);
    
    mav.setViewName("/contents/product_update"); // /webapp/WEB-INF/views/contents/product_update.jsp
    // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
    // mav.addObject("content", content);

    return mav; // forward
  }  
  
  /**
   * [43][Contents] 등록 기능 제작 응용 상품 정보의 등록(연속 입력) 
   * 상품 정보 수정 처리 http://localhost:9091/contents/product_update.do
   * 
   * @return
   */
  @RequestMapping(value = "/contents/product_update.do", method = RequestMethod.POST)
  public ModelAndView product_update(ContentsVO contentsVO) {
    ModelAndView mav = new ModelAndView();
    
    // Call By Reference: 메모리 공유, Hashcode 전달
    int cnt = this.contentsProc.product_update(contentsVO);
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
    mav.addObject("cateno", contentsVO.getCateno()); // redirect parameter 적용

    // 연속 입력 지원용 변수, Call By Reference에 기반하여 contentsno를 전달 받음
    mav.addObject("contentsno", contentsVO.getContentsno());
    
    mav.addObject("url", "/contents/product_update_msg"); // product_update_msg.jsp

    mav.setViewName("redirect:/contents/msg.do"); 
    
    return mav; // forward
  }
  
  // http://localhost:9091/contents/read.do
  /**
   * [45][Contents] 조회 기능의 제작, 상품 구입 화면
   * 조회
   * @return
   */
  @RequestMapping(value="/contents/read.do", method=RequestMethod.GET )
  public ModelAndView read(int contentsno) {
  // public ModelAndView read(int contentsno, int now_page) 
    ModelAndView mav = new ModelAndView();
    // System.out.println("-> now page : " +now_page);
    
    ContentsVO contentsVO = this.contentsProc.read(contentsno);
    mav.addObject("contentsVO", contentsVO); // request.setAttribute("contentsVO", contentsVO);

    CateVO cateVO = this.cateProc.read(contentsVO.getCateno());
    mav.addObject("cateVO", cateVO); 

    CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
    mav.addObject("categrpVO", categrpVO); 
    
    mav.setViewName("/contents/read"); // /WEB-INF/views/contents/read.jsp
        
    return mav;
  }  
  
  /**
   * [46] 텍스트 정보 수정
   * [36][Contents] 등록 기능 제작(INSERT ~ INTO ~ VALUES ~) 활용
   * 수정폼
   * http://localhost:9091/contents/update_text.do?&contentsno=1
   * @return
   */
  @RequestMapping(value = "/contents/update_text.do", method = RequestMethod.GET)
  public ModelAndView update_text(int contentsno) {
    // int cateno = Integer.parseInt(request.getParameter("cateno")); //  자동으로 수행
    
    ModelAndView mav = new ModelAndView();
    
    ContentsVO contentsVO = this.contentsProc.read_update_text(contentsno); // cateno를 호출하기위한 절차
    CateVO cateVO = this.cateProc.read(contentsVO.getCateno());  // 파라미터에 cateno 명시 안해도 OK
    CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno()); // Categrp에 대한 정보도 읽어옴.
    
    mav.addObject("contentsVO", contentsVO);
    mav.addObject("cateVO", cateVO);             // ==request.setAttritube("cateVO", cateVO);
    mav.addObject("categrpVO", categrpVO);
    
    mav.setViewName("/contents/update_text"); // /webapp/WEB-INF/views/categrp/update_text.jsp
    return mav; // forward
  }  
  
  /**
   * [46] 텍스트 정보 수정 처리
   * [36][Contents] 등록 기능 제작(INSERT ~ INTO ~ VALUES ~) 활용
   * 처리폼
   * http://localhost:9091/contents/update_text.do?&contentsno=1
   * @return
   */
  @RequestMapping(value = "/contents/update_text.do", method = RequestMethod.POST)
  public ModelAndView update_text(ContentsVO contentsVO,
                  @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.contentsProc.update_text(contentsVO); // 수정 처리

    mav.addObject("contentsno", contentsVO.getContentsno());
    mav.addObject("now_page", now_page);
    
    mav.setViewName("redirect:/contents/read.do");  // redirect시 전송된 form 데이터는 모두 삭제.

    return mav; // forward
  }
  
  /**
   * [47] 파일 수정폼
   * 파일 수정폼
   * http://localhost:9091/contents/update_file.do?&contentsno=1
   * @return
   */
  @RequestMapping(value = "/contents/update_file.do", method = RequestMethod.GET)
  public ModelAndView update_file(int contentsno) {
    ModelAndView mav = new ModelAndView();
    
    ContentsVO contentsVO = this.contentsProc.read(contentsno);
    CateVO cateVO = this.cateProc.read(contentsVO.getCateno());
    CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
    
    mav.addObject("contentsVO", contentsVO);
    mav.addObject("cateVO", cateVO);
    mav.addObject("categrpVO", categrpVO);
    
    mav.setViewName("/contents/update_file"); // /WEB-INF/views/contents/update_file.jsp

    return mav; // forward
  }
  
  /**
   * 파일 수정 처리 http://localhost:9091/contents/update_file.do
   * 
   * @return
   */
  @RequestMapping(value = "/contents/update_file.do", method = RequestMethod.POST)
  public ModelAndView update_file(HttpServletRequest request, 
                                                    ContentsVO contentsVO, 
                                                    @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
    ModelAndView mav = new ModelAndView();

    // -------------------------------------------------------------------
    // 파일 삭제 코드 시작
    // -------------------------------------------------------------------
    // 삭제할 파일 정보를 읽어옴.
    ContentsVO vo = contentsProc.read(contentsVO.getContentsno());
//    System.out.println("contentsno: " + vo.getContentsno());
//    System.out.println("file1: " + vo.getFile1());
    
    String file1saved = vo.getFile1saved();
    String thumb1 = vo.getThumb1();
    long size1 = 0;
    boolean sw = false;
    
    // 완성된 경로 F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/contents/storage/
    String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/contents/storage/"; // 절대 경로

    sw = Tool.deleteFile(upDir, file1saved);  // Folder에서 1건의 파일 삭제
    sw = Tool.deleteFile(upDir, thumb1);     // Folder에서 1건의 파일 삭제
    // System.out.println("sw: " + sw);
    // -------------------------------------------------------------------
    // 파일 삭제 종료 시작
    // -------------------------------------------------------------------
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String file1 = "";          // 원본 파일명 image

    // 완성된 경로 F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/contents/storage/
    // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/contents/storage/"; // 절대 경로
    
    // 전송 파일이 없어도 fnamesMF 객체가 생성됨.
    // <input type='file' class="form-control" name='file1MF' id='file1MF' 
    //           value='' placeholder="파일 선택">
    MultipartFile mf = contentsVO.getFile1MF();
    
    file1 = mf.getOriginalFilename(); // 원본 파일명
    size1 = mf.getSize();  // 파일 크기
    
    if (size1 > 0) { // 파일 크기 체크
      // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
      file1saved = Upload.saveFileSpring(mf, upDir); 
      
      if (Tool.isImage(file1saved)) { // 이미지인지 검사
        // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
        thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
      }
      
    }    
    
    contentsVO.setFile1(file1);
    contentsVO.setFile1saved(file1saved);
    contentsVO.setThumb1(thumb1);
    contentsVO.setSize1(size1);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    // Call By Reference: 메모리 공유, Hashcode 전달
    int cnt = this.contentsProc.update_file(contentsVO);
    
    mav.addObject("contentsno", contentsVO.getContentsno());
    mav.addObject("now_page", now_page);
    
    mav.setViewName("redirect:/contents/read.do"); 

    return mav; // forward
  }   
  
  // [48][Contents] 삭제 기능의 제작, 패스워드 검사(향후 Ajax 적용 구현)
  @RequestMapping(value="/contents/delete.do", method=RequestMethod.GET )
  public ModelAndView delete(int contentsno) { 
    ModelAndView mav = new  ModelAndView();
    
    // 삭제할 정보를 조회하여 확인
    ContentsVO contentsVO = this.contentsProc.read(contentsno);
    mav.addObject("contentsVO", contentsVO);     
    
    CateVO cateVO = this.cateProc.read(contentsVO.getCateno());
    mav.addObject("cateVO", cateVO); 

    CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
    mav.addObject("categrpVO", categrpVO); 
    
    mav.setViewName("/contents/delete");  // contents/delete.jsp
    
    return mav; 
  }
    
  /**
   * [48][Contents] 삭제 기능의 제작, 패스워드 검사(향후 Ajax 적용 구현)
   * [47] 파일 수정처리 기반 
   * http://localhost:9091/contents/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/contents/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, int contentsno, int now_page,
                                             int cateno, String word) {
    ModelAndView mav = new ModelAndView();

    // -------------------------------------------------------------------
    // 파일 삭제 코드 시작
    // -------------------------------------------------------------------
    // 삭제할 파일 정보를 읽어옴.
    ContentsVO vo = contentsProc.read(contentsno);
//    System.out.println("contentsno: " + vo.getContentsno());
//    System.out.println("file1: " + vo.getFile1());
    
    String file1saved = vo.getFile1saved();
    String thumb1 = vo.getThumb1();
    long size1 = 0;
    boolean sw = false;
    
    // 완성된 경로 F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/contents/storage/
    String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/contents/storage/"; // 절대 경로

    sw = Tool.deleteFile(upDir, file1saved);  // Folder에서 1건의 파일 삭제
    sw = Tool.deleteFile(upDir, thumb1);     // Folder에서 1건의 파일 삭제
    // System.out.println("sw: " + sw);
    // -------------------------------------------------------------------
    // 파일 삭제 종료 시작
    // -------------------------------------------------------------------
    
    int cnt = this.contentsProc.delete(contentsno); // DBMS 삭제

    if (cnt == 1) {
      // -------------------------------------------------------------------------------------
      // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno);
      map.put("word", word);
      // 10번째 레코드 삭제 후
      // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
      // 페이지 수를 4-> 3으로 감소 시켜야함.
      if (contentsProc.search_count(map) % Contents.RECORD_PER_PAGE == 0) {
        now_page = now_page - 1;
        if (now_page < 1) {
          now_page = 1; // 시작 페이지
        }
      }
      // -------------------------------------------------------------------------------------
    }// if end
    
    mav.addObject("cateno", cateno);
    mav.addObject("now_page", now_page);
    mav.setViewName("redirect:/contents/list_by_cateno_search_paging.do"); 
    
    return mav; // forward
  }   
  
}
