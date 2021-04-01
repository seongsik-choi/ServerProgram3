/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
DROP TABLE categrp;

-- Physical Modeling 
CREATE TABLE categrp(
		categrpno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(50)		 NOT NULL,
		seqno                         		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

-- Logical Modeling
COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN categrp.name is '이름';
COMMENT ON COLUMN categrp.seqno is '출력 순서';
COMMENT ON COLUMN categrp.visible is '출력 모드';
COMMENT ON COLUMN categrp.rdate is '그룹 생성일';

DROP SEQUENCE categrp_seq;

CREATE SEQUENCE categrp_seq
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                 -- 다시 1부터 생성되는 것을 방지

-- Create, 등록 : CREATE + INSERT
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '영화', 1, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '여행', 2, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '음악', 3, 'Y', sysdate);

-- List, 목록 : 여러 건의 레코드를 읽는 것
SELECT categrpno, name, seqno, visible, rdate FROM categrp
ORDER BY categrpno ASC;

-- Read, 조회 : 한 건의 레코드를 읽는 것
SELECT categrpno, name, seqno, visible, rdate FROM categrp
WHERE categrpno = 1;

-- Update, 수정 : PK는 update 불가능, 컬럼의 특징을 파악후 변경 여부결정
-- UPDATE 테이블명 SET에 바꿀 조건, WHERE에 PK조건을 명시.
UPDATE categrp SET name='영화에서영화2로', seqno=5, visible='N'
WHERE categrpno=1;

-- 복구
UPDATE categrp SET name='영화', seqno=1, visible='Y'
WHERE categrpno=1;

-- Delete, 삭제
DELETE FROM categrp WHERE categrpno=3;

-- 복구 : categrpno는 3이 아닌 4 or 5 그 이상 nuum으로 : PK는 재생성 NO
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '음악', 3, 'Y', sysdate);

SELECT * FROM categrp;

-- Count(갯수) : 그룹화 함수이자 Column명
-- 컬럼에 null이 있는경우 갯수 산정에 제외됨.
SELECT count(*) FROM categrp;

-- count(*) 보완 : AS는 컬럼별명을 사용
SELECT COUNT(*) AS cnt FROM categrp;

commit;