DROP TABLE attachfile;
DROP TABLE contents CASCADE CONSTRAINTS;

CREATE TABLE contents(
        contentsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        adminno                              NUMBER(10)     NOT NULL ,
        cateno                                NUMBER(10)         NOT NULL ,
        title                                 VARCHAR2(300)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        word                                  VARCHAR2(300)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,
        file1saved                            VARCHAR(100)          NULL,
        thumb1                              VARCHAR(100)          NULL,
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  
        price                                 NUMBER(10)      DEFAULT 0 NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,          
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 NUMBER(10)      DEFAULT 0 NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL,  
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (cateno) REFERENCES cate (cateno)
);

COMMENT ON TABLE contents is '컨텐츠 - 영화 상품';
COMMENT ON COLUMN contents.contentsno is '컨텐츠 번호';
COMMENT ON COLUMN contents.adminno is '관리자 번호';
COMMENT ON COLUMN contents.cateno is '카테고리 번호';
COMMENT ON COLUMN contents.title is '제목';
COMMENT ON COLUMN contents.content is '내용';
COMMENT ON COLUMN contents.recom is '추천수';
COMMENT ON COLUMN contents.cnt is '조회수';
COMMENT ON COLUMN contents.replycnt is '댓글수';
COMMENT ON COLUMN contents.passwd is '패스워드';
COMMENT ON COLUMN contents.word is '검색어';
COMMENT ON COLUMN contents.rdate is '등록일';
COMMENT ON COLUMN contents.file1 is '메인 이미지';
COMMENT ON COLUMN contents.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN contents.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN contents.size1 is '메인 이미지 크기';
COMMENT ON COLUMN contents.price is '정가';
COMMENT ON COLUMN contents.dc is '할인률';
COMMENT ON COLUMN contents.saleprice is '판매가';
COMMENT ON COLUMN contents.point is '포인트';
COMMENT ON COLUMN contents.salecnt is '수량';


-- contents의 SEQUENCE Table(ORACLE 기준)
DROP SEQUENCE contents_seq;

CREATE SEQUENCE contents_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- 오류 보고 - ORA-02291: integrity constraint (AI8.SYS_C007026) violated - parent key not found
-- (부모)admin 레코드 삽입후 (자식)contents 레코드 생성 가능  
-- 등록(CREATE + INSERT)

-- 컨텐츠번호(PK), 관리자번호(FK), 카테고리번호(FK), 제목,   내용,  추천수, 조회수, 댓글수  
-- 패스워드, 검색어, 등록일, 메인이미지, 실제 저장된 메인 이미지, 메인 이미지 preview, 메인이미지 크기
-- 정가, 할인률, 판매가, 포인트, 수량
INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, 
                              passwd, word, rdate, file1, file1saved, thumb1, size1, 
                              price, dc, saleprice,  point, salecnt)
VALUES(contents_seq.nextval, 1, 1, '인터스텔라', '앤헤서웨이 주연', 0, 0, 0,
           '123', '우주', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 
           2000, 10, 1800, 100, 500);
   
INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, 
                              passwd, word, rdate, file1, file1saved, thumb1, size1, 
                              price, dc, saleprice,  point, salecnt)
VALUES(contents_seq.nextval, 1, 1, '러브 액츄얼리', '앤헤서웨이 주연', 0, 0, 0,
           '123', '우주', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 
           2000, 10, 1800, 100, 500);
           
INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, 
                              passwd, word, rdate, file1, file1saved, thumb1, size1, 
                              price, dc, saleprice,  point, salecnt)
VALUES(contents_seq.nextval, 1, 1, '마션', '멧데이먼 주연 화성 탈출', 0, 0, 0,
           '123', '우주', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 
           2000, 10, 1800, 100, 500);
           
commit;          

-- List, 목록 : 여러 건의 레코드를 읽는 것
SELECT * FROM contents
ORDER BY contentsno ASC;        

-- [36] 등록화면1 관련
-- 사용자로부터 입력받는 레코드(10가지) -> 컬럼의 수가 상당히 많음
-- 입력컬럼 : 제목, 내용, 패스워드, 검색어, 메인 이미지, 정가, 할인율, 판매가, 포인트, 재고수량

-- 컬럼 분할 <-> 개인프로젝트는 분할없이도 가능.
-- 1) Community 글 등록화면 1 : 제목, 내용, 패스워드, 검색어, 메인 이미지관련파일들, 등록일

-- INSERT로 필요한 레코드들 먼저 선언 + 추가적인 레코드는 UPDATE로 추가
INSERT INTO contents(contentsno, adminno, cateno, title, content, passwd, word, 
                             file1, file1saved, thumb1, size1, rdate)
VALUES(contents_seq.nextval, 1, 1, '미션파서블', '톰크루즈', '123', 'SF', 
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, sysdate);
commit;

-- 2) 쇼핑몰의 상품 정보 등록화면 2 : 정가, 할인율, 판매가, 포인트, 재고수량
UPDATE contents 
SET price = 3000, dc=10, saleprice=3700, point=300, salecnt=200
WHERE contentsno = 5;
commit;

--- [37][Contents] 테이블 이미지 기반 cateno별 목록 출력 변경(list_by_cateno.do) 
-- 출력하고자하는 컬럼명 선정이 필요!
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
          file1, file1saved, thumb1, size1, price, dc, saleprice, point
