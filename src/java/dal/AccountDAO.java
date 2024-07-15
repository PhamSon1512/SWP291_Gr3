package dal;

import context.DBContext;
import config.Encode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Account;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.GoogleAccount;
import model.Setting;

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
            String sql = "SELECT u.[user_id], u.full_name, u.[user_name], u.email, u.phone_number, u.[password], u.setting_id, u.status, u.note, u.verified "
                    + "FROM [user] u "
                    + "INNER JOIN setting s ON u.setting_id = s.setting_id "
                    + "WHERE email = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            String encodedPassword = Encode.enCode(password);
            statement.setString(2, encodedPassword);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"), "", "", "");
                int userId = rs.getInt("user_id");
                String avatarUrl = getAvatarUrlByUserId(userId);
                account = new Account(userId, rs.getString("full_name"), rs.getString("user_name"),
                        rs.getString("email"), rs.getString("phone_number"), rs.getString("password"),
                        avatarUrl, setting, rs.getInt("status"), rs.getString("note"), rs.getBoolean("verified"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return account;
    }

    public Account getAccountsByEmail(String email) {
        Account account = null;
        String sql = "SELECT u.[user_id], u.full_name, u.[user_name], u.email, u.phone_number, u.[password], u.setting_id, u.status, u.note, u.verified "
                + "FROM [user] u "
                + "INNER JOIN setting s ON u.setting_id = s.setting_id "
                + "WHERE u.email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"), "", "", "");
                int userId = rs.getInt("user_id");
                String avatarUrl = getAvatarUrlByUserId(userId);
