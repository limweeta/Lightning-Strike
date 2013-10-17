package model;

public class ProjectScore {
	 private double score;
	 private double totalScore;
	 private Project project;
	 public ProjectScore(){}
	 
	 public ProjectScore(Project project, double score, double totalScore){
		 this.project = project;
		 this.score = score;
		 this.totalScore = totalScore;
	 }
	 
	 public Project getProject(){
		 return project;
	 }
	 
	 public double getScore(){
		 return score;
	 }
	 
	 public double getTotalScore(){
		 return totalScore;
	 }
	 
	 public void setProj(Project project){
		 this.project = project;
	 }
	 
	 public void setScore(double score){
		 this.score = score;
	 }
	 
	 public void setTotalScore(double totalScore){
		 this.score = score;
	 }
}
