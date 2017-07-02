use master
go
if exists (select * from sysdatabases where name ='Recruiment')
drop database Recruiment
create database Recruiment
on
(
name=Recruiment,
filename ='E:\C#学习课程\Recruiment.mdf',
size=10MB,
maxsize=200MB,
filegrowth=15%
)
log on 
(
name=Recruiment1,
filename ='E:\C#学习课程\Recruiment.ldf',
size=10MB,
maxsize=200MB,
filegrowth=15%
)
 

 use Recruiment
 go 
   
    --------------Personalinfo  个人信息表--------------------    
 if exists (select * from sysobjects where name ='PersonalInfo')
 drop table PersonalInfo
 go 
 create table PersonalInfo
 (
 ApplyId int not null,
 ApplyJobID int not null,
 Name  varchar(40) not null,
 EngName  varchar(40) not null,
 Gender int not null,
 BronDate date not null,
 Height  float null,
 Nation varchar(20) null,
 HuKou  varchar(50) not  null,
 IdentityType varchar(20) not null,
 IdentityNo varchar(20) not null,
 MarriageType varchar(20) null,
 WorkYear  int null,
 AvailableDate varchar not  null,
 CurrenSalary  varchar null,
 ExpectedSalry  varchar  null,
 Residency  varchar(50)   null,
 Homephone  varchar(20)   null,
 CompanyPhone varchar(20)  null,
 Moblie  varchar(20)   null,
 Email varchar(20)   null
 )

   alter table PersonalInfo
  add constraint PK_ApplyId primary key (ApplyId)





   --------------Question  问题表--------------------
 if exists (select * from sysobjects where name = 'Question')
 drop table Question
 go
 create table Question
 (
 QuestionID int not null,
 QuestionName varchar(20) not null,
 QuestionContent  varchar(255) not null,
 QuestionType1 varchar(20) not null,
 QuestionType2 varchar(20) not null,
 Others  varchar(255) not null,
 ReMark  varchar(50)  not null
 )

alter table Question 
add constraint PK_QuestionID primary key (QuestionID)



   --------------Exam 考试表--------------------    
 if exists (select * from sysobjects where name ='Exam')
 drop table Exam
 go 
 create table Exam
 (
 ExamID int not null,
 ExamName varchar(50) not null,
 ExamType int not null,
 Remark varchar(255) not null,
 PassRemark  varchar(50) not null,
 IssueDate  date not null,
 JobType  varchar(50) not null
 )

 alter table Exam
 add constraint PK_ExamID primary key (ExamID)




 --------------Examdetail  考试详情表--------------------    
 if exists (select * from sysobjects where name ='Examdetail')
 drop table Examdetail
 go 
 create table Examdetail
 (
 ExamdetailId  int not null,
 ExamID  int not null ,
 QuesttionID int  not null,
 QuesttionOrder  varchar(20) not null,
 )

   alter table Examdetail
  add constraint PK_QuesttionID_ExamID primary key (QuesttionID,ExamID)
  alter table Examdetail
add constraint FK_QuesttionID foreign key (QuesttionID) references Question(QuestionID)
  alter table Examdetail
add constraint FK_ExamID foreign key (ExamID) references Exam(ExamID)



   --------------JobExperience 工作经历--------------------
if exists (select * from sysobjects where name=' JobExperience')
drop table JobExperience
go 
create table JobExperience
(
Users int not null,
ApplyID int not null,
StarDate date not null,
EndDate  date  not null,
Company  varchar(20)  not null,
CompanyProperty varchar(40)  not null,
Depaerment  varchar(20)  not null,
Jobtitle varchar(20)  not null,
JobDescription varchar(255)  not null,
)

alter table  JobExperience
add constraint PK_Users primary key (Users)
alter table JobExperience 
add constraint FK_ApplyId foreign key (ApplyId) references PersonalInfo(ApplyId)



  --------------ApplyJob  申请职位表--------------------
 if exists(select * from sysobjects where name='ApplyJob')
 drop table ApplyJob
 go 
create table ApplyJob
(
JobId int not null,
ApplyId  int   not null,
ApplyJobId  int not null,
State varchar null,
InterviewTime date null,
IntervieweMan varchar(20) null,
InterviewResult varchar(20) null
)

alter table ApplyJob
add constraint PK_ApplyJobId primary key (ApplyJobId)
alter table ApplyJob
add constraint FK_ApplyJob_PresonalInfo_ApplyId foreign key (ApplyId) references PersonalInfo(ApplyId)



   --------------JobType  职位类型表--------------------
   if exists(select * from sysobjects where name='JobType')
   drop table JobType
   go 
   create table JobType
   (
   JobTypeID int not null,
   JobTypeName varchar(20) not null,
   JobTypeCName varchar(20) not null
   )
