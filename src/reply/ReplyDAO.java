package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.Board;
import reply.Reply;
import user.User;;

public class ReplyDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ReplyDAO() {	
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
		public int write(Reply reply) {
			String sql = "insert into board_reply values (null,?,?,?,now(),0)";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,reply.getBoard_pk());
				pstmt.setString(2,reply.getReplytext());
				pstmt.setString(3,reply.getUser_reply_pk());				
				return pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		
		// 수정
					public int reply_change(Reply reply) {
						
						String sql = "update board_reply set replytext = ?, reg_date=now() where pk=?";
						
						try {
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1,reply.getReplytext());
							pstmt.setInt(2,reply.getPk());
							
							return pstmt.executeUpdate();
							
						}catch(Exception e) {
							e.printStackTrace();
						}
						return -1;
					}
					
					//삭제
					public int reply_delete(Reply reply) {
						
						String sql = "update board_reply set board_reply_delete = 1 where pk=?";
						
						try {
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, reply.getPk());
							
							return pstmt.executeUpdate();
							
						}catch(Exception e) {
							e.printStackTrace();
						}
						return -1;
					}
					
					//댓글 목록 보기
					public ArrayList<Reply> get_reply_list(int pk){
						String SQL = "select * from board_reply where board_pk=? order by pk desc";
						ArrayList<Reply> list = new ArrayList<Reply>();
						try {
							PreparedStatement pstmt = conn.prepareStatement(SQL);
							pstmt.setInt(1, pk);
							rs = pstmt.executeQuery();
							while(rs.next()) {
								Reply reply = new Reply();
								reply.setPk(rs.getInt(1));
								reply.setBoard_pk(rs.getInt(2));
								reply.setReplytext(rs.getString(3));
								reply.setUser_reply_pk(rs.getString(4));
								reply.setReg_date(rs.getString(5));
								reply.setBoard_reply_delete(rs.getInt(6));
								list.add(reply);
							}
						}catch(Exception e) {
							e.printStackTrace();
						}
						return list;		
					}
					
					//마이페이지 내 댓글 뽑아오기
					public ArrayList<Reply> getMypage_reply_list(String id){
						String SQL = "select * from board_reply where user_reply_pk =? AND board_reply_delete=0";
						ArrayList<Reply> list = new ArrayList<Reply>();
						try {
							PreparedStatement pstmt = conn.prepareStatement(SQL);
							pstmt.setString(1,id);
							rs = pstmt.executeQuery();
							while(rs.next()) {
								Reply reply = new Reply();
								reply.setPk(rs.getInt(1));
								reply.setBoard_pk(rs.getInt(2));
								reply.setReplytext(rs.getString(3));
								reply.setUser_reply_pk(rs.getString(4));
								reply.setReg_date(rs.getString(5));
								reply.setBoard_reply_delete(rs.getInt(6));
								list.add(reply);
							}
						}catch(Exception e) {
							e.printStackTrace();
						}
						return list;
					}

}
