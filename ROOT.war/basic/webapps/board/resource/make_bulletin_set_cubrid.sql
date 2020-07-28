---------------------------------------------------------------------------------------------------
-- �� ������ enBoard �ý��� ������ ���������̺� ���� �� ���ǹǷ� �������� ����.
-- �� ������ ������ 'ANSI ���ڵ�'���� �ٸ� ������ �ٲ��� ����.
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- BULLETIN::�Խù�
---------------------------------------------------------------------------------------------------
CREATE TABLE BULLETIN (
	BOARD_ID		VARCHAR(30) NOT NULL,
	BLTN_NO			VARCHAR(17) NOT NULL,
	BLTN_GID		VARCHAR(100),
	BLTN_GN			DECIMAL(10),
	BLTN_GQ			DECIMAL(5),
	BLTN_LEV		DECIMAL(3),
	DEL_FLAG		CHAR(1),
	CATE_ID			VARCHAR(10),
	USER_ID			VARCHAR(30),
	USER_PASS		VARCHAR(512),
	USER_NICK		VARCHAR(45),
	USER_IP			VARCHAR(39),
	BLTN_READ_CNT	DECIMAL(9),
	BLTN_REPLY_CNT	DECIMAL(9),
	BLTN_MEMO_CNT	DECIMAL(9),
	BLTN_FILE_CNT	DECIMAL(9),
	BLTN_TOP_TAG	CHAR(1),
	BLTN_BEST_LEVEL	CHAR(1),
	BLTN_SECRET_YN	CHAR(1),
	BLTN_PERMIT_YN	CHAR(1),
	BET_PNT			DECIMAL(6),
	BLTN_ICON		CHAR(1),
	BLTN_BGN_YMD	DATE,
	BLTN_END_YMD	DATE,
	SUB_BOARD_ID	VARCHAR(30),
	BLTN_SUBJ		VARCHAR(180),
	REG_DATIM		TIMESTAMP,
	UPD_DATIM		TIMESTAMP,
  CONSTRAINT BULLETINP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO ));

-- �⺻ ����
CREATE INDEX BULLETINIDEF ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_PERMIT_YN,
	BLTN_GN DESC,
	BLTN_GQ DESC );

-- ���� �˻�
CREATE INDEX BULLETINISUBJ ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC,
	BLTN_SUBJ );

-- �ֽű�, �ۼ��� �˻�
CREATE INDEX BULLETINIREG ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC,
	REG_DATIM );

-- �ۼ��� �˻�
CREATE INDEX BULLETINIUSER ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC,
	USER_NICK );

-- �ԽñⰣ �˻�
CREATE INDEX BULLETINIYMD ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC,
	BLTN_BGN_YMD,
	BLTN_END_YMD );
	
-- �ǻ�������� ������� �ʴ� �Խ����� ��쿡 �ʿ��� �ε���.
CREATE INDEX BULLETINIDEL ON BULLETIN (
	BOARD_ID,
	BLTN_GID,
	DEL_FLAG,
	BLTN_PERMIT_YN,
	BLTN_GN DESC,
	BLTN_GQ DESC );

-- ���� �ֽű�
CREATE INDEX BULLETININEW ON BULLETIN (
	REG_DATIM DESC,
	BOARD_ID,
	BLTN_GID );

-- �α��
CREATE INDEX BULLETINIREAD ON BULLETIN (
	BLTN_READ_CNT DESC,
	BOARD_ID,
	BLTN_GID );

-- �������ڷ��
CREATE INDEX BULLETINIMINE ON BULLETIN (
	USER_ID,
	BOARD_ID,
	BLTN_GID,
	BLTN_GN DESC,
	BLTN_GQ DESC );	

---------------------------------------------------------------------------------------------------
-- BLTN_MEMO::���
---------------------------------------------------------------------------------------------------
CREATE TABLE BLTN_MEMO (
	BOARD_ID	VARCHAR(30) NOT NULL,
	BLTN_NO		VARCHAR(17) NOT NULL,
	MEMO_SEQ	DECIMAL(6) NOT NULL,
	MEMO_GN		DECIMAL(10),
	MEMO_GQ		DECIMAL(5),
	MEMO_LEV	DECIMAL(3),
	USER_ID		VARCHAR(30),
	USER_PASS	VARCHAR(512),
	USER_NICK	VARCHAR(30),
	USER_IP		VARCHAR(30),
	MEMO_CNTT	VARCHAR(3000),
	BAD_CNT		DECIMAL(4),
	REG_DATIM	TIMESTAMP,
	UPD_DATIM	TIMESTAMP,
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
-- BLTN_CNTT::�Խù� ����
---------------------------------------------------------------------------------------------------
CREATE TABLE BLTN_CNTT (
	BOARD_ID		VARCHAR(30) NOT NULL,
	BLTN_NO			VARCHAR(17) NOT NULL,
	BLTN_CNTT		CLOB,
  CONSTRAINT BLTN_CNTTP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO ));

---------------------------------------------------------------------------------------------------
-- BLTN_FILE::÷������
---------------------------------------------------------------------------------------------------
CREATE TABLE BLTN_FILE (
	BOARD_ID	VARCHAR(30) NOT NULL,
	BLTN_NO		VARCHAR(17) NOT NULL,
	FILE_SEQ	DECIMAL(2) NOT NULL,
	ATCH_TYPE	CHAR(1),
	FILE_NM		VARCHAR(120),
	FILE_MASK	VARCHAR(32),
	FILE_SIZE	DECIMAL(12),
	DOWN_CNT	DECIMAL(12),
	ATCH_DATIM	TIMESTAMP,
  CONSTRAINT BLTN_FILEP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO,
	FILE_SEQ ));

---------------------------------------------------------------------------------------------------
-- BLTN_EVAL::��õ/�򰡳���
---------------------------------------------------------------------------------------------------
CREATE TABLE BLTN_EVAL (
	BOARD_ID		VARCHAR(30) NOT NULL,
	BLTN_NO			VARCHAR(17) NOT NULL,
	EVAL_DATIM		TIMESTAMP NOT NULL,
	EVAL_TYPE		CHAR(1),
	EVAL_USER_ID	VARCHAR(30),
	EVAL_USER_IP	VARCHAR(39),
	EVAL_PNT		DECIMAL(6),
  CONSTRAINT BLTN_EVALP1 PRIMARY KEY (
	BOARD_ID,
	BLTN_NO,
	EVAL_DATIM ));

---------------------------------------------------------------------------------------------------
-- �� ������ enBoard �ý��� ������ ���������̺� ���� �� ���ǹǷ� �������� ����.
---------------------------------------------------------------------------------------------------
