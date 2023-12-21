package controller.post;

import java.util.Date;

import java.io.File;
import java.util.List;
import java.util.UUID;

//파일 업로드 APIs 
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;
 // 파일 용량 초과에 대한 Exception 클래스를 FileUploadBase 클래스의 Inner 클래스로 처리

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Post;
import model.service.PostManager;

public class CreatePostController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(CreatePostController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getMethod().equals("GET")) {    
            // GET request: 게시글 등록 form 요청 
            log.debug("RegisterForm Request"); 
        
            return "/post/createForm.jsp";    
        }   

        // POST request (회원정보가 parameter로 전송됨)
//        String createDateParam = request.getParameter("createDate");
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        Date createDate = dateFormat.parse(createDateParam);
        
        /*  --------------- 파일처리를 위한 코드부분 시작 --------------------------*/
        String isPublic = null;
        String title = null;
        String content = null;   
        String locationId = null;
        String filename = null;     
    
        boolean check = ServletFileUpload.isMultipartContent(request);              
        if(check) {    // 전송된 요청 메시지의 타입이 multipart 인지 여부를 체크한다. (multipart/form-data)
            
            // 아래와 같이 하면 Tomcat 내부에 복사된 프로젝트 밑에 upload 폴더가 생성됨 
            ServletContext context = request.getServletContext();
            String path = context.getRealPath("/upload");
            File dir = new File(path);          
            
            // Tomcat 외부의 폴더에 저장하려면 아래와 같이 절대 경로로 폴더 이름을 지정함
            // File dir = new File("C:/Temp");
                        
            if (!dir.exists()) dir.mkdir();  // 전송된 파일을 저장할 폴더 생성
            
            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                    // 파일 전송에 대한 기본적인 설정 Factory 클래스를 생성한다.
                factory.setSizeThreshold(10 * 1024);
                    // 메모리에 한번에 저장할 데이터의 크기를 10KB로 설정한다.
                factory.setRepository(dir);
                    // 전송된 데이터의 내용을 저장할 폴더를 지정한다.                
    
                ServletFileUpload upload = new ServletFileUpload(factory);
                    // Factory 클래스를 통해 실제 업로드 되는 내용을 처리할 객체를 선언한다.
                upload.setSizeMax(10 * 1024 * 1024);
                    // 업로드 될 파일의 최대 용량을 10MB로 설정한다.
                upload.setHeaderEncoding("utf-8");
                    // 업로드 되는 내용의 인코딩 방식을 설정한다.
                                
                List<FileItem> items = (List<FileItem>)upload.parseRequest(request);                
                    // upload 객체에 전송된 모든 데이터(요청 파라미터)를 Collection 객체에 담는다.
                
                for (int i = 0; i < items.size(); ++i) {
                    FileItem item = (FileItem)items.get(i);            
                    
                    String value = item.getString("utf-8"); // 넘어온 값에 대한 한글 처리를 한다.                 
                    
                    if (item.isFormField()) {  // item이 일반 데이터인 경우                      
                        if(item.getFieldName().equals("isPublic")) 
                            isPublic = value;
                        else if(item.getFieldName().equals("title")) 
                            title = value;
                        else if(item.getFieldName().equals("content"))
                            content = value; 
                        else if(item.getFieldName().equals("locationId")) 
                            locationId = value; 
                    }
                    else {  // item이 파일인 경우   
                        if (item.getFieldName().equals("image")) {
                            // parameter 이름이 image이면 파일 저장을 한다.
                            String oriFilename = item.getName();    // 파일 이름 획득 (자동 한글 처리 됨)
                            if (oriFilename == null || oriFilename.trim().length() == 0) continue;
                                // 파일이 전송되어 오지 않았다면 건너뜀
                            
                            // filename = oriFileName.substring(oriFileName.lastIndexOf("\\") + 1);                                          
                                // 파일 이름이 파일의 전체 경로까지 포함하기 때문에 이름 부분만 추출해야 한다.
                                // 실제 C:\Web_Java\aaa.gif라고 하면 aaa.gif만 추출하기 위한 코드임
                            
                            filename = UUID.randomUUID().toString() + "_" 
                                    + oriFilename.substring(oriFilename.lastIndexOf("\\") + 1);  
                                // 파일 이름이 중복되지 않도록 UUID(Universally Unique IDentifier)를 생성해서 원래의 이름 앞에 붙임
                                

                            // 또는 아래와 같이 원래의 파일의 확장자만 추출해서 UUID와 함께 파일 이름 생성
                            // filename = UUID.randomUUID().toString() 
                            //      + oriFilename.substring(oriFilename.lastIndexOf("."));
                             
                            System.out.println("uploaded file: " + filename);
                                
                            File file = new File(dir, filename);
                            item.write(file);
                                // 파일을 upload 경로에 실제로 저장한다.
                                // FileItem 객체로부터 바로 출력 저장할 수 있다.
                        }
                    }
                }
                
            } catch(SizeLimitExceededException e) {
                // 업로드 되는 파일의 크기가 지정된 최대 크기를 초과할 때 발생하는 예외처리
                e.printStackTrace();           
            } catch(FileUploadException e) {
                // 파일 업로드와 관련되어 발생할 수 있는 예외 처리
                e.printStackTrace();
            } catch(Exception e) {            
                e.printStackTrace();
            }
                
        }   
        /*  --------------- 파일처리를 위한 코드부분 끝--------------------------*/
        
        
        Date createDate = new Date();
        
        System.out.println("파일이름임니당" + filename);
     
        Post post = new Post(
            3,
            Integer.parseInt(isPublic),
            createDate,
            title,
            filename,
            content,
            "seha",
            Integer.parseInt(locationId),
            0 
        );
        
        log.debug("Create Post : {}", post);

        try {
        	PostManager manager = PostManager.getInstance();
            manager.createPost(post);
            return "redirect:/post/detailPage?postId=" + post.getPostId();
//            return "redirect:/post/detailPage";   // 성공 시 게시글 디테일 화면으로 redirect
            
        } catch (Error e) { // 예외 발생 시 post작성 form으로 forwarding인데 다 작성 안하고 등록눌렀을때의 처리는 jsp에서 해주자
            request.setAttribute("registerFailed", true);
            request.setAttribute("exception", e);
            request.setAttribute("post", post);
            return "/post/createForm.jsp";
        }
    }
}
