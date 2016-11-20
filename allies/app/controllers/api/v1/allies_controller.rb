class Api::V1::AlliesController < ApplicationController

  def index
    render json:
    [
        {"latitude": 42.3654627841, "longitude": -71.0891974996},
        {"latitude": 42.3708210995, "longitude": -71.0819901925},
        {"latitude": 42.3681455535, "longitude": -71.0948398539},
        {"latitude": 42.3688019382, "longitude": -71.0915918823},
        {"latitude": 42.3719538143, "longitude": -71.0885373248},
        {"latitude": 42.3659348677, "longitude": -71.0940942674},
        {"latitude": 42.3685951537, "longitude": -71.080931028},
        {"latitude": 42.3634835054, "longitude": -71.0886196855},
        {"latitude": 42.3716833795, "longitude": -71.088890045},
        {"latitude": 42.3655857332, "longitude": -71.0876737121},
        {"latitude": 42.3626467702, "longitude": -71.0960264214},
        {"latitude": 42.3731388074, "longitude": -71.0971356835},
        {"latitude": 42.3658574973, "longitude": -71.0838877193},
        {"latitude": 42.3642910067, "longitude": -71.0857457077},
        {"latitude": 42.3679124666, "longitude": -71.0846768967},
        {"latitude": 42.3707193064, "longitude": -71.0810162322},
        {"latitude": 42.3633483358, "longitude": -71.0907225507},
        {"latitude": 42.3661770247, "longitude": -71.0966301822},
        {"latitude": 42.3726446813, "longitude": -71.0966228972},
        {"latitude": 42.3699926975, "longitude": -71.096590266}
    ]
  end
end
