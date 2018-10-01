package board_like;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.Board;

public class Board_LikeDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public Board_LikeDAO() {	
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
	
	//하트 누르기
		public int like(Board_Like like) {
			
			String sql = "insert into board_like values (null,?,?,1)";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,like.getBoard_pk());
				pstmt.setString(2,like.getUser_pk());
				
				return pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}

		//하트 확인
		/*public ArrayList<Board_Like> getHeart(String user_id,int board_pk){
			String SQL = "select * from board_like where user_pk =? AND board_pk = ?";
			ArrayList<Board_Like> list2 = new ArrayList<Board_Like>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user_id);
				pstmt.setInt(2, board_pk);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					Board_Like like = new Board_Like();
					like.setPk(rs.getInt(1));
					like.setBoard_pk(rs.getInt(2));
					like.setUser_pk(rs.getString(3));
					like.setBoard_like(rs.getInt(4));
					list2.add(like);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list2;
		}*/
		
		public int getHeart(String user_id,int board_pk) {
			String sql = "select * from board_like where user_pk =? AND board_pk = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,user_id);
				pstmt.setInt(2,board_pk);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					int like = rs.getInt("board_like");				
					return like;
				}
				
				else {
					return -1;
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			return 0;
		}

		
		//하트 총 개수
		public int heart_count(int pk) {
			int count =0;		
			String sql = "select count(*) from board_like where board_pk = ?";	        
	        try{
	            pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,pk);
				
	            rs = pstmt.executeQuery();
	            
	            if(rs.next()){
	                count = rs.getInt(1);}
	            
			}catch(Exception e) {
				e.printStackTrace(); }
			return count;
		}

}
