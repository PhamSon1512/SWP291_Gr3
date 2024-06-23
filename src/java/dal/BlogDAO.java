/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author FANCY
 */
import model.Blog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.BlogOfClub;

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

  public List<BlogOfClub> getBlogByClubId(int club_id) {
    List<BlogOfClub> list = new ArrayList<>();
    String sql = "select blog_id, club_id, title, imageBlog, content from blogofclub WHERE club_id = ?";
    try {
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, club_id);
        ResultSet rs = ps.executeQuery();

       while (rs.next()) {
            BlogOfClub blog = new BlogOfClub();
            blog.setBlog_id(rs.getInt("blog_id"));
            blog.setClub_id(rs.getInt("club_id"));
           blog.setTitle(rs.getString("title"));
           blog.setImageBlog(rs.getString("imageBlog"));
            blog.setContent(rs.getString("content"));
            list.add(blog); // Add each blog to the list
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Print the exception (you can log it instead)
    }
    return list;
}


   
}
