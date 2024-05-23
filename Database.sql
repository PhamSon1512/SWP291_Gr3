create database ClubManagement;
go

use ClubManagement;
go

-- Bảng account
CREATE TABLE account (
    acc_ID INT IDENTITY(1,1) PRIMARY KEY,
    name nvarchar(50) not null,
    email VARCHAR(35) NOT NULL,
    phone_number VARCHAR(11) NULL,
    password VARCHAR(255) NOT NULL, -- Lưu mật khẩu đã mã hóa
    avatar_url NVARCHAR(255) NULL,
    role_id INT NOT NULL,
    acc_status INT NOT NULL -- 0: unvalidated, 1: active, 2: deactive
);
GO

-- Bảng role
CREATE TABLE [role] (
    role_ID INT IDENTITY(1,1) PRIMARY KEY,
    role_name VARCHAR(15) NOT NULL,
    role_status INT NOT NULL -- 0: user, 1: admin
);
GO

-- Bảng post
CREATE TABLE post (
    post_ID INT IDENTITY(1,1) PRIMARY KEY,
    p_title NVARCHAR(50) NOT NULL,
    p_content NVARCHAR(1000) NOT NULL,
    account_ID INT NOT NULL,
    FOREIGN KEY (account_ID) REFERENCES account(acc_ID)
);
GO

-- Bảng club
CREATE TABLE club (
    club_ID INT IDENTITY(1,1) PRIMARY KEY,
    club_name VARCHAR(35) NOT NULL,
    club_status VARCHAR(20) NOT NULL,
    club_image VARCHAR(50)
);
GO

-- Bảng blog
CREATE TABLE blog (
    blog_ID INT IDENTITY(1,1) PRIMARY KEY,
    b_title NVARCHAR(50) NOT NULL,
    b_content NVARCHAR(1000) NOT NULL,
    club_ID INT NOT NULL,
    FOREIGN KEY (club_ID) REFERENCES club(club_ID)
);
GO

-- Bảng contact
CREATE TABLE contact (
    contact_ID INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(35) NOT NULL,
    email VARCHAR(35) NOT NULL,
    phone VARCHAR(11) NOT NULL,
    [subject] NVARCHAR(50) NOT NULL,
    [message] NVARCHAR(1000) NOT NULL
);
GO

-- Bảng student_club
CREATE TABLE student_club (
    student_club_ID INT IDENTITY(1,1) PRIMARY KEY,
    account_ID INT NOT NULL,
    club_ID INT NOT NULL,
    r_ID INT NOT NULL,
    FOREIGN KEY (account_ID) REFERENCES account(acc_ID),
    FOREIGN KEY (club_ID) REFERENCES club(club_ID),
    FOREIGN KEY (r_ID) REFERENCES [role](role_ID)
);
GO

-- Bảng student_role_club
CREATE TABLE student_role_club (
    sc_ID INT IDENTITY(1,1) PRIMARY KEY,
    sc_name NVARCHAR(35)
);
GO

-- Thủ tục lưu trữ để thêm tài khoản với mật khẩu được mã hóa
CREATE PROCEDURE AddAccount
    @name NVARCHAR(35),
    @email VARCHAR(35),
    @phone_number VARCHAR(11),
    @password NVARCHAR(255), -- Sử dụng NVARCHAR cho mật khẩu gốc
    @avatar_url NVARCHAR(255),
    @role_id INT,
    @acc_status INT
AS
BEGIN
    DECLARE @hashed_password VARBINARY(255);
    
    -- Mã hóa mật khẩu sử dụng SHA2_256
    SET @hashed_password = HASHBYTES('SHA2_256', @password);

    -- Thêm tài khoản vào bảng
    INSERT INTO account (name, email, phone_number, password, avatar_url, role_id, acc_status)
    VALUES (@name, @email, @phone_number, @hashed_password, @avatar_url, @role_id, @acc_status);
END;
GO