package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import reply.Reply;;

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

}
