--create Exam
alter proc AddExam
	@ExamType int,
	@year int,
    @StartTime datetime,
    @EndTime datetime,
    @AllowanceOption Nvarchar(300),
	@instructorID int,
	@CourseID int,
    @BranchID int,
    @TrackID int,
	@IntakeID int
AS
BEGIN
    SET NOCOUNT ON;
    -- Insert the new exam details into the Exam table
    Insert into Exam (examType, year, startTime,endTime, allowanceOption,instructorID,courseID,branchID,trackID,intakeID)
    Values (@ExamType, @year, @StartTime, @EndTime, @AllowanceOption, @instructorID, @CourseID, @BranchID,@TrackID,@IntakeID);
END;

--===========================================================
-- Set Exam Schedule
alter proc SetExamSchedule
	@ExamId int,
	@StartTime datetime,
	@EndTime datetime
as
begin
	SET NOCOUNT ON;

	UPDATE Exam
		set StartTime = @StartTime,
		EndTime = @EndTime
		where ExamId = @ExamId;

	select 'Exam schedule updated successfully.';
end

--======================================================
--sp for Assign Students to an Exam
create proc AssignValidStudentsToExam
	@ExamId int,
	@StudentIds nvarchar(MAX)
as
begin
	SET NOCOUNT ON;
	-- conver table list to tables 
	declare @Students table (StudentId int);
	insert into @Students (StudentId)
	select cast(value AS int)
	from STRING_SPLIT(@StudentIds, ',');

	insert into dbo.studentExam(ExamId, StudentId)
	select @ExamId, S.StudentId
	from @Students S
	join Student ST ON S.StudentId = ST.StudentId
	join Exam E ON E.ExamId = @ExamId
	where ST.IntakeId = E.IntakeId
		and ST.BranchId = E.BranchId
		and ST.TrackId = E.TrackId;

	select 'Valid students assigned successfully.';
end

--===========================================================
-- Assign Students and Schedule Exam
alter proc AssignStudentsAndScheduleExam
    @ExamId int,
    @StudentIds nvarchar(MAX),
    @ExamDate date,
    @StartTime datetime,
    @EndTime datetime
as
begin
    SET NOCOUNT ON;
    EXEC AssignValidStudentsToExam @ExamId, @StudentIds;
    EXEC SetExamSchedule @ExamId , @StartTime, @EndTime;

	select 'Students assigned and exam schedule set successfully.';
end
--===========================================================
-- Validate Exam Submission
create proc ValidateExamSubmission
	@ExamId int,
	@StudentId int
as
begin
	SET NOCOUNT ON;

	IF NOT EXISTS (
		SELECT 1
		FROM dbo.studentAnswer
		where ExamId = @ExamId and StudentId = @StudentId
	)
    
		select  'No answers submitted for this exam by the student.';

	select 'Exam submission validated successfully.';
end
--===========================================================
-- View Exam Details
create proc ViewExamDetails
    @ExamId int
as
begin
    set nocount on;

    select 
        q.QuestionId,
        q.QuestionText,
        q.QuestionType,
        qe.ExamId,
        sa.StudentId,
        sa.Answer,
        sa.MarksAwarded
    from 
        Question q
    join 
        QuestionExam qe on q.QuestionId = qe.QuestionId
    left join 
        StudentAnswer sa on q.QuestionId = sa.QuestionId
    where 
        qe.ExamId = @ExamId;

	select 'Exam details fetched successfully.';
end;

--==================================================
