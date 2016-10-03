/**
 * Created by Atit Shetty on 25-09-2016.
 */

$(document).on('turbolinks:load', function(){
    intialize();
    checkLogIn();
    checkSignUp();
})

function intialize(){
    if((window.location.pathname.indexOf("/login") >=0)) {
        $('.headerHomePage').hide();
    }
    hideSearch();
}
function showSearch() {
    $(".hideSearchButton").show()
    $(".searchForm").show()
    $(".searchButton").hide()
    $(".search_form").trigger("reset");;
}

function hideSearch(){
    $(".hideSearchButton").hide()
    $(".searchForm").hide()
    $(".searchButton").show()
}

function makeAdmin(id){
    $.ajax({
        type: "POST",
        url: "/user/change_role",
        data: {"id":""+id},
        dataType: "json",
        success: function(data){

                window.location.reload()

        }
    });
}

function deleteUser(id){
    $.ajax({
        type: "POST",
        url: "/user/delete",
        data: {"id":""+id},
        dataType: "json",
        success: function(data){

            window.location.reload()

        }
    });
}

function validateLogInForm(formName){
    $(formName).validate({
        debug: true,
        rules: {
            "email": {required: true, email: true},
            "password": {required: true, minlength: 6}
}
});
}

function validateSignUpForm(formName){
    $(formName).validate({
        debug: true,
        rules: {
            "user[email]": {required: true, email: true},
            "user[password]": {required: true, minlength: 6},
            "user[password_confirmation]": {required:true, equalTo: "#user_password"},
            "user[phoneNumber]":{required:false, phoneUS: true},
            "user[name]":{required:true},
            "user[address]":{required:true},

        }
    });
}

function checkLogIn(){
    validateLogInForm(".signonform");
    $(".signonform").on('submit',function (e){
        $(".loginMessage").hide();
        $(".loginMessage").html("")

        e.preventDefault();
        $.ajax({
            type: 'post',
            url: '/sessions',
            data: $('.signonform').serialize(),
            success: function (data) {
                if (!data){
                    $(".signonform").trigger("reset");
                    $.rails.enableFormElements($($.rails.formSubmitSelector));
                    $(".loginMessage").html("Either your email or password is incorrect! <br>Please try again.")
                    $(".loginMessage").show();
                }
            }
        });

    });
}

function checkSignUp(){
    validateSignUpForm("#new_user.new_user");
    $("#new_user.new_user").on('submit',function (e){
        $(".signUpHeader").html("Checking your data...");
        $(".signupMessage").hide();
        $(".signupMessage").html("");
        $(".signUpCourtesy").hide();
        $('#new_user.new_user').hide();

        e.preventDefault();
        $.ajax({
            type: 'post',
            url: '/sign_up/create',
            data: $('#new_user.new_user').serialize(),
            success: function (data) {
                if(data.message == "success"){
                    $(".signUpHeader").html("Data verified.");
                    $(".signupMessage").html("Welome to the pack!<br>Please visit the <a href='/login'>login page</a> to enter the Library.")
                    $(".signupMessage").show();
                }else{
                    $(".signUpHeader").html("Let's get you signed up");
                    var msg = data.message;
                    $("#new_user.new_user").trigger("reset");
                    $(".signUpCourtesy").show();
                    $('#new_user.new_user').show();
                    $.rails.enableFormElements($($.rails.formSubmitSelector));
                    $(".signupMessage").html(msg+"<br>Please try again.")
                    $(".signupMessage").show();
                }
            }
        });

    });
}
