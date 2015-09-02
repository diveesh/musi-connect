jQuery(document).on('mouseenter', ".iffyTip", function () {
     var jQuerythis = jQuery(this);
     if (this.offsetWidth < this.scrollWidth) {
         jQuerythis.tooltip();
     }
 });