# monitors data bandwidth both up and dow
import time

def get_bytes(t, iface='wlan0'):
    with open('/sys/class/net/' + iface + '/statistics/' + t + '_bytes', 'r') as f:
        data = f.read();
        return int(data)

while(True):
    tx1 = get_bytes('tx')
    rx1 = get_bytes('rx')

    time.sleep(1)

    tx2 = get_bytes('tx')
    rx2 = get_bytes('rx')

    tx_speed = round((tx2 - tx1)/1000000.0, 4)
    rx_speed = round((rx2 - rx1)/1000000.0, 4)

    # print(f"TX: {tx_speed}M      {rx_speed}M")

    if rx_speed < 1 and tx_speed < 1:
        print(f" {round(tx_speed*1000, 2)}K  {round(rx_speed*1000)}K")
    elif rx_speed < 1:
        print(f" {tx_speed}M  {round(rx_speed*1000)}K")
    elif tx_speed < 1:
        print(f" {round(tx_speed*1000, 2)}K  {rx_speed}M")