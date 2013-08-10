public class Requirement{
  @Id private Long id;
  private String requirement;
  
  public Requirement(){}
  
  public Requirement(Long id, String requirement){
    this(requirement);
    this.id = id;
  }
  
  public Requirement(String requirement){
    this.requirement = requirement;  
  }
  
  public Long getId(){
    return id;
  }
  
  public String getRequirement(){
    return requirement;
  }
  
  public void setRequirement(String requirement){
    this.requirement = requirement;
  }
}
