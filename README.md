# App de Gestión de Usuarios (Prueba Técnica iOS)

## Introducción

Esta aplicación es una solución a una prueba técnica para iOS que demuestra la construcción de una app robusta y escalable para la gestión de usuarios. La aplicación permite listar, agregar y editar usuarios, integrando una API REST para la obtención de datos inicial y persistencia local con Realm.

El proyecto está construido en SwiftUI y sigue los principios SOLID y Clean Code.

## ✨ Features

* **Listado de Usuarios:** Muestra una lista de usuarios obtenida desde una API y/o la base de datos local.
* **Persistencia Offline-First:** Utiliza **Realm** como base de datos local. La app siempre muestra datos de la base de datos primero para un inicio rápido y funcionamiento sin conexión.
* **Sincronización Automática:** Al iniciar, si la base de datos local está vacía, consume los datos de la API y los guarda automáticamente en Realm.
* **CRUD:**
    * **Crear:** Añade nuevos usuarios a través de un formulario con validaciones. Los nuevos usuarios se guardan localmente.
    * **Editar:** Modifica el nombre y el email de un usuario, persistiendo los cambios en Realm.
* **Actualización Reactiva:** La lista de usuarios se actualiza automáticamente y al instante después de crear o editar un usuario, gracias a un enfoque reactivo.
* **Interfaz Moderna:** Construida con **SwiftUI** y utilizando concurrencia con **async/await**.

## 🏛️ Arquitectura: MVVM-C con Capa de Datos Aislada

La arquitectura de la aplicación está diseñada para ser escalable y fácil de mantener, separando claramente las responsabilidades.

**Flujo General:** `Vista (SwiftUI)` → `ViewModel` → `Repositorio` → `Fuentes de Datos (API/Realm)`

* **MVVM-C (Model-View-ViewModel-Coordinator):**
    * **Vista:** Componentes de SwiftUI cuya única responsabilidad es mostrar el estado del ViewModel y reenviar las acciones del usuario.
    * **ViewModel:** Contiene la lógica de presentación y el estado de la vista. 
    * **Coordinador:** Gestiona el flujo de navegación. Decide qué vista mostrar y cuándo, manteniendo los ViewModels y las Vistas desacoplados de la lógica de navegación.

* **Capa de Datos (Patrón Repositorio):**
    * **`UserRepository` (La Fachada):** Es el único punto de entrada para la lógica de negocio. Actúa como un orquestador las fuentes de datos. Implementa la estrategia de "cache-first": primero intenta leer de la base de datos local y, solo si está vacía, acude a la API.
    * **`Data Sources`:**
        * `UserLocalDataSource`: Es el único componente que sabe hablar con **Realm**. Contiene toda la lógica de escritura, lectura y actualización de la base de datos.
        * `UserRemoteDataSource`: Es el único componente que sabe hablar con la **API**. Contiene la lógica de las llamadas de red.


## 🛠️ Decisiones Técnicas y Stack

* **Lenguaje:** Swift 5.7+
* **UI:** SwiftUI
* **Arquitectura:** MVVM+C
* **Concurrencia:** `async/await` para un código asíncrono limpio y legible.
* **Persistencia:** **Realm Swift SDK**. Elegido por su alto rendimiento.
* **Consumo de API:** **Alamofire**.
* **Navegación:** `NavigationStack` gestionado por un Coordinador para un control centralizado del flujo.

## 🚀 Cómo Ejecutar el Proyecto

1.  **Clonar el Repositorio:**
    ```bash
    git clone https://github.com/MayeMR22/UserAppPayPhone.git
    ```
2.  **Abrir en Xcode:**
    Abre el archivo `.xcodeproj` o `.xcworkspace` en Xcode.
3.  **Instalar Dependencias:**
    Xcode instalará automáticamente las dependencias (Realm, Alamofire) a través de Swift Package Manager. Si no lo hace, ve a `File > Packages > Resolve Package Versions`.
4.  **Ejecutar:**
    Selecciona un simulador o un dispositivo físico con iOS 15+ y pulsa "Run" (Cmd+R).

## 📝 Aspectos a Considerar

* **Agregar funcionalidad de Eliminar:** En la prueba quedo pendiente implementar la funcionalidad de eliminar usuario. 
* **Manejo de Errores:** El manejo de errores actual es básico (mensajes simples en la UI). 
* **Pruebas Unitarias:** La arquitectura, basada en protocolos e inyección de dependencias (`UserRepositoryType`, `UserLocalDataSourceType`), está perfectamente diseñada para ser testeable. El siguiente paso sería añadir pruebas unitarias para los ViewModels y el Repositorio, usando "mocks" de las dependencias.
* **UI/UX:** El enfoque principal fue la arquitectura y la funcionalidad. La interfaz de usuario es limpia y funcional, pero podría ser mejorada aún más con animaciones y un diseño más elaborado.