FROM contents
WHERE cateno = 1
ORDER BY contentsno ASC;  

DELETE FROM contents;
commit;

-- Read, 조회 : 한 건의 레코드를 읽는 것
-- Update, 수정 : PK는 update 불가능, 컬럼의 특징을 파악후 변경 여부결정


--[38] 상품정보 업데이트(컨텐츠 등록후 -> 상품정보 업데이트)
UPDATE contents 
SET price=15000, dc=10, saleprice=13500, point=750
WHERE contentsno = 19 OR contentsno = 20 OR contentsno = 21 OR contentsno = 22;

COMMIT;

-- 삭제
DELETE FROM contents WHERE contentsno = 18;

--[38] 1) 검색  ① cateno별 검색 목록
-- word 컬럼의 사용(추가)로 검색 정확도를 높이기 위하여 중요 단어를 명시
-- ex) 노트북, notebook, 놋북 등
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
          file1, file1saved, thumb1, size1, price, dc, saleprice, point
FROM contents
WHERE cateno=13 AND word LIKE '%노트북%'
ORDER BY contentsno DESC;

-- cateno= 13이면서 OR로(title, content, word 중 1)
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
          file1, file1saved, thumb1, size1, price, dc, saleprice, point
FROM contents
WHERE cateno=13 AND (title LIKE '%노트북%' OR content LIKE '%노트북%' OR word LIKE '%노트북%')
ORDER BY contentsno DESC;

-- ② 검색 레코드 갯수 전체 레코드 갯수
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=13;

-- cateno 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=13 AND word LIKE '%스위스%';

SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=13 AND (title LIKE '%노트북%' OR content LIKE '%노트북%' OR word LIKE '%노트북%')


-- [40][Contents] 페이징, SQL, DAO, Process, list_by_cateno_search_paging.jsp 
-- 13) 검색 + 페이징 + 메인 이미지
-- step 1 : cateno = 영화 등록된 cate의 번호(CONTENTS 가서 확인)
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
          file1, file1saved, thumb1, size1, price, dc, saleprice, point
FROM contents
WHERE cateno=13 AND word LIKE '%라이언%'
ORDER BY contentsno DESC;

-- step 2 : 내부쿼리 SELECT의 컬럼들만 먼저 복붙,
-- 외부쿼리는 맨뒤 rownum as r 그대로
-- rownum은 AS로 별명 지정 해줘야함 : rownum 그냥 사용시 누적
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
          file1, file1saved, thumb1, size1, price, dc, saleprice, point, rownum as r
FROM (
          SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
                     file1, file1saved, thumb1, size1, price, dc, saleprice, point
          FROM contents
          WHERE cateno=13 AND word LIKE '%라이언%'
          ORDER BY contentsno DESC
);

-- step 3, 1 page
-- 제일 바깥쪽 쿼리는 r(별명)만
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
          file1, file1saved, thumb1, size1, price, dc, saleprice, point, r
FROM (
           SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
                     file1, file1saved, thumb1, size1, price, dc, saleprice, point, rownum as r
           FROM (
                     SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
                                file1, file1saved, thumb1, size1, price, dc, saleprice, point
                     FROM contents
                     WHERE cateno=13 AND word LIKE '%라이언%'
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
          file1, file1saved, thumb1, size1, price, dc, saleprice, point, r
FROM (
           SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
                     file1, file1saved, thumb1, size1, price, dc, saleprice, point, rownum as r
           FROM (
                     SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
                                file1, file1saved, thumb1, size1, price, dc, saleprice, point
                     FROM contents
                     WHERE cateno=13 AND word LIKE '%라이언%'
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 11 AND r <= 20;

-- [42, 45][Contents] 조회 기능의 제작 
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate, 
          file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt
FROM contents
WHERE contentsno = 20;

-- [43][Contents] 등록 기능의 제작의 상품 정보의 등록(연속입력)
-- 글 수정, id="update"
UPDATE contents 
SET price=5000, dc=10, saleprice=4500, point=250
WHERE contentsno = 20;

commit;

-- [46][Contents] 텍스트 관련 수정 기능의 제작, 패스워드 검사(향후 Ajax 적용 구현) ▲ 
-- 1) 글(텍스트) 부분 수정 : 예외 컬럼(추천수, 조회수, 댓글수)
UPDATE contents
SET title='기차를 타고', content='계획없이 여행 출발',  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 46;

-- ERROR
UPDATE contents
SET title='기차를 타고', content="계획없이 '여행' 출발",  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 46;

-- ERROR
UPDATE contents
SET title='기차를 타고', content='계획없이 \'여행\' 출발',  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 46;

-- ' ' 안에 "나 ' 찍는 방법 : 두번 표시
-- SUCCESS
UPDATE contents
SET title='기차를 타고', content='계획없이 ''여행'' 출발',  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 46;

-- [47][Contents] 파일 수정 기능의 제작, 패스워드 검사(향후 Ajax 적용 구현
UPDATE contents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE contentsno = 1;

-- [48][Contents] 삭제 기능의 제작, 패스워드 검사(향후 Ajax 적용 구현) ▲
DELETE FROM contents
WHERE contentsno = 49;
commit;


