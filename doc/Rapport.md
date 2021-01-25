# Rapport de Projet de Méthodologie de la Programmation

## Objectif du rapport 

Ce rapport présentera le projet réalisé pour le module "Méthodologie de la Programmation" de l'ENSEEIHT Toulouse.   
Il  abordera les différentes parties de la conception de ce projet. Il y sera présenté les choix techniques, les algorithmes utilisés, la structure du programme et les difficultés rencontrée.

## Introduction 

Le projet proposé consiste à créer un système de gestion d'arbre généalogique d'un individue. L'arbre généalogique permet à un individu de répertorier l'ensemble de ses ancêtres.
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

## Plan 

Les modules étant déjà une sous-division structurante du projet du programme nous aborderont chaque aspect de conception pour chaque module.

Le rapport suivra le plan suivant : 

[TOC]

## Architecture du programme : 

Afin d'assurer une bonne lisibilité et une bonne modularité, le code du projet a été décomposé en plusieurs moules ada par rapport à leurs fonctions. 

Dans cette partie les modules constituant ce projet seront présenté avec leur but. Nous nous intéresserons qu'aux modules appartenant au projet et nous omettrons les modules standard de ada.

Les modules développé sont : 
- **``p_arbre_binaire``** : Ce module générique contient l'entièreté des fonctions et des types nécessaire pour faire fonctionner un arbre binaire non trié. On y trouve le type générique``T_AB`` et les sous programmes permettant de le manipuler.
*Paramètre de généricité* : 
	- T : type des donnés
	- "=" : comparaison entre deux T
	- put(x :T) : procédure d'affichage de T
- **``p_linked_list``** : Ce module générique contient les sous-programmes et les types afin de faire une liste chainée.  Pour éviter de répéter du travail. On utilise un module développé dans le cadre des TPs 
*Paramètre de généricité* : 
	- T : type des donnés
	- afficher(x :T) : procédure d'affichage de T
- **``p_personne``** : Ce module contient le type ``t_personne`` qui représente un individu. Il y a aussi les différents sous-programmes permettant de le manipuler (init/getter/setter/comparaison/affichage).
- **``p_arbre_genealogique``** : Ce module instancie ``p_arbre_binaire`` avec ``t_persone`` et ses sous programme associé. Dans ce module on retrouve aussi toutes les procédures de manipulation d'un arbre généalogique qui ne n'ont pas de sens dans un arbre binaire non trié quelconque.  Dans ce module on renomme ``T_AB`` en ``T_AG``. Dans ce module on instancie aussi ``p_linked_list `` avec ``t_personne`` car certaines fonctions ont besoin de renvoyer une liste d'individus.
- **``p_front``** : dans ce module on retrouve toutes les procédures et fonction d'entré/sortie nécessaire pour le programme principal(``main``).
- **``main``** et le programme principal il contient la logique du menu et fait les appels à ``p_arbre_généalogique`` et à ``p_arbre_binaire`` en fonction des entré de l'utilisateur.


## Choix de conception 


## Types

Dans cette partie nous nous intéresserons aux types contenue dans les différents modules. 

### ``p_arbre_binaire`` : 

Dans ce module on veut mettre en place un arbre binaire non trié. Un arbre binaire non trié structurellement n'est pas diffèrent de tout autre arbre binaire. Il est constitué de cellules contenant chacune deux références à d'autre cellule et un élément de donné 
  
Pour ce faire il nous faut trois types :
- **``T_Element``**(privé) : Un type en paramètre de généricité du module.
- **``T_AB``**(visible privé) : Un pointeur vers une cellule de l'arbre(``T_AB_Cell``). Représente un arbre binaire.
- **``T_AB_Cell``**(privé) : Un record qui représente une cellule d'arbre : 
```
- gauche : T_AB
- droite : T_AB
- valeur : T_Element
```


### ``p_personne`` 

Nous allons vouloir représenter des individus. Pour ce faire on utilisera un type record ``T_Personne`` :
```
- id : integer
- nom : string
- prenom : string
```
Le type ``T_personne`` n'est encore utilisé que pour contenir le nom et le prénom de l'individue mais le type pourrait être très facilement étendu en modifiant la déclaration du type.   

### ``T_linked_list``

Certains sous programmes nécessiterons une liste pour fonctionner. Il faudra 

### ``p_arbre_genealogique`` 

Nous allons vouloir faire un arbre généalogique. On peut se servir de l'arbre binaire de ``p_arbre_binaire`` pour faire notre arbre généalogique.
On utilisera le type ``T_AG`` qui est une implémentation de ``T_AB`` avec ``T_personne`` renommé.

Les sous programmes de ce module nécessite de faire des listes de personnes nous implémenterons donc le module ``p_linked_list`` avec ``T_personne`` pour obtenir une ``t_linked_list`` qu'on renommera en ``L_personne`` .
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1MDAzODEwMiwyMDMzODg5MDc2LC0xMD
M4OTc1ODcwLDE4ODc1OTk1MSwtMTMzMzk4MDU5MCwtMTk0NDQ0
NDQ4MywxNDgzNzM4MjMwLC0xMjc4MTE0NTUsNzg2NzA1MjExXX
0=
-->