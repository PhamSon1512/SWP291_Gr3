package model;

/**
 *
 * @author PhamSon
 */
public class Account {

    public int user_id;
    public String fullname;
    public String username;
    public String email;
    public String phone_number;
    public String password;
    public String avatar_url;
    public Setting setting;
    public int status;
    public String note;

    public Account() {
    }

    public Account(int user_id, String fullname, String username, String email, String phone_number, String password, String avatar_url, Setting setting, int status, String note) {
        this.user_id = user_id;
        this.fullname = fullname;
        this.username = username;
        this.email = email;
        this.phone_number = phone_number;
        this.password = password;
        this.avatar_url = avatar_url;
        this.setting = setting;
        this.status = status;
        this.note = note;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public Setting getSetting() {
        return setting;
    }

    public void setSetting(Setting setting) {
        this.setting = setting;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Account{" + "user_id=" + user_id + ", fullname=" + fullname + ", username=" + username + ", email=" + email + ", phone_number=" + phone_number + ", password=" + password + ", avatar_url=" + avatar_url + ", setting=" + setting + ", status=" + status + ", note=" + note + '}';
    }

}
