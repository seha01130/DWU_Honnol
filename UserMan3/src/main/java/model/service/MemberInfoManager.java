package model.service;

import java.sql.SQLException;

import model.MemberInfo;
import model.dao.MemberDAO;
import model.dao.MemberInfoDAO;

/**
 * 사용자 관리 API를 사용하는 개발자들이 직접 접근하게 되는 클래스.
 * UserDAO를 이용하여 데이터베이스에 데이터 조작 작업이 가능하도록 하며,
 * 데이터베이스의 데이터들을 이용하여 비지니스 로직을 수행하는 역할을 한다.
 * 비지니스 로직이 복잡한 경우에는 비지니스 로직만을 전담하는 클래스를 
 * 별도로 둘 수 있다.
 */
public class MemberInfoManager {
	private static MemberInfoManager userMan = new MemberInfoManager();
	private MemberInfoDAO memberInfoDAO;
	private MemberDAO memberDAO;
	private MemberInfoManager() {
		try {
			memberInfoDAO = new MemberInfoDAO();
			memberDAO = new MemberDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static MemberInfoManager getInstance() {
		return userMan;
	}
	
	public int create(MemberInfo memberInfo) throws SQLException, ExistingMemberException {
//		if (memberDAO.existingMember(memberInfo.getMemberId()) == true) {
//			throw new ExistingMemberException(memberInfo.getMemberId() + "는 이미 사용자 정보가 존재합니다.");
//		}
		return memberInfoDAO.create(memberInfo);
	}

}
