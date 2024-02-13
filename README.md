# tallerfebrero2024
Obligatorio: Taller Instalación Servidores Linux febrero 2024

Letra del Obligatorio:
[EvaluacionTallerInstalacionServidores_Febrero2024.pdf](https://github.com/tatodanielr/tallerfebrero2024/files/14269518/EvaluacionTallerInstalacionServidores_Febrero2024.pdf)

Configuración de virtualizador:

Se implementó un ambiente virtual, utilizando un tipo de hipervisor llamado Hyper-V, integrado en Windows 10 y habilitado en la computadora. El hipervisor se ejecuta directamente sobre el hardware, permitiendo la creación de máquinas virtuales (VM). Cada VM puede ejecutar sistemas operativos o aplicaciones diferentes, compartiendo los recursos físicos de la computadora principal, pero de manera independiente. Esto facilita la realización de pruebas y experimentos sin afectar otras máquinas virtuales ni el sistema operativo del host.

![image](https://github.com/tatodanielr/tallerfebrero2024/assets/157429072/8b93086c-1eb7-4062-a624-1d289a74629c)


¿Qué es Hyper-V?

Hyper-V es una plataforma de virtualización desarrollada por Microsoft. Se trata de un hipervisor, un software que permite la creación y gestión de máquinas virtuales (VMs) en entornos Windows. Hyper-V funciona como un hipervisor tipo 1, lo que significa que se ejecuta directamente sobre el hardware de la computadora, proporcionando un entorno de virtualización eficiente y de alto rendimiento.

Aquí hay algunas características clave de Hyper-V:

• Hipervisor Tipo 1: Hyper-V opera directamente sobre el hardware, lo que lo clasifica como un hipervisor de tipo 1. Esto le permite gestionar máquinas virtuales de manera eficiente sin depender de un sistema operativo anfitrión adicional.

• Plataforma Integrada: Hyper-V está integrado en sistemas operativos Windows, incluyendo versiones de escritorio como Windows 10 y en versiones de servidor Windows Server. Esto facilita su implementación en entornos que utilizan productos Microsoft.

• Creación y Gestión de VM: Permite la creación, configuración y gestión de máquinas virtuales. Cada VM puede ejecutar un sistema operativo independiente y sus aplicaciones, proporcionando aislamiento y flexibilidad.

• Consolidación de Servidores: Hyper-V permite consolidar varios servidores virtuales en un solo hardware físico, lo que mejora la utilización de recursos y facilita la administración.

• Migración en Caliente: Ofrece características como la migración en caliente, que permite trasladar máquinas virtuales de un host a otro sin interrupciones en el servicio.

• Snapshot y Clonación: Facilita la creación de instantáneas (snapshots) para respaldo y clonación de máquinas virtuales para replicar configuraciones.

Compatibilidad con Diversos Sistemas Operativos: Puede ejecutar máquinas virtuales que utilizan diversos sistemas operativos, incluyendo versiones de Windows, Linux y otros sistemas operativos compatibles.
En resumen, Hyper-V es una solución de virtualización integral para entornos Windows, utilizada para crear y gestionar máquinas virtuales en sistemas operativos de escritorio y servidores.

Configuración del ambiente Hyper-V

Dada la naturaleza de esta solución, deberemos profundizar en qué es un Virtual Switch. Sus diferentes formas de configuración y cómo van a ser implementadas para este caso práctico.
Configuración conmutadores virtuales
En Hyper-V, un Virtual Switch es un componente esencial que actúa como un conmutador de red virtual dentro del entorno de virtualización.

1) Definición: Un Virtual Switch es un componente de red virtual que permite la comunicación entre máquinas virtuales y también puede facilitar la conexión de máquinas virtuales con la red física.

2) Funcionamiento: Opera de manera similar a un switch físico en una red convencional. Permite que las máquinas virtuales se conecten entre sí y, en algunos casos, con la red física del host.

3) Tipos de Virtual Switch: Hay varios tipos de Virtual Switch en Hyper-V:

   • Externo: Permite que las máquinas virtuales se conecten a la red física del host y, por lo tanto, a la red externa.
   
   ▪ Interno: Facilita la comunicación entre máquinas virtuales y el host, pero no proporciona acceso directo a la red física externa.

   ▪ Privado: Ofrece aislamiento completo, permitiendo la comunicación solo entre las máquinas virtuales conectadas al mismo Virtual Switch privado.
 
4) Configuración: Al configurar un Virtual Switch, puedes especificar qué interfaz de red física en el host estará asociada con el switch. Esto determina cómo las máquinas virtuales se conectan a la red física.

5) Aislamiento y Comunicación: Un Virtual Switch puede proporcionar aislamiento entre las máquinas virtuales o permitir su conexión a la red física, según el tipo de switch seleccionado. Esto es esencial para establecer la topología de red deseada.

6) Consideraciones de Red: La configuración del Virtual Switch afecta cómo las máquinas virtuales se comunican entre sí y con la red externa. Es una parte clave para establecer la conectividad y la topología de red en entornos de virtualización.
En resumen, un Virtual Switch en Hyper-V es una entidad virtual que facilita la conectividad de red para las máquinas virtuales, permitiendo su comunicación y, en algunos casos, su conexión a la red física del host. La configuración del Virtual Switch es crucial para diseñar la infraestructura de red virtual y garantizar la comunicación eficiente entre las máquinas virtuales.

Conmutador “Internet”

![image](https://github.com/tatodanielr/tallerfebrero2024/assets/157429072/c8725c12-7bd6-417f-ae69-34892c3b470b)

Esta interfaz la configuramos con el perfil “Red externa”, nos va a permitir comunicar las redes privadas con el exterior.

Conmutador “Red Servidores”

En esta interfaz la configuramos con el perfil “Red interna”, en la misma vamos a todos los servidores.

![image](https://github.com/tatodanielr/tallerfebrero2024/assets/157429072/fa1ae377-35e6-4d6a-8d4e-d16d2b5a86e4)


 Instalacion ServerA:
 Sistema operativo: Rocky Linux 9.2
 Configuracion del hardware para la maquina virtual.
 ![image](https://github.com/tatodanielr/tallerfebrero2024/assets/157429072/4125877b-7cac-48ec-9a07-3d36d12a17d7)
