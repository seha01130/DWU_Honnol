
DROP SEQUENCE Sequence_EventId;

CREATE SEQUENCE Sequence_EventId
	INCREMENT BY 1
	START WITH 1;

DROP SEQUENCE Sequence_LocationId;

CREATE SEQUENCE Sequence_LocationId
	INCREMENT BY 1
	START WITH 1;

DROP SEQUENCE Sequence_MemberInfoId;

CREATE SEQUENCE Sequence_MemberInfoId
	INCREMENT BY 1
	START WITH 1;

DROP SEQUENCE Sequence_PostId;

CREATE SEQUENCE Sequence_PostId
	INCREMENT BY 1
	START WITH 1;

DROP SEQUENCE Sequence_ReplyId;

CREATE SEQUENCE Sequence_ReplyId
	INCREMENT BY 1
	START WITH 1;

DROP TABLE Bookmark CASCADE CONSTRAINTS PURGE;

DROP TABLE Reply CASCADE CONSTRAINTS PURGE;

DROP TABLE Post CASCADE CONSTRAINTS PURGE;

DROP TABLE AppliedEvent CASCADE CONSTRAINTS PURGE;

DROP TABLE Event CASCADE CONSTRAINTS PURGE;

DROP TABLE Location CASCADE CONSTRAINTS PURGE;

DROP TABLE MemberInfo CASCADE CONSTRAINTS PURGE;

DROP TABLE Member CASCADE CONSTRAINTS PURGE;

CREATE TABLE Event
(
	eventId              INTEGER  NOT NULL ,
	memberId             VARCHAR2(10)  NOT NULL ,
	title                VARCHAR2(30)  NULL ,
	image                VARCHAR2(1000)  NULL ,
	createDate           DATE  NULL ,
	content              VARCHAR2(1000)  NULL ,
	attendees            INTEGER  NULL ,
	locationId           INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKEvent ON Event
(eventId   ASC);

ALTER TABLE Event
	ADD CONSTRAINT  XPKEvent PRIMARY KEY (eventId);

CREATE TABLE Location
(
	locationId           INTEGER  NOT NULL ,
	name                 VARCHAR2(30)  NULL ,
	address              VARCHAR2(50)  NULL 
);

CREATE UNIQUE INDEX XPKLocation ON Location
(locationId   ASC);

ALTER TABLE Location
	ADD CONSTRAINT  XPKLocation PRIMARY KEY (locationId);

CREATE TABLE Member
(
	memberId             VARCHAR2(10)  NOT NULL ,
	password             VARCHAR2(20)  NULL ,
	email                VARCHAR2(30)  NULL ,
	posts                INTEGER  NULL ,
	events               INTEGER  NULL 
);

CREATE UNIQUE INDEX XPKMember ON Member
(memberId   ASC);

ALTER TABLE Member
	ADD CONSTRAINT  XPKMember PRIMARY KEY (memberId);

CREATE TABLE AppliedEvent
(
	eventId              INTEGER  NOT NULL ,
	memberId             VARCHAR2(10)  NOT NULL 
);

CREATE UNIQUE INDEX XPKAppliedEvent ON AppliedEvent
(eventId   ASC,memberId   ASC);

ALTER TABLE AppliedEvent
	ADD CONSTRAINT  XPKAppliedEvent PRIMARY KEY (eventId,memberId);

CREATE TABLE MemberInfo
(
	nickname             VARCHAR2(30)  NULL ,
	profilePicture       VARCHAR2(1000)  NULL ,
	rating               INTEGER  DEFAULT 0  NULL ,
	memberId             VARCHAR2(10)  NOT NULL 
);

CREATE UNIQUE INDEX XPKMemberInfo ON MemberInfo
(memberId   ASC);

ALTER TABLE MemberInfo
	ADD CONSTRAINT  XPKMemberInfo PRIMARY KEY (memberId);

CREATE TABLE Post
(
	postId               INTEGER  NOT NULL ,
	isPublic             SMALLINT  DEFAULT 1  NULL ,
	createDate           DATE  NULL ,
	title                VARCHAR2(30)  NULL ,
	image                VARCHAR2(1000)  NULL ,
	content              VARCHAR2(1000)  NULL ,
	memberId             VARCHAR2(10)  NOT NULL ,
	locationId           INTEGER  NOT NULL ,
	myBookmarks          INTEGER  DEFAULT 0  NULL 
);

CREATE UNIQUE INDEX XPKPost ON Post
(postId   ASC);

ALTER TABLE Post
	ADD CONSTRAINT  XPKPost PRIMARY KEY (postId);

CREATE TABLE Bookmark
(
	memberId             VARCHAR2(10)  NOT NULL ,
	postId               INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKBookmark ON Bookmark
(postId   ASC,memberId   ASC);

ALTER TABLE Bookmark
	ADD CONSTRAINT  XPKBookmark PRIMARY KEY (postId,memberId);

CREATE TABLE Reply
(
	replyId              INTEGER  NOT NULL ,
	content              VARCHAR2(100)  NULL ,
	createDate           DATE  NULL ,
	postId               INTEGER  NOT NULL ,
	memberId             VARCHAR2(10)  NOT NULL 
);

CREATE UNIQUE INDEX XPKReply ON Reply
(replyId   ASC);

ALTER TABLE Reply
	ADD CONSTRAINT  XPKReply PRIMARY KEY (replyId);

ALTER TABLE Event
	ADD (
CONSTRAINT makeEvent FOREIGN KEY (memberId) REFERENCES Member (memberId));

ALTER TABLE Event
	ADD (
CONSTRAINT containEventLocation FOREIGN KEY (locationId) REFERENCES Location (locationId));

ALTER TABLE AppliedEvent
	ADD (
CONSTRAINT applyEvent FOREIGN KEY (memberId) REFERENCES Member (memberId));

ALTER TABLE AppliedEvent
	ADD (
CONSTRAINT applied_Member FOREIGN KEY (eventId) REFERENCES Event (eventId));

ALTER TABLE MemberInfo
	ADD (
CONSTRAINT makeProfile FOREIGN KEY (memberId) REFERENCES Member (memberId));

ALTER TABLE Post
	ADD (
CONSTRAINT makePost FOREIGN KEY (memberId) REFERENCES Member (memberId));

ALTER TABLE Post
	ADD (
CONSTRAINT containPostLocation FOREIGN KEY (locationId) REFERENCES Location (locationId));

ALTER TABLE Bookmark
	ADD (
CONSTRAINT addBookmark FOREIGN KEY (memberId) REFERENCES Member (memberId));

ALTER TABLE Bookmark
	ADD (
CONSTRAINT bookmarkedPost FOREIGN KEY (postId) REFERENCES Post (postId));

ALTER TABLE Reply
	ADD (
CONSTRAINT writeReply FOREIGN KEY (memberId) REFERENCES Member (memberId));

ALTER TABLE Reply
	ADD (
CONSTRAINT getReplies FOREIGN KEY (postId) REFERENCES Post (postId));