package chat;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String listType = request.getParameter("listType");
		
		if(listType == null || listType.equals("")) response.getWriter().write("");
		else if(listType.equals("today")) response.getWriter().write(getToday());
		
		else {
			try {
				Integer.parseInt(listType);
				response.getWriter().write(getID(listType));
				
			}catch(Exception e) {
				response.getWriter().write("");
			}
		}
	}
		
		
		public String getToday() {
			StringBuffer result = new StringBuffer("");
			
			//json형태로 변수들을 지정하고 클라이언트에게 돌려줌
			result.append("{\"result\":[");
			ChatDAO chatDAO = new ChatDAO();
			
			ArrayList<Chat> chatList = chatDAO.getChatList(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		
			for(int i=0;i<chatList.size();i++) {
				result.append("[{\"value\": \"" + chatList.get(i).getChatName() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
				
				if(i != chatList.size() - 1) result.append(",");
				
			}
			result.append("], \"last\":\"" + chatList.get(chatList.size() -1 ).getChatID() + "\"}");
			return result.toString();
		}
		
		public String getTen() {
			StringBuffer result = new StringBuffer("");
			result.append("{\"result\":[");
			ChatDAO chatDAO = new ChatDAO();
			
			ArrayList<Chat> chatList = chatDAO.getChatListByRecent(10);
		
			for(int i=0;i<chatList.size();i++) {
				result.append("[{\"value\": \"" + chatList.get(i).getChatName() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
				
				if(i != chatList.size() - 1) result.append(",");
				
			}
			result.append("], \"last\":\"" + chatList.get(chatList.size() -1 ).getChatID() + "\"}");
			return result.toString();
		}
		
		public String getID(String chatID) {
			StringBuffer result = new StringBuffer("");
			result.append("{\"result\":[");
			ChatDAO chatDAO = new ChatDAO();
			
			ArrayList<Chat> chatList = chatDAO.getChatListByRecent(chatID);
		
			for(int i=0;i<chatList.size();i++) {
				result.append("[{\"value\": \"" + chatList.get(i).getChatName() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
				
				if(i != chatList.size() - 1) result.append(",");
				
			}
			result.append("], \"last\":\"" + chatList.get(chatList.size() -1 ).getChatID() + "\"}");
			return result.toString();
		}

	}

