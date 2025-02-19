import ipaddress

# Укажите диапазон подсети
network = ipaddress.ip_network("172.16.16.0/22", strict=False)

# Генерация первых 350 адресов
clients = [str(ip) for ip in network.hosts()][:350]

# Формируем строку client_list
client_list = f"client_list: [{', '.join(clients)}]"
print(client_list)

# Сохраняем результат в файл
with open("generated_clients.txt", "w") as output_file:
    output_file.write(client_list)
