package controller.manager;

import dal.ClubDBContext;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ClubMember;
import model.Department;

public class TeamDetail extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String club_id = request.getParameter("club_id");
        int clubId = Integer.parseInt(club_id);
        
        ClubDBContext dbContext = new ClubDBContext();
        
        // Fetch club members
        List<ClubMember> clubMembers = dbContext.getClubMembersByClubId(clubId);
        
        // Fetch departments
        List<Department> departments = dbContext.getDepartmentsByClubId(clubId);
        
        // Create a map for speciality_id to position names
        Map<Integer, String> specialityMap = new HashMap<>();
        specialityMap.put(1, "Chủ Nhiệm");
        specialityMap.put(2, "Chuyên Môn");
        specialityMap.put(3, "Văn Hóa");
        specialityMap.put(4, "Truyền Thông");
        specialityMap.put(5, "Hậu Cần");
        specialityMap.put(6, "Nội Dung");
        
        // Group members by speciality_id
        Map<Integer, List<ClubMember>> departmentMembersMap = new HashMap<>();
        for (ClubMember member : clubMembers) {
            int specialityId = member.getSpeciality_id();
            if (!departmentMembersMap.containsKey(specialityId)) {
                departmentMembersMap.put(specialityId, new ArrayList<>());
            }
            departmentMembersMap.get(specialityId).add(member);
        }
        
        // Create a map for department information
        Map<Integer, Department> departmentInfoMap = new HashMap<>();
        for (Department dept : departments) {
            departmentInfoMap.put(dept.getSpecialityId(), dept);
        }
        
        // Set attributes to request
        request.setAttribute("departmentMembersMap", departmentMembersMap);
        request.setAttribute("specialityMap", specialityMap);
        request.setAttribute("departmentInfoMap", departmentInfoMap);
        
        // Forward request to teamDetail.jsp
        request.getRequestDispatcher("teamDetail.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}