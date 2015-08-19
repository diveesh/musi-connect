function createDropDown(objectId, objectType) {
    var selectMenu = document.createElement('select');
    var divId = objectType + objectId;
    var resultDiv = document.getElementById(divId);
    resultDiv.appendChild(selectMenu);
}

function readURL(input) {

    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#profile_picture').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}