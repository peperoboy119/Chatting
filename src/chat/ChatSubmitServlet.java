package chat;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String chatName = URLDecoder.decode(request.getParameter("chatName"), "UTF-8");
		String chatContent = URLDecoder.decode(request.getParameter("chatContent"), "UTF-8");
		
		//이름이 비어있거나 채팅내용이 비어있으면 0을 반환시키고
		if(chatName == null || chatName.equals("") || chatContent == null || chatContent.equals("") ) {
			response.getWriter().write("0");
		}
		//반대의 경우 1을 반환 시켜서 db에 저장되게 한다
		else {
			response.getWriter().write(new ChatDAO().submit(chatName, chatContent)+"");
		}
	}
	//이후 서블릿을 매핑을 시킨다 -> web.xml에서

}
