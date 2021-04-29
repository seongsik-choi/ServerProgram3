/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE cate;

CREATE TABLE cate(
		cateno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categrpno                     		NUMBER(10)		 NULL ,
		name                          		VARCHAR2(50)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

COMMENT ON TABLE cate is '카테고리';
COMMENT ON COLUMN cate.cateno is '카테고리 번호';
COMMENT ON COLUMN cate.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN cate.name is '카테고리 이름';
COMMENT ON COLUMN cate.rdate is '등록일';
COMMENT ON COLUMN cate.cnt is '관련 자료 수';

-- cate(자식 Table)도 SEQUENCE Table 필요(ORACLE 기준)
DROP SEQUENCE cate_seq;
CREATE SEQUENCE cate_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1000, '가을', sysdate, 0);
-- 오류 보고 : ORA-02291: integrity constraint (AI7.SYS_C008048) violated - parent key not found
-- FK 컬럼의 값 1000은 categrp 테이블에 없어서 에러 발생
-- FK는 다른 테이블의 PK나 UNIQUE 속성이 적용된 컬럼에 연결하여 등록된 값만 사용 할 수 있음

-- 부모 테이블 체크(categrpno= 1000인 값이 없기에 cate 테이블에서는 사용 no)
SELECT * FROM categrp ORDER BY categrpno ASC;

CATEGRPNO NAME                                 SEQNO V    RDATE              
---------- --------------------------------------- ---------- - -------------------
         1 영화22                                            1 Y 2021-04-02 03:37:44
         2 음악                                               4 Y 2021-04-02 03:39:05
         3 드라마                                            2 N 2021-04-02 03:39:20

-- 등록(CREATE, INSERT) : categrpno가 부모테이블에 있는 레코드로만
INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, 'SF', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, '드라마', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, '로코', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, '스릴러', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, '공포', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 2, '경기도', sysdate, 0);

COMMIT;

-- 목록(LIST)
SELECT cateno, categrpno, name, rdate, cnt
FROM cate ORDER BY cateno ASC;

-- 목록(LIST) 출력. -> but categrp 테이블의 1번 레코드는 변하지 않음.
     PK           FK 
   CATENO  CATEGRPNO NAME                                               RDATE                      CNT
---------- ---------- -------------------------------------------------- ------------------- ----------
         1          1         SF                                                 2021-04-09 10:47:14          0
         2          1        드라마                                             2021-04-09 10:47:14          0
         3          1        로코                                                2021-04-09 10:47:14          0

-- [28] categrpno 별 목록(WHER로 caregrpno = 1(여행) 인 레코드만 출력.
SELECT cateno, categrpno, name, rdate, cnt
FROM cate
WHERE categrpno = 1
ORDER BY cateno ASC;

-- [29] Categrp + Cate join, 연결 목록 : name 컬럼 이름이 겹침 이를 join
-- 1) FROM절의 r과 c는 TABLE에 대한 별명
-- 2) SLEECT 절에 컬럼은 별명.컬럼명 / 겹치는 컬럼명 반드시 명시 + 별명 선언(AS)
-- 3) AS로 컬럼명 선언시 실제 컬럼명은 사용 NO.
-- 4) 부모쪽에 AS로 별병 선언 시, 자식은 별명 선언 필요 NO.
-- 5) WHERE 조건에 부모 PK(Categrpno)와 자식 FK(categrpno) 비교해 같으면 Join하여 출력
-- 6) 결합시 자식 테이블의 레코드 갯수만큼 결합(Join)이 발생
SELECT r.categrpno AS r_categrpno, r.name AS r_name,
          c.cateno, c.categrpno, c.name, c.rdate, c.cnt
FROM categrp r, cate c
WHERE r.categrpno = c.categrpno
ORDER BY categrpno ASC, cateno ASC;

(부_PK)                         (자_PK)     (자_FK)
R_CATEGRPNO R_NAME    CATENO  CATEGRPNO NAME             RDATE                      CNT
---------------- ----------------------- ---------- ---------------------------------------- ------------------
         1      영화                1           1                 SF             2021-04-12 11:28:14          0
         1      영화                 2          1             드라마            2021-04-12 11:28:14          0
         1      영화                 3          1                 로코           2021-04-12 11:28:14          0
         1      영화                 14         1             스릴러           2021-04-12 01:13:45          0
         2      여행                  15        2              경기도           2021-04-12 01:16:23          0
         3      음악                  17        3              pop              2021-04-12 02:44:00          0
         3      음악                   18       3             발라드            2021-04-12 02:48:08          0
         3      음악                   19       3             클래식            2021-04-12 02:50:52          0


-- 카테고리 그룹 : READ
SELECT categrpno, name, seqno, visible, rdate FROM categrp
ORDER BY categrpno ASC;


-- 조회(READ)
SELECT cateno, categrpno, name, rdate, cnt
FROM cate WHERE cateno=3;

-- 수정(UPDATE)
UPDATE cate SET categrpno=1, name='식당', cnt=0
WHERE cateno = 3;

COMMIT;

-- 삭제(DELETE)
DELETE cate
WHERE cateno = 4;

COMMIT;

-- 목록(LIST)
SELECT * FROM cate ORDER BY cateno ASC;       

-- 갯수(Count) 가져오기.
SELECT COUNT(*) AS cnt
FROM cate;

-- cnt 컬럼 1. 글 수 증감 : cnt = cnt +1 or -1
UPDATE cate SET cnt = cnt + 1 WHERE cateno=1;
COMMIT;

-- cnt 컬럼 2. 글수 초기화 : cnt = 0
UPDATE cate SET cnt = 0;
COMMIT;
