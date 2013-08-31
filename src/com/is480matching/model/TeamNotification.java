public class TeamNotification{
  @Id private Long id;
  private Long notificationId;
  private String teamName;
  
  public TeamNotification(){}
  
  public TeamNotification(Long id, Long notificationId, String teamName){
    this(notificationId, teamName);
    this.id = id;
  }
  
  public TeamNotification(Long notificationId, String teamName){
    this.notitificationId = notificationId;
    this.teamName = teamName;
  }
  
  public Long getId(){
    return id;
  }
  
  public Long getNotitificationId(){
    return notificationId;
  }
  
  public void setNotificationId(Long notificationId){
    this.notificationId = notificationId;
  }
  
  public String getTeamName(){
    return teamName;
  }
  
  public void setTeamName(String teamName){
    this.teamName = teamName;
  }
}
