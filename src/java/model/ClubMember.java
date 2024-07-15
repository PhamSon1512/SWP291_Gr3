package model;

public class ClubMember {

    private int club_id;
    private int user_id;
    private String email;
    private int speciality_id;
    private boolean status;
    private String fullName;
    private String userName;
    private String imageUrl;
     private boolean active_status;
    // Getters and Setters

    public ClubMember() {
    }

     public ClubMember(int club_id, int user_id, String email, int speciality_id, boolean status, String fullName, String userName, String imageUrl, boolean active_status) {
        this.club_id = club_id;
        this.user_id = user_id;
        this.email = email;
        this.speciality_id = speciality_id;
        this.status = status;
        this.fullName = fullName;
        this.userName = userName;
        this.imageUrl = imageUrl;
        this.active_status = active_status;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getClub_id() {
        return club_id;
    }

    public void setClub_id(int club_id) {
        this.club_id = club_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getSpeciality_id() {
        return speciality_id;
    }

    public void setSpeciality_id(int speciality_id) {
        this.speciality_id = speciality_id;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public boolean isActive_status() {
        return active_status;
    }

    public void setActive_status(boolean active_status) {
        this.active_status = active_status;
    }
    
}
