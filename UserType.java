public class UserType{
  @Id private Long id;
  private String roleName;
  private String userName;
  private Long projectId;
  
  public UserType(){}
  
  public UserType(Long id, String roleName, String userName, Long projectId){
    this(roleName, userName, projectId);
    this.id = id;
  }
  
  public UserType(String roleName, String userName, Long projectId){
    this.roleName = roleName;
    this.userName = userName;
    this.projectId = projectId;
  }
  
  public Long getId(){
    return id;
  }
  
  public String getRoleName(){
    return roleName;
  }
  
  public void setRoleName(String roleName){
    this.roleName = roleName;
  }
  
  public String getUserName(){
    return userName;
  }
  
  public void setUserName(String userName){
    this.userName = userName;
  }
  
  public Long getNotificationId(){
    return notificationId;
  }
  
  public void setNotificationId(Long notificationId){
    this.notificationID = notificationId;
  }
}
