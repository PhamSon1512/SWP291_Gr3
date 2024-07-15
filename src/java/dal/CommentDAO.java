package dal;

import context.DBContext;
import model.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CommentDAO extends DBContext {
    public void insertComment(int postId, int authorId, String content) {
        String sql = "INSERT INTO comment (post_id, user_id, content, created_at) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, authorId);
            stmt.setString(3, content);
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, "Error inserting comment", ex);
        }
    }

    public List<Comment> getCommentsByPostId(int postId) {
    List<Comment> comments = new ArrayList<>();
    String sql = "SELECT c.comment_id, c.post_id, c.user_id, c.content, c.created_at, u.user_name " +
                 "FROM comment c " +
                 "JOIN [user] u ON c.user_id = u.user_id " +
                 "WHERE c.post_id = ?";
    try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, postId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPostId(rs.getInt("post_id"));
                comment.setAuthorId(rs.getInt("user_id"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getTimestamp("created_at"));
                comment.setUserName(rs.getString("user_name"));
                comments.add(comment);
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, "Error retrieving comments", ex);
    }
    return comments;
}
    public static void main(String[] args) {
        CommentDAO dao = new CommentDAO();
        dao.getCommentsByPostId(9);
    }

}
