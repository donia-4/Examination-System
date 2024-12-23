create table student(
	studentID int identity primary key,
	fullName Nvarchar(50),
	email Nvarchar(50),
	phone Nvarchar(30),
	userID int,
	branchID int,
    trackID int,
    intakeID int,
	trainingManagerID int,
	foreign key(userID) references users(userID),
	foreign key(branchID) references branch(branchID),
	foreign key(trackID) references track(trackID),
	foreign key(intakeID) references Intake(intakeID),
	foreign key(trainingManagerID) references trainingManager(trainingManagerID)
)

create table users(
	userID int identity primary key,
	userName Nvarchar(50),
	password Nvarchar(50),
	role Nvarchar(50)
)

create table trainingManager(
	trainingManagerID int identity primary key,
	fullName Nvarchar(50),
	email Nvarchar(50),
	phone Nvarchar(30),
	userID int,
	foreign key(userID) references users(userID)
)

create table instructor(
	instructorID int identity primary key,
	fullName Nvarchar(50),
	email Nvarchar(50),
	phone Nvarchar(30),
	userID int,
	foreign key(userID) references users(userID)
)

create table Course(
	courseID int identity primary key,
	courseName Nvarchar(50),
	minDegree decimal(5,2),
	maxDegree decimal(5,2),
	description Nvarchar(max)
)

create table question(
	questionID int identity primary key,
	questionType Nvarchar(20) check (questionType in ('MCQ', 'Text', 'True/False')),
	questionText Nvarchar(500),
	degree decimal(5,2),
	courseID int,
	foreign key(courseID) references Course(courseID)
)

create table MCQ_Question (
	questionID int primary key,
	option1 Nvarchar(255),
    option2 Nvarchar(255),
    option3 Nvarchar(255),
    option4 Nvarchar(255),
	correctAnswer Nvarchar(50) check (correctAnswer in ('option1', 'option2', 'option3', 'option4')),
	foreign key(questionID) references question(questionID)
)

create table TrueFalse_Question(
	questionID int primary key,
	correctAnswer bit,
	foreign key(questionID) references question(questionID)
)

create table TextQuestion (
	questionID int primary key,
	bestAnswer Nvarchar(max),
	foreign key(questionID) references question(questionID)
)

create table Exam(
	examID int identity primary key,
	examType Nvarchar(20),
	year int,
	startTime datetime,
	endTime datetime,
	allowanceOption Nvarchar(100),
	instructorID int,
	courseID int,
	branchID int,
	trackID int,
	intakeID int,
	foreign key(instructorID) references instructor(instructorID),
	foreign key(courseID) references Course(courseID),
	foreign key(branchID) references branch(branchID),
	foreign key(trackID) references track(trackID),
	foreign key(intakeID) references Intake(intakeID)
)

create table branch(
	branchID int identity primary key,
	branchName Nvarchar(30),
	trainingManagerID int,
	foreign key(trainingManagerID) references trainingManager(trainingManagerID)
)

create table track(
	trackID int identity primary key,
	trackName Nvarchar(30),
	branchID int,
	trainingManagerID int,
	intakeID int,
	foreign key(branchID) references branch(branchID),
	foreign key(trainingManagerID) references trainingManager(trainingManagerID),
	foreign key(intakeID) references Intake(intakeID)
)

create table Intake(
	intakeID int identity primary key,
	intakeYear int,
	trainingManagerID int,
	foreign key(trainingManagerID) references trainingManager(trainingManagerID)
)

create table studentAnswer(
	answerID int identity primary key,
	answer Nvarchar(max),
	isCorrect bit,
	marksAwarded decimal(5,2),
	studentID int,
	questionID int,
	examID int,
	foreign key(studentID) references student(studentID),
	foreign key(questionID) references question(questionID),
	foreign key(examID) references Exam(examID)
)

create table studentExam(
	studentID int,
    examID int,
	studentResult decimal(5,2),
	primary key(studentID, examID),
	foreign key(studentID) references student(studentID),
	foreign key(examID) references Exam(examID)
)

create table instructorCourse (
    instructorID int,
    courseID int,
    year int,
    primary key (instructorID, courseID),
    foreign key (instructorID) references instructor(instructorID),
    foreign key (courseID) references course(courseID)
)

create table questionExam (
    examID int,
    questionID int,
    primary key (examID, questionID),
    foreign key (examID) references exam(examID),
    foreign key (questionID) references question(questionID)
)

--=====================================================================
-- Indexes
create index Index_questionExam_ExamId
on questionExam (ExamId);

create index Index_questionExam_QuestionId
on questionExam (QuestionId);

create index Index_StudentAnswer_QuestionId
on StudentAnswer (QuestionId);

create index Index_Student_IntakeId_TrackId_BranchId
on dbo.Student (IntakeId, TrackId, BranchId);

create index Index_Exam_CourseId_InstructorId_TrackId_BranchId_IntakeId
on dbo.Exam (CourseId, InstructorId, TrackId, BranchId, IntakeId);

create index Index_Question_CourseId_QuestionType
on dbo.question (CourseId, QuestionType);

create index Index_Branch_TrainingManagerID
on dbo.branch (trainingManagerID);

create index Index_Track_BranchID_IntakeID
on dbo.track (branchID, intakeID);

create index Index_StudentAnswer_ExamId_StudentId_QuestionId
on StudentAnswer (ExamId, StudentId, QuestionId);

--=====================================================================
SELECT * FROM users

SELECT * FROM trainingManager

SELECT * FROM branch

SELECT * FROM track

SELECT * FROM Intake

SELECT * FROM student

SELECT * FROM instructor

select * from Course

select * from instructorCourse

select * from Exam

select * from question

select * from MCQ_Question

select * from TrueFalse_Question

select * from TextQuestion

select * from studentAnswer

select * from studentExam

select * from questionExam


