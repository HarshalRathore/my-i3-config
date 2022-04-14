from datetime import date
import os
vnstat = os.system('vnstat -m > /tmp/vnstat.txt')

with open('/tmp/vnstat.txt', 'r') as f:
    for line in f:
        try:
            if line.split(" ")[7] == date.today().strftime('%Y-%m'):
                print(line.split(" ")[23], line.split(" ")[24], sep='')
        except IndexError:
            pass