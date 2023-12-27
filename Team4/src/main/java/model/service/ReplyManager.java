package model.service;

import java.sql.SQLException;

import model.Post;
import model.Reply;
import model.dao.PostDAO;
import model.dao.ReplyDAO;

public class ReplyManager {
	private static ReplyManager replyMan = new ReplyManager();
	private ReplyDAO replyDAO;
	private ReplyManager() {
		try {
			replyDAO = new ReplyDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static ReplyManager getInstance() {
		return replyMan;
	}
	
	public Reply createReply(Reply reply) throws SQLException {
        return replyDAO.createReply(reply);       
    }
}
