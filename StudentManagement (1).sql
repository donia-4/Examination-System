--triggers when a training manager adds a new student 
create trigger trg_ValidateStudentInsert
on student
after insert
as
begin
    if exists (
        select 1
        from vw_StudentDetails v
        join inserted i on v.studentID = i.studentID
        where v.BranchID is null
           or v.trackID is null
           or v.IntakeID is null
    )
    begin
        select 'Invalid branch, track, or intake assignment for the student.' as message;
        rollback transaction;
    end
end;

--==================================================================
-- Add or Edit Branch
alter proc sp_add_or_edit_branch
    @branchID int = NULL,
    @branchName nvarchar(100),
    @trainingManagerID int
as
begin
	set nocount on;

    if @branchID is null
    begin
        -- Insert new branch
        insert into branch (branchName, trainingManagerID)
        values (@branchName, @trainingManagerID);
		select 'New branch added successfully!' as message;
    end
    else
    begin
        -- Update existing branch
        update branch
        set branchName = @branchName,
            trainingManagerID = @trainingManagerID
        where branchID = @branchID;
		select 'Branch updated successfully!' as message;
    end
end;

--==================================================================
-- Add or Edit Track
alter proc sp_add_or_edit_track
    @trackID int = NULL,
    @trackName nvarchar(100),
    @intakeID int,
    @branchID int,
	@trainingManagerID int
as
begin
	set nocount on;

	if not exists (select 1 from branch where branchID = @branchID)
    begin
        select 'Invalid Branch ID.' message;
        return;
    end

    if not exists (select 1 from intake where intakeID = @intakeID)
    begin
		select 'Invalid Intake ID.' message;
        return;
    end

    if @trackID is null
    begin
        -- Insert new track
        insert into track (trackName, intakeID, branchID, trainingManagerID)
        values (@trackName, @intakeID, @branchID, @trainingManagerID);
		select 'New track added successfully!' as message;
    end
    else
    begin
        -- Update existing track
        update track
        set trackName = @trackName,
            intakeID = @intakeID,
            branchID = @branchID,
			trainingManagerID = @trainingManagerID
        where trackID = @trackID;
		select 'Track updated successfully!' as message;
    end
end;

--==================================================================
-- Add or Edit Intake
alter proc sp_add_or_edit_intake
    @intakeID int = NULL,
    @intakeYear int,
	@trainingManagerID int,
	@trackID INT = NULL
as
begin
	set nocount on;

    if @intakeID is null
    begin
        -- Insert new intake
        insert into intake (intakeYear, trainingManagerID)
        values (@intakeYear, @trainingManagerID );
        -- Get the newly generated intakeID (assuming it's an IDENTITY column)
        set @intakeID = scope_identity();
		select 'New intake added successfully!' as message;
    end
    else
    begin
        -- Update existing intake
        update intake
        set intakeYear = @intakeYear
        where intakeID = @intakeID;
		select 'Intake updated successfully!' as message;
    end
    -- Update the related track entry to link it to the new or updated intake
    if @trackID is not NULL
    begin
        update track
        set intakeID = @intakeID
        where trackID = @trackID;

        select 'Track updated with the new intake.' as message;
    end
end;

--==================================================================
-- Add or Edit Student
alter proc sp_add_or_edit_student
    @studentID int = NULL,
    @fullName nvarchar(100),
    @email nvarchar(100),
    @phone nvarchar(100),
    @branchID int,
    @trackID int,
    @intakeID int,
    @username nvarchar(100),      
    @password nvarchar(100),           
    @role nvarchar(50) = 'Student',
    @trainingManagerID int = NULL
as
begin
    SET NOCOUNT ON;
    begin transaction;
    begin try
        -- Validate Inputs
        if not exists (select 1 from branch where branchID = @branchID)
        begin
            rollback transaction;
            select 'Invalid Branch ID.' as message;
            return;
        end

        if not exists (select 1 from track where trackID = @trackID)
        begin
            rollback transaction;
            select 'Invalid Track ID.' as message;
            return;
        end

        if not exists (select 1 from intake where intakeID = @intakeID)
        begin
            rollback transaction;
            select 'Invalid Intake ID.' as message;
            return;
        end

        --  Get or Create User
        declare @userID int;
        select @userID = userID from users where username = @username;

        if @userID is null
        begin
            -- Insert a new user account
            insert into users (username, password, role)
            values (@username, @password, @role);

            set @userID = scope_identity();
        end

        -- Add or Update Student
        if @studentID is null
        begin
            -- Insert new student
            insert into student (fullName, email, phone, userID, branchID, trackID, intakeID, trainingManagerID)
            values (@fullName, @email, @phone, @userID, @branchID, @trackID, @intakeID, @trainingManagerID);

            select 'New student and user account added successfully!' as message;
        end
        else
        begin
            -- Update existing student
            update student
            set fullName = @fullName,
                email = @email,
                phone = @phone,
                userID = @userID,
                branchID = @branchID,
                trackID = @trackID,
                intakeID = @intakeID,
                trainingManagerID = @trainingManagerID
            where studentID = @studentID;

            select 'Student and user account updated successfully!' as message;
        end

        -- Commit Transaction
        commit transaction;
    end try
    begin catch
        rollback transaction;

        -- Return Error Details
        select ERROR_MESSAGE() as error_message, ERROR_NUMBER() as error_number, ERROR_SEVERITY() as error_severity;
    end catch
end;

--==================================================================
-- Add or delete Student
create proc sp_delete_student
    @studentID int
as
begin
    if not exists (select 1 from student where studentID = @studentID)
    begin
        select 'Invalid Student ID.' as message;
        return;
    end
    
    delete from student where studentID = @studentID;
    select 'Student deleted successfully!' as message;
end;
