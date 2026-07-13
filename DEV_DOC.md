# Developer Documentation

This document provides complete, exhaustive instructions for developers to initialize, build, manage, and verify the infrastructure of this project from scratch. It addresses all mandatory evaluation criteria regarding environment setup, compilation, administration, and data isolation.

---

## 1. Environment Setup

The ecosystem is explicitly designed to be provisioned and run within a **Debian Virtual Machine (VM)** environment to guarantee network architecture compatibility and configuration isolation.

### Prerequisites
Before executing any component, the host environment must have the following native binaries installed, active, and available in the system `PATH`:
* **Docker Engine & CLI** (v20.10+ recommended) -> Handles container isolation, virtualization, and runtime execution.
* **Docker Compose** (v2) -> Orchestrates multi-container multi-network architecture deployment.
* **GNU Make** -> Provides entry point automation wrappers for simplified interaction.

### Configuration & Credentials
To maintain security standards and prevent leakage, all structural environment settings and sensitive authentication data are strictly excluded from git tracking (`.gitignore`). Developers must construct these resources manually prior to initiating compilation:

#### A. Environment Variables Setup
* **File Path:** `src/.env`
* **Purpose:** Defines global variables, structural setup configurations, and non-sensitive architecture arguments passed down to the build context.
* **Required Key Structures:**
  ```env
  # Example Keys (Must be customized by the developer)
  DOMAIN_NAME=username.42.fr
  WP_TITLE=Inception_Services
  MARIADB_USER=db_user
  ```

#### B. Secrets Infrastructure Setup
* **Location:** `/secrets/` (Positioned securely at the root directory level, inline with the master `Makefile`).
* **Purpose:** Holds raw, un-encrypted structural files that store explicit passwords and credentials away from the environment file block. Each file should hold exactly one raw string value without trailing whitespaces or line breaks:
  * `/secrets/db_password.txt` -> Password for the standard MariaDB database user.
  * `/secrets/db_root_password.txt` -> Administrative root password for the MariaDB cluster.
  * `/secrets/wp_admin_password.txt` -> Password for the core WordPress Administrator profile.
  * `/secrets/wp_user_password.txt` -> Password for the secondary non-administrative WordPress author account.

---

## 2. Build and Launch Architecture

The absolute lifecycle management of the multi-container grid is completely abstracted into a structured `Makefile`. This ensures deterministic execution by wrapping `docker compose` calls into uniform development stages.

### Infrastructure Rules and Lifecycle Operations

* **Default Build and Boot Sequence**
  Compiles custom Dockerfiles, creates local bridge networks, mounts persistent paths, and provisions the entire framework detached in the background.
  ```bash
  make
  ```
  *(Alternatively, explicitly call the up sequence)*:
  ```bash
  make up
  ```

* **Graceful De-provisioning (Stop & Tear Down)**
  Signals all active microservices to stop execution safely, tears down the dedicated internal bridges, and removes active container instances while maintaining persistent storage blocks intact.
  ```bash
  make down
  ```

* **Full Structural Re-compilation (Clean Rebuild)**
  Forces Docker Compose to ignore pre-cached layers, re-triggering a strict step-by-step compilation of the custom configuration files.
  ```bash
  make re
  ```

---

## 3. Container, Network & Volume Management

Developers can inspect, intercept, and manage the underlying multi-container system directly by tapping into native Docker CLI tools. Use these commands to debug or audit the runtime framework:

### Container State Inspection
* **List Active Containers:** Identifies running services, container IDs, exposed ports, and uptimes.
  ```bash
  docker ps
  ```
* **Comprehensive Grid Audit:** Displays every single container instance associated with the engine (running, stopped, or exited).
  ```bash
  docker ps -a
  ```
* **Live Logs Interception:** Streams container-specific stdout and stderr streams. Essential for debugging fast-failing services.
  ```bash
  docker logs <container_name>
  ```
  *(To follow logs in real-time, append the `-f` flag)*:
  ```bash
  docker logs -f <container_name>
  ```

### Volume Infrastructure Auditing
* **Enumerate Active Storage Volumes:** Lists all independent named volume structures active in the engine.
  ```bash
  docker volume ls
  ```
* **Deep Metadata Inspection:** Inspect a Docker volume.
  ```bash
  docker volume inspect <volume_name>
  ```

### Hard System Reset (Destructive Clean)
> ⚠️ **CRITICAL WARNING:** To completely wipe out the development runtime—including custom local networks, execution containers, active service states, AND all persistent storage configurations—execute the following instruction from the directory containing the compose manifest:
```bash
docker compose down -v
```

---

## Data Persistence

This project uses **Docker volumes** to preserve data across container restarts and recreations.

- The **MariaDB** container stores its database files in a dedicated Docker volume.
- The **WordPress** container keeps its website files and uploaded content in a separate Docker volume.
- Since Docker volumes exist independently of containers, data remains available even if the containers are stopped, recreated, or removed.
- Stored data is only lost if the corresponding Docker volumes are manually deleted.