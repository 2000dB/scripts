#!/usr/bin/env python
#
# Get time by via HTTP headers for NTP-less LANs.
#
# vincent@uva.co.uk 
# 2015
# 

import sys
import subprocess
import urllib2
import re

servers = ['http://20.0.0.254', 'http://20.0.0.253', 'http://20.0.0.252'] # put whatever machines you expect on the network in this list


def get_time():
    response = None
    headers = None
    for s in servers:
        try:
            print 'trying ' + s + '...'
            response = urllib2.urlopen(s)
            headers  = response.info()
        except urllib2.HTTPError as e: #(req.get_full_url(), code, msg, hdrs, fp):
           headers = e.hdrs
           print 'server ' + s + ' on network'
           parse_time_from_header(s, headers)
        except:
            print 'server ' + s + ' not on network'
    print 'could not get time'


def parse_time_from_header(s, headers):            
    m = re.search(r'Date:(.*)\n', str(headers))
    if m is not None:
        subprocess.call(['date', '-s', m.group(1)])
        sys.exit(1) # done
    else:
        print 'could not parse time'


if __name__ == '__main__':
    get_time()

