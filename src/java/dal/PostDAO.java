/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;

/**
 * PostDAO class for managing database operations related to posts.
 */
public class PostDAO extends DBContext {

    private Connection conn;

    DBContext dbc = new DBContext();

    public PostDAO() {
        conn = dbc.getConnection();
    }

    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.post_id, p.title, p.thumnail_Url, p.content, p.author_id, p.created_at, p.updated_at, u.user_name "
                + "FROM post p "
                + "JOIN [user] u ON p.author_id = u.user_id "
                + "ORDER BY p.created_at DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setThumnailUrl(rs.getString("thumnail_Url"));
                post.setContent(rs.getString("content"));
                post.setAuthorId(rs.getInt("author_id"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setUpdatedAt(rs.getTimestamp("updated_at"));
                post.setUserName(rs.getString("user_name")); // Assuming you have this setter in your Post class
                posts.add(post);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error retrieving all posts", ex);
        }
        return posts;
    }

    public Post getPostById(int postId) {
        Post post = null;
        String sql = "SELECT p.post_id, p.title, p.thumnail_Url, p.content, p.author_id, p.created_at, p.updated_at, u.user_name "
                + "FROM post p "
                + "JOIN [user] u ON p.author_id = u.user_id "
                + "WHERE p.post_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    post = new Post();
                    post.setPostId(rs.getInt("post_id"));
                    post.setTitle(rs.getString("title"));
                    post.setThumnailUrl(rs.getString("thumnail_Url"));
                    post.setContent(rs.getString("content"));
                    post.setAuthorId(rs.getInt("author_id"));
                    post.setCreatedAt(rs.getTimestamp("created_at"));
                    post.setUpdatedAt(rs.getTimestamp("updated_at"));
                    post.setUserName(rs.getString("user_name")); // Add this line to set the user name
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error retrieving post by ID", ex);
        }
        return post;
    }

    public void insertPost(String title, String thumbnailUrl, String content, int authorId) {
        String sql = "INSERT INTO post (title, thumnail_url, content, author_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Set values in the PreparedStatement
            stmt.setString(1, title);
            stmt.setString(2, thumbnailUrl);
            stmt.setString(3, content);
            stmt.setInt(4, authorId);

            // Execute the update
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // Print stack trace for debugging
        }
    }

    public boolean updatePost(Post post) {
        String sql = "UPDATE post SET title = ?, content = ?, author_id = ?, created_at = ?, updated_at = ? WHERE post_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setInt(3, post.getAuthorId());
            stmt.setTimestamp(4, post.getCreatedAt());
            stmt.setTimestamp(5, post.getUpdatedAt());
            stmt.setInt(6, post.getPostId());
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error updating post", ex);
            return false;
        }
    }

    public boolean deletePost(int postId) {
        String sql = "DELETE FROM post WHERE post_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error deleting post", ex);
            return false;
        }
    }

    public List<Post> searchPosts(String keyword) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT post_id, title, content, author_id, created_at, updated_at FROM post WHERE LOWER(title) LIKE LOWER(?) OR LOWER(content) LIKE LOWER(?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setPostId(rs.getInt("post_id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setAuthorId(rs.getInt("author_id"));
                    post.setCreatedAt(rs.getTimestamp("created_at"));
                    post.setUpdatedAt(rs.getTimestamp("updated_at"));
                    posts.add(post);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error searching posts", ex);
        }
        return posts;
    }

    public static void main(String[] args) {
        PostDAO postDAO = new PostDAO();
        postDAO.getAllPosts();

        // Create a new Post object
    }
}
