___This project has been created as part of the 42 curriculum by kpineda-___
# Inception
- ## Description
  - Inception is a project that uses Docker to teach the principles of containerization and service orchestration. The project's objective is to create and implement a modest infrastructure made up of several services operating in separate containers.

- ## Instructions
  - As required by the project specifications, the entire project must be developed and executed inside a virtual machine. For this implementation, a Debian virtual machine was used.

  - Before running the project, make sure Docker and Docker Compose are installed. If they are not available on your system, install them with the following commands:

    ```bash
    sudo apt update
    sudo apt install -y docker.io docker-compose
    sudo systemctl enable docker
    sudo systemctl start docker
  - A text editor is also needed to modify the project configuration files. Although the default editor included with the operating system is sufficient, using a more advanced editor such as Visual Studio Code is recommended for improved readability and a better editing experience.
  
  - Detailed instructions for launching and using the project can be found in the `USER_DOC.md`.
- ## Resources
  - ### References
    - [Docker Documentation](https://docs.docker.com/)
    - [Docker Compose Documentation](https://docs.docker.com/compose/)
    - [NGINX Documentation](https://nginx.org/en/docs/)
    - [WordPress Documentation](https://wordpress.org/support/)
    - [MariaDB Documentation](https://mariadb.com/kb/en/)
  - ### AI Usage
    - Improving the structure and readability of the README documentation.
    - Explaining Docker concepts and container configuration.
    - Recommending documentation practices to enhance clarity and consistency.
- ## Proyect description
    - ### Virtual Machine vs Docker.
      - **Vitual machine:** A virtual machine emulates an entire operating system with its own allocated hardware resources, providing a high level of isolation from the host system.
      - **Docker:** Docker uses containers that share the host operating system kernel, making applications significantly lighter, faster to deploy, and more resource-efficient.
  - ### Secrets vs Environment Variables.
    - **Secrets:** Securely stored confidential information, such as passwords, API keys, or certificates, that is only accessible to the services requiring them.
    - **Environment Variables:** Configuration parameters supplied to applications at runtime. While convenient, they are generally less secure for storing sensitive information.
  - ### Docker Network vs Host Network.
    - **Docker Network:** Provides an isolated virtual network where containers can communicate with each other while exposing only the necessary services to the host.
    - **Host Network:** Allows a container to use the host machine's networking stack directly, eliminating network isolation but offering direct access to the host's interfaces and ports.
  - ### Docker Volumes vs Bind Mounts.
    - **Docker Volumes:** Docker-managed storage designed for persistent data. Volumes are portable, easy to back up, and independent of the host filesystem structure.
    - **Bind Mounts:** Link a file or directory from the host machine directly into a container. They are useful during development but depend on the host filesystem and provide less portability and isolation than volumes.