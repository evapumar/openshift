```bash
docker network create mi_red
docker run --rm --name aa -d --network mi_red busybox ping localhost
docker run --rm --name bb -d --network mi_red busybox ping localhost
docker exec aa ping -c1 8.8.8.8
docker exec bb ping -c1 8.8.8.8
docker exec aa nslookup localhost
docker exec bb nslookup localhost
```
