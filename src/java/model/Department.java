package model;

public class Department {

    private int departmentId;
    private String name;
    private String description;
    private int clubId;
    private int specialityId;

    private String currentProjects;

    private String regularMeetingSchedule;
    private int status;

    // Constructor, getters, and setters
    public Department() {
    }

    public Department(int departmentId, String name, String description, int clubId, int specialityId, String currentProjects, String regularMeetingSchedule, int status) {
        this.departmentId = departmentId;
        this.name = name;
        this.description = description;
        this.clubId = clubId;
        this.specialityId = specialityId;
        this.currentProjects = currentProjects;
        this.regularMeetingSchedule = regularMeetingSchedule;
        this.status = status;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getClubId() {
        return clubId;
    }

    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public int getSpecialityId() {
        return specialityId;
    }

    public void setSpecialityId(int specialityId) {
        this.specialityId = specialityId;
    }

    public String getCurrentProjects() {
        return currentProjects;
    }

    public void setCurrentProjects(String currentProjects) {
        this.currentProjects = currentProjects;
    }

    public String getRegularMeetingSchedule() {
        return regularMeetingSchedule;
    }

    public void setRegularMeetingSchedule(String regularMeetingSchedule) {
        this.regularMeetingSchedule = regularMeetingSchedule;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