alter table JobType
add constraint Pk_JobTypeID primary key (JobTypeID)




--------------JobList  职位列表--------------------
 if exists (select * from sysobjects where name = 'JobList')
 drop table JobList
 go 
 create table JobList
 (
 JobNAME varchar(20) not null,
 JobID int not null,
 JobTypeID  int  not null,
 PubDate  date null,
 EndDate date null,
 JobNum  int not null,
 Description varchar(255) null,
 Requirements varchar(255) null,
 Others  varchar(255) null
 )
 alter table JobList
add constraint PK_JobId  primary key (JobId)
alter table JobList
add constraint Fk_JobList_JobType_JobTypeID foreign key (JobTypeID) references JobType(JobTypeID)



 


  --------------Education  教育状况表--------------------    
 if exists (select * from sysobjects where name ='Education')
 drop table Education
 go 
 create table Education
 (
 EducationID int not null,
 ApplyId int not null,
 StartDate date not null,
 EndDate   date  not null,
 Name varchar(40)  not null
 )

alter table Education
add constraint PK_EducationID primary key (EducationID)
alter table Education
add constraint FK_Education_PersonalInfo_ApplyId foreign key (ApplyId) references PersonalInfo(ApplyId)
 





   --------------Answer  回答表--------------------
   if exists (select * from sysobjects where name='Answer')
   drop table Answer
  go 
   create table Answer
	(
	AnswerID int  not null,
	QuestionID int not null,
	Content varchar(255) not null,
	Mark  float not null
	)
	--alter table Answer
	--add constraint 


 --------------Skill  技能表--------------------
 if exists(select * from sysobjects where name= 'Skill' )
  drop table Skill
  go 
  create table Skill 
  (
  SkillID int not null,
  ApplyId int not null,
  SkillName  varchar(40)  not null,
  SkillLever  varchar(20)  not null,
  CertName   varchar(20)  not null,
  SkillDetail varchar(255)  not null,
  )

alter table Skill
add constraint PK_SkillID primary key (SkillID)
alter table Skill
add constraint FK_Skill_PersonalInfo_ApplyId foreign key (ApplyId) references PersonalInfo(ApplyId)





  --------------Family  家庭情况表--------------------    
 if exists (select * from sysobjects where name ='Family')
 drop table Family
 go 
 create table Family
 (
 FamilyName varchar(20) not null,
 FamilyID int not null,
 ApplyID int not null,
 SchoolName  varchar(50) not null,
 Major varchar(50) not null,
 Degree int not null,
 EduDetail varchar(50) not null
 )

 alter table Family
add constraint PK_FamilyID primary key (FamilyID)
alter table Family
add constraint FK_Family_PersonalInfo_ApplyId foreign key (ApplyId) references PersonalInfo(ApplyId)




    --------------Users 用户表--------------------    
 if exists (select * from sysobjects where name ='Users')
 drop table Users
 go 
 create table Users
 (
 UsersID varchar not null,
 UsersName varchar(20)  not null,
 UsersPwd  varchar(20)  not null,
 Permisstion int not null
 )

 alter table Users
add constraint PK_UsersID primary key (UsersID)
 


    --------------Examresult 考试结果表--------------------    
 if exists (select * from sysobjects where name ='Examresult')
 drop table Examresult
 go 
 create table Examresult
 (
 ExamresultId int not null,
 QuestionID int not null,
 Mark0 float not null,
 AnswerRecord0 varchar(255)  not null,
 Mark1 float not null ,
 AnswerRecord1 varchar(255) not null,
 Marks float not null
 )

 alter table Examresult
add constraint PK_ExamresultId primary key (ExamresultId)
 alter table Examresult
add constraint FK_QuestionID foreign key (QuestionID) references Question(QuestionID)

     --------------JobExam 职位考试表--------------------    
 if exists (select * from sysobjects where name ='JobExam')
 drop table JobExam
 go 
 create table JobExam
 (
 JobID int not null,
 ExamID int not null,
 ApplyId int not null,
 ExamType varchar(20) not null,
 ExanName varchar(20) not null
 )

  alter table JobExam
add constraint PK_JobID_ExamID primary key (JobID, ExamID)
 alter table JobExam
add constraint FK_JobID foreign key (JobID) references JobList(JobID)
  alter table JobExam
add constraint FK_JobExam_Exam_ExamID foreign key (ExamID) references Exam(ExamID)
