from flask import Flask, request

import requests
import json
from argparse import ArgumentParser
import numpy as np

app = Flask(__name__)
ally_data = '../data/mock_allies.json'
incident_data = '../data/mock_incidents.json'
with open(ally_data) as f:
    allies = json.load(f)
with open(incident_data) as fi:
    incidents = json.load(fi)
    
class Point(object):
    def __init__(self, lat, lon):
        self.lat = float(lat)
        self.lon = float(lon)

    def __str__(self):
        return str(self.lat) + ',' + str(self.lon)
    
class Area(object):
    def __init__(self, north_west, south_east):
        self.north_west = north_west
        self.south_east = south_east
        
    def __str__(self):
        return str(self.north_west) + ';' + str(self.south_east)

    def in_area(self, point):
        return point.lat >= self.south_east.lat and point.lat <= self.north_west.lat \
            and point.lon >= self.north_west.lon  and point.lon <= self.south_east.lon
def compute_danger_score(area):
    """
    Return Score from 0 to 1
    """
    # query all incidents that are in this area
    # compute a dumb score based on the number of incidents
    # query all the allies avaible within x parameters
    # update the score based on number of allies and distance from the closest allies
    num_allies = 0
    for ally in allies:
        if area.in_area(Point(ally['latitude'], ally['longitude'])):
            num_allies += 1
    num_incidents = 0
    for i in incidents:
        if area.in_area(Point(i['latitude'], i['longitude'])):
            num_allies += 1
    # scales of num incidents with range from 0 to 5
    score = min(num_incidents, 5) / 5.0
    # each ally contribute 0.2 point
    score -= 0.2 * num_allies
    return score

def to_avoid(start, end, danger_threshold):
    """
    Danger threshold: 0 - 1
    """
    # Pick a big "enough" that would cover every routes possible
    # Calculate danger for each "standard" areas 
    # return areas that go over the threshold
    # Expand the area by 0.1% (arbitrary number)
    # Hmm you need to treat different points differently
    if start.lat < end.lat:
        lat1 = start.lat * 0.999
        lat2 = end.lat * 1.001
    else:
        lat1 = end.lat * 0.999
        lat2 = start.lat * 1.001
    if start.lon < end.lon:
        lon1 = start.lon * 0.999
        lon2 = end.lon * 1.001
    else:
        lon1 = end.lon * 0.999
        lon2 = start.lon * 1.001
    big_area = Area(Point(lat2, lon1), Point(lat1, lon2))
    # 10 meter in lat and long: 0.00009
    step_size = 0.00009
    lat_list = np.arange(lat1, lat2, step_size)
    lon_list = np.arange(lon1, lon2, step_size)
    avoid_areas = []
    for lat in lat_list:
        for lon in lon_list:
            area = Area(Point(lat+step_size, lon), Point(lat, lon+step_size))
            if compute_danger_score(area) >= danger_threshold:
                avoid_areas.append(a)
    return '!'.join([str(a) for a in avoid_areas]) # avoid areas 

@app.route('/to_avoid/', methods=['POST', 'GET'])
def main():
    start= request.args.get('start')
    end= request.args.get('end')
    lat1, lon1 = start.split(',')
    lat2, lon2 = end.split(',')
    point1 = Point(lat1, lon1)
    point2 = Point(lat2, lon2)
    threshold = 0.5
    return to_avoid(point1, point2, threshold), 200

if __name__ == '__main__':
    parser = ArgumentParser()

    parser.add_argument("--port", default=1234, type=int,
                        help="Port to run server.")
    
    parser.add_argument("--debug", action="store_true",
                        help="Run in debug mode?")
    
    args = parser.parse_args()
    
    app.run(port=args.port, debug=args.debug)
