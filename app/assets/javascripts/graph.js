// Contains functionality related to displaying the graphs for a report. Each
// Graph object created from the class below represents a single graph (e.g.
// the graph for 'race'), so a collection of Graph objects (e.g. an Array
// containing the Graph objects for 'race', 'gender', and 'sexual
// orientation') is what's used when showing a report.

// ----------------------------------------------------------------------------

// Creates a new Graph.
//
// element - DOM element matching the following spec (example):
//             class="js-graph"
//             data-graph-id="race"
//             data-graph-index="0"
//             data-graph-labels="['Black / African-American', 'White']"
//             data-graph-values="[50.0,50.0]"
//
//           The element's first child must be `.exhibit`, and `.exhibit`'s
//           first child must be a `canvas`.
//
//           Example (attributes' values omitted for ease of reading):
//
//             <div class="js-graph"
//               data-graph-id="" data-graph-index=""
//               data-graph-labels="" data-graph-values="">
//
//               <div class="exhibit">
//                 <canvas id="graph_race"></canvas>
//               </div>
//             </div>
//
// Returns a Graph.
var Graph = function(element){
  this.element = element;

  // Tracks the state of the graph's generation. Later, when this graph's
  // visuals are actually created, this Boolean will flip.
  this.generated = false;

  // Returns an Integer of this graph's zero-based position in its collection,
  // e.g. `2` for the third graph.
  this.index = parseInt(element.dataset.graphIndex);

  // Returns a String with the graph's demographic key, e.g. "race".
  this.id = element.dataset.graphId;

  // Returns the `canvas` DOM element for the graph to be inserted into.
  this.canvas = element.children[0].children[0];

  // Returns an Array with the demographic labels (keys), e.g. ["Black / African-American", "White"].
  this.labels = JSON.parse(element.dataset.graphLabels);

  // Returns an Array with the demographic percentages, e.g. [50.0, 50.0].
  this.values = JSON.parse(element.dataset.graphValues);

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

// Add this graph to the menu.
//
// When a user clicks on this link, it will show this graph.
Graph.prototype.addSwitcherLink = function() {
  var graph = this;

  var link = document.createElement("a");
  link.setAttribute("href", "#");
  link.classList.add("showGraphLink");
  link.appendChild(document.createTextNode(this.id))

  var li = document.createElement("li");
  li.appendChild(link);

  var linksUL = document.getElementsByClassName("js-demographicKeys")[0];
  linksUL.insertBefore(li, linksUL.children[0]);

  link.addEventListener("click", function(e){
    graph.show();
  })
};

// Generate this graph's visuals, using Chart.js.
Graph.prototype.generate = function() {
  var chart = new Chart(this.canvas, {
    type: 'pie',
    data: {
      labels: this.labels,
      datasets: [{
        label: 'TODO: Graph Label Goes Here',
        data: this.values,
        backgroundColor: window.graphSectionColors
      }]
    },
    options: {
    }
  });

  this.generated = true;
};

// Show only this graph.
Graph.prototype.show = function() {
  this.hidden = false;
  this.hideAll();
  this.element.classList.remove("graph--isHidden");

  if (!this.generated){
    this.generate();
  }
};

// Hide only this graph.
Graph.prototype.hide = function() {
  this.hidden = true;
  this.element.classList.add("graph--isHidden");
};

// Hide all graphs.
Graph.prototype.hideAll = function() {
  for (var i = graphs.length - 1; i >= 0; i--) {
    graphs[i].hide();
  }
};

// ----------------------------------------------------------------------------

// Collects all the Graphs that are created on a page.
window.graphs = [];

// Set colors for graph sections (i.e. pie pieces).
window.graphSectionColors = [
  "#ECD078",
  "#D95B43",
  "#C02942",
  "#542437",
  "#53777A",
  "#6AEBBA",
  "#CE1FC8",
  "#1E30B3",
  "#32431B",
  "#664055",
]
