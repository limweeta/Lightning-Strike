public class TeamRole{
  @Id private Long id;
  private String roleType;
  private String userName;
  private String teamName;
  
  public TeamRole(){}
  
  public TeamRole(Long id, String roleType, String userName, String teamName){
    this(roleType, userName, teamName);
    this.id = id;
  }
  
  public TeamRole(String roleType, String userName, String teamName){
    this.roleType = roleType;
    this.userName = userName;
    this.teamName = teamName;
  }
  
  public Long getId(){
    return id;
  }
  
  public String getRoleType(){
    return roleType;
  }
  
  public void setRoleType(String roleType){
    this.roleType = roleType;
  }
  
  public String getUserName(){
    return userName;
  }
  
  public void setUserName(String userName){
    this.userName = userName;
  }
  
  public String getTeamName(){
    return teamName;
  }
  
  public void setTeamName(String teamName){
    this.teamName = teamName;
  }
}
