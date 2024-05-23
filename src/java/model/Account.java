package model;

/**
 *
 * @author PhamSon
 */
public class Account {
    private int acc_ID;
    private String name;
    private String email;
    private String phone_number;
    private String password;
    private String avatar_url;
    private int roleID;
    private int acc_status;
    

    public Account() {
    }

    public Account(int acc_ID, String name, String email, String phone_number, String password, String avatar_url, int roleID, int acc_status) {
        this.acc_ID = acc_ID;
        this.name = name;
        this.email = email;
        this.phone_number = phone_number;
        this.password = password;
        this.avatar_url = avatar_url;
        this.roleID = roleID;
        this.acc_status = acc_status;
    }

    public int getAcc_ID() {
        return acc_ID;
    }

    public void setAcc_ID(int acc_ID) {
        this.acc_ID = acc_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatar_url() {
        return avatar_url;
    }

    public void setAvatar_url(String avatar_url) {
        this.avatar_url = avatar_url;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public int isAcc_status() {
        return acc_status;
    }

    public void setAcc_status(int acc_status) {
        this.acc_status = acc_status;
    }

    @Override
    public String toString() {
        return "Account{" + "acc_ID=" + acc_ID + ", name=" + name + ", email=" + email + ", phone_number=" + phone_number + ", password=" + password + ", avatar_url=" + avatar_url + ", roleID=" + roleID + ", acc_status=" + acc_status + '}';
    }

   
    
    
}
