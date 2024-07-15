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
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Club;
import model.ClubMember;
import model.Department;

/**
 *
 * @author Admin
 */
public class ClubDBContext extends DBContext {

    private Connection conn;

    DBContext dbc = new DBContext();

    public ClubDBContext() {
        conn = dbc.getConnection();
    }

    public boolean updateMemberActiveStatus(int memberId, boolean newStatus) {
        String sql = "UPDATE club_member SET active_status = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, newStatus);
            stmt.setInt(2, memberId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, "Error updating member status", ex);
            return false;
        }
    }

    public List<Club> getAllClubs() {
        List<Club> list = new ArrayList<>();
        String sql = "SELECT club_id, code, name, category_id, description, status, imageUrl, numberPhone, facebook FROM club";

        try (PreparedStatement stm = conn.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Club club = new Club();
                club.setClub_id(rs.getInt("club_id"));
                club.setCode(rs.getString("code"));
                club.setName(rs.getString("name"));

                int categoryId = rs.getInt("category_id");
                if (rs.wasNull()) {
                    club.setCategory_id(0); // hoặc bất kỳ giá trị mặc định nào khác cho trường hợp của bạn
                } else {
                    club.setCategory_id(categoryId);
                }

                club.setDescription(rs.getString("description"));
                club.setStatus(rs.getBoolean("status"));
                club.setImageUrl(rs.getString("imageUrl"));
                club.setPhoneNumber(rs.getString("numberPhone"));
                club.setFacebook(rs.getString("facebook"));

                list.add(club);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Department> getDepartmentsByClubId(int clubId) {
        List<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM department WHERE club_id = ?";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clubId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Department dept = new Department();
                    dept.setDepartmentId(rs.getInt("department_id"));
                    dept.setName(rs.getString("name"));
                    dept.setDescription(rs.getString("description"));
                    dept.setClubId(rs.getInt("club_id"));
                    dept.setSpecialityId(rs.getInt("speciality_id"));

                    dept.setCurrentProjects(rs.getString("current_projects"));

                    dept.setRegularMeetingSchedule(rs.getString("regular_meeting_schedule"));
                    dept.setStatus(rs.getInt("status"));

                    departments.add(dept);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving departments: " + e.getMessage());
            e.printStackTrace();
        }

        return departments;
    }

    public int getTotalDistinctSpecialitiesByClubId(int clubId) {
        int totalSpecialities = 0;
        String sql = "SELECT COUNT(DISTINCT speciality_id) AS totalSpecialities FROM club_member WHERE club_id = ?";

        try (Connection conn = getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setInt(1, clubId);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    totalSpecialities = rs.getInt("totalSpecialities");
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return totalSpecialities;
    }

    public int getTotalMemberByClubId(int clubId) {
        int totalMembers = 0;
        try {
            String sql = "SELECT COUNT(*) AS total FROM club_member WHERE club_id = ?";
            Connection conn = getConnection(); // Assuming you have a method to get a database connection
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalMembers = rs.getInt("total");
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalMembers;
    }

    public String getEmailByStatus(int clubId, int status) {
        String email = null;
        String sql = "SELECT email FROM club_member WHERE club_id = ? AND status = ?";

        try (Connection conn = getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setInt(1, clubId);
            stm.setInt(2, status);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    email = rs.getString("email");
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return email;
    }

    public List<ClubMember> getClubMembersByClubId(int clubId) {
        List<ClubMember> list = new ArrayList<>();
        String sql = "SELECT cm.club_id, cm.user_id, cm.email, cm.speciality_id, cm.status, cm.active_status, u.full_name, u.user_name, u.avatar_url "
                + "FROM club_member cm "
                + "JOIN [user] u ON cm.user_id = u.user_id "
                + "WHERE cm.club_id = ?";
        try (PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, clubId);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    ClubMember member = new ClubMember();
                    member.setClub_id(rs.getInt("club_id"));
                    member.setUser_id(rs.getInt("user_id"));
                    member.setEmail(rs.getString("email"));
                    member.setSpeciality_id(rs.getInt("speciality_id"));
                    member.setStatus(rs.getBoolean("status"));
                    member.setActive_status(rs.getBoolean("active_status"));
                    // Set additional user details if needed
                    member.setFullName(rs.getString("full_name"));
                    member.setUserName(rs.getString("user_name"));
                    member.setImageUrl(rs.getString("avatar_url"));
                    list.add(member);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getClubIdByEmail(String email) {
        int clubId = -1; // Default value if not found
        String sql = "SELECT club_id FROM club_member WHERE email = ?";

        try (PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, email);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    clubId = rs.getInt("club_id");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return clubId;
    }

    public List<ClubMember> getAllClubMember() {
        List<ClubMember> list = new ArrayList<>();
        String sql = "SELECT club_id, user_id, email,speciality_id,status FROM club_member";

        try (PreparedStatement stm = conn.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                ClubMember club = new ClubMember();
                club.setClub_id(rs.getInt("club_id"));

                club.setUser_id(rs.getInt("user_id"));
                club.setEmail(rs.getString("email"));
                club.setSpeciality_id(rs.getInt("speciality_id"));
                club.setStatus(rs.getBoolean("status"));
                list.add(club);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Club> getClubNameByCategoryId(int categoryId) {
        List<Club> list = new ArrayList<>();
        try {
            String sql = "select name from club where club.category_id = ?";

            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, categoryId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Club club = new Club();
                club.setClub_id(rs.getInt("club_id"));
                club.setCode(rs.getString("code"));
                club.setName(rs.getString("name"));
                club.setDescription(rs.getString("description"));
                club.setStatus(rs.getBoolean("status"));
                club.setImageUrl(rs.getString("imageUrl"));

                club.setCategory_id(rs.getInt("category_id"));
                club.setPhoneNumber(rs.getString("numberPhone"));
                club.setFacebook(rs.getString("facebook"));
                list.add(club);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Club> getClubsByCategoryId(int categoryId) {
        List<Club> list = new ArrayList<>();
        try {
            String sql = "select * from club where club.category_id = ?";

            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, categoryId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Club club = new Club();
                club.setClub_id(rs.getInt("club_id"));
                club.setCode(rs.getString("code"));
                club.setName(rs.getString("name"));
                club.setDescription(rs.getString("description"));
                club.setStatus(rs.getBoolean("status"));
                club.setImageUrl(rs.getString("imageUrl"));

                club.setCategory_id(rs.getInt("category_id"));
                club.setPhoneNumber(rs.getString("numberPhone"));
                club.setFacebook(rs.getString("facebook"));
                list.add(club);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Club getClubById(int clubId) {
        Club club = null;
        String sql = "SELECT * FROM club WHERE club_id = ?";

        try (PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, clubId);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                club = new Club(); // Initialize the Club object

                club.setClub_id(rs.getInt("club_id"));
                club.setCode(rs.getString("code"));
                club.setName(rs.getString("name"));
                club.setDescription(rs.getString("description"));
                club.setStatus(rs.getBoolean("status"));
                club.setImageUrl(rs.getString("imageUrl"));
                club.setCategory_id(rs.getInt("category_id"));
                club.setPhoneNumber(rs.getString("numberPhone"));
                club.setFacebook(rs.getString("facebook"));

            } else {
                // Handle case where no club with given ID is found
                // You can throw an exception or return null based on your design
                // For simplicity, I'm returning null when no club is found.
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
            // Handle exception (log or rethrow as appropriate)
        }

        return club;
    }

    public List<Club> getProductsWithPagging(int page, int PAGE_SIZE) {
        List<Club> list = new ArrayList<>();
        try {
            String sql = "select *  from club order by club_id\n"
                    + "offset (?-1)*? row fetch next ? rows only";

            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, page);
            stm.setInt(2, PAGE_SIZE);
            stm.setInt(3, PAGE_SIZE);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Club club = new Club();
                club.setClub_id(rs.getInt(1));
                club.setCode(rs.getString(2));
                club.setName(rs.getString(3));

                club.setDescription(rs.getString(4));
                club.setStatus(rs.getBoolean(5));
                club.setImageUrl(rs.getString(6));
                club.setCategory_id(rs.getInt(7));

                list.add(club);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalClubs() {
        try {
            String sql = "select count(club_id)  from club ";

            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Club> search(String keyword) {
        List<Club> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM club WHERE LOWER(name) LIKE LOWER(?)";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + keyword + "%"); // Use wildcards for partial matching

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Club club = new Club();
                club.setClub_id(rs.getInt("club_id")); // Lấy club_id dưới dạng INT từ cột trong SQL
                club.setCode(rs.getString("code"));
                club.setName(rs.getString("name"));
                club.setDescription(rs.getString("description"));
                club.setStatus(rs.getBoolean("status"));
                club.setImageUrl(rs.getString("imageUrl")); // Lấy imageUrl dưới dạng STRING từ cột trong SQL
                club.setCategory_id(rs.getInt("category_id"));

                list.add(club);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void insertClub(String code, String name, String description, String imageUrl, int category_id, String phoneNumber, String facebook) {
        try {
            String sql = "INSERT INTO [club] (code, name, description, imageUrl, category_id, numberPhone, facebook) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, code);
            statement.setString(2, name);
            statement.setString(3, description);
            statement.setString(4, imageUrl);
            statement.setInt(5, category_id);
            statement.setString(6, phoneNumber);
            statement.setString(7, facebook);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkEmailAndClubId(String email, int clubId) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM club_member WHERE email = ? AND club_id = ?";

        try (PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, email);
            stm.setInt(2, clubId);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    exists = (count > 0);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, "Error checking email and club_id", ex);
        }

        return exists;
    }

    public List<ClubMember> searchClubMembers(String searchTerm) {
        List<ClubMember> result = new ArrayList<>();
        String sql = "SELECT cm.*, u.full_name, u.user_name, u.avatar_url "
                + "FROM club_member cm "
                + "JOIN [user] u ON cm.user_id = u.user_id "
                + "WHERE u.full_name LIKE ? OR u.user_name LIKE ? OR cm.email LIKE ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ClubMember member = new ClubMember();
                    member.setClub_id(rs.getInt("club_id"));
                    member.setUser_id(rs.getInt("user_id"));
                    member.setEmail(rs.getString("email"));
                    member.setSpeciality_id(rs.getInt("speciality_id"));
                    member.setStatus(rs.getBoolean("status"));
                    member.setActive_status(rs.getBoolean("active_status"));
                    member.setFullName(rs.getString("full_name"));
                    member.setUserName(rs.getString("user_name"));
                    member.setImageUrl(rs.getString("avatar_url"));
                    result.add(member);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClubDBContext.class.getName()).log(Level.SEVERE, "Error searching club members", ex);
        }

        return result;
    }

    public static void main(String[] args) {
        ClubDBContext dao = new ClubDBContext();
        

    }
}
