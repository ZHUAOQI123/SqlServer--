create database MyShool
ON 
(
name='MyShool',
filename='E:\C#学习课程\MyShool.mdf',
size=5MB,
maxsize=100MB,
filegrowth=15%
)
log on 
(
name='MyShool1',
filename='E:\C#学习课程\MyShool.ldf',
size=5MB,
maxsize=100MB,
filegrowth=15%
)



use master 
go
if exists (select * from sysdatabases where name = 'MyShool')
drop database MyShool
create database MyShool
ON 
(
name='MyShool',
filename='E:\C#学习课程\MyShool.mdf',
size=5MB,
maxsize=100MB,
filegrowth=15%
)
log on 
(
name='MyShool1',
filename='E:\C#学习课程\MyShool.ldf',
size=5MB,
maxsize=100MB,
filegrowth=15%
)


use MyShool
go 

if exists (select * from sysobjects where name= 'Grade')
drop table Grade
go 
create table Grade
(
 GradeId int identity (1,1) not null constraint PK_GradeId primary key (GradeId),
 GradeName  nvarchar(50) not null
)


if exists (select * from sysobjects where name ='Student' )
drop table Student
go
create table Student
(
StudentNo int identity (1,1)  not null constraint PK_StudentNo primary key (StudentNo),
LoginPwd  nvarchar(20)  not null ,
StudentName nvarchar(20) not null,
Sex char(2) not null,
GradeId int not null constraint FK_Student_Grade_GradeId foreign key(GradeId) references Grade(GradeId) ,
Phone nvarchar(50) , 
BornDate datetime  not null constraint CK_BornDate check (BornDate>1980-1-1),
Adress nvarchar(255) null constraint DF_Adress default ('地址不详'),
Email nvarchar(50) ,
IDENTITYCard nvarchar(18) not null constraint UQ_IDENTITYCard unique(IDENTITYCard)
)
--alter table Student 
--add constraint PK_StudentNo primary key (StudentNo)
--alter table Student 
--add constraint UQ_IDENTITYCard unique  (IDENTITYCard)
--alter table Student
--add constraint CK_Borndate check (Borndate>1980-1-1)
--alter table Student 
--add constraint FK_GradeId foreign key  (GradeId) references Grade(GradeId)
--缺少一个关于地址的默认约束.(不会)



if exists (select * from sysobjects where name ='Subject')
drop table Subject
go
create table Subject 
(
SubjectNo int  identity (1,1) not null constraint PK_SubjectNo primary key (SubjectNo),
SubjectName  nvarchar(50) not null constraint CK_SubjectName check (SubjectName is not null),
ClassHour  int constraint CK_ClassHour check(ClassHour>=0),
GradeId int constraint FK_Subject_Grade_GradeId foreign  key(GradeId) references Grade(GradeId)
)
--alter table Subject
--add constraint PK_SubjectNo primary key (SubjectNo) 
--alter table Subject
--add constraint CK_SubjectName check (SubjectName is not null)
--alter table Subject
--add constraint  CK_ClassHour check (ClassHour>=0)
--alter table Subject
--add constraint FK_GradeId foreign key (GradeId) references Grade(GradeId)


if exists(select * from sysobjects where name ='Result')
drop table Result
go
create table Result
(
StudentNo int not null constraint FK_Result_Student_StudentNo foreign key (StudentNo) references Student(StudentNo),
SubjectNo  int  not null constraint FK_Result_Subject_SubjectNo foreign key (SubjectNo) references Subject(SubjectNo),
ExamDate  datetime  not null constraint DF_ExamDate default  getdate() ,
StudentResult int not null constraint CK_StudentResult check (StudentResult>=0 and StudentResult<=100)
)
--复合主键是否可以在建表格的时候添加
alter table Result 
add constraint PK_StudentNo_SubjectNo_ExamDate primary key (StudentNo,SubjectNo,ExamDate)
--alter table Result 
--add constraint DF_ExamDate default  getdate()------无法运用
--alter table Result 
--add constraint CK_StudentResult check (StudentResult>=0 and StudentResult<=100)
--alter table Result
--add constraint FK_Result_Student_StudentNo foreign key (StudentNo) references Student(StudentNo)
--alter table Result
--add constraint FK_Result_Subject_SubjectNo foreign key (SubjectNo) references Subject(SubjectNo)

-- Grade
insert into Grade(GradeName)
values ('一年级')
insert into Grade(GradeName)
values ('二年级')
insert into Grade(GradeName)
values ('三年级')

--Subject
insert into Subject(SubjectName,ClassHour,GradeId)
values('English',50,1)
insert into Subject(SubjectName,ClassHour,GradeId)
values('China',70,2)
insert into Subject(SubjectName,ClassHour,GradeId)
values('IT ',60,3)

--Student
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(123,'小一子','女',1,13144556677,1994-5-6,'合肥',default,1111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(1211,'虚竹','男',2,13554556666,1990-5-6,default,'111@qq.com',2111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(4444,'段誉','男',2,18144556677,1999-10-6,'上海','222@qq.com',3111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(2233,'王语嫣','女',1,17444556677,1992-5-1,'合肥',default,4111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(2345,'李莫愁','女',3,15844556677,1998-5-6,default,default,5111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(5432,'乔峰','男',1,13444556677,1999-1-6,'北京','333@qq.com',6111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(1122,'阿朱','女',2,13144589677,1993-7-6,'合肥',default,7111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(6565,'丁春秋','男',1,13144556677,1995-5-11,default,'444@qq.com',8111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(8899,'金毛狮王','男',3,15144523677,1993-4-10,'合肥',default,9111111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(1010,'阿紫','女',2,18544556997,1998-7-9,default,'777@qq.com',1011111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(9876,'哪吒','男',3,17244556397,1994-7-8,'上海','555@qq.com',1311111111)
insert into Student(LoginPwd,StudentName,Sex,GradeId,Phone,BornDate,Adress,Email,IDENTITYCard )
values(7788,'小龙女','女',3,13144556789,1993-7-7,'合肥',default,1211111111)

--delete from Student

--Result
insert into Result(StudentNo,SubjectNo,ExamDate,StudentResult)
values (1,1,GETDATE(),80)
insert into Result(StudentNo,SubjectNo,ExamDate,StudentResult)
values (3,3,GETDATE(),90)
insert into Result(StudentNo,SubjectNo,ExamDate,StudentResult)
values (5,1,GETDATE(),88)
insert into Result(StudentNo,SubjectNo,ExamDate,StudentResult)
values (6,3,GETDATE(),72)
insert into Result(StudentNo,SubjectNo,ExamDate,StudentResult)
values (7,1,GETDATE(),55)
insert into Result(StudentNo,SubjectNo,ExamDate,StudentResult)
values (12,2,GETDATE(),30)
insert into Result(StudentNo,SubjectNo,ExamDate,StudentResult)
values (9,2,GETDATE(),43)
insert into Result(StudentNo,SubjectNo,ExamDate,StudentResult)
values (10,1,GETDATE(),60)