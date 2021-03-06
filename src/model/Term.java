package model;

public class Term {
	private String acadYear;
	private String sem;
	private int id;
	private String startDate;
	private String endDate;
	
	public Term(){}
	
	public Term(String acadYear, String sem){
		this.acadYear = acadYear;
		this.sem = sem;
	}
	
	public Term(String acadYear, String sem, String startDate, String endDate){
		this.acadYear = acadYear;
		this.sem = sem;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	
	public Term(int id, String acadYear, String sem, String startDate, String endDate){
		this.id = id;
		this.acadYear = acadYear;
		this.sem = sem;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	
	public Term(int id, String acadYear, String sem){
		this.id = id;
		this.acadYear = acadYear;
		this.sem = sem;
	}
	
	public String getStartDate(){
		return startDate;
	}
	
	public String getEndDate(){
		return endDate;
	}
	
	public String getAcadYear(){
		return acadYear;
	}
	
	public int getId(){
		return id;
	}
	
	public String getSem(){
		return sem;
	}
	
	public void setAcadYear(String acadYear){
		this.acadYear = acadYear;
	}
	
	public void setSem(String sem){
		this.sem = sem;
	}
	
	public void setStartDate(String startDate){
		this.startDate = startDate;
	}
	
	public void setEndDate(String endDate){
		this.endDate = endDate;
	}
	
	public void setId(int id){
		this.id = id;
	}
}
