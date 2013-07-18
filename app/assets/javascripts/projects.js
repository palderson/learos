$(function() {
  $("a[data-toggle='tab']").on("shown", function (e) {
    var hash = $(e.target).attr("href");
    localStorage.setItem('lastTab', $(e.target).attr('href'));
  });

  var lastTab = localStorage.getItem('lastTab');
  if (lastTab) {
      $("a[href='" + lastTab + "']").tab("show");
  }
});
