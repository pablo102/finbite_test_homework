Finbite OÜ ::  Tasks for new System Administrators / Engineers

Contact: leone.viru@finbite.eu

Note #1:
Please put all answers to github project and preserve history working on the tasks.

Note #2: 
If some tasks are too difficult, then simply explain why is difficult, try atleast answer those you can.


Good Luck!!

Prerequisites:
    Installed (used):

      - Windows Subsystem for Linux

      - Ubuntu 20.04

      - Docker-desktop with WSL

      - Visual Studio Code

      - dateutils

      - GIT

-------------------------
Task 1:
Using grep or similar utility available in your OS, find lines from random text file which have two or more "-" symbols on one line.

Answer: awk '/-|--/{print $0}' filename or cat filename | grep -e "-" -e "--"

Bonus: create script that creates such random text file.

Answer: /finbite_test_homework/Task1/Task1.sh

-------------------------
Task 2:
Try to describe all servers that Finbite is using.
Try to gather as much technical information about these servers as you can (uptime, OS, location etc). Try to determine their functions and role in the network.

Answer: This information must be hidden, from non-company employees. (Under GDPR law)

-------------------------
Task 3:
Situation: you have poorly written web service which stops responding from time to time. Moreover, we know that if web server has >N tcp sessions open, the service becomes unresponsive.

Please write a restarter script which
1) restarts web server when page is unretrievable in M seconds
2) restarts web server when it has >N incoming tcp sessions open
3) can be executed periodically by OS task scheduler (like cron)

    Answer:
    1) finbite_test_homework/Task3/Task3.sh
    2) finbite_test_homework/Task3/Task3.sh
    3) Can be executed from crontab -e

Bonus: Create script in your favorite language to simulate the "poorly written web service".
    
    Answer: A docker-compose with with Flask. finbite_test_homework/Task3/bonus/

-------------------------

Task 4:
Situation: You have a fragment of logfile from service which clients make sessions to (log_fragment.bz2). Session id is not guaranteed to be unique all over the logfile, but there can only be one session with specific id at the time.
Your task is to write a program that finds top 5 countries where the sessions longer than 5 seconds originate from.

    Answer: - When customer open session, Linux assigning session ID that will be used when session done.
    I wrote the script that makes top 5 coutries with session longer than 5 seconds.
    finbite_test_homework/Task4/Task4.sh

-------------------------

Task 5:
A server is running a program that continuously outputs data to its output directory. If output file grows bigger than N megabytes, it closes the file and starts filling next one.
You can use following shell script as a testcase. You can also write your own testcase.

-------------CUT HERE-------------

#!/bin/sh

 

DIR=/tmp

while [ 1==1 ]

do

        TF=`tempfile --prefix="$DIR" --suffix=.data`

        dd if=/dev/zero of="$TF" bs=1M count=500

done

-------------CUT HERE-------------
Your task is to write a script, that moves those files to another directory or another medium and encrypts them. The script must be able to run from crontab or similar task scheduler every minute. The process should be as parallel and time efficent as possible taking advantage of modern SMP hardware.
    
    Anwer: I wrote script that checks the file size, and if size more than 250MB, script copy all data from this file and delete data inside source file. I used provided task script to generate continuously a 500MB file. A output file encrypts with password and compress. The copy process always starts in parallel.
    finbite_test_homework/Task5/Task5.sh

-------------------------

Task 6:
Create docker-compose file that consists of nginx frontend for load balancer for two instances of backend python service with Flask (simple Flask hello from / path is sufficient)
    
    Answer: A docker-compose configuration that proxying 80 port to two backend python instances. (Used Round Robin load balancer scheme)
    finbite_test_homework/Task6/docker/docker-compose.yml

Bonus: setup service in heroku with Let's Encrypt certificate
    
    Answer: https://finbiteapp.herokuapp.com/ This repository can be cloned to any envirorment and assign Let's Encrypt SSL with CERTBOT.

-------------------------

Task 7:
You have an issue in Oracle 11g database. One specific server creates queries that locks table for INSERT queries. 
Create PL/SQL script that kills those each query from thatserver if one specific query is taking longer than 5 seconds.

Answer: finbite_test_homework/Task7/query.sql

Bonus: Have docker-compose file with simple table and sample scripts to simulate error.

Answer: finbite_test_homework/Task7/Bonus/docker-compose.yml Simulate script is not done yet.






