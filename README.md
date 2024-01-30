The Project was designed to automate daily testing of Webservices exposed by application, it is used as part of daily Environment Sanity Testing.
It kind of imitates behaviour of SOAP UI,wherein static configured requests are sent to an end point URL, response is captured along with response code to track if response is failure or success.
The perl script is main script which does the processing and creates files into necessary folder structure.
THe bash script is wrapper script to read the status and send formated email to audience/management.
