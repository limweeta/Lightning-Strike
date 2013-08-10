public class Team{
  @Id private Long id;
  private String name;
  
  public Team(){}
  
  public Team(Long id, String name){
    this(name);
    this.id = id;
  }
  
  public Team (String name){
    this.name = name;
  }
  
  public Long getId(){
    return id;
  }
  
  private String getName(){
    return name;
  }
  
  private void setName(String name){
    this.name = name;
  }
}
