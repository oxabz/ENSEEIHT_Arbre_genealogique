# ENSEEIHT Arbre genealogique

## Introduction 

Le projet proposé par l'ENSEEIHT consiste à créer un système de gestion d'arbre généalogique d'un individue. L'arbre généalogique permet à un individu de répertorier l'ensemble de ses ancêtres.
On peut représenter l'ensemble des ancêtres par un arbre où chaque ou chaque individu est représenté par un nœud qui peut avoir deux parents. 
> Exemple :
> - Bernard
>	 - pere : Jackie
>		- pere : Dominique 
>	 - mere : Jane 
>		- mere : Dominique 

On voudra pouvoir designer les individus en relation des uns par rapport aux autres avec la notion de génération d'ancêtre et de descendant
> Exemple : 
> - Un individue est sont propre ancetre/decendant  de generation 0
> - Le pere d'un individue est sont ancetre de generation 1
> - La grand mere d'un  individue est son ancetre de generation 2
> - Le fils d'un individue est sont dedendant de generation 1


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
- Déplacer l'exécutable vers ``/bin/`` ou vers ``/usr/bin/``

#### Installation utilisateur : 

- Renommer l'exécutable ``main`` localisé dans ``target`` et le renommer en le nom de la commande voulu.
- Déplacer l'exécutable vers ``~/.local/bin``
- ajouter ``export PATH=$PATH:~/.local/bin`` au fichier ``.bashrc``/``.zshrc``.

## Utilisation

- exécuter la commande/exécutable
- Remplissez les demandes de l'application afin d'initialiser l'arbre
- L'arbre sera visible en haut de l'écran. 
	- On peut modifier et faire des requête sur l'arbre en entrant les lettres correspondant a une commande et en suivant les demandes faite par le programme. Les lettres des commandes sont encadré dans les interface pour les mettre en évidence
`` Exemple : [r]einitialiser l'arbre -> La commande est r.`` 
	- On peut quitter le programme entrant la commende ``e``.


## [Rapport](./doc/Rapport.md)

Pour plus d'information consultez le rapport sur le projet.