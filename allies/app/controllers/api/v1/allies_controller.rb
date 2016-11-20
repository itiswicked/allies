class Api::V1::AlliesController < ApplicationController

  def index
    render json:
    [
        {
            "allyID":1,
            "latitude": 42.3573,
            "longitude": -71.0637000
        }, {
            "allyID":2,
            "latitude":42.3573,
            "longitude": -71.0644000
        }, {
            "allyID":3,
            "latitude": 42.3762632,
            "longitude":-71.0654000
        }
    ]
  end
end
