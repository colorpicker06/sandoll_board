package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
			
			//글 목록 갯수 받아오기 
			public int board_count() {
				int count =0;    
				Statement stmt = null;
		        try{
		        	stmt = conn.createStatement();
		        	
		    	    ResultSet countrs = stmt.executeQuery("select count(*) from board where board_delete = 0;"); 
		            
		            if(countrs.next()){
		                count = countrs.getInt(1);
		            }
		            
				}catch(Exception e) {
					e.printStackTrace();
				}
				return count;
			}
			
			//좋아요 업데이트
			public int board_like_count(int board_pk,int board_count) {
				
				String sql = "update board set board_like = ? where pk=?";
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1,board_count);
					pstmt.setInt(2,board_pk);
					
					return pstmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				return -1;			
			}
			
			
			
			//글 목록 불러오기
			public ArrayList<Board> getList(String pageNumber){
				String SQL = "select * from board where board_delete=0 and pk > (select max(pk) from board) -? and pk <= (select max(pk) from board) - ? order by pk desc";
				ArrayList<Board> boardList = null;
				try {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1,Integer.parseInt(pageNumber)*10);
					pstmt.setInt(2,(Integer.parseInt(pageNumber)-1)*10);
					rs = pstmt.executeQuery();
					boardList = new ArrayList<Board>();
					while (rs.next()) {
						Board board = new Board();
						board.setPk(rs.getInt(1));
						board.setTitle(rs.getString(2));
						board.setContent(rs.getString(3));
						board.setWriter(rs.getString(4));
						board.setReg_date(rs.getString(5));
						board.setBoard_like(rs.getInt(6));
						board.setBoard_delete(rs.getInt(7));
						boardList.add(board);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return boardList;		
			}

			
			//다음 페이지
			public boolean nextPage(String pageNumber) {
				String SQL = "SELECT * from board where pk >= ?";
				try {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, Integer.parseInt(pageNumber) * 10);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						return true;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return false;
			}
			
			//다음 페이지
			public int targetPage(String pageNumber) {
				String SQL = "SELECT count(pk) from board where board_delete = 0 and pk >= ?";
				try {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, (Integer.parseInt(pageNumber)-1) * 10);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						return rs.getInt(1)/10;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return 0;
			}
			
			//글 상세내용
			public ArrayList<Board> getDetail(int pk){
				String SQL = "select * from board where pk =?";
				ArrayList<Board> list = new ArrayList<Board>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, pk);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						Board board = new Board();
						board.setPk(rs.getInt(1));
						board.setTitle(rs.getString(2));
						board.setContent(rs.getString(3));
						board.setWriter(rs.getString(4));
						board.setReg_date(rs.getString(5));
						board.setBoard_like(rs.getInt(6));
						board.setBoard_delete(rs.getInt(7));
						list.add(board);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return list;
			}
		
			
			//마이페이지 내 글 뽑아오기
			public ArrayList<Board> getMypage_board_list(String id){
				String SQL = "select * from board where writer =? AND board_delete=0";
				ArrayList<Board> list = new ArrayList<Board>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1,id);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						Board board = new Board();
						board.setPk(rs.getInt(1));
						board.setTitle(rs.getString(2));
						board.setContent(rs.getString(3));
						board.setWriter(rs.getString(4));
						board.setReg_date(rs.getString(5));
						board.setBoard_like(rs.getInt(6));
						board.setBoard_delete(rs.getInt(7));
						list.add(board);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return list;
			}
			
}