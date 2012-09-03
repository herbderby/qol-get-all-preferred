#!/bin/bash

username=${1}
password=${2}

cookie_file=$(mktemp /tmp/qol-cookies.XXXXX)

# All commands must execute with no errors.
set -e

# Get initial cookie. This cookie enables proper login.
curl --cookie-jar ${cookie_file} --output /dev/null --silent http://quantumonline.com/login.cfm

# Login, getting registered user cookie.
curl --cookie-jar ${cookie_file} --cookie ${cookie_file} --output /dev/null --silent http://quantumonline.com/login_test.cfm -d acctname=herbderby -d pswrd=Wibus0 -d submit=Login

# Fetch all preferred data.
curl --cookie ${cookie_file} --silent http://quantumonline.com/pfdtable.cfm -d Type=AllPfds -d SortColumn=Company -d Sortorder=ASC -d b_c=-100 -d t_r=1 -d itemsreturned=5000 -d submit=GO
