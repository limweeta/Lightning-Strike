<script>

function validateForm(theForm) {
	var reason = "";

	  reason += validateFullname(theForm.fullName);
	  reason += validatePhone(theForm.contactNum);
	  reason += validateEmail(theForm.email);
	  reason += validateUsername(theForm.userName);
	  reason += validatePassword(theForm.password);
	  reason += validateSelect(theForm.orgType);	
	  if (reason != "") {
	    alert("Some fields need correction:\n" + reason);
	    return false;
	  }
	  return true;
}
function validateSelect(fld){
	var error="";
	if(fld.value == "default"){
		fld.style.background='Yellow';
		error="Please select an Organization type.\n";
	}else{
		fld.style.background='White';
	}
	return error;
}

function validateFullname(fld) {
    var error = "";
    var illegalChars = /[0-9]/; // allow letters ONLY
 
    if (fld.value.length == 0) {
        fld.style.background = 'Yellow'; 
        error = "Please enter your full name.\n";
    } /* else if ((fld.value.length < 5) || (fld.value.length > 15)) {
        fld.style.background = 'Yellow'; 
        error = "Your full name is the wrong length.\n";
    } */ else if (illegalChars.test(fld.value)) {
        fld.style.background = 'Yellow'; 
        error = "Your full name contains illegal characters.\n";
    } else {
        fld.style.background = 'White';
    } 
    return error;
}

function validatePhone(fld)  
{  
  var error  = "";
  var phoneno = /^[\d\.\-\+]+$/;  
  if(!(fld.value.match(phoneno))){  
	  error = "Invalid phone number.\n"; 
	  fld.style.background='Yellow';
  }else if(fld.value.length == 0){  
	  error = "Please enter a phone number.\n";  
	  fld.style.background='Yellow'; 
  }else if(fld.value.length<8){
	  error="Invalid phone number. \n";
	  fld.style.background='Yellow';
  }else {
      fld.style.background = 'White';
  }
  return error;
}  

function validateEmail(fld) {
    var error="";
    var tfld = trim(fld.value);                        // value of field with whitespace trimmed off
    var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
    var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
    
    if (fld.value.length == 0) {
        fld.style.background = 'Yellow';
        error = "Please enter an email address.\n";
    } else if (!emailFilter.test(tfld)) {              //test email for illegal characters
        fld.style.background = 'Yellow';
        error = "Please enter a valid email address.\n";
    } else if (fld.value.match(illegalChars)) {
        fld.style.background = 'Yellow';
        error = "The email address contains illegal characters.\n";
    } else {
        fld.style.background = 'White';
    }
    return error;
}

function validateUsername(fld) {
    var error = "";
  
    if (fld.value.length == 0) {
        fld.style.background = 'Yellow'; 
        error = "Please enter your username.\n";
    } else {
        fld.style.background = 'White';
    }
    return error;   
}

function validatePassword(fld) {
    var error = "";
  
    if (fld.value.length == 0) {
        fld.style.background = 'Yellow'; 
        error = "Please enter your password.\n";
    } else {
        fld.style.background = 'White';
    }
    return error;   
}

function trim(s)
{
  return s.replace(/^\s+|\s+$/, '');
} 

</script>

<html>
	<link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<form name="register" method="post" onSubmit = "return validateFormOnSubmit(this)" accept-charset="UTF-8">
		  <input type="text" name="userName" id="userName" style="margin-bottom: 20px; height:30px;" type="text" name="new[username]" placeholder="Username" size="45" />
		  <input type="text" name="fullName" id="fullName" style="margin-bottom: 20px; height:30px;" type="text" name="new[fullname]" placeholder="Full Name" size="45" />
		  <input type="text" name="contactNum" id="contactNum" style="margin-bottom: 20px; height:30px;" type="text" name="new[contact]" placeholder="Contact Number" size="45" />
		  <input type="text" name="email"  id="email" style="margin-bottom: 20px; height:30px;" type="text" name="new[email]" placeholder="Email" size="45" />
		  <input type="text" name="coyName"  id="coyName" style="margin-bottom: 20px; height:30px;" type="text" name="new[companyname]" placeholder="Company Name" size="45" />
		  <input type="text" name="coyContact"  id="coyContact" style="margin-bottom: 20px; height:30px;" type="text" name="new[companycontact]" placeholder="Company Contact Number" size="45" />
		  <input type="text" name="coyAdd"  id="coyAdd" style="margin-bottom: 20px; height:30px;" type="text" name="new[companyadd]" placeholder="Company Address" size="45" />
		  <input type="password" name="password"  id="password" style="margin-bottom: 20px; height:30px;" type="password" name="new[password]" placeholder="Password" size="45" />
		  <div id="loginError" class="error"></div>
		  <div class="field-container">
				<input type="hidden" class="right rounded" name="type" id="type" value="sponsor" />
		  </div>
		  <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Register" />
	</form>
</html>