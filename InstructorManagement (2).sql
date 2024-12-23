-- sp for add instructor
alter proc add_ins
	@fullName nvarchar(50),
	@email nvarchar (50),
	@phone nvarchar(30),
	@userName nvarchar (50),
	@password nvarchar (50),
	@role nvarchar (50)
as 
begin
	begin transaction;
		begin try
			insert into users (userName, password, role)
			values (@userName, @password, @role);

			declare @userID int = scope_identity();

			insert into instructor (fullName, email, phone, userID)
			values (@fullName, @Email, @Phone, @userID);

			commit transaction;
			select 'Instructor added successfully!' message;
		end try
		begin catch
			rollback transaction;
			select 'Error occurred while adding instructor.' message;
		end catch
end

--===============================================================
--sp for update instructor 
alter proc update_ins
	@fullName nvarchar(50),
	@email nvarchar (50),
	@instructorId int, 
	@phone nvarchar(30)
as 
begin
	begin transaction;
		begin try
			if not exists (select 1 from instructor where instructorID = @instructorId)
			begin
				select 'Instructor not found!' message;
				return;
			end

			update instructor
			set fullName = @fullName,
				email = @email,
				phone = @phone
			where instructorID = @instructorId;

			commit transaction;
			select 'Instructor updated successfully!' message;
		end try
		begin catch
			rollback transaction;
			select 'Error occurred while updating instructor.' message;
		end catch
end

--===============================================================
-- sp for delete instructor 
alter proc delete_ins 
	@instructorId int 
as 
begin
	begin transaction;
		begin try
			if not exists (select 1 from instructor where instructorID = @instructorId)
			begin
				select 'Instructor not found!' message;
				return;
			end

			if exists (select 1 from instructorCourse where instructorID = @instructorId)
			begin
				select 'Instructor is associated with courses and cannot be deleted.' message;
				return;
			end

			delete from instructor
			where instructorID = @instructorId

			commit transaction;
			select 'Instructor deleted successfully!' message;
		end try
		begin catch
			rollback transaction;
			select 'Error occurred while deleting instructor.' message;
		end catch
end

--===============================================================
-- sp for remove instructor from course
create proc remove_instructor_from_course
	@instructorId int,
	@courseId int
as
begin
	if not exists (select 1 from instructorCourse where instructorID = @instructorId and courseID = @courseId)
	begin
		select 'Instructor not assigned to this course.' message;
		return;
	end

	delete from instructorCourse
	where instructorID = @instructorId and courseID = @courseId;

	select 'Instructor removed from course successfully!' message;
end

--===============================================================
-- sp for get instructor
alter proc get_ins  
as 
begin
	select * from instructor;
end

--===============================================================
-- sp for get instructor by id
create proc get_instructor_by_id
    @instructorId int
as
begin
    select * from instructor where instructorID = @instructorId;
end

--===============================================================
-- sp for Assign Instructor to Course
create proc assign_instructor_to_course
    @instructorId int,
    @courseId int,
    @year int
as
begin
    if exists (select 1 from instructorCourse where instructorID = @instructorId and courseID = @courseId)
    begin
 	   select 'Instructor already assigned to this course.' message;
 	   return;
    end
 
    insert into instructorCourse (instructorID, courseID, year)
    values (@instructorId, @courseId, @year);

    select 'Instructor assigned to course successfully!' message;
end