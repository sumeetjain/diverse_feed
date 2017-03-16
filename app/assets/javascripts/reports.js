window.addEventListener("load", function(e){

  // Find all graphs on the page, and initialize them
  // according to the Graph class.
  var graphs = document.getElementsByClassName("graph");
  for (var i = graphs.length - 1; i >= 0; i--) {
    var graph = new Graph(graphs[i]);
  }

});
