import datetime
import os
import urllib.request

print("=== ACTIVE.PY VERSION CHECK ===")
print("This is the UPDATED version with /batch/logs/latest.log")
print("If you see this message, the new version is running")

file_path = '/batch/logs/latest.log'
lambda_stop_url = os.environ.get("LAMBDA_STOP_URL")

print(f"Looking for file at: {file_path}")
print(f"File exists: {os.path.exists(file_path)}")

if not os.path.exists(file_path):
    print("ERROR: Log file not found!")
    print("Minecraft server may not be running")
    import sys
    sys.exit(0)

with open(file_path) as f:
    lines = f.readlines()

in_cnt = 0
out_cnt = 0
last_logout_time = None
starting = True

for i, l in enumerate(lines):
    line = l.strip()
    if i == 0:
        hms = line.split()[0][1:-1].split(':')
        before = int(hms[0]) * 3600 + int(hms[1]) * 60 + int(hms[2])
        now = datetime.datetime.now()
        after = now.hour * 3600 + now.minute * 60 + now.second
        diff = after - before
        if diff < 0:
            diff += 24 * 3600
        starting = diff < 10 * 60
    if 'joined the game' in line:
        in_cnt += 1
    if 'left the game' in line:
        out_cnt += 1
        time_str = line.split()[0][1:-1]
        h, m, s = map(int, time_str.split(':'))
        last_logout_time = h * 3600 + m * 60 + s

def send_shutdown_request():
    urllib.request.urlopen(lambda_stop_url)

if starting:
    print('server is starting')
elif in_cnt > out_cnt:
    print('someone is login')
else:
    if last_logout_time is None:
        send_shutdown_request()
    else:
        now = datetime.datetime.now()
        current_time = now.hour * 3600 + now.minute * 60 + now.second
        diff = current_time - last_logout_time
        if diff < 0:
            diff += 24 * 3600
        if diff >= 10 * 60:
            send_shutdown_request()
