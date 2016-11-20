class Api::V1::IncidentsController < ApplicationController

  def index
    render json:
    [
        {
            "eventID":1,
            "latitude": 42.3563,
            "longitude": -71.0637000,
            "time":"2012-04-23T06:25:43.511Z",
            "event_type_id":1
        }, {
            "eventID":2,
            "latitude":42.3563,
            "longitude": -71.0654000,
            "time":"2012-04-23T14:25:43.511Z",
            "event_type_id":1
        }, {
            "eventID":3,
            "latitude": 42.3562632,
            "longitude":-71.0643845,
            "time":"2012-04-23T22:25:43.511Z",
            "event_type_id":2
        }, {
            "eventID":4,
            "latitude": 42.3573,
            "longitude": -71.0637000,
            "time":"2012-04-23T06:25:43.511Z",
            "event_type_id":1
        }, {
            "eventID":5,
            "latitude":42.3573,
            "longitude": -71.0654000,
            "time":"2012-04-23T14:25:43.511Z",
            "event_type_id":1
        }, {
            "eventID":6,
            "latitude": 42.3572632,
            "longitude":-71.0643845,
            "time":"2012-04-23T22:25:43.511Z",
            "event_type_id":2
        }, {
            "eventID":7,
            "latitude": 42.3553,
            "longitude": -71.0637000,
            "time":"2012-04-23T06:25:43.511Z",
            "event_type_id":1
        }, {
            "eventID":8,
            "latitude":42.3553,
            "longitude": -71.0654000,
            "time":"2012-04-23T14:25:43.511Z",
            "event_type_id":1
        }, {
            "eventID":9,
            "latitude": 42.3552632,
            "longitude":-71.0643845,
            "time":"2012-04-23T22:25:43.511Z",
            "event_type_id":2
        }
    ]
  end

end
