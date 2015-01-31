#!/usr/bin/env python

"""
exports gxp files trk to dxf file
2013
v@2000db.com
"""

import os
import argparse

from dxfwrite import DXFEngine as dxf
import gpxpy.parser as parser



def get_gpx_files(directory):
    """
    Returns a list of gpx files in a directory
    """
    gpx_dir = directory
    gpx_files = []
    
    for f in os.listdir(gpx_dir):
        if f.endswith(".gpx"):
            gpx_files.append(os.path.splitext(f)[0])

    return gpx_files

def draw_gpx(g, d):
    """
    Draws gpx trk points to the specified a dxf file
    Each gpx file gets drawn to a corresponding layer
    """
    try:
        gpx_file = open(g + ".gpx", 'r' )
    except:
        print "error opening file: " + g + ".gpx"
        
    gpx_parser = parser.GPXParser(gpx_file)
    gpx_parser.parse()
    gpx_file.close()
    gpx = gpx_parser.get_gpx()

    for track in gpx.tracks:
        for segment in track.segments:
            point_num = len(segment.points)
            for i in range(point_num-1):
                d.add(dxf.line((segment.points[i].latitude, segment.points[i].longitude),(segment.points[i+1].latitude, segment.points[i+1].longitude),
                               layer=g.split('/')[-1]))


if __name__ == "__main__":
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument("gpx_dir", metavar="GPX", type=str, help="gpx files folder")
    arg_parser.add_argument("dxf_file", metavar="DXF", type=str, help="dxf drawing file")

    args = arg_parser.parse_args()
            
    d = dxf.drawing(args.dxf_file)

    for f in get_gpx_files(args.gpx_dir):
        draw_gpx(args.gpx_dir + "/" + f, d)
    
    d.save()

            
