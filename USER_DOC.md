# User Documentation

## Services Overview

This project sets up a simple web infrastructure composed of three main services:

- **NGINX:** Serves as the web server and reverse proxy, managing secure HTTPS connections and forwarding requests to the appropriate containers.
- **WordPress:** A content management system (CMS) that hosts the website and provides an administrative interface for managing its content.
- **MariaDB:** A relational database responsible for storing all WordPress data, including users, posts, settings, and other persistent information.

---

## Execution

Unlike most 42 projects, this one is intended to be executed inside a **virtual machine** rather than directly on the host system.

Follow these steps to set it up:

1. Clone the repository from the 42 Intra as usual:

   ```bash
   git clone <project_ssh> <folder_name>
   ```

2. Copy the project into the virtual machine. There are several ways to achieve this, such as:

   - Transferring the files over SSH.
   - Using a shared folder between the host and the virtual machine.
   - Enabling drag-and-drop or copy-paste in the virtual machine settings.

   For this project, the easiest approach is to enable **drag-and-drop** and copy the project folder directly onto the virtual machine's desktop.

### Required Files

For security reasons, the following files are **not included** in the repository because they contain confidential information:

- The `secrets` directory.
- The `.env` file.

They must be placed in the correct locations before starting the project:

- Copy the `secrets` folder to the same directory as the `Makefile`.
- Place the `.env` file inside the `src` directory.

Once everything is in place, start the project by running:

```bash
make up
```

or simply:

```bash
make
```

### Stopping the Stack

To stop the infrastructure and shut down all containers without losing persistent data, run:

```bash
make down
```

If you want to stop the containers and clean up all stored data (including volumes, networks, and Docker configurations) to start completely fresh, run:

```bash
make clean
```

---

## Accessing the Website

After all containers have started successfully, the website can be accessed through a web browser using **HTTPS**.

### Local Domain Configuration

Before accessing the website via the domain name, you must map the domain to your local loopback address inside the virtual machine's hosts configuration.

1. Open `/etc/hosts` with root privileges:

   ```bash
   sudo nano /etc/hosts
   ```

2. Add the following line to the end of the file, then save and exit:

   ```text
   127.0.0.1    kpineda-.42.fr
   ```

Available URLs:

- `https://localhost`
- `https://<login>.42.fr`

For this project:

```
https://kpineda-.42.fr
```

### WordPress Administration

To access the WordPress dashboard, navigate to:

```
https://kpineda-.42.fr/wp-admin
```

Log in using the administrator credentials configured during the installation.

> **Note:** HTTP connections are intentionally disabled. Since port **80** is not exposed, only secure **HTTPS (SSL)** connections are accepted.

---

## Managing Credentials

Sensitive information is intentionally kept outside the repository.

Configuration is divided into two parts:

- Environment variables are stored in the `.env` file located inside the `src` directory.
- Confidential data, such as database passwords, is stored inside the `secrets` directory located alongside the `Makefile`.

If you need to update any credentials:

1. Modify the corresponding value in the `.env` file or in the appropriate file inside the `secrets` directory.
2. Restart the containers to apply the changes:

```bash
make down
make up
```

---

## Verifying the Services

To confirm that all containers are running correctly, execute:

```bash
docker ps
```

The command should display the NGINX, WordPress, and MariaDB containers in the **Up** state.

Additionally, you can run:

```bash
docker compose ps
```

To view the status of all services belonging to this stack.