account = new Account(userId, rs.getString("full_name"), rs.getString("user_name"),
                        rs.getString("email"), rs.getString("phone_number"), rs.getString("password"),
                        avatarUrl, setting, rs.getInt("status"), rs.getString("note"), rs.getBoolean("verified"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return account;
    }

    public Account getAccountsByUserName(String userName) {
        Account account = null;
        String sql = "SELECT u.[user_id], u.full_name, u.[user_name], u.email, u.phone_number, u.[password], u.setting_id, u.status, u.note, u.verified "
                + "FROM [user] u "
                + "INNER JOIN setting s ON u.setting_id = s.setting_id "
                + "WHERE u.[user_name] = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, userName);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"), "", "", "");
                int userId = rs.getInt("user_id");
                String avatarUrl = getAvatarUrlByUserId(userId);
                account = new Account(userId, rs.getString("full_name"), rs.getString("user_name"),
                        rs.getString("email"), rs.getString("phone_number"), rs.getString("password"),
                        avatarUrl, setting, rs.getInt("status"), rs.getString("note"), rs.getBoolean("verified"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return account;
    }

    public Account getAccountById(int userId) {
        Account account = null;
        String sql = "SELECT u.[user_id], u.full_name, u.[user_name], u.email, u.phone_number, u.[password], u.setting_id, u.status, u.note, u.verified "
                + "FROM [user] u "
                + "INNER JOIN setting s ON u.setting_id = s.setting_id "
                + "WHERE u.[user_id] = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"), "", "", "");
                String avatarUrl = getAvatarUrlByUserId(userId);
                account = new Account(userId, rs.getString("full_name"), rs.getString("user_name"),
                        rs.getString("email"), rs.getString("phone_number"), rs.getString("password"),
                        avatarUrl, setting, rs.getInt("status"), rs.getString("note"), rs.getBoolean("verified"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
return account;
    }

    public List<Account> getListByPage(List<Account> list, int start, int end) {
        ArrayList<Account> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public int getTotalAccount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM [user]";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public boolean checkEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM [user] WHERE email = ?";
        try (Connection conn = dbc.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public GoogleAccount getGoogleAccountByEmail(String email) {
        GoogleAccount googleAccount = null;
        String sql = "SELECT user_id, email, full_name, phone_number "
                + "FROM [user] "
                + "WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    googleAccount = new GoogleAccount(
                            String.valueOf(rs.getInt("user_id")),
                            rs.getString("email"),
                            rs.getString("full_name"),
                            null, // You may set other fields to null or empty if not available
                            null,
                            null,
                            null,
                            true // Assuming email is verified in this context
                    );

                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return googleAccount;
    }

    public ArrayList<Account> listAcc() {
        ArrayList<Account> acc = new ArrayList<>();
        try {
            String sql = "SELECT u.[user_id], u.full_name, u.[user_name], u.email, u.phone_number, u.[password], u.avatar_url, u.setting_id, u.status, u.note, u.verified "
                    + "FROM [user] u "
+ "INNER JOIN setting s ON u.setting_id = s.setting_id";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"), "", "", "");
                Account a = new Account(rs.getInt("user_id"), rs.getString("full_name"),
                        rs.getString("user_name"), rs.getString("email"), rs.getString("phone_number"),
                        rs.getString("password"), rs.getString("avatar_url"), setting,
                        rs.getInt("status"), rs.getString("note"), rs.getBoolean("verified"));
                acc.add(a);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return acc;
    }

    public void insertAccount(String name, String user_name, String email, String password, int setting, int status, boolean verified) {
        try {
            String sql = "INSERT INTO [user] (full_name, user_name, email, password, setting_id, status, verified) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, user_name);
            statement.setString(3, email);
            statement.setString(4, password);
            statement.setInt(5, setting);
            statement.setInt(6, status);
            statement.setBoolean(7, verified);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changePassword(String email, String newPassword) {
        try {
            String sql = "UPDATE [user] SET password = ? WHERE email = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, newPassword);
            statement.setString(2, email);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeInformations(String fullname, String username, String phone, int userId) {
        try {
            String sql = "UPDATE [user] SET full_name = ?, [user_name] = ?, phone_number = ? WHERE [user_id] = ?";
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
            String sql = "UPDATE [user] SET password = ? WHERE email = ?";
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

    public boolean updateAccountStatus(int userId, int newStatus) {
        String sql = "UPDATE [user] SET setting_id = ? WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, newStatus);
            statement.setInt(2, userId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public void updateEmailVerifiedStatus(String email) {
        try {
            String query = "UPDATE [user] SET verified = ? WHERE email = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setBoolean(1, true);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateAccount(int userId, String fullname, String username, String phoneNumber, int role) {
        String sql = "UPDATE [user] SET full_name = ?, [user_name] = ?, phone_number = ?, [status] = ? WHERE [user_id] = ?";

        try (Connection conn = getConnection(); // Giả sử bạn có phương thức getConnection()
PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, fullname);
            statement.setString(2, username);
            statement.setString(3, phoneNumber);
            statement.setInt(4, role);
            statement.setInt(5, userId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Account updated successfully for user ID: " + userId);
                return true;
            } else {
                System.out.println("No account was updated for user ID: " + userId);
                return false;
            }
        } catch (SQLException ex) {
            System.err.println("Error updating account: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

    public List<Account> searchAccounts(String searchTerm) {
        List<Account> result = new ArrayList<>();
        String sql = "SELECT * FROM [user] WHERE full_name LIKE ? OR user_name LIKE ? OR email LIKE ? OR phone_number LIKE ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Account account = new Account();
                    account.setUser_id(rs.getInt("user_id"));
                    account.setFullname(rs.getString("full_name"));
                    account.setUsername(rs.getString("user_name"));
                    account.setEmail(rs.getString("email"));
                    account.setPhone_number(rs.getString("phone_number"));
                    account.setStatus(rs.getInt("status"));

                    Setting setting = new Setting();
                    setting.setSetting_id(rs.getInt("setting_id"));
                    account.setSetting(setting);

                    result.add(account);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) {
        AccountDAO accountDAO = new AccountDAO();

        // Thông tin cần cập nhật
        int userId = 80; // Giả sử có user với ID là 10, thay đổi nếu cần
        String fullname = "PhamSon";
        String username = "PhamSon123";
        String phoneNumber = "1234567890";
        int role = 2; // Giả sử 0 là role user

        // Lấy và in thông tin user trước khi cập nhật
        System.out.println("User information before update:");
        printUserInfo(accountDAO, userId);

        // Thực hiện cập nhật
boolean updateSuccess = accountDAO.updateAccount(userId, fullname, username, phoneNumber, role);

        if (updateSuccess) {
            System.out.println("Update successful!");

            // Lấy và in thông tin user sau khi cập nhật
            System.out.println("User information after update:");
            printUserInfo(accountDAO, userId);
        } else {
            System.out.println("Update failed!");
        }
    }

    private static void printUserInfo(AccountDAO accountDAO, int userId) {
        Account account = accountDAO.getAccountById(userId);
        if (account != null) {
            System.out.println("User ID: " + account.getUser_id());
            System.out.println("Full Name: " + account.getFullname());
            System.out.println("Username: " + account.getUsername());
            System.out.println("Email: " + account.getEmail());
            System.out.println("Phone Number: " + account.getPhone_number());
            System.out.println("Role/Status: " + account.getStatus());
            System.out.println("--------------------");
        } else {
            System.out.println("User not found!");
        }
    }
}
