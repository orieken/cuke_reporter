$(document).ready(function(){
  $('#btnPass').click(function(){
    $(".passed").toggle();
    if($(".passed").is(":visible")) { $("#btnPass").html('Hide Passing'); }
    else { $("#btnPass").html('Show Passing');  };
  });

  $('#btnFail').click(function(){
    $(".failed").toggle();
    if($(".failed").is(":visible")) { $("#btnFail").html('Hide Failing'); }
    else { $("#btnFail").html('Show Failing');  };
  });

  $('#btnUndefined').click(function(){
    $(".undefined").toggle();
    if($(".undefined").is(":visible")) { $("#btnUndefined").html('Hide Undefined'); }
    else { $("#btnUndefined").html('Show Undefined');  };
  });

  $('#btnCollapase').click(function(){
    if($("#btnCollapase").html() === "Collapse All"){$("#btnCollapase").html("Expand All");}
    else {$("#btnCollapase").html("Collapse All");}
    $('.collapse').collapse('toggle');
  });
});