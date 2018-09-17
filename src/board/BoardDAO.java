package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.Board;;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public BoardDAO() {	
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

	
	//글쓰기 
	public int write(Board board) {
		String sql = "insert into board values (null,?,?,?,now(),0,0)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,board.getTitle());
			pstmt.setString(2,board.getContent());
			pstmt.setString(3,board.getWriter());
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//글 목록
	/*public ArrayList<Bbs> board_list(Board board) {
		String sql = "select pk, title, content, writer,reg_date,board_like from board order by pk desc";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}*/
	
	
}