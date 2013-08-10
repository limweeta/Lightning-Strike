public class Notification{
  @Id private Long id;
  private String content;
  private String timestamp;
  private boolean read;
  
  public Notification(){}
  
  public Notification(Long id, String content, String timestamp, boolean read){
    this(content, timestamp, read);
    this.id = id;
  }
  
  public Notification(String content, String timestamp, boolean read){
    this.content = content;
    this.timestamp = timestamp;
    this.read = read;
  }
  
  public Long getId(){
    return id;
  }
  
  public String getContent(){
    return content;
  }
  
  public void setContent(String content){
    this.content = content;
  }
  
  public String getTimestamp(){
    return timestamp;
  }
  
  public void setTimestamp(String timestamp){
    this.timestamp = timestamp;
  }
  
  public boolean getRead(){
    return read;
  }
  
  public void setRead(boolean read){
    this.read = read;
  }
}
