# Dockerized IOOS Compliance Checker Web Frontend

## Operating/Installation Instructions

1. Ensure `docker` is installed (which version at minimum?)

2. Ensure TCP port 8000 is available (or override in `docker-compose` options),
i.e. in Linux:
   ```
   lsof -i :8000
   ```

3. Install `docker-compose`
   ```
   pip install docker-compose
   ```

4. Run `docker-compose up`

5. Navigate to [localhost:8000](localhost:8000)
