package model;

import java.sql.Timestamp;

public class Post {

    private int postId;
    private String title;
    private String thumnailUrl;
    private String content;
    private int status;
    private int authorId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String userName;

    public Post() {
    }

    public Post(int postId, String title, String thumnailUrl, String content, int status, int authorId, Timestamp createdAt, Timestamp updatedAt, String userName) {
        this.postId = postId;
        this.title = title;
        this.thumnailUrl = thumnailUrl;
        this.content = content;
        this.status = status;
        this.authorId = authorId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // Getter và Setter cho các thuộc tính
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumnailUrl() {
        return thumnailUrl;
    }

    public void setThumnailUrl(String thumbnailUrl) {
        this.thumnailUrl = thumbnailUrl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
