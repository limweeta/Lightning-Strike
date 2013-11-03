package model;

public class SecondMajor {
	private String secondMajor;
	private int id;
	
	public SecondMajor(){}
	
	public SecondMajor(int id, String secondMajor){
		this.id = id;
		this.secondMajor = secondMajor;
	}
	
	public String getSecondMajor(){
		return secondMajor;
	}
	
	public int getId(){
		return id;
	}
	
	public void setSecondMajor(String secondMajor){
		this.secondMajor = secondMajor;
	}
	
	public void setId(int id){
		this.id = id;
	}
}
