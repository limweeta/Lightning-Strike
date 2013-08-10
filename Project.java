public class Project{
  @Id private Long id;
  private String name;
  private String description;
  private String status;
  private String predecessor;
  
  public Project(){}
  
  public Project(Long id, String name, String description, String status, String predecessor){
    this(name, description, status, predecessor);
    this.id = id;
  }
  
  public Project(String name, String description, String status, String predecessor){
    this.name = name;
    this.description = description;
    this.status = status;
    this.predecessor = predecessor;
  }
  
  public Long getId(){
    return id;
  }
  
  public String getName(){
    return name;
  }
  
  public void setName(String name){
    this.name = name;
  }
  
  public String getDescription(){
    return description;
  }
  
  public void setDescription(String description){
    this.description = description;
  }
  
  public String getStatus(){
    return status;
  }
  
  public void setStatus(String status){
    this.status = status;
  }
  
  public String getPredecessor(){
    return predecessor;
  }
  
  public void setPredecessor(String predecessor){
    this.predecessor = predecessor;
  }
}
