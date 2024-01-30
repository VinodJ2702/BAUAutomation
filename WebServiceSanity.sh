#!/bin/bash
#set -x
##Delete old xml files in Output directory.
find /home/***/ServiceOutput -name *.xml -delete > /dev/null

##Execute the Perl scripts ##
filename=/bin/perl /home/***/WebServicesTest.pl

sleep 10

##Variable decleration##
temp1='/home/***/ServiceOutput/AWSWebserviceStatus.txt'
html='/home/****/WebServiceSanityReport.html'
echo "<html>" >> $html
       echo "<style type="text/css">
                table, th, td {
                border: 1px solid black;
                font-family: Arial;
                font-size: 14px;
                }
                h3   {color: red;}
                p    {
                        font-family:Arial;
                        font-size:14px;
                     }
            </style>" >> $html
       echo "<body>" >> $html
       echo '<p style="font-family:Arial;font-size:14px;">' >> $html
       echo "Hello Team," >> $html
       echo "<BR>" >> $html
       echo "<BR>" >> $html
       echo "<h3><u> WebService Sanity Status AWS SIT1 Chordiant : </u></h3" >> $html
       echo "<BR>" >> $html
       echo '<table>' >> $html
       echo '<th bgcolor="#00FFFF">Environment</th>' >> $html
       echo '<th bgcolor="#00FFFF">WebService</th>' >> $html
       echo '<th bgcolor="#00FFFF">Status' >> $html
        while read line; do
                echo "<tr>" >> $html
                var1=$(echo $line | cut -f1 -d ';')
                var2=$(echo $line | cut -f2 -d ';')
                var3=$(echo $line | cut -f3 -d ';')
                echo "<td bgcolor="#D3D3D3">$var1</td>" >> $html
                echo "<td bgcolor="#D3D3D3">$var2</td>" >> $html
                if [ $var3 == "Passed" ]
                then
                        echo "<td bgcolor="#32CD32">$var3</td>" >> $html
                else
                        echo "<td bgcolor="#FF0000">$var3</td>" >> $html
                fi
        done < $temp1
       echo "</tr>" >> $html
       echo '</table>' >> $html
       echo "<BR>" >> $html
       echo '<p style="font-family;Arial;font-size;14px;">' >> $html
       echo "Regards," >> $html
       echo "<BR>" >> $html
       echo "Chordiant Tech Support" >> $html
       echo "</p>" >> $html
       echo "</body>" >> $html
       echo "</html>" >> $html
       echo "</body>" >> $html
       echo "</html>" >> $html

NOW=$(date +'%d/%m/%Y')

cat <<'EOF' - $html | /usr/sbin/sendmail -t
To:***@**.com
Subject: Webservices Sanity for *** Environment.
Content-Type: text/html

EOF

rm $html
