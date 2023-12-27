package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DispatcherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = LoggerFactory.getLogger(DispatcherServlet.class);

    private RequestMapping rm;

    @Override
    public void init() throws ServletException {
        rm = new RequestMapping();
        rm.initMapping();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("Method : {}, Request URI : {}, ServletPath : {}", request.getMethod(), request.getRequestURI(),
                request.getServletPath());
        String contextPath = request.getContextPath();
        String servletPath = request.getServletPath();

        // URL 중 servletPath에 대응되는 controller를 구함
        Controller controller = rm.findController(servletPath);
        try {
            if (controller == null) {
                // 적절한 오류 처리 또는 로깅을 수행하세요.
                logger.error("Controller not found for servletPath: {}", servletPath);
                // 적절한 응답 처리 또는 에러 페이지로 리다이렉션 등을 수행할 수 있습니다.
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Controller not found");
                return;
            }

            // controller를 통해 request 처리 후, 이동할 uri를 반환 받음
            String uri = controller.execute(request, response);

            if (uri == null)
                return; // Ajax request 처리 완료

            // 반환된 uri에 따라 forwarding 또는 redirection 여부를 결정하고 이동
            if (uri.startsWith("redirect:")) {
                // redirection 지시
                String targetUri = contextPath + uri.substring("redirect:".length());
                response.sendRedirect(targetUri); // redirect to url
            } else {
                // forwarding 수행
                String targetUri = "/WEB-INF" + uri;
                RequestDispatcher rd = request.getRequestDispatcher(targetUri);
                rd.forward(request, response); // forward to the view page
            }
        } catch (Exception e) {
            logger.error("Exception : {}", e);
            throw new ServletException(e.getMessage());
        }
    }
}
