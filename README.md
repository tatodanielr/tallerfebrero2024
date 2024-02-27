# tallerfebrero2024
Obligatorio: Taller Instalación Servidores Linux febrero 2024

Letra: https://github.com/tatodanielr/tallerfebrero2024/blob/main/EvaluacionTallerInstalacionServidores_Febrero2024.pdf


Automatización de Configuraciones mediante Ansible
========================================================

Este repositorio contiene una serie de playbooks de Ansible diseñados para automatizar tareas de configuración en entornos Ubuntu y Rocky Linux. Los playbooks abordan desde la actualización de paquetes hasta la instalación de Docker y Nginx, así como el despliegue de aplicaciones.


Requisitos
----------

* 🛠️  Ansible instalado en una máquina bastión desde donde se ejecutarán los playbooks.
*  🔒 Conexión SSH establecida con los hosts gestionados.
* 📚 Conocimientos básicos de YAML y Ansible.

Uso
---

1.  Clonar este repositorio en tu máquina bastión:
    
    `git clone git@github.com:tatodanielr/tallerfebrero2024.git`
    
2.  Actualizar el archivo de inventario en el directorio `Inventories_Usuario_Ansible/` con los detalles de los hosts a gestionar.
    
3.  Ejecuta los playbooks de Ansible utilizando el siguiente comando:
    
    `ansible-playbook -i inventory.ini playbooks/nombre_del_playbook.yaml`
    
    Asegúrate de reemplazar `nombre_del_playbook.yaml` con el nombre del playbook que deseas ejecutar y `inventario.ini` con el nombre de tu archivo de inventario.

Ubicación de la archivos
----------

[    https://github.com/tatodanielr/tallerfebrero2024/tree/main/Inventories_Usuario_Ansible](https://github.com/tatodanielr/tallerfebrero2024/tree/main/Inventories_Usuario_Ansible)
    

Playbooks
---------------------

1. 🔄  **Actualización de Servidores**: `1_update_servers.yaml`
    
    *   Actualiza los paquetes en sistemas Ubuntu y Rocky Linux.
2. 🐳 **Instalación de Docker**: `2_install_docker.yaml`
    
    *   Instala Docker en sistemas Ubuntu.
3. 🚀 **Despliegue de Contenedores Docker**: `3_deploy_dockers.yaml`
    
    *   Despliega un contenedor Docker de Tomcat 8 y copia una aplicación web.
4. 🌐 **Instalación de Nginx**: `4_install_nginx.yaml`
    
    *   Instala y configura Nginx en sistemas Rocky Linux.
  
Ubicación de las playbooks.
----------

[Inventories_Usuario_Ansible/playbooks](https://github.com/tatodanielr/tallerfebrero2024/tree/main/Inventories_Usuario_Ansible/playbooks)
    

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
    *   Instala el módulo de Python para Docker.
    *   Las tareas están dirigidas solo a los hosts del grupo "Ubuntu".

### 3\_deploy\_dockers.yaml

*   **Objetivo**: Desplegar un contenedor Docker de Tomcat 8 y copiar una aplicación web.
*   **Descripción detallada**:
    *   Crea un directorio en los hosts destinado para el despliegue de aplicaciones.
    *   Copia un archivo https://github.com/tatodanielr/tallerfebrero2024/blob/main/Tomcat8/sample.war desde la máquina bastion al directorio creado en los hosts.
    *   Utiliza el módulo `docker_container` para crear y ejecutar un contenedor Docker de Tomcat 8 con OpenJDK.
    *   El contenedor se configura para que sirva la aplicación web desde el archivo `.war`.
    *   Estas tareas están dirigidas solo a los hosts del grupo "Ubuntu".

### 4\_install\_ngix.yaml

*   **Objetivo**: Instalar y configurar Nginx en sistemas Rocky Linux.
*   **Descripción detallada**:
    *   Configura el firewall para permitir tráfico HTTP y HTTPS.
    *   Instala OpenSSL para generar un certificado auto firmado.
    *   Instala Nginx y crea un directorio para almacenar certificados SSL.
    *   Copia un archivo de configuración personalizado utilizando jinja para Nginx.
    *   Genera un certificado SSL auto firmado.
    *   Configura SELinux con el booleano httpd_can_network_connect.
    *   Reinicia el firewall y el servicio Nginx.
    *   Estas tareas están dirigidas solo a los hosts del grupo "Rocky".

### Chequeo de Despliegue

*   Utiliza el comando `curl` para verificar que las aplicaciones desplegadas estén accesibles.
*   Realiza solicitudes HTTP/HTTPS a las aplicaciones desplegadas en los hosts correspondientes.
*   Comprueba que el servidor responda con el contenido esperado, validando así el despliegue exitoso de las aplicaciones.

### Evidencia de funcionamiento

*   Curl al contenedor desplegado.
  ```bash
 curl http://servera:8080/sample/
```
  ```
<html>
<head>
<title>Sample "Hello, World" Application</title>
</head>
<body bgcolor=white>

<table border="0">
<tr>
<td>
<img src="images/tomcat.gif">
</td>
<td>
<h1>Sample "Hello, World" Application</h1>
<p>This is the home page for a sample application used to illustrate the
source directory organization of a web application utilizing the principles
outlined in the Application Developer's Guide.
</td>
</tr>
</table>

<p>To prove that they work, you can execute either of the following links:
<ul>
<li>To a <a href="hello.jsp">JSP page</a>.
<li>To a <a href="hello">servlet</a>.
</ul>

</body>
</html>
```
Curl al reverse proxy.
  ```bash
 curl https://serverb/sample/
```
```
<html>
<head>
<title>Sample "Hello, World" Application</title>
</head>
<body bgcolor=white>

<table border="0">
<tr>
<td>
<img src="images/tomcat.gif">
</td>
<td>
<h1>Sample "Hello, World" Application</h1>
<p>This is the home page for a sample application used to illustrate the
source directory organization of a web application utilizing the principles
outlined in the Application Developer's Guide.
</td>
</tr>
</table>

<p>To prove that they work, you can execute either of the following links:
<ul>
<li>To a <a href="hello.jsp">JSP page</a>.
<li>To a <a href="hello">servlet</a>.
</ul>

</body>
</html>
```
Chequeo vía navegador para verificación de certificado.
![image](https://github.com/tatodanielr/tallerfebrero2024/assets/157429072/5a075523-39f2-4093-8bc2-63c802929b60)

Evidencia avanzada de ejecución.

https://github.com/tatodanielr/tallerfebrero2024/tree/main/Inventories_Usuario_Ansible/evidencias

Documentación detallada de la implementación.
========================================================

El siguiente documento detalla paso por paso, la implementación y el despliegue, de la arquitectura solicitada en la letra del obligatorio.

https://github.com/tatodanielr/tallerfebrero2024/blob/main/Documentaci%C3%B3n_del_proyecto.docx

Autor
-----

*   Nombre: Daniel Rondeau
*   Universidad ORT Uruguay
*   GitHub: [https://github.com/tatodanielr](https://github.com/tatodanielr)
