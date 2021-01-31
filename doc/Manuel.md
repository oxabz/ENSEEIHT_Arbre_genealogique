# Manuel Utilisateur

## Dépendances 

### Build 
| Dépendance | Version               |
|------------|-----------------------|
| gnat       | testé avec : 7ubuntu1 |

### Utilisation
- Terminal qui accepte les caractères d'échappement ANSI. ([xterm](https://en.wikipedia.org/wiki/Xterm "Xterm"), [rxvt](https://en.wikipedia.org/wiki/Rxvt "Rxvt"), [GNOME Terminal](https://en.wikipedia.org/wiki/GNOME_Terminal "GNOME Terminal"), [Konsole](https://en.wikipedia.org/wiki/Konsole)...)


## Installation

### Compilation

Dans la racine du projet exécuter :
```sh
./build.sh
```
Le script effectuera la compilation du programme et met, le résultat dans le dossier ``target``.

### Installation 

#### Installation administrateur :
- Renommer l'exécutable ``main`` localisé dans ``target`` et le renommer en le nom de la commande voulu.
- Déplacer l'exécutable vers /bin/ ou vers /usr/bin/

#### Installation utilisateur : 

- Renommer l'exécutable ``main`` localisé dans ``target`` et le renommer en le nom de la commande voulu.
- Déplacer l'exécutable vers ~/.local/bin
- ajouter ``export PATH=$PATH:~/.local/bin`` au fichier ``.bashrc``/``.zshrc``.

## Utilisation

- exécuter la commande/exécutable
- Remplissez les demandes de l'application afin d'initialiser l'arbre
- L'arbre sera visible en haut de l'écran 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5MjkwMTE1NDUsLTU3MDIwOTg4OV19
-->