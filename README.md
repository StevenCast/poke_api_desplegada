# Despliegue de una Aplicación en Amazon Appstore
Esta guía detalla el proceso paso a paso para desplegar una aplicación móvil en la Amazon Appstore. Sigue estos pasos para garantizar que tu aplicación esté lista para llegar a una audiencia global.

## Crear una Cuenta de Desarrollador en Amazon
Para comenzar, dirígete a Amazon Developer y crea una cuenta de desarrollador. Una vez creada, serás redirigido al panel principal, donde deberás hacer clic en el botón "Add a New App" para iniciar el proceso de envío.

![{87F33BD8-DAD2-4E2C-B8A5-6733EE2DB554}](https://github.com/user-attachments/assets/d7a8ddbd-5060-4f38-89cd-36ffddfd20e8)


## Información Inicial de la Aplicación
Proporciona el título de tu aplicación y selecciona una categoría adecuada (por ejemplo, Social). Después de guardar, se te pedirá completar varios campos necesarios para el envío de la aplicación.

![{418B6742-29F8-489F-8ADF-5CE058016F02}](https://github.com/user-attachments/assets/88aaa1e7-e2ac-4691-b80d-b98040c031ba)

## Subir el Archivo APK
Antes de continuar, asegúrate de haber generado el archivo APK de tu aplicación. Para este proyecto, el APK fue creado con Flutter e incluye funciones como la visualización de Pokémon y la localización basada en direcciones IP. Para generar el APK, abre una terminal en el directorio de tu proyecto y ejecuta:

bash
Copy code
flutter build apk --split-per-abi  
Este comando generará varios archivos APK. Cambia el nombre del archivo correspondiente y súbelo a la plataforma.

![{F7BB4C4D-4F23-4DB4-9BD8-F8ADAA6D9DFA}](https://github.com/user-attachments/assets/62501d0c-80d1-4047-aa0c-f8dba54e604b)

![{B2842BD6-ED22-476B-83DB-EBBF028FEE1D}](https://github.com/user-attachments/assets/9da948c0-9bc7-4e73-a5d5-11418433c2ef)


## Detalles Adicionales
Añade detalles opcionales como una subcategoría (si aplica) y los idiomas soportados. En este caso, el idioma principal es español.

## Compatibilidad y Público Objetivo
Define la compatibilidad de dispositivos para tu aplicación. Ten en cuenta que algunos dispositivos de Amazon no están disponibles en todas las regiones. Especifica el público objetivo, que en este caso son usuarios de 16 años en adelante. Completa el cuestionario de clasificación de contenido para determinar la categoría de tu aplicación. Si tu aplicación no recopila datos de los usuarios, indica esta información en la sección de recopilación de datos.

![{0D060BD9-ECD0-4162-9380-8FE281379281}](https://github.com/user-attachments/assets/fdeaf7f9-c42a-4a43-b433-f1aaf9283af2)

![{CA9270EF-B749-40C4-88E3-D68B5A93FB99}](https://github.com/user-attachments/assets/5463d1d4-bcb6-42ea-b0ed-f540a9a7b30c)

## Detalles de la Appstore
En esta etapa, proporciona la siguiente información:

Precios: Define el precio de tu aplicación (esta aplicación es gratuita).
Descripciones: Añade descripciones cortas y largas para diferentes localizaciones (por ejemplo, inglés, español, español (México)).
Recursos Multimedia: Sube el ícono de tu aplicación, capturas de pantalla y videos promocionales.

![{128ADFBD-59C6-4EF9-9B7B-8A2794EE76F5}](https://github.com/user-attachments/assets/540cbf37-2327-4f88-a7d1-c5e8e37694b5)
![{0199E319-F6B3-4BA4-B0EA-FDB0242EAC28}](https://github.com/user-attachments/assets/d8322eae-7436-495c-9ec4-e8610f01fa06)


## Revisión Final y Envío
Revisa todos los detalles para asegurarte de que sean correctos antes de enviar tu aplicación. Opcionalmente, puedes especificar una fecha de lanzamiento. Finalmente, certifica el envío y envía la aplicación para su aprobación.

![{29855267-9315-42B9-B097-EFF1DD900B67}](https://github.com/user-attachments/assets/52a6a102-29a5-46cf-a2a6-8bef4bfa9fa4)
![{A4C85282-061E-4AF6-B975-0F70B1B2A6FA}](https://github.com/user-attachments/assets/76ecabaa-07d5-4f46-a1b5-10850f20107d)


## Aprobación de la Aplicación
Una vez enviada, espera a que el equipo de Amazon Appstore revise y apruebe tu aplicación. Tras la aprobación, tu aplicación estará disponible en la tienda para que los usuarios la descarguen.
![{792F51C4-BE13-49D6-ADBD-3EC19BCC840C}](https://github.com/user-attachments/assets/2c9d7030-9e05-4102-a510-b9b1b809d7ae)
![{18ACEDD1-5A94-41EF-A1DB-0C784E57C207}](https://github.com/user-attachments/assets/fcd07568-5a10-4075-bbdc-5a4227eb0983)


