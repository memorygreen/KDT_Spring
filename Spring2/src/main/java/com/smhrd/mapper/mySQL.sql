DELETE FROM REPLY;
DELETE FROM BOARD;

DROP TABLE BOARD;

CREATE TABLE BOARD(
	IDX INT NOT NULL AUTO_INCREMENT,
	TITLE VARCHAR(100) NOT NULL,
	CONTENT VARCHAR(2000) NOT NULL,
	WRITER VARCHAR(30) NOT NULL,
	INDATE DATETIME DEFAULT NOW(),
	COUNT INT DEFAULT 0,
	IMGPATH VARCHAR(200),
	PRIMARY KEY(IDX)
);


SELECT * FROM BOARD;



INSERT INTO BOARD (TITLE, CONTENT, WRITER)
VALUES('봄이 왔나봐요 날이 따뜻해집니다.', '하지만 외롭죠...', '장범준');
INSERT INTO BOARD (TITLE, CONTENT, WRITER)
VALUES('해뜨는집 미친 메뉴 오늘 알아옴', '묵은지고등어조림 진짜 완전 꿀맛', '김가가');
INSERT INTO BOARD (TITLE, CONTENT, WRITER)
VALUES('엊그제만 하더라도 기본자료형 배웠는데', '벌써 스프링이라니 세상빠르다', '최나나');
INSERT INTO BOARD (TITLE, CONTENT, WRITER)
VALUES('호두아빠 구독 좋아요 부탁드립니다', '400명 유튜버 가자!!', '강다다');
INSERT INTO BOARD (TITLE, CONTENT, WRITER)
VALUES('안녕하세요 박라라입니다!', '라라라라', '박라라');


SELECT * FROM BOARD;

CREATE TABLE REPLY(
   IDX INT NOT NULL AUTO_INCREMENT,
   BOARDNUM INT NOT NULL,
   WRITER VARCHAR(30) NOT NULL,
   CONTENT VARCHAR(2000) NOT NULL,
   INDATE DATETIME DEFAULT NOW(),
   PRIMARY KEY(IDX)
);

DROP TABLE REPLY;

SELECT * FROM REPLY; 
