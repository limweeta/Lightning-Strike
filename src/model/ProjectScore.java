package model;

public class ProjectScore {
	 private double score;
	 private Project project;
	 public ProjectScore(){}
	 
	 public ProjectScore(Project project, double score){
		 this.project = project;
		 this.score = score;
	 }
	 
	 public Project getProject(){
		 return project;
	 }
	 
	 public double getScore(){
		 return score;
	 }
	 
	 public void setProj(Project project){
		 this.project = project;
	 }
	 
	 public void setScore(double score){
		 this.score = score;
	 }
}
