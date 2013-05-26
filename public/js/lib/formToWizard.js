/* Created by jankoatwarpspeed.com */

(function($) {
    $.fn.formToWizard = function(options) {

        options = $.extend({  
            submitButton: "" 
        }, options); 
        
        var element = this;

        var steps = $(element).find("fieldset");
        var count = steps.size();
        var submmitButtonName = "#" + options.submitButton;
        $(submmitButtonName).hide();

        // 2
        $(element).before("<ul id='steps'></ul>");

        steps.each(function(i) {
            $(this).wrap("<div id='step" + i + "'></div>");
            $(this).append("<p id='step" + i + "commands'></p>");

            // 2
            var name = $(this).find("legend").html();

            $("#steps").append("<li id='stepDesc" + i + "'>Step " + (i + 1) + "<span>" + name + "</span></li>");

            if (i == 0) {
                createNextButton(i);
                selectStep(i);
            }
            else if (i == count - 1) {
                $("#step" + i).hide();
                createPrevButton(i);
            }
            else {
                $("#step" + i).hide();
                createPrevButton(i);
                createNextButton(i);
            }
        });

        function createPrevButton(i) {
            var stepName = "step" + i;
            $("#" + stepName + "commands").append("<a href='#' id='" + stepName + "Prev' class='prev'>< Back</a>");

            $("#" + stepName + "Prev").bind("click", function(e) {
                $("#" + stepName).hide();
                $("#step" + (i - 1)).show();
                $(submmitButtonName).hide();
                selectStep(i - 1);
            });
        }

        function createNextButton(i) {

            var stepName = "step" + i;
            $("#" + stepName + "commands").append("<a href='#' id='" + stepName + "Next' class='next'>Next ></a>");

            $("#" + stepName + "Next").bind("click", function(e) {
                if($("#login").val()=="") {  alert('Login is required');return false;}
                
                if(!validateEmail($("#Email").val())) {  alert('Email is required or not valid');return false;}
                if($("#Password").val()=="") {  alert('Password is required');return false;}
                if(i==1){
                    if($("#fname").val()=="") {  alert('FirstName is required');return false;}    
                    if($("#lname").val()=="") {  alert('LastName is required');return false;}    
                    if($("#ad1").val()=="") {  alert('Adress 1 is required');return false;}    
                    if($("#City").val()=="") {  alert('City 1 is required');return false;}    
                    if($("#phone").val()=="") {  alert('Phone Number 1 is required');return false;}    
                    
                }
               

                $("#" + stepName).hide();
                $("#step" + (i + 1)).show();
                if (i + 2 == count)
                    $(submmitButtonName).show();
                selectStep(i + 1);
            });
        }

        function selectStep(i) {
            $("#steps li").removeClass("current");
            $("#stepDesc" + i).addClass("current");
        }

    }
})(jQuery); 


 //  if(validateEmail($("#email").val())) {  alert('Email is required or not valid');return false;} else {return true;} 

function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
} 
function validate_creditcardnumber() {
    var numbers = $("#CardNumber").val();
    var regex = /(\d{4}-){3}\d{4}/,g

    return regex.test(numbers);
}
function formsubmit(){
                    if($("#NameOnCard").val()=="") {  alert('NameOnCard is required');return false;}    
                    if($("#CardNumber").val()=="") {  alert('CardNumber is required');return false;}    
                    if($("#threenumbers").val()=="") {  alert('threenumbers 1 is required');return false;}    

    if(validate_creditcardnumber()!=true)
    {
        alert("CARD NUMBER ISN'T VALID");
        return false;
    }
 // save input string and strip out non-numbers
   // if(!checkLuhn($("#CardNumber").val().replace(/[^\d]/g, ''))) { alert('Sorry, that is not a valid number - please try again!');return false; }    
  //  else return true;
}