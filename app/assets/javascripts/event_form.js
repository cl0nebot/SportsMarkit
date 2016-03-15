$(function() {
  $(".repeat-until").hide();
  $("#event_repeat_type").on("change", function() {
    if (this.value == "single") {
      $(".repeat-until").hide("fast");
    } else {
      $(".repeat-until").show("fast");
    }
  });
});