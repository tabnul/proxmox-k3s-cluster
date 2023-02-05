#!/usr/bin/env python
import requests
try:
    import json
except ImportError:
    import simplejson as json
import sys
import argparse


bool_validate_cert = True
parser = argparse.ArgumentParser(usage='%(prog)s [options]')
parser.add_argument('--action', choices=['add', 'remove'], help='Add or Remove the DNS Override', dest="action")
parser.add_argument('--fqdn', dest="fqdn")
parser.add_argument('--ip', dest='ip')
parser.add_argument('--adguardurl', dest='adguardurl')
parser.add_argument('--adguarduser', dest='adguarduser')
parser.add_argument('--adguardpassword', dest='adguardpassword')
args = parser.parse_args()

postdata = '{"answer":"' + args.ip + '","domain":"' + args.fqdn + '"}'

if args.action == "add":
    r = requests.post((args.adguardurl + "/control/rewrite/add"), auth=(args.adguarduser, args.adguardpassword), data=postdata, headers={"Content-Type":"application/json"})
    print(r.status_code)


if args.action == "remove":
    r = requests.post((args.adguardurl + "/control/rewrite/delete"), auth=(args.adguarduser, args.adguardpassword), data=postdata, headers={"Content-Type":"application/json"})
    print(r.status_code)
#print(r.request.headers)