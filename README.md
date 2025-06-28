# Deploy
[![wakatime](https://wakatime.com/badge/user/ce63b378-df01-4480-af66-a4f584b910ad/project/78fd3177-e8e7-4ccc-a2d6-efff51525a5d.svg)](https://wakatime.com/badge/user/ce63b378-df01-4480-af66-a4f584b910ad/project/78fd3177-e8e7-4ccc-a2d6-efff51525a5d)

Deployment Repository  

![Docker](https://img.shields.io/badge/Docker-20.10%2B-blue)
![Swarm](https://img.shields.io/badge/Docker%20Swarm-3.0%2B-important)
![GitLab CI/CD](https://img.shields.io/badge/GitLab%20CI/CD-v15%2B-red)

## 🌟 Overview  

**HomeRep** is a revolutionary platform designed to bridge the gap between homeowners in need of quick household repairs and skilled craftsmen. Combining the words *"Home"* and *"Repair"*, our service offers a seamless, time-efficient solution for everyday maintenance tasks.  

This repository contains the **CI/CD configuration** and deployment scripts for the HomeRep platform, which consists of multiple microservices deployed using **Docker Swarm**.

---

## 🏗 Architecture  

The HomeRep platform consists of the following core services:  

| Service | Description | Repository |  
|---------|-------------|------------|
| 🔐 **Auth Service** | Handles user authentication and authorization | [auth_server](https://gitlab.com/homerep/auth_server) |  
| 👤 **User Service** | Manages user profiles and information | [userservice](https://gitlab.com/homerep/userservice) |  
| 📦 **Order Service** | Processes repair orders and connects homeowners with craftsmen | [order_service](https://gitlab.com/homerep/order_service) |  
| 📍 **Location Service** | Provides geolocation functionality | [user_location_service](https://gitlab.com/homerep/user_location_service) |  
| ☁️ **Cloud Service** | Handles image storage and retrieval | [image_cloud](https://gitlab.com/homerep/image_cloud) |  
| ✉️ **Mail Service** | Manages email notifications and verification | [codesender](https://gitlab.com/homerep/codesender) |  
| 🖥 **Admin Panel** | Administrative interface for system management | [adminpanel](https://gitlab.com/homerep/adminpanel) |  
| 🚀 **Redis** | Used for caching and temporary storage | *Infrastructure component* |  
| 🐘 **PostgreSQL** | Primary database for most services | *Infrastructure component* |  
| ⏱ **TimescaleDB** | Time-series database for location data | *Infrastructure component* |  

🔗 *All repositories are part of the [HomeRep group](https://gitlab.com/homerep)*

---

## 📋 Prerequisites  

Before deploying HomeRep, ensure you have:  

- ✅ Docker installed on all swarm nodes  
- ✅ Docker Swarm initialized  
- ✅ Access to the GitLab container registry  
- ✅ Proper network configuration (especially for the `homerep-global-network`)  

---

## 🚀 Deployment  

### 🔑 CI/CD Variables  

#### Project Variables:  
| Variable | Description | Security |  
|----------|-------------|----------|  
| `API_ADDRESS_CLOUD` | Cloud service API address | 🔒 Protected |  
| `DB_PASSWORD_CLOUD` | Database password | 🔒🔐 Protected & Masked |  
| `YANDEX_GEOCODE` | Yandex Geocoding API key | 🔒🔐 Protected & Masked |  

#### Group Variables (inherited):  
| Variable | Description |  
|----------|-------------|  
| `HOMEREP_MAIL_PASSWORD` | Email service password |  
| `DOCKER_KEY_PEM` | Docker key |  

### ⚙️ Deployment Process  

1. **Docker Login**  
   ```bash
   docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
   ```  
2. **Variable Setup** - Configures all environment variables  
3. **Stack Removal** - Cleans up existing deployment  
4. **Network Setup** - Creates Docker networks  
5. **Image Cleanup** - Removes old images  
6. **Compose Generation** - Creates final docker-compose file  
7. **Stack Deployment** - Deploys to Docker Swarm  

---

## ⚙️ Configuration  

Key configuration options in `docker-compose.prod.yml`:  

```yaml
services:
  auth-service:
    deploy:
      replicas: 1
      restart_policy:
        condition: any
```

- **Service Replicas**: Configured per service  
- **Restart Policies**: Automatic recovery  
- **Network Config**: Isolated communication  

---

## 🔍 Monitoring & Maintenance  

```bash
# View stack status
sudo docker stack ps homerep --no-trunc

# Tail service logs
sudo docker service logs -f homerep_auth-service
```

---

## 🛠 Troubleshooting  

| Issue | Solution |  
|-------|----------|  
| Deployment Failures | Check Swarm node status and network |  
| Connectivity Issues | Verify Docker network config |  
| Database Problems | Check volume permissions |  

---

## 🔒 Security  

- All sensitive variables are **protected** and **masked**  
- Internal network communication preferred  
- Regular security updates enforced  

---