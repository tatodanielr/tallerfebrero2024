# tallerfebrero2024
Obligatorio: Taller Instalación Servidores Linux febrero 2024
https://github.com/tatodanielr/tallerfebrero2024/blob/main/EvaluacionTallerInstalacionServidores_Febrero2024.pdf

Automatización de Configuraciones mediante Ansible
========================================================

Este repositorio contiene una serie de playbooks de Ansible diseñados para automatizar tareas de configuración en entornos Ubuntu y Rocky Linux. Los playbooks abordan desde la actualización de paquetes hasta la instalación de Docker y Nginx, así como el despliegue de aplicaciones.

Requisitos
----------

*   Ansible instalado en la máquina local o en el servidor desde donde se ejecutarán los playbooks.
*   Conexión SSH establecida con los hosts gestionados.
*   Conocimientos básicos de YAML y Ansible.

Uso
---

1.  Clona este repositorio en tu máquina local:
    
    `git clone git@github.com:tatodanielr/tallerfebrero2024.git`
    
2.  Actualiza el archivo de inventario en el directorio `inventory/` con los detalles de los hosts a gestionar.
    
3.  Ejecuta los playbooks de Ansible utilizando el siguiente comando:
    
    `ansible-playbook -i inventory/inventario.txt playbooks/nombre_del_playbook.yaml`
    
    Asegúrate de reemplazar `nombre_del_playbook.yaml` con el nombre del playbook que deseas ejecutar y `inventario.ini` con el nombre de tu archivo de inventario.
    

Playbooks
---------------------

1.  **Actualización de Servidores**: `1_update_servers.yaml`
    
    *   Actualiza los paquetes en sistemas Ubuntu y Rocky Linux.
2.  **Instalación de Docker**: `2_install_docker.yaml`
    
    *   Instala Docker en sistemas Ubuntu.
3.  **Despliegue de Contenedores Docker**: `3_deploy_dockers.yaml`
    
    *   Despliega un contenedor Docker de Tomcat 8 y copia una aplicación web.
4.  **Instalación de Nginx**: `4_install_nginx.yaml`
    
    *   Instala y configura Nginx en sistemas Rocky Linux.
    

Descripción detallada de los Playbooks
----------

### 1\_update\_servers.yaml

*   **Objetivo**: Actualizar los paquetes en sistemas Ubuntu y Rocky Linux.
*   **Descripción detallada**:
    *   Utiliza el módulo `apt` para actualizar los paquetes en sistemas Ubuntu.
    *   Utiliza el módulo `dnf` para actualizar los paquetes en sistemas Rocky Linux.
    *   La tarea de actualización solo se ejecuta en los hosts que coinciden con el tipo de distribución (Ubuntu o Rocky Linux) definido en la condición `when`.

### 2\_install\_docker.yaml

*   **Objetivo**: Instalar Docker en sistemas Ubuntu.
*   **Descripción detallada**:
    *   Utiliza el módulo `apt` para instalar los paquetes requeridos por Docker.
    *   Agrega la clave GPG de Docker y agrega el repositorio de Docker al sistema.
    *   Utiliza el módulo `apt` nuevamente para instalar Docker CE y Docker Compose.
    *   Las tareas están dirigidas solo a los hosts del grupo "Ubuntu".

### 3\_deploy\_dockers.yaml

*   **Objetivo**: Desplegar un contenedor Docker de Tomcat 8 y copiar una aplicación web.
*   **Descripción detallada**:
    *   Crea un directorio en los hosts destinado para el despliegue de aplicaciones.
    *   Copia un archivo `.war` desde la máquina de control al directorio creado en los hosts.
    *   Utiliza el módulo `docker_container` para crear y ejecutar un contenedor Docker de Tomcat 8.
    *   El contenedor se configura para que sirva la aplicación web desde el archivo `.war`.
    *   Estas tareas están dirigidas solo a los hosts del grupo "Ubuntu".

### 4\_install\_ngix.yaml

*   **Objetivo**: Instalar y configurar Nginx en sistemas Rocky Linux.
*   **Descripción detallada**:
    *   Configura el firewall para permitir tráfico HTTP y HTTPS.
    *   Instala OpenSSL para generar un certificado autofirmado.
    *   Instala Nginx y crea un directorio para almacenar certificados SSL.
    *   Copia un archivo de configuración personalizado de Nginx.
    *   Genera un certificado SSL autofirmado.
    *   Configura SELinux y reinicia el firewall y el servicio Nginx.
    *   Estas tareas están dirigidas solo a los hosts del grupo "Rocky".

### Chequeo de Despliegue

*   Utiliza el comando `curl` para verificar que las aplicaciones desplegadas estén accesibles.
*   Realiza solicitudes HTTP/HTTPS a las aplicaciones desplegadas en los hosts correspondientes.
*   Comprueba que el servidor responda con el contenido esperado, validando así el despliegue exitoso de las aplicaciones.
    


Autor
-----

*   Nombre: Daniel Rondeau
*   Universidad ORT Uruguay
*   GitHub: [https://github.com/tatodanielr](https://github.com/tatodanielr)
