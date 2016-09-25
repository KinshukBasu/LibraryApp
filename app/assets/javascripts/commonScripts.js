/**
 * Created by Atit Shetty on 25-09-2016.
 */

$(document).ready(function(){
            if((window.location.pathname.indexOf("/login") >=0) || (window.location.pathname.indexOf("/signup") >=0)) {
                $('.headerHomePage').hide();
            }
    $(".hideSearchButton").hide()
    $(".searchForm").hide()

})
function showSearch() {
    $(".hideSearchButton").show()
    $(".searchForm").show()
    $(".searchButton").hide()
    document.getElementByClassName("search_form").reset();

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
