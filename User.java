public class User{
  
  @Id private Long id;
  private String fullName;
  private String userName;
  private String contact;
  private String gender;
  private String email;
  private String role;
  
  public User(){}
  
  public User(id, fullName, userName, contact, gender, email, role){
    this(fullName, userName, contact, gender, email, role);
    this.id = id;
  }
  
  public User(fullName, userName, contact, gender, email, role){
    this.fullname = fullName;
    this.username = userName;
    this.contact = contact;
    this.gender = gender;
    this.email = email;
    this.role = role;
  }
  
  public Long getId(){
    return id;
  }
  
  public String getFullName(){
    return fullName;
  }
  
  public void setFullName(String fullName){
    this.fullName = fullName;
  }
  
  public String getUserName(){
    return userName;
  }
  
  public void setUserName(String userName){
    this.userName = userName;
  }
  
  public String getContact(){
    return contact;
  }
  
  public void setContact(String contact){
    this.contact = contact;
  }
  
  public String getGender(){
    return gender;
  }
  
  public void setGender(String gender){
    this.gender = gender;
  }
  
  public String getEmail(){
    return email;
  }
  
  public void setEmail(String email){
    this.email = email;
  }
  
  public String getRole(){
    return role;
  }
  
  public void setRole(String role){
    this.role = role;
  }
}
