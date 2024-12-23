-- Add Question to Pool
create proc AddQuestionToPool
@CourseId int,
@QuestionType NVARCHAR(50), 
@QuestionText NVARCHAR(MAX)
as
begin
	SET NOCOUNT ON;

	insert into question(CourseId, QuestionType, QuestionText)
	values (@CourseId, @QuestionType, @QuestionText);

	select 'Question added successfully.' as message;
end

--=============================================
-- Update Question in Pool
alter proc UpdateQuestionInPool
@QuestionId int,
@QuestionText NVARCHAR(MAX)
as
begin
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT 1 FROM question where QuestionId = @QuestionId)
    begin
		select 'Question not found.' as message;
		RETURN;
    end

	update question
	set QuestionText = @QuestionText
	where QuestionId = @QuestionId;

	select 'Question updated successfully.' as message;
end

--======================================================
--sp to delete Question from Pool
create proc DeleteQuestionFromPool
@questionId int
as
begin
	SET NOCOUNT ON;
	if exists (select 1 from questionExam where questionID = @questionId)
	begin
		select 'cannot delete question as it is assigned to an exam' as message;
		return;
	end

	delete from question where questionID = @questionId;

	select 'Question deleted successfully.' as message;
end

--======================================================
--sp to add random questions
alter proc AddRandomQuestionsToExam
    @ExamId int,
    @CourseID int,
    @MCQCount int,             -- Number of MCQ questions
    @TrueFalseCount int,       -- Number of True/False questions
    @TextQuestionCount int,    -- Number of Text questions
	@mcqdegree decimal(5,2),
	@TrueFalse_degree decimal(5,2),
	@textdegree decimal(5,2)
as
begin
    -- Insert random MCQ questions and update degree
    insert into questionExam (examId, questionId)
    select top (@MCQCount) @ExamId, questionId
    from question
    where courseId = @CourseID and questionType = 'MCQ'
    order by newid();

    -- Update degrees for MCQ questions
    update Q
    set Q.degree = @mcqdegree -- Assign degree for MCQ, adjust as needed
    from question Q
    join questionExam QE on Q.questionId = QE.questionId
    where QE.examId = @ExamId and Q.questionType = 'MCQ';

    -- Insert random True/False questions and update degree
    insert into questionExam (examId, questionId)
    select top (@TrueFalseCount) @ExamId, questionId
    from question
    where courseId = @CourseID and questionType = 'True/False'
    order by newid();

    -- Update degrees for True/False questions
    update Q
    set Q.degree = @TrueFalse_degree -- Assign degree for True/False, adjust as needed
    from question Q
    join questionExam QE on Q.questionId = QE.questionId
    where QE.examId = @ExamId and Q.questionType = 'True/False';

    -- Insert random Text questions and update degree
    insert into questionExam (examId, questionId)
    select top (@TextQuestionCount) @ExamId, questionId
    from question
    where courseId = @CourseID and questionType = 'Text' 
    order by newid();

    -- Update degrees for Text questions
    update Q
    set Q.degree = @textdegree -- Assign degree for Text, adjust as needed
    from question Q
    join questionExam QE on Q.questionId = QE.questionId
    where QE.examId = @ExamId and Q.questionType = 'Text';
end;

--======================================================
-- sp to an exam(Manual select)
alter proc AddManualQuestion
    @ExamID int,
    @MCQIds nvarchar(max),             -- Comma-separated Question IDs for MCQ
    @TrueFalseIds nvarchar(max),       -- Comma-separated Question IDs for True/False
    @TextQuestionIds nvarchar(max),    -- Comma-separated Question IDs for Text
    @MCQDegree decimal(5,2),           -- Degree for MCQ questions
    @TrueFalseDegree decimal(5,2),     -- Degree for True/False questions
    @TextDegree decimal(5,2)           -- Degree for Text questions
