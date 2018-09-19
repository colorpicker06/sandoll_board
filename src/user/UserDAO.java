package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import board.Board;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
		public UserDAO() {
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/sandoll_board";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}		
	}
	
	//로그인 
	public int login(String id,String password) {
		String sql = "select password from user where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(password))
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 틀림 
			}
			return -1; //아이디 틀림 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //db연결실패
	}
	
	//회원가입
	public int signin(User user) {
		String sql = "insert into user values (null,?,?,?,?,now(),0)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,user.getId());
			pstmt.setString(2,user.getPassword());
			pstmt.setString(3,user.getName());
			pstmt.setString(4,user.getNickname());
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//개인정보 수정
		public int info_change(User user) {
			
			String sql = "update user set id = ?, password=?, nickname=? where pk=?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,user.getId());
				pstmt.setString(2,user.getPassword());
				pstmt.setString(3,user.getNickname());
				pstmt.setInt(4,user.getPk());
				
				return pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
	
	//아이디 중복체크 
	public int id_chk(String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from user where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 0;
			}
			else {
				return 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	//계정 상태 변경
	public int user_state(User user) {
		
		String sql = "update user set user_state = ?, id =?, name = ?, password =?, reg_date =?, nickname =? where pk=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user.getUser_state() );
			pstmt.setString(2, user.getId());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getPassword());
			pstmt.setString(5, user.getReg_date());
			pstmt.setString(6, user.getNickname());
			pstmt.setInt(7, user.getPk());
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}