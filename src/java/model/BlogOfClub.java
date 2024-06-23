/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class BlogOfClub {

    private int blog_id;
    private int club_id;
    private String title;
    private String imageBlog;
    private String content;

    public BlogOfClub() {
    }

    public BlogOfClub(int blog_id, int club_id, String title, String imageBlog, String content) {
        this.blog_id = blog_id;
        this.club_id = club_id;
        this.title = title;
        this.imageBlog = imageBlog;
        this.content = content;
    }

    public int getBlog_id() {
        return blog_id;
    }

    public void setBlog_id(int blog_id) {
        this.blog_id = blog_id;
    }

    public int getClub_id() {
        return club_id;
    }

    public void setClub_id(int club_id) {
        this.club_id = club_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageBlog() {
        return imageBlog;
    }

    public void setImageBlog(String imageBlog) {
        this.imageBlog = imageBlog;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    

}
