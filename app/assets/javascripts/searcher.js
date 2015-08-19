function Searcher(resultsDivId, formId, URI, userId, callback) {
    this.callback = callback;
    this.resultsDivId = resultsDivId;
    this.formId = formId;
    this.URI = URI;
    this.userId = userId;
}

Searcher.prototype.submitForm = function() {
    var obj = this;
    jQuery('#searchForm').submit(function() {

            var url = obj.URI; // the script where you handle the form input.

            jQuery.ajax({
                   type: 'POST',
                   url: url,
                   data: jQuery('#searchForm').serialize(), // serializes the form's elements.
                   success: function(data)
                   {
                       obj.callback(data);
                   }
                 });

            return false; // avoid to execute the actual submit of the form.
        });
}

Searcher.prototype.search = function() {
  var obj = this;
  //jQuery("button").click(function(){
    jQuery.ajax({
      type: 'GET',
      url: obj.URI + obj.userId, 
      success: function(result){
        obj.callback(result);
      }
    });
//});
}