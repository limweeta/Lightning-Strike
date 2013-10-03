package model;

public class Announcement {
	private String announcement;
	private String timestamp;
	private int id;
	
	public Announcement(){}
	
	public Announcement(int id, String announcement, String timestamp){
		this.id = id;
		this.announcement = announcement;
		this.timestamp = timestamp;
	}
	
	public String getAnnouncement(){
		return announcement;
	}
	
	public int getId(){
		return id;
	}
	
	public String getTimestamp(){
		return timestamp;
	}
	
	public void setAnnouncement(String announcement){
		this.announcement = announcement;
	}
	
	public void setTimestamp(String timestamp){
		this.timestamp = timestamp;
	}
	
	public void setId(int id){
		this.id = id;
	}
}
