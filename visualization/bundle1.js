looker.plugins.visualizations.add({
  // Id and Label are legacy properties that no longer have any function besides documenting
  // what the visualization used to have. The properties are now set via the manifest
  // form within the admin/visualizations page of Looker
  id: "hello_world",
  label: "Hello World",
  options: {
    font_size: {
      type: "string",
      label: "Font Size",
      values: [
        {"Large": "large"},
        {"Med": "med"},
        {"Small": "small"}
      ],
      display: "radio",
      default: "large"
    },
    font_color: {
      type: "string",
      label: "Font Color",
      values: [
       {"Red": "red"},
        {"Green": "green"},
        {"Yellow": "yellow"}
    ],
    display: "radio",
    default: "large"
    }
  },
  // Set up the initial state of the visualization
  create: function(element, config) {

    // Insert a <style> tag with some styles we'll use later.
    element.innerHTML = `
      <style>

        .hello-world-vis {
          /* Vertical centering */
          height: 100%;
          display: flex;
          flex-direction: column;
          justify-content: center;
          text-align: center;

        }
        .hello-world-text-large {
          font-size: 72px;
          color: #FF0000;
          font-family:verdana;
          background-color:powderblue;
        }
        .hello-world-text-med {
          font-size: 50px;
          color: #00FF00;
          font-family:courier;
        }
        .hello-world-text-small {
          font-size: 18px;
          color: yellow;
          background-color:tomato;
        }

        .hello-world-vis_color {
          /* Vertical centering */
          height: 100%;
          display: flex;
          flex-direction: column;
          justify-content: left;
          text-align: left;
        }
        .hello-world-text-red {
          color: #FF0000;
        }
        .hello-worl

        d-text-green {
          color: #00FF00;
        }
        .hello-world-text-yellow {
          color: yellow;
        }
      </style>
    `;

    // Create a container element to let us center the text.
    var container = element.appendChild(document.createElement("div"));
    container.className = "hello-world-vis";

    // Create an element to contain the text.
    this._textElement = container.appendChild(document.createElement("div"));

  },
  // Render in response to the data or settings changing
  updateAsync: function(data, element, config, queryResponse, details, done) {

    // Clear any errors from previous updates
    this.clearErrors();

    // Throw some errors and exit if the shape of the data isn't what this chart needs
    if (queryResponse.fields.dimensions.length == 0) {
      this.addError({title: "No Dimensions", message: "This chart requires dimensions."});
      return;
    }

    // Grab the first cell of the data
    var firstRow = data[0];
    var firstCell = firstRow[queryResponse.fields.dimensions[0].name];

    // Insert the data into the page
    this._textElement.innerHTML = LookerCharts.Utils.htmlForCell(firstCell);

    // Set the size to the user-selected size
    if (config.font_size == "small") {
      this._textElement.className = "hello-world-text-small";
    }
    else if(config.font_size == "med") {
      this._textElement.className = "hello-world-text-med";
    }
    else {
      this._textElement.className = "hello-world-text-large";
    }

    // We are done rendering! Let Looker know.
    done()
  }
});
