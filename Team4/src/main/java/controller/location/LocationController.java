package controller.location;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.service.LocationManager;

public class LocationController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(LocationController.class);
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
    	
		String address = request.getParameter("address");

		LocationManager manager = LocationManager.getInstance();
		int locationId = manager.getLocation(address);
		
		request.setAttribute("locationId", locationId);
		
		log.debug("location Request : {}", locationId);
		
		// 사용자 리스트 화면으로 이동(forwarding)
		return "/location/locationResult.jsp";        
    }
}
