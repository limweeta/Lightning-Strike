public class Student extends User{
  
  @Id private Long id;
  private String secondMajor;
  
  public Student(){}
  
  public Student(Long id, String email, String fullname, String contact, String secondMajor){
    super(id, email, fullname,contact);
    this.secondMajor = seccondMajor;
  }
  
  public String getSecondMajor(){
    return secondMajor;
  }
  
  public void setSecondMajor(String secondMajor){
    this.secondMajor = secondMajor;
  }
} 
