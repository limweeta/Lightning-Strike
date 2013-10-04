package model;

public class Term {
	private String acadYear;
	private int sem;
	private int id;
	
	public Term(){}
	
	public Term(int id, String acadYear, int sem){
		this.id = id;
		this.acadYear = acadYear;
		this.sem = sem;
	}
	
	public String getAcadYear(){
		return acadYear;
	}
	
	public int getId(){
		return id;
	}
	
	public int getSem(){
		return sem;
	}
	
	public void setAcadYear(String acadYear){
		this.acadYear = acadYear;
	}
	
	public void setSem(int sem){
		this.sem = sem;
	}
	
	public void setId(int id){
		this.id = id;
	}
}
