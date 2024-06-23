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
import model.Club;

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

    public List<Club> getAllClubs() {
        List<Club> list = new ArrayList<>();
        String sql = "SELECT club_id, code, name, description, status, imageUrl, category_id FROM club";

        try (PreparedStatement stm = conn.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Club club = new Club();
                club.setClub_id(rs.getInt("club_id"));
                club.setCode(rs.getString("code"));
                club.setName(rs.getString("name"));
                club.setDescription(rs.getString("description"));
                club.setStatus(rs.getBoolean("status"));
                club.setImageUrl(rs.getString("imageUrl"));

                int categoryId = rs.getInt("category_id");
                if (rs.wasNull()) {
                    club.setCategory_id(0); // or any other default value for your use case
                } else {
                    club.setCategory_id(categoryId);
                }

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
            String sql = "SELECT * FROM club WHERE LOWER(name) = LOWER(?)";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, keyword);

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

    public static void main(String[] args) {
        ClubDBContext dao = new ClubDBContext();
        System.out.println(dao.getAllClubs());
        System.out.println(dao.getClubsByCategoryId(3));
    }

}
