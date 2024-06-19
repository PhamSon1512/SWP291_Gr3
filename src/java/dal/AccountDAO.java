package dal;

import context.DBContext;
import config.Encode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Account;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;

/**
 *
 * @author Pham Son
 */
public class AccountDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbc = new DBContext();
    Connection connection = null;

    // Constructor to initialize connection
    public AccountDAO() {
        connection = dbc.getConnection();
    }

    public Account getAccountByUP(String email, String password) {
        Account account = null;
        try {
            String sql = "SELECT u.[user_id], u.full_name, u.[user_name], u.email, u.phone_number, u.[password], u.setting_id, u.status, u.note "
                    + "FROM [user] u "
                    + "INNER JOIN setting s ON u.setting_id = s.setting_id "
                    + "WHERE email = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            String encodedPassword = Encode.enCode(password);
            statement.setString(2, encodedPassword);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"), "", "", "", rs.getInt("status"));
                int userId = rs.getInt("user_id");
                String avatarUrl = getAvatarUrlByUserId(userId);
                account = new Account(userId, rs.getString("full_name"), rs.getString("user_name"), rs.getString("email"), rs.getString("phone_number"), rs.getString("password"), avatarUrl, setting, rs.getInt(8), rs.getString("note"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return account;
    }

    public Account getAccountsByEmail(String email) {
        Account account = null;
        String sql = "SELECT u.[user_id], u.full_name, u.[user_name], u.email, u.phone_number, u.[password], u.setting_id, u.status, u.note "
                + "FROM [user] u "
                + "INNER JOIN setting s ON u.setting_id = s.setting_id "
                + "WHERE u.email = ?";
        try (
            PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"), "", "", "", rs.getInt("status"));
                int userId = rs.getInt("user_id");
                String avatarUrl = getAvatarUrlByUserId(userId);
                account = new Account(userId,
                        rs.getString("full_name"),
                        rs.getString("user_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("password"),
                        avatarUrl,
                        setting,
                        rs.getInt(8),
                        rs.getString("note"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return account;
    }

    public ArrayList<Account> listAcc() {
        ArrayList acc = new ArrayList();

        try {
            String sql = "select u.[user_id],u.full_name,u.[user_name],u.email,u.phone_number,u.[password],u.avatar_url,u.setting_id,u.status,u.note \n"
                    + "from [user] u \n"
                    + "inner join setting s on u.setting_id = s.setting_id\n";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"), "", "", "", rs.getInt("status"));
                Account a = new Account(rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("user_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("password"),
                        rs.getString("avatar_url"),
                        setting,
                        rs.getInt(8),
                        rs.getString("note"));
                acc.add(a);

            }
            return acc;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertAccount(String name, String user_name, String email, String phone_number, String password, int setting, int status) {
        try {
            String sql = "INSERT INTO [user] (full_name, user_name, email, phone_number, password, setting_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, user_name);
            statement.setString(3, email);
            statement.setString(4, phone_number);
            statement.setString(5, password);
            statement.setInt(6, setting);
            statement.setInt(7, status);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changePassword(String email, String newPassword) {
        try {
            String sql = "UPDATE account SET password = ? WHERE email = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, newPassword);
            statement.setString(2, email);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeInformations( String fullname, String username, String phone,int userId) {
        try {
            String sql = "UPDATE account SET full_name = ?,[user_name] = ?, phone_number = ? WHERE [user_id] = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, fullname);
            statement.setString(2, username);
            statement.setString(3, phone);  
            statement.setInt(4, userId);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updatePasswordByEmail(String email, String newPassword) {
        try {
            String sql = "UPDATE account SET password = ? WHERE email = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, newPassword);
            statement.setString(2, email);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getAvatarUrlByUserId(int userId) {
        String avatarUrl = null;
        try {
            String sql = "SELECT avatar_url FROM [user] WHERE user_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                avatarUrl = rs.getString("avatar_url");
            }
            rs.close();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return avatarUrl;
    }

    public void updateAvatar(int user_id, String avatarUrl) throws SQLException {
        String sql = "UPDATE [user] SET avatar_url = ? WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, avatarUrl);
            statement.setInt(2, user_id);
            statement.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public static void main(String[] args) {
    AccountDAO dao = new AccountDAO();
    Account account = dao.getAccountsByEmail("sodoku18@gmail.com");
    if (account != null) {
        System.out.println("User ID: " + account.getUser_id());
        System.out.println("Full Name: " + account.getFullname());
        System.out.println("User Name: " + account.getUsername());
        System.out.println("Email: " + account.getEmail());
        System.out.println("Phone Number: " + account.getPhone_number());
        System.out.println("Password: " + account.getPassword());
        System.out.println("Avatar URL: " + account.getAvatar_url());
        System.out.println("Setting ID: " + account.getSetting().getSetting_id());
        System.out.println("Status: " + account.getStatus());
        System.out.println("Note: " + account.getNote());
    } else {
        System.out.println("Account not found");
    }
}
}
