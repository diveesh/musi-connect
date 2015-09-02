jQuery(document).on('mouseenter', ".iffyTip", function () {
     var jQuerythis = jQuery(this);
     if (this.offsetWidth < this.scrollWidth && !jQuerythis.attr('title')) {
         jQuerythis.tooltip({
             title: jQuerythis.text(),
             placement: "top"
         });
         jQuerythis.tooltip('show');
     }
 });