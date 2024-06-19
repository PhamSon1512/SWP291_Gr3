/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author FANCY
 */
import context.DBContext;
import model.Blog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {

    private Connection conn;

    public BlogDAO() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            this.conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=ClubManagement", "sa", "123");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Blog> getAllBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT blog_id, title, thumnail_url, content, status FROM blog WHERE status = '1'";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setThumbnailUrl(rs.getString("thumnail_url"));
                blog.setContent(rs.getString("content"));
                blog.setStatus(rs.getString("status"));
                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blogs;
    }

    public Blog getBlogById(int blogId) {
        Blog blog = null;
        String sql = "SELECT blog_id, title, thumnail_url, content, status FROM blog WHERE blog_id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, blogId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setThumbnailUrl(rs.getString("thumnail_url"));
                blog.setContent(rs.getString("content"));
                blog.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blog;
    }

//      public Blog getBlogById(int blogId) {
//        Blog blog = null;
//        String query = "SELECT * FROM blogs WHERE blog_id = ?";
//        try (Connection con = new DBContext().getConnection();
//             PreparedStatement ps = con.prepareStatement(query)) {
//            ps.setInt(1, blogId);
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    blog = new Blog();
//                    blog.setBlogId(rs.getInt("blog_id"));
//                    blog.setTitle(rs.getString("title"));
//                    blog.setThumbnailUrl(rs.getString("thumbnail_url"));
//                    blog.setContent(rs.getString("content"));
//                    blog.setStatus(rs.getString("status"));
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return blog;
//    }
    public List<Blog> getRelatedBlogs(int blogId) {
        List<Blog> relatedBlogs = new ArrayList<>();
        String query = "SELECT * FROM blogs WHERE id != ? LIMIT 3";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, blogId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setThumbnailUrl(rs.getString("thumbnail_url"));
                    blog.setContent(rs.getString("content"));
                    relatedBlogs.add(blog);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return relatedBlogs;
    }

}
