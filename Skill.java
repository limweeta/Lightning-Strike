public class Skill{
  @Id private Long id;
  private String skill;
  
  public Skill(){}
  
  public Skill(Long id, String skill){
    this(skill);
    this.id = id;
  }
  
  public Skill(String skill){
    this.skill = skill;  
  }
  
  public Long getId(){
    return id;
  }
  
  public String getSkill(){
    return skill;
  }
  
  public void setSkill(String skill){
    this.skill = skill;
  }
}
