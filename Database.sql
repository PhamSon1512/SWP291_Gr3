create database ClubManagement
GO

USE ClubManagement;
GO

-- Bảng 'setting'
CREATE TABLE setting (
    setting_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255),
    type NVARCHAR(50),
    description NVARCHAR(MAX),
    status TINYINT
);
GO

-- Bảng 'user'
CREATE TABLE [user] (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(255) NOT NULL,
    user_name NVARCHAR(255) UNIQUE,
    email NVARCHAR(255) NOT NULL UNIQUE,
    phone_number NVARCHAR(20) NOT NULL, 
    password NVARCHAR(255) NOT NULL,
    avatar_url NVARCHAR(255),
    setting_id INT,
    status TINYINT,
    note NVARCHAR(MAX),
    FOREIGN KEY (setting_id) REFERENCES setting(setting_id)
);
GO

-- Bảng 'club'
CREATE TABLE club (
    club_id INT IDENTITY(1,1) PRIMARY KEY,
    code NVARCHAR(50) NOT NULL UNIQUE,
    name NVARCHAR(255) NOT NULL,
    category_id INT,
    description NVARCHAR(MAX),
    status TINYINT,
    FOREIGN KEY (category_id) REFERENCES setting(setting_id)
);
GO

-- Bảng 'club_member'
CREATE TABLE club_member (
    club_id INT,
    user_id INT,
    speciality_id INT,
    request_note NVARCHAR(MAX),
    status TINYINT,
    PRIMARY KEY (club_id, user_id, speciality_id),
    FOREIGN KEY (club_id) REFERENCES club(club_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id)
);
GO

-- Bảng 'event'
CREATE TABLE [event] (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    club_id INT,
    user_id INT,
    FOREIGN KEY (club_id) REFERENCES club(club_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id)
);
GO

-- Bảng 'task'
CREATE TABLE task (
    task_id INT IDENTITY(1,1) PRIMARY KEY,
    event_id INT,
    club_id INT,
    assigner_id INT,
    assignee_id INT,
    FOREIGN KEY (event_id) REFERENCES event(event_id),
    FOREIGN KEY (club_id) REFERENCES club(club_id),
    FOREIGN KEY (assigner_id) REFERENCES [user](user_id),
    FOREIGN KEY (assignee_id) REFERENCES [user](user_id)
);
GO

-- Bảng 'post'
CREATE TABLE post (
    post_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    thumnail_url NVARCHAR(255),
    content NVARCHAR(MAX),
    status TINYINT
);
GO

-- Bảng 'post_category'
CREATE TABLE post_category (
    post_id INT,
    setting_id INT,
    PRIMARY KEY (post_id, setting_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (setting_id) REFERENCES setting(setting_id)
);
GO

-- Bảng 'blog'
CREATE TABLE blog (
    blog_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    thumnail_url NVARCHAR(255),
    content NVARCHAR(MAX),
    status TINYINT
);
GO

-- Bảng 'blog_category'
CREATE TABLE blog_category (
    blog_id INT,
    setting_id INT,
    PRIMARY KEY (blog_id, setting_id),
    FOREIGN KEY (blog_id) REFERENCES blog(blog_id),
    FOREIGN KEY (setting_id) REFERENCES setting(setting_id)
);
GO

-- Bảng 'contact'
CREATE TABLE contact (
    contact_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,
    title NVARCHAR(255),
    message NVARCHAR(MAX) NOT NULL,
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES setting(setting_id)
);
GO
