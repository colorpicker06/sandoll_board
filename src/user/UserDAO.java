package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.Board;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public int getNext() {
		String SQL = "select pk from user order by pk desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
		public UserDAO() {
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/sandoll_board?useSSL=false";
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
			return -1; //아이디 없
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
	
	//회원 목록 불러오기
	public ArrayList<User> getList(int pageNumber){
		String SQL = "select * from user where pk <? order by pk desc LIMIT 10";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setPk(rs.getInt(1));
				user.setId(rs.getString(2));
				user.setPassword(rs.getString(3));
				user.setName(rs.getString(4));
				user.setNickname(rs.getString(5));
				user.setReg_date(rs.getString(6));
				user.setUser_state(rs.getInt(7));
				list.add(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;		
	}
	
	//개인 정보 불러오기
	public ArrayList<User> get_info_list(String id){
		String SQL = "select * from user where id = ? ";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setPk(rs.getInt(1));
				user.setId(rs.getString(2));
				user.setPassword(rs.getString(3));
				user.setName(rs.getString(4));
				user.setNickname(rs.getString(5));
				user.setReg_date(rs.getString(6));
				user.setUser_state(rs.getInt(7));
				list.add(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;		
	}
	
	//다음 페이지
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * from user where pk <? AND user_state=0";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return false;
	}
	
	//id chk
	public boolean chk_id(String user_id) {
		boolean result = false;
		String SQL = "select id from user where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true; //중복된 아이디가 있다.
			}
			
			else {
				result = false; //중복된 아이디가 없다.
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result; //bd오류;
	}

}