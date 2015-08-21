function Searcher(resultsDivId, formId, URI, userId, callback) {
    this.callback = callback;
    this.resultsDivId = resultsDivId;
    this.formId = formId;
    this.URI = URI;
    this.userId = userId;
}

/*
 * Uses AJAX to submit a form without submitting the form via standard HTML. Expects
 * a JSON string as data in the successFn, which it then parses and passes onto the object's
 * callback.
 */
Searcher.prototype.submitForm = function() {
    var obj = this;
    jQuery('#' + obj.formId).submit(function() {

            var url = obj.URI; // the script where you handle the form input.

            jQuery.ajax({
                   type: 'POST',
                   url: url,
                   data: jQuery('#' + obj.formId).serialize(), // serializes the form's elements.
                   success: function(data)
                   {
                       obj.callback(JSON.parse(data));
                   }
                 });

            return false; // avoid to execute the actual submit of the form.
        });
}

Searcher.prototype.search = function() {
  var obj = this;
    jQuery.ajax({
      type: 'GET',
      url: obj.URI + obj.userId, 
      success: function(result){
        obj.callback(result);
      }
    });
}