var Graph = function(graph){
  this.element = graph;
  this.index = graph.dataset.graphIndex;
  this.canvas = graph.children[0].children[0];
  this.labels = graph.dataset.graphLabels;
  this.values = graph.dataset.graphValues;

  // Generate the first graph; hide the rest.
  if (this.index == 0){
    this.generate();
  }
  else {
    this.hide();
  }
}

Graph.prototype.generate = function() {
  var chart = new Chart(this.canvas, {
    type: 'pie',
    data: {
      labels: JSON.parse(this.labels),
      datasets: [{
        label: 'TODO: Graph Label Goes Here',
        data: JSON.parse(this.values)
      }]
    },
    options: {
    }
  });
};

Graph.prototype.show = function() {
  this.hidden = false;
  this.element.classList.remove("graph--hidden");
};

Graph.prototype.hide = function() {
  this.hidden = true;
  this.element.classList.add("graph--hidden");
};
