package dal;

import context.DBContext;
import model.ClubRegistration;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Club;

public class ClubRegistrationDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbc = new DBContext();
    Connection connection = null;

    // Constructor to initialize connection
    public ClubRegistrationDAO() {
        connection = dbc.getConnection();
    }

    public void insertRegistration(int clubId, String name, String email, String purpose, String committees, String description) {
        String sql = "INSERT INTO club_registration (club_id, name, email, purpose, committees, description) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, clubId);
            statement.setString(2, name);
            statement.setString(3, email);
            statement.setString(4, purpose);
            statement.setString(5, committees);
            statement.setString(6, description);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ClubRegistration> getPendingRegistrations(int clubId) {
        List<ClubRegistration> registrations = new ArrayList<>();
        String sql = "SELECT * FROM club_registration WHERE status = 'pending' AND club_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, clubId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ClubRegistration registration = new ClubRegistration();
                registration.setId(rs.getInt("registration_id"));
                registration.setClubId(rs.getInt("club_id"));
                registration.setName(rs.getString("name"));
                registration.setEmail(rs.getString("email"));
                registration.setPurpose(rs.getString("purpose"));
                registration.setCommittees(rs.getString("committees"));
                registration.setDescription(rs.getString("description"));
                registration.setStatus(rs.getString("status"));
                registration.setCreatedAt(rs.getTimestamp("created_at"));
                registrations.add(registration);
            }
            // Check if no records found
            if (registrations.isEmpty()) {
                System.out.println("No pending registrations found for club_id: " + clubId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return registrations;
    }

    public String createViewToken(int clubId) {
        String token = generateToken(); // Implement this method to generate a unique token
        LocalDateTime expirationTime = LocalDateTime.now().plusHours(24);
        String sql = "INSERT INTO view_tokens (token, club_id, expiration_time) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);
            statement.setInt(2, clubId);
            statement.setTimestamp(3, Timestamp.valueOf(expirationTime));
            int affectedRows = statement.executeUpdate();
            if (affectedRows > 0) {
                return token;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isValidToken(String token, int clubId) {
        String sql = "SELECT * FROM view_tokens WHERE token = ? AND club_id = ? AND expiration_time > ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);
            statement.setInt(2, clubId);
            statement.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            ResultSet rs = statement.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void cleanupExpiredTokens() {
        String sql = "DELETE FROM view_tokens WHERE expiration_time <= ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String generateToken() {
        // Implement a method to generate a unique token
        // For example, you could use java.util.UUID.randomUUID().toString()
        return java.util.UUID.randomUUID().toString();
    }

    public int getClubIdFromToken(String token) {
        String sql = "SELECT club_id FROM view_tokens WHERE token = ? AND expiration_time > ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);
            statement.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("club_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Trả về -1 nếu không tìm thấy token hợp lệ
    }

    public ClubRegistration getRegistrationById(int id) {
        String sql = "SELECT * FROM club_registration WHERE registration_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                ClubRegistration registration = new ClubRegistration();
                registration.setId(rs.getInt("registration_id"));
                registration.setClubId(rs.getInt("club_id"));
                registration.setName(rs.getString("name"));
                registration.setEmail(rs.getString("email"));
                registration.setPurpose(rs.getString("purpose"));
                registration.setCommittees(rs.getString("committees"));
                registration.setDescription(rs.getString("description"));
                registration.setStatus(rs.getString("status"));
                registration.setCreatedAt(rs.getTimestamp("created_at"));
                return registration;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no registration found
    }

    public void updateRegistrationStatus(int id, String status) {
        String sql = "UPDATE club_registration SET status = ? WHERE registration_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ClubRegistration> getListByPage(List<ClubRegistration> list, int start, int end) {
        ArrayList<ClubRegistration> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<ClubRegistration> getAllRegistrations() {
        List<ClubRegistration> registrations = new ArrayList<>();
        String sql = "SELECT * FROM club_registration";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ClubRegistration registration = new ClubRegistration();
                registration.setId(rs.getInt("registration_id"));
                registration.setClubId(rs.getInt("club_id"));
                registration.setName(rs.getString("name"));
                registration.setEmail(rs.getString("email"));
                registration.setPurpose(rs.getString("purpose"));
                registration.setCommittees(rs.getString("committees"));
                registration.setDescription(rs.getString("description"));
                registration.setStatus(rs.getString("status"));
                registration.setCreatedAt(rs.getTimestamp("created_at"));
                registrations.add(registration);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return registrations;
    }

    public void addMemberToClub(int clubId, String email, String committees, int status) {
        String sql = "INSERT INTO club_member (club_id, user_id, email, speciality_id, status) "
                + "SELECT ?, user_id, ?, ?, ? FROM [user] WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, clubId);
            stmt.setString(2, email);
            stmt.setInt(3, getSpecialityIdFromCommittees(committees));
            stmt.setInt(4, status);
            stmt.setString(5, email);
            stmt.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ClubRegistrationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private int getSpecialityIdFromCommittees(String committees) {
        // Map committees to speciality_id based on your requirements
        switch (committees) {
            case "Ban Chủ Nhiệm":
                return 1;
            case "Ban Chuyen Mon":
                return 2;
            case "Ban Van Hoa":
                return 3;
            case "Ban Truyen Thong":
                return 4;
            case "Ban Hau Can":
                return 5;
            case "Ban Noi Dung":
                return 6;
            default:
                return 0; // Default value or handle unknown committees
        }
    }

    public static void main(String[] args) {
        ClubRegistrationDAO club = new ClubRegistrationDAO();

    }
}
