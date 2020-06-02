```bash
docker network create mi_red
docker run --rm --name aa -d --network mi_red busybox ping localhost
```
