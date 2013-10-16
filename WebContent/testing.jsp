<script>
function validateFormOnSubmit(theForm) {
	var reason = "";

	  reason += validateUsername(theForm.username);
	  reason += validatePassword(theForm.pwd);
	  reason += validateEmail(theForm.email);
	  reason += validatePhone(theForm.phone);
	  reason += validateEmpty(theForm.from);
	      
	  if (reason != "") {
	    alert("Some fields need correction:\n" + reason);
	    return false;
	  }

	  return true;
}

function validateEmpty(fld) {
    var error = "";
  
    if (fld.value.length == 0) {
        fld.style.background = 'Yellow'; 
        error = "The required field has not been filled in.\n"
    } else {
        fld.style.background = 'White';
    }
    return error;   
}

function validateUsername(fld) {
    var error = "";
    var illegalChars = /\W/; // allow letters, numbers, and underscores
 
    if (fld.value == "") {
        fld.style.background = 'Yellow'; 
        error = "You didn't enter a username.\n";
    } else if ((fld.value.length < 5) || (fld.value.length > 15)) {
        fld.style.background = 'Yellow'; 
        error = "The username is the wrong length.\n";
    } else if (illegalChars.test(fld.value)) {
        fld.style.background = 'Yellow'; 
        error = "The username contains illegal characters.\n";
    } else {
        fld.style.background = 'White';
    } 
    return error;
}

function validatePassword(fld) {
    var error = "";
    var illegalChars = /[\W_]/; // allow only letters and numbers 
 
    if (fld.value == "") {
        fld.style.background = 'Yellow';
        error = "You didn't enter a password.\n";
    } else if ((fld.value.length < 7) || (fld.value.length > 15)) {
        error = "The password is the wrong length. \n";
        fld.style.background = 'Yellow';
    } else if (illegalChars.test(fld.value)) {
        error = "The password contains illegal characters.\n";
        fld.style.background = 'Yellow';
    } else if (!((fld.value.search(/(a-z)+/)) && (fld.value.search(/(0-9)+/)))) {
        error = "The password must contain at least one numeral.\n";
        fld.style.background = 'Yellow';
    } else {
        fld.style.background = 'White';
    }
   return error;
}  

function trim(s)
{
  return s.replace(/^\s+|\s+$/, '');
} 

function validateEmail(fld) {
    var error="";
    var tfld = trim(fld.value);                        // value of field with whitespace trimmed off
    var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
    var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
    
    if (fld.value == "") {
        fld.style.background = 'Yellow';
        error = "You didn't enter an email address.\n";
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

function validatePhone(fld) {
    var error = "";
    var stripped = fld.value.replace(/[\(\)\.\-\ ]/g, '');     

   if (fld.value == "") {
        error = "You didn't enter a phone number.\n";
        fld.style.background = 'Yellow';
    } else if (isNaN(parseInt(stripped))) {
        error = "The phone number contains illegal characters.\n";
        fld.style.background = 'Yellow';
    } else if (!(stripped.length == 10)) {
        error = "The phone number is the wrong length. Make sure you included an area code.\n";
        fld.style.background = 'Yellow';
    } 
    return error;
}
</script>

<html>
<head>
<title>WebCheatSheet - JavaScript Tutorial</title>
</head>
<body>
<h1>WebCheatSheet - JavaScript Tutorial</h1>

<form name="demo" onsubmit="return validateFormOnSubmit(this)" action="test.htm">
<table summary="Demonstration form">
  <tbody>
  <tr>
    <td><label for="username">Your user name:</label></td>
    <td><input name="username" size="35" maxlength="50" type="text"></td>
  </tr>   
  <tr>
    <td><label for="pwd">Your password</label></td>
    <td><input name="pwd" size="35" maxlength="25" type="password"></td>
  </tr>   
  <tr>
    <td><label for="email">Your email:</label></td>
    <td><input name="email" size="35" maxlength="30" type="text"></td>
  </tr>   
  <tr>
    <td><label for="phone">Your telephone number:</label></td>
    <td><input name="phone" size="35" maxlength="25" type="text"></td>
  </tr>   
  <tr>
    <td>
        <label for="from">Where are you :</label></td>
    <td><input name="from" size="35" maxlength="50" type="text"></td>
  </tr>   
  <tr>
    <td>&nbsp;</td>
    <td><input name="Submit" value="Send" type="submit" ></td>
    <td>&nbsp;</td>
  </tr> 
  </tbody>
</table>
</form> 


</body>
</html>