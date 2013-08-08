public class TA extends User{
  
  public TA(){}
  
  public TA(Long id, String fullName, String userName, String contact, String gender, String email, String role){
     super(id, fullName, userName, contact, gender, email, role);
  }
  
    public User(String fullName, String userName, String contact, String gender, String email, String role){
      super(fullName, userName, contact, gender, email, role);
  }
}
