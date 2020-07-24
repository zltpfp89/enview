---------------------------------------------------------------------------------------------------
-- 이 파일은 enBoard 시스템 내에서 독립형테이블 생성 시 사용되므로 제거하지 말것.
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- BULLETIN::게시물
---------------------------------------------------------------------------------------------------
CREATE TABLE BULLETIN (
	BOARD_ID		VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	BLTN_NO			VARCHAR(17) COLLATE Korean_Wansung_CS_AI,
	BLTN_GID		VARCHAR(100) COLLATE Korean_Wansung_CS_AI,
	BLTN_GN			NUMERIC(10),
	BLTN_GQ			NUMERIC(5),
	BLTN_LEV		NUMERIC(3),
	DEL_FLAG		CHAR(1) COLLATE Korean_Wansung_CS_AI,
	CATE_ID			VARCHAR(10) COLLATE Korean_Wansung_CS_AI,
	USER_ID			VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	USER_PASS		VARCHAR(512) COLLATE Korean_Wansung_CS_AI,
	USER_NICK		VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	USER_IP			VARCHAR(39) COLLATE Korean_Wansung_CS_AI,
	BLTN_READ_CNT	NUMERIC(9),
	BLTN_REPLY_CNT	NUMERIC(9),
	BLTN_MEMO_CNT	NUMERIC(9),
	BLTN_FILE_CNT	NUMERIC(9),
	BLTN_TOP_TAG	CHAR(1) COLLATE Korean_Wansung_CS_AI,
	BLTN_BEST_LEVEL	CHAR(1) COLLATE Korean_Wansung_CS_AI,
	BLTN_SECRET_YN	CHAR(1) COLLATE Korean_Wansung_CS_AI,
	BLTN_PERMIT_YN	CHAR(1) COLLATE Korean_Wansung_CS_AI,
	BET_PNT			NUMERIC(6),
	BLTN_ICON		CHAR(1) COLLATE Korean_Wansung_CS_AI,
	BLTN_BGN_YMD	DATE,
	BLTN_END_YMD	DATE,
	SUB_BOARD_ID	VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	BLTN_SUBJ		VARCHAR(120) COLLATE Korean_Wansung_CS_AI,
	REG_DATIM		DATETIME,
	UPD_DATIM		DATETIME,
  CONSTRAINT BULLETINP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO ));

-- 기본 정렬
CREATE INDEX BULLETINIDEF ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_PERMIT_YN,
	BLTN_GN DESC,
	BLTN_GQ DESC );

-- 제목 검색
CREATE INDEX BULLETINISUBJ ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC,
	BLTN_SUBJ );

-- 최신글, 작성일 검색
CREATE INDEX BULLETINIREG ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC,
	REG_DATIM );

-- 작성자 검색
CREATE INDEX BULLETINIUSER ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC,
	USER_NICK );

-- 게시기간 검색
CREATE INDEX BULLETINIYMD ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC,
	BLTN_BGN_YMD,
	BLTN_END_YMD );
	
-- 실삭제기능을 사용하지 않는 게시판의 경우에 필요한 인덱스.
CREATE INDEX BULLETINIDEL ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	DEL_FLAG,
	BLTN_PERMIT_YN,
	BLTN_GN DESC,
	BLTN_GQ DESC );

-- 통합 최신글
CREATE INDEX BULLETININEW ON BULLETIN (
	REG_DATIM DESC,
	BOARD_ID,
	BLTN_GID );

-- 인기글
CREATE INDEX BULLETINIREAD ON BULLETIN (
	BLTN_READ_CNT DESC,
	BOARD_ID,
	BLTN_GID );

-- 나만의자료실
CREATE INDEX BULLETINIMINE ON BULLETIN (
	USER_ID,
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC );	

---------------------------------------------------------------------------------------------------
-- BLTN_MEMO::댓글
---------------------------------------------------------------------------------------------------
CREATE TABLE BLTN_MEMO (
	BOARD_ID	VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	BLTN_NO		VARCHAR(17) COLLATE Korean_Wansung_CS_AI,
	MEMO_SEQ	NUMERIC(6),
	MEMO_GN		NUMERIC(10),
	MEMO_GQ		NUMERIC(5),
	MEMO_LEV	NUMERIC(3),
	USER_ID		VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	USER_PASS	VARCHAR(512) COLLATE Korean_Wansung_CS_AI,
	USER_NICK	VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	USER_IP		VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	MEMO_CNTT	VARCHAR(3000) COLLATE Korean_Wansung_CS_AI,
	BAD_CNT		NUMERIC(4),
	REG_DATIM	DATETIME,
	UPD_DATIM	DATETIME,
  CONSTRAINT BLTN_MEMOP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO,
	MEMO_SEQ ));

CREATE INDEX BLTN_MEMOI1 ON BLTN_MEMO (
	BOARD_ID,
	BLTN_NO,
	MEMO_GN DESC,
	MEMO_GQ DESC );	

---------------------------------------------------------------------------------------------------
-- BLTN_CNTT::게시물 본문
---------------------------------------------------------------------------------------------------
CREATE TABLE BLTN_CNTT (
	BOARD_ID		VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	BLTN_NO			VARCHAR(17) COLLATE Korean_Wansung_CS_AI,
	BLTN_CNTT		VARCHAR(MAX) COLLATE Korean_Wansung_CS_AI,
  CONSTRAINT BLTN_CNTTP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO ));

---------------------------------------------------------------------------------------------------
-- BLTN_FILE::첨부파일
---------------------------------------------------------------------------------------------------
CREATE TABLE BLTN_FILE (
	BOARD_ID	VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	BLTN_NO		VARCHAR(17) COLLATE Korean_Wansung_CS_AI,
	FILE_SEQ	NUMERIC(2),
	ATCH_TYPE	CHAR(1) COLLATE Korean_Wansung_CS_AI,
	FILE_NM		VARCHAR(120) COLLATE Korean_Wansung_CS_AI,
	FILE_MASK	VARCHAR(32) COLLATE Korean_Wansung_CS_AI,
	FILE_SIZE	NUMERIC(12),
	DOWN_CNT	NUMERIC(12),
	ATCH_DATIM	DATETIME,
  CONSTRAINT BLTN_FILEP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO,
	FILE_SEQ ));

---------------------------------------------------------------------------------------------------
-- BLTN_EVAL::추천/평가내역
---------------------------------------------------------------------------------------------------
CREATE TABLE BLTN_EVAL (
	BOARD_ID		VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	BLTN_NO			VARCHAR(17) COLLATE Korean_Wansung_CS_AI,
	EVAL_DATIM		DATETIME,
	EVAL_TYPE		CHAR(1) COLLATE Korean_Wansung_CS_AI,
	EVAL_USER_ID	VARCHAR(30) COLLATE Korean_Wansung_CS_AI,
	EVAL_USER_IP	VARCHAR(39) COLLATE Korean_Wansung_CS_AI,
	EVAL_PNT		NUMERIC(6),
  CONSTRAINT BLTN_EVALP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO,
	EVAL_DATIM ));
---------------------------------------------------------------------------------------------------
-- 이 파일은 enBoard 시스템 내에서 독립형테이블 생성 시 사용되므로 제거하지 말것.
---------------------------------------------------------------------------------------------------