as
begin
    -- Insert and update degree for MCQ questions
    insert into questionExam (ExamId, QuestionId)
    select 
        @ExamID, 
        value AS QuestionId 
    from 
        STRING_SPLIT(@MCQIds, ',') 
    where 
        value in (select questionId from question where questionType = 'MCQ'); -- Ensure valid MCQ questions

    -- Update degree for MCQ questions
    update Q
    set Q.degree = @MCQDegree -- Assign degree for MCQ questions
    from question Q
    join questionExam QE on Q.questionId = QE.questionId
    where QE.examId = @ExamID
    and Q.questionType = 'MCQ';

    -- Insert and update degree for True/False questions
    insert into questionExam (ExamId, QuestionId)
    select 
        @ExamID, 
        value AS QuestionId 
    from 
        STRING_SPLIT(@TrueFalseIds, ',') 
    where 
        value in (select questionId from question where questionType = 'True/False'); -- Ensure valid True/False questions

    -- Update degree for True/False questions
    update Q
    set Q.degree = @TrueFalseDegree -- Assign degree for True/False questions
    from question Q
    join questionExam QE on Q.questionId = QE.questionId
    where QE.examId = @ExamID
    and Q.questionType = 'True/False';

    -- Insert and update degree for Text questions
    insert into questionExam (ExamId, QuestionId)
    select 
        @ExamID, 
        value AS QuestionId 
    from 
        STRING_SPLIT(@TextQuestionIds, ',') 
    where 
        value in (select questionId from question where questionType = 'Text'); -- Ensure valid Text questions

    -- Update degree for Text questions
    update Q
    set Q.degree = @TextDegree -- Assign degree for Text questions
    from question Q
    join questionExam QE on Q.questionId = QE.questionId
    where QE.examId = @ExamID
    and Q.questionType = 'Text';

end;

--======================================================
-- Add or Select Questions to Exam
alter proc AddOrSelectQuestionsToExam
    @ExamId int,
    @SelectionType nvarchar(10),       -- 'Manual' or 'Random'
    @MCQIds nvarchar(max) = null,      -- Comma-separated Question IDs for MCQ (manual)
    @TrueFalseIds nvarchar(max) = null,-- Comma-separated Question IDs for True/False (manual)
    @TextQuestionIds nvarchar(max) = null, -- Comma-separated Question IDs for Text (manual)
    @MCQCount int = null,              -- Number of MCQ questions (random)
    @TrueFalseCount int = null,        -- Number of True/False questions (random)
    @TextCount int = null,             -- Number of Text questions (random)
    @MCQDegree decimal(5,2) = null,    -- Degree for MCQ questions
    @TrueFalseDegree decimal(5,2) = null, -- Degree for True/False questions
    @TextDegree decimal(5,2) = null    -- Degree for Text questions
as
begin
    set nocount on;

    -- If the selection type is 'Manual'
    if @SelectionType = 'Manual'
    begin
        -- Call the AddManualQuestion procedure
        exec AddManualQuestion 
            @ExamID = @ExamId,                 -- Pass the exam ID
            @MCQIds = @MCQIds,                 -- Pass comma-separated MCQ question IDs
            @TrueFalseIds = @TrueFalseIds,     -- Pass comma-separated True/False question IDs
            @TextQuestionIds = @TextQuestionIds, -- Pass comma-separated Text question IDs
            @MCQDegree = @MCQDegree,           -- Degree for MCQ questions
            @TrueFalseDegree = @TrueFalseDegree, -- Degree for True/False questions
            @TextDegree = @TextDegree;         -- Degree for Text questions
    end

    -- If the selection type is 'Random'
    else if @SelectionType = 'Random'
    begin
        -- Call the AddRandomQuestionsToExam procedure
        exec AddRandomQuestionsToExam 
            @ExamId = @ExamId,                 -- Pass the exam ID
            @CourseID = null,                  -- Ensure CourseID is defined if needed
            @MCQCount = @MCQCount,             -- Number of MCQ questions
            @TrueFalseCount = @TrueFalseCount, -- Number of True/False questions
            @TextQuestionCount = @TextCount,   -- Number of Text questions
            @mcqdegree = @MCQDegree,           -- Degree for MCQ questions
            @TrueFalse_degree = @TrueFalseDegree, -- Degree for True/False questions
            @textdegree = @TextDegree;         -- Degree for Text questions
    end
end;
