package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.Board;
import sun.misc.Perf.GetPerfAction;
import user.User;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public BoardDAO() {	
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
	
			// 수정
			public int board_change(Board board) {
				
				String sql = "update board set title = ?, content=? where pk=?";
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,board.getTitle());
					pstmt.setString(2,board.getContent());
					pstmt.setInt(3,board.getPk());
					
					return pstmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				return -1;
			}
			
			//삭제
			public int board_delete(Board board) {
				
				String sql = "update board set board_delete = 1 where pk=?";
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, board.getPk());
					
					return pstmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				return -1;
			}
			
			//관리자 게시물 변경
			public int board_state(Board board) {
				
				String sql = "update board set title = ?, board_like =?, reg_date = ?, writer =?, board_delete =? where pk=?";
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, board.getTitle());
					pstmt.setInt(2, board.getBoard_like());
					pstmt.setString(3, board.getReg_date());
					pstmt.setString(4, board.getWriter());
					pstmt.setInt(5, board.getBoard_delete());
					pstmt.setInt(6, board.getPk());
					
					return pstmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				return -1;
			}
}