public class Faculty{
  @Id private Long id;
  private String facultyEmail;
  private String facultyName;
  private String facultyContact;
  
  public Faculty(){}
  
  public Faculty(Long id, String facultyEmail, String facultyName, String facultyContact){
    this(facultyEmail, facultyName, facultyContact);
    this.id=id;
  }
  
  public Faculty(String facultyEmail, String facultyName, String facultyContact){
    this.facultyEmail = facultyEmail;
    this.facultyName = facultyName;
    this.facultyContact = facultyContact;
  }
  
  public Long getId(){
    return id;
  }
  
  public String getFacultyEmail(){
    return facultyEmail;
  }
  
  public void setFacultyEmail(String facultyEmail){
    this.facultyEmail = facultyEmail;
  }
  
  public String getFacultyName(){
    return facultyName;
  }
  
  public void setFacultyName(String facultyName){
    this.facultyName = facultyName;
  }
  
  public String getFacultyContact(){
    return facultyContact;
  }
  
  public void setFacultyContact(String facultyContact){
    this.facultyContact = facultyContact;
  }
}
