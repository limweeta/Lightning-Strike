<link rel="stylesheet" href="css/bootstrap.css" type="text/css"/>
<link rel="stylesheet" href="css/bootstrap-multiselect.css" type="text/css"/>
 
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/bootstrap-multiselect.js"></script>
    	<%@ include file="template.jsp" %> 

<script type="text/javascript">
  $(document).ready(function() {
    $('#example22').multiselect({
      buttonClass: 'btn',
      buttonWidth: 'auto',
      buttonText: function(options) {
        if (options.length == 0) {
          return 'None selected <b class="caret"></b>';
        } else if (options.length > 6) {
          return options.length + ' selected  <b class="caret"></b>';
        } else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      },
      onChange: function(element, checked) {
        if(checked == true) {
          // action taken here if true
        } else if (checked == false) {
          if (confirm('Do you wish to deselect the element?')) {
            // action taken here
          } else {
            $("#example22").multiselect('select', element.val());
            return false;
          }
        }
      }
    });
  });
</script>

<div class="input-group btn-group">
  <span class="input-group-addon"><b class="glyphicon glyphicon-list-alt"></b></span>
  <select class="multiselect" multiple="multiple">
    <option value="cheese">Cheese</option>
    <option value="tomatoes">Tomatoes</option>
    <option value="mozarella">Mozzarella</option>
    <option value="mushrooms">Mushrooms</option>
    <option value="pepperoni">Pepperoni</option>
    <option value="onions">Onions</option>
  </select>
  <button class="btn btn-danger">Cancel</button>
  <button class="btn btn-success">Save</button>
</div>