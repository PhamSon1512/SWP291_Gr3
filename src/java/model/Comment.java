package model;

import java.sql.Timestamp;

public class Comment {
    private int commentId;
    private int postId;
    private int authorId; // ID of the user who made the comment
    private String content;
    private Timestamp createdAt;
   private String userName;
    // Constructors, getters, and setters
    public Comment() {}

    public Comment(int commentId, int postId, int authorId, String content, Timestamp createdAt, String userName) {
        this.commentId = commentId;
        this.postId = postId;
        this.authorId = authorId;
        this.content = content;
        this.createdAt = createdAt;
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    // Getters and setters
    // ...
    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
