/**
 * Moves the map 
  *
   * @param  {H.Map} map      A HERE Map instance within the application
    */
function moveMap(map){
    map.setCenter({lat:42.3629, lng:-71.0988});
    map.setZoom(16);
}

/**
 * Display clustered markers on a map
 *
 * @param {H.Map} map A HERE Map instance within the application
 * @param {Array.<Object>} data Raw data that contains coordinates
 * @param {Bool} isIncident Whether the coordinates are incidents or allies
 */
function startClustering(map, data, isIncident) {
    // First we need to create an array of DataPoint objects,
    // for the ClusterProvider
    var dataPoints = data.map(function (item) {
        return new H.clustering.DataPoint(item.latitude, item.longitude, 100);
    });

    // Create a clustering provider with custom options for clusterizing the input
    var clusterSvgTemplate = '<svg xmlns="http://www.w3.org/2000/svg" height="{diameter}" width="{diameter}">' +
        '<circle cx="{radius1}px" cy="{radius1}px" r="{radius1}px" fill="{color}" fill-opacity="0.4"/>' +
        '<circle cx="{radius1}px" cy="{radius1}px" r="{radius}px" fill="{color}" fill-opacity="1"/>' +
        '<text x="{radius1}px" y="{radius2}px" fill="white" font-family="Arial" text-anchor="middle">{weight}</text>' +
        '</svg>';
    var clusteredDataProvider = new H.clustering.Provider(dataPoints, {
        theme: {
            getClusterPresentation: function(cluster) {
            // Calculate cluster size and weight
            var weight = cluster.getWeight(),
                pointColor = isIncident ? 'red' : 'blue',
                radius = Math.min(20, weight / 10),
                diameter = 2 * radius,

            // Replace variables in the icon template
            svgString = clusterSvgTemplate.replace(/\{radius\}/g, radius).replace(/\{diameter\}/g, diameter+10);
            svgString = svgString.replace(/\{radius1\}/g, radius+5);
            svgString = svgString.replace(/\{radius2\}/g, radius+10);
            svgString = svgString.replace(/\{weight\}/g, weight.toString() / 100);
            svgString = svgString.replace(/\{color\}/g, pointColor)

            // Create an icon
            // Note that we create a different icon depending from the weight of the cluster
            clusterIcon = new H.map.Icon(svgString, {
                size: {w: diameter, h: diameter},
                anchor: {x: radius, y: radius}
            }),

            // Create a marker for the cluster
            clusterMarker = new H.map.Marker(cluster.getPosition(), {
                icon: clusterIcon,

                // Set min/max zoom with values from the cluster, otherwise
                // clusters will be shown at all zoom levels
                min: cluster.getMinZoom(),
                max: cluster.getMaxZoom()
            });

            // Bind cluster data to the marker
            clusterMarker.setData(cluster);

            return clusterMarker;
        },
        getNoisePresentation: function(noisePoint) {
            // Create a marker for noise points:
            var noiseMarker = new H.map.Marker(noisePoint.getPosition(), {
                icon: noiseIcon,

                // Use min zoom from a noise point to show it correctly at certain zoom levels
                min: noisePoint.getMinZoom()
            });

            // Bind noise point data to the marker:
            noiseMarker.setData(noisePoint);
            return noiseMarker;
        }
    },
    clusteringOptions: {
        // Maximum radius of the neighbourhood
        eps: 32,
        // minimum weight of points required to form a cluster
        minWeight: 2
    }});

    // Create a layer tha will consume objects from our clustering provider
    var clusteringLayer = new H.map.layer.ObjectLayer(clusteredDataProvider);

    // To make objects from clustering provder visible,
    // we need to add our layer to the map
    map.addLayer(clusteringLayer);
}

/**
   * Boilerplate map initialization code starts below:
    */

//Step 1: initialize communication with the platform
var platform = new H.service.Platform({
      app_id: '1RfiaGtQvYivGpD7yFZQ',
      app_code: 'rGmfPSL70HTKO6A2iUoKGQ',
      useCIT: true,
      useHTTPS: true
});
var defaultLayers = platform.createDefaultLayers();

//Step 2: initialize a map  - not specificing a location will give a whole world view.
var map = new H.Map(document.getElementById('map'),
          defaultLayers.normal.map);

//Step 3: make the map interactive
// MapEvents enables the event system
// Behavior implements default interactions for pan/zoom (also on mobile touch environments)
var behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

// Create the default UI components
var ui = H.ui.UI.createDefault(map, defaultLayers);

// Read a page's GET URL variables and return them as an associative array
function getUrlVars() {
      var vars = [], hash;
      var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
      for(var i = 0; i < hashes.length; i++)
      {
          hash = hashes[i].split('=');
          vars.push(hash[0]);
          vars[hash[0]] = hash[1];
      }
      return vars;
}
var dataArray = [];
var incidents = Boolean(getUrlVars()['incidents']);
// get incidents or allies, whichever we're looking for
jsonFile = (incidents === true) ? 'http://localhost:8000/data/mock_incidents.json' : 'http://localhost:8000/data/mock_allies.json';
jQuery.getJSON(jsonFile, function (data) {
      var time = parseInt(getUrlVars()['time']) || -1;
      // will evaluate to false if no url param included
      var isIncident = Boolean(getUrlVars()['incident']);
      var filteredData = [];
      switch (time) {
          case 1:
              filteredData = data.filter(function(n) {
                  date1 = new Date(n.time);
                  return date1.getHours() < 8;
              });
              break;
          case 2:
              filteredData = data.filter(function(n) {
                  date1 = new Date(n.time);
                  return (date1.getHours() >= 8 && date1.getHours() < 16);
              });
              break;
          case 3:
              filteredData = data.filter(function(n) {
                  date1 = new Date(n.time);
                  return (date1.getHours() >= 16);
              });
              break;
          default:
              // default to showing all incidents
              filteredData = data;
              break;
      }
      startClustering(map, filteredData, incidents);
});

// Now use the map as required...
moveMap(map);
