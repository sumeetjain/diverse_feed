// Collects all the Graphs that are created on a page.
window.graphs = [];

var Graph = function(graph){
  this.element = graph;
  this.index = graph.dataset.graphIndex;
  this.id = graph.dataset.graphId;
  this.canvas = graph.children[0].children[0];
  this.labels = graph.dataset.graphLabels;
  this.values = graph.dataset.graphValues;
  this.generated = false;
  this.allGraphs = this.element.parentElement.getElementsByClassName("graph");

  // Add a link for this graph, so the user can switch between graphs.
  this.addSwitcherLink();

  // Generate the first graph; hide the rest.
  if (this.index == 0){
    this.generate();
  }
  else {
    this.hide();
  }

  // Store the graph in the global namespace, so the collection
  // of graphs can be accessed later.
  graphs.push(this);
}

Graph.prototype.addSwitcherLink = function() {
  var graph = this;
  var linksContainer = document.getElementsByClassName("demographicKeys")[0];

  var linkHTML  = '<a href="#" class="showGraphLink">';
      linkHTML += this.id;
      linkHTML += '</a>';

  var link = $(linkHTML);
  var li   = $("<li></li>");
  $(li).append(link);
  $(linksContainer).append(li);

  link.on("click", function(e){
    graph.show();
  })
};

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

  this.generated = true;
};

Graph.prototype.show = function() {
  this.hidden = false;
  this.hideAll();
  this.element.classList.remove("graph--hidden");

  if (!this.generated){
    this.generate();
  }
};

Graph.prototype.hide = function() {
  this.hidden = true;
  this.element.classList.add("graph--hidden");
};

Graph.prototype.hideAll = function() {
  for (var i = graphs.length - 1; i >= 0; i--) {
    graphs[i].hide();
  }
};
