-- Start Exam
create proc StartExam
    @ExamId int,
    @StudentId int
as
begin
    set nocount on;

    declare @AllowanceOptions nvarchar(max);

    select @AllowanceOptions = allowanceOption
    from Exam
    where examID = @ExamId;

    if @AllowanceOptions is not null
    begin
        print 'You are now starting your exam. Here are your allowances:';
        print @AllowanceOptions;
    end
    else
    begin
        raiserror('No allowances found for this exam.', 16, 1);
    end;
end;

--=========================================================================
--stored procedure to get Exam Questions
create proc GetExamQuestions
    @ExamId int,
    @StudentId int
as
begin
    set nocount on;
    select 
        q.QuestionId,
        q.QuestionText,
        q.QuestionType,            -- Type of question (MCQ, True/False, Text)
        mcq.Option1 as MCQ_Option1, -- MCQ-specific options
        mcq.Option2 as MCQ_Option2,
        mcq.Option3 as MCQ_Option3,
        mcq.Option4 as MCQ_Option4,
        null as TrueFalse_Answer,  -- Placeholder for True/False
        null as Text_Input         -- Placeholder for Text questions
    from 
        questionExam qe
    join 
        question q on qe.QuestionId = q.QuestionId
    left join 
        MCQ_Question mcq on q.QuestionId = mcq.QuestionId 
    where 
        qe.ExamId = @ExamId;

    print 'Questions displayed successfully for the exam.';
end;

--==================================================
-- Insert Student Answer
create proc InsertStudentAnswer
    @ExamId int,
    @StudentId int,
    @QuestionId int,
    @Answer nvarchar(max) -- Student's answer (supports text for all types)
as
begin
    set nocount on;

    insert into StudentAnswer (ExamId, StudentId, QuestionId, Answer)
    values (@ExamId, @StudentId, @QuestionId, @Answer);

    print 'Answer recorded successfully.';
end;

--======================================================
