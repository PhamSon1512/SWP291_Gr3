package controller.manager;

import dal.ClubDBContext;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Collections;
import java.util.Comparator;
import model.ClubMember;

public class MemberDetailController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
      
     
                
        int clubId = (Integer) request.getSession().getAttribute("loggedInClubId");
        request.setAttribute("clubId", clubId);
        List<ClubMember> clubMembers = new ClubDBContext().getClubMembersByClubId(clubId);
        request.setAttribute("clubMembers", clubMembers);
        Collections.sort(clubMembers, new Comparator<ClubMember>() {
            @Override
            public int compare(ClubMember o1, ClubMember o2) {
                return Integer.compare(o1.getSpeciality_id(), o2.getSpeciality_id());
            }
        });
        // Create a map for speciality_id to position names
        Map<Integer, String> specialityMap = new HashMap<>();
        specialityMap.put(1, " Chủ Nhiệm");
        specialityMap.put(2, "Ban Chuyên Môn");
        specialityMap.put(3, "Ban Văn Hóa");
        specialityMap.put(4, "Ban Truyền Thông");
        specialityMap.put(5, "Ban Hậu Cần");
        specialityMap.put(6, "Ban Nội Dung");
        Map<Boolean, String> activeStatusMap = new HashMap<>();
        activeStatusMap.put(true, "Active");
        activeStatusMap.put(false, "Non-Active");
        request.setAttribute("specialityMap", specialityMap);
        request.setAttribute("activeStatusMap", activeStatusMap);

        request.getRequestDispatcher("admin/memberDetail.jsp").forward(request, response);
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
