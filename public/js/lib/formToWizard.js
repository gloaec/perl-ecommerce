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


function isValidCCNumber( ccNum ) {
    var cardNum = new String( ccNum );
    var digitsOnly = "";
    // Filter out non-digit characters
    for( var i = 0; i < cardNum.length; i++ ) {
        if( "0123456789".indexOf( cardNum.charAt( i ) ) > -1 ) {
            digitsOnly += cardNum.charAt( i );
        }
    }
    // Perform Luhn check
    var sum = 0;
    var digit = 0;
    var addend = 0;
    var timesTwo = false;
    for( var i = digitsOnly.length - 1; i >= 0; i-- ) {
        digit = parseInt( digitsOnly.charAt( i ) );
        if( timesTwo ) {
            addend = digit * 2;
            if( addend > 9 ) {
                addend -= 9;
            }
        } else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    return sum % 10 == 0;
}
function checkLuhn(input) { 
    var sum = 0;
     var numdigits = input.length;
      var parity = numdigits % 2;
       for(var i=0; i < numdigits; i++) {
        var digit = parseInt(input.charAt(i)); 
        if(i % 2 == parity) 
            digit *= 2; 
            if(digit > 9) 
                digit -= 9;
                 sum += digit;
     } return (sum % 10) == 0; 
}
function validate_creditcardnumber() {
    var numbers = $("#CardNumber").val();
    var regex = /(\d{4}-){3}\d{4}/,g

    return regex.test(numbers);
}
function formsubmit(){
    if(validate_creditcardnumber()==true)
    return true;
    else return false;
 // save input string and strip out non-numbers
   // if(!checkLuhn($("#CardNumber").val().replace(/[^\d]/g, ''))) { alert('Sorry, that is not a valid number - please try again!');return false; }    
  //  else return true;
}