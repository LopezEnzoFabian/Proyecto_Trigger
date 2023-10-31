GUIA PARA GIT 

1_ Iniciar GIT en una carpeta
Posicionarse en la carpeta deseada y ejecutar " git init " . dentro de la carpeta se va a crear una carpeta oculta
llamada " .git " alli tendra toda la configuración del GITproyecto
2_ Cambiar ( MAIN o MASTER {Nombre de la rama principal}) Tenemos que ejecutar " git congfig --global init.defaultBranch nombre_cualqueira",
luego borrar la carpeta oculta y ejecutar " git init "
3_ Usuario ( git config --global user.name "nombre" ) (--global puede ir o no)
4_ Email ( git config --global user.email "email" ) (--global puede ir o no)
5_Comando para asociar editores de texto a GIT ( git config --global core.editor "code --wait" o "ruta/ejecutableDelEditor --wait")
6_Comando para editar una descripcion del ultimo commit ( git commit --amend )
7_ Revertir o quitar el ultimo commit realizado ( git reset --soft HEAD~1 )
8_Crear Ramas ( git branch " nombre-de-la-rama" ) en este caso solo se va a crear y para acceder
vamos a tener que escribir ( git checkout "nombre-de-la-rama" ). Pero si queremos hacer
las dos cosas juntas ( git checkout -b "nombre-de-la-rama" ) creamos y nos posicionamos dentro de larama
9_Para cambiar el nombre de una rama ( git branch -m "nombre-nuevo"). Pirmero nos posicionamos dentro de la rama
Tambien lo podemos hacer desde cualquier rama (git branch -m "nombre-rama-a-cambiar" "nombre-nuevo" )
10_Borrar una rama ( git branch -d "nombre-rama" ). Solo para repositorios locales
No hay que estar en la rama que estamos eliminando, siempre desde otra. La MAIN no se puede eliminar
11_ Fusionar ramas, para ello antes hay que estar posicionado en la rama que recibe los cambios o en la MAIN.
comando ( git merge "nombre-rama") vamos a fusionar desde MAIN la rama que elegimos, lo que va a hacer es agregar todo lo que tiene la rama a la rama MAIN
12_ Mostrar commit en una sola linea ( git log --oneline )
13_ Para fusionar ramas en conflictos, podemos elegir desde el editor qué parte vamos a agregar
puede ser una sola, o las dos, ademas agreando y quitando, podemos ponerle uno arriba de otro según combinemos
Luego vamos a la consola y ponemos ( git --continue ) para hacer un commit normal
14_Para subir un commit a GitHug ( git push origin main )
15_ Para bajar cambios desde github ( git checkout origin/main ) vemos los cambios dentro de la rama de GITHUB
Luego volvemos a la rama MAIN ( git pull origin main )
16_ Enviar mi repositorio remoto a un repositorio limpio a github, primero hay que crear un repositorio en GitHub, sólo con su nombre y anda más.
Luego en GIT ponemos ( git remote add origin "link http" )
17_Para clonar un repositorio de github a tu repositorio local ( git clone "https" )
18_ Eliminar una rama desde consola hacia github ( git push origin -d "nombre de la rama")
19_Ver las ramas tanto local como remota ( git branch -a )
20_Push de una RAMA local a RAMA remota ( git push rama-remota:rama-local )

