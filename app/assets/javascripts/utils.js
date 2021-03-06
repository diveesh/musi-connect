function createDropDown(objectId, objectType) {
    var selectMenu = document.createElement('select');
    var divId = objectType + objectId;
    var resultDiv = document.getElementById(divId);
    resultDiv.appendChild(selectMenu);
}

function readURL(input, id) {

    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#' + id).attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

function ajaxFormSubmit(URI, formId, callback) {
    jQuery('#' + formId).submit(function() {

            var url = URI; // the script where you handle the form input.

            jQuery.ajax({
                   type: 'POST',
                   url: url,
                   data: jQuery('#' + formId).serialize(), // serializes the form's elements.
                   success: function(data)
                   {
                       callback(data);
                   }
                 });

            return false; // avoid to execute the actual submit of the form.
        });
}