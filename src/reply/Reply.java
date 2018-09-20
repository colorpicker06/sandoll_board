package reply;

public class Reply {
	
	private int pk;
	private int board_pk;
	private String replytext;
	private String user_reply_pk;
	private String reg_date;
	private int board_reply_delete;
	
	public int getPk() {
		return pk;
	}
	public void setPk(int pk) {
		this.pk = pk;
	}
	public int getBoard_pk() {
		return board_pk;
	}
	public void setBoard_pk(int board_pk) {
		this.board_pk = board_pk;
	}
	public String getReplytext() {
		return replytext;
	}
	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}
	public String getUser_reply_pk() {
		return user_reply_pk;
	}
	public void setUser_reply_pk(String user_reply_pk) {
		this.user_reply_pk = user_reply_pk;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getBoard_reply_delete() {
		return board_reply_delete;
	}
	public void setBoard_reply_delete(int board_reply_delete) {
		this.board_reply_delete = board_reply_delete;
	}
	

}
