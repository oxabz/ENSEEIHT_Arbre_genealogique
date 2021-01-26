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
- nom : unbounded_string
- prenom : unbounded_string
```
Le type ``T_personne`` n'est encore utilisé que pour contenir le nom et le prénom de l'individue mais le type pourrait être très facilement étendu en modifiant la déclaration du type.   

### ``P_linked_list``

Certains sous programmes nécessiterons une liste pour fonctionner. Il faudra donc un type ``T_linked_list`` qui représente une liste 

Dans ce module on a 2 types :  
- ``T_linked_list_cell`` : Un record qui constitue la liste
```
- value : T
- next : T_linked_list
``` 
- ``T_linked_list`` : un pointeur vers ``T_linked_list_cell``.

### ``p_arbre_genealogique`` 

Nous allons vouloir faire un arbre généalogique. On peut se servir de l'arbre binaire de ``p_arbre_binaire`` pour faire notre arbre généalogique.
On utilisera le type ``T_AG`` qui est une implémentation de ``T_AB`` avec ``T_personne`` renommé.

Les sous programmes de ce module nécessite de faire des listes de personnes nous implémenterons donc le module ``p_linked_list`` avec ``T_personne`` pour obtenir une ``t_linked_list`` qu'on renommera en ``L_personne``.


## Fonctions Et Procédures

Dans cette partie nous nous intéresserons aux procédures et fonctions importantes de chaque module.

Nous omettrons certaines fonctions et procédures qui ne sont pas complexe. La spécification complète des packages avec la spécification des sous-programmes seront disponible en annexe. 

### Fonctions et procédures de ``P_arbre_binaire`` : 

#### Calculer la taille (``calcul_taille``)

Pour calculer la taille d'un arbre binaire se calcule avec un algorithme de récursion. En effet on peut décomposer le problème en sommer la taille des deux sous arbre + 1.

#####  Spécification 
```ada
-- nom : calcul_taille
-- sémantique :  renvoie nombre de nœuds de l’arbre 
-- paramètres :
  -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
-- retour : integer --nombre nœud de l’arbre
-- pré-condition : 
-- post-condition : 
-- Tests de la procédure :
function calcul_taille(arbre : in T_AB) return integer;
```

##### Rafinage
```
R0 : calculer le  nombre de nœuds de l’arbre 
R1 : comment “calculer le  nombre de nœuds de l’arbre”  --arbre : in T_AB
ajouter le noeud courant + sosu arbre gauche + sous_arbre droit
R2 : comment “ajouter le noeud courant + sosu arbre gauche + sous_arbre droit”
  if(arbre = null) then
    return 0;
  else
    return 1+ calcul_taille(arbre.all.gauche) + calcul_taille(arbre.all.droite)
  end if;
```

#### Rechercher un nœud (``rechercher``)

Rechercher fais partie des fonctions qui change entre un arbre binaire trié et non trié. Dans un arbre non trié nous n'avons aucune information pour trouver l'élément. Il nous faut donc parcourir récursivement l'arbre pour trouver l'element. 

##### Specification 
```ada
-- nom : rechercher
-- sémantique :  rechercher un noeud dans un arbre
-- paramètres : racine : in T_AB --l’arbre où on fait une recherche
  -- valeur : in T_element -- le noeud à rechercher
  -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
-- retour : T_AB -- le noeud
-- pré-condition : l’arbre est initialisé
-- post-condition : retourne le noeud ou null si le noeud existe pas
-- Tests de la procédure :
function rechercher(racine : in  T_AB ; valeur : in T_element) return T_AB
```

##### Raffinage 
```
R0 : ”rechercher un noeud dans un arbre”
R1 : comment “rechercher un noeud dans un arbre”  -- arbre : in  T_AB ; valeur : in 
  if(arbre =null or else arbre.all.element = valeur) then
    return arbre;
  end if;
  result := rechercher(arbre.all.gauche);
  if(result = null)
      result := rechercher (arbre.all.droite);
  end if;
  return result;
```

#### afficher arbre (``afficher``)

On cherche à reproduire la trace ci-dessou. Pour ce faire on va utiliser un algorithme récursif. Mais cependant on voit qu’afficher un sous arbre n'est pas la même chose qu'afficher un arbre en effet la tabulation varie en fonction de la profondeur il nous faudra donc passer la profondeur dans les paramètres.
On fera aussi une récursion avec l'ordre ``racine->sous arbre gauche->sous arebre droit``.
##### Trace 

```
[1] Minet Bernard
   Pere : [2] Minet Jack
      Pere : [4] Minet Pierre
      Mere : [5] Brosse Anne
   Mere : [3] Legrand Jean
```
plus généralement : 
```
<element>
   <label-gauche> : <element>
      <label-gauche> : <element>
      <label-droit> : <element>
   <label-droit> : <element>
```

##### Spécification 
```ada
-- nom : afficher
-- sémantique :  affiche un arbre  
-- paramètres :
  -- arbre : in  T_AB -- Arbre qu’on veut afficher
  -- profondeur : in integer -- Profondeur de cette arbre pour affichage (déterminé le décalage de l’arbre)
  -- etiquette_gauche : in string(0..10)  -- Étiquette pour la partie gauche 
  -- etiquette_droite : in string(0..10) -- Étiquette pour la partie droite
-- pré-condition : 
-- post-condition : 
-- Tests de la procédure :
procedure afficher(arbre : in T_AB; profondeur : in integer; ethiquette_gauche, etiquette_droite : in string(0..10))
```

##### Rafinage
```
R0 : “affiche un arbre”
R1 : Comment “affiche un arbre”  -- arbre : in  T_AB; profondeur : in integer; 
                                 -- etiquette_gauche : in string(0..10); 
                                 -- etiquette_droite : in string(0..10) 
  if(arbre = null) then raise arbre_exception; end if;
  afficher racine; 
  if(arbre.all.droite /= null )then 
    afficher sous arbre droit 
  end if;
  if(arbre.all.gauche /= null )then 
    afficher sous arbre gauche 
  end if;
R2 : Comment “afficher racine”  -- arbre : in  T_AB;        
  afficher_element(arbre.all.element);
  new_line;
R2 : Comment afficher sous arbres droite -- arbre : in  T_AB; profondeur : in integer; 
                                         -- etiquette_gauche : in string(0..10); 
                                         -- etiquette_droite : in string(0..10) 
  for i in 1..profondeur loop
    put(“   ”);
  end loop;
  put(etiquette_droite);
  put(“ : ”);
  afficher(arbre.all.droite, profondeur+1, etiquette_droite, etiquette_gauche)
R2 : Comment afficher sous arbres gauche -- arbre : in  T_AB; profondeur : in integer; 
                                         -- etiquette_gauche : in string(0..10); 
                                         -- etiquette_droite : in string(0..10) 
  for i in 1..profondeur loop
    put(“   ”);
  end loop;
  put(etiquette_gauche);
  put(“ : ”);
  afficher(arbre.all.gauche, profondeur+1, etiquette_droite, etiquette_gauche)

```

#### Supprimer élément(``supprimer``)

La suppression d'un élément est très similaire avec la recherche. On fait juste attention à rechercher avec une profondeur d'avance afin de pouvoir set le bon pointeur de sous arbre à null.

##### Spécification 
```ada
-- nom : supprimer
-- sémantique :  suprime un noeud de l’arbre 
-- paramètres :
  -- arbre : in  T_AB -- Arbre dont on veut suprimer un nœud
  -- element : in T_element -- Element à supprimer dans l’arbre
-- pré-condition : 
-- post-condition : 
-- Tests de la procédure :
procedure supprimer(arbre: in out T_AB;  element : in T_Element)
```

##### Raffinage 
```
R0 : suprimer un noeud de l’arbre 
R1 : comment “supprimer un noeud de l’arbre” -- arbre : in  T_AB; element : in T_element
  if(suprimer_rec(arbre, valeur) = false) then
    raise noeud_absent
  end if;
R2 : comment “supprimer récursivement le noeud et ses antécédents" aka "suprimer_rec"
          -- arbre : in  T_AB; element : in T_element
          -- return : boolean
  if(arbre=null) then
    return false;
  end if;
  if(arbre.all.gauche /= null and then arbre.all.gauche.all.element = valeur) then
    arbre.all.gauche:=null;
    return true;
  end if;
  if(arbre.all.droit /= null and then arbre.all.droit.all.element = valeur) then
    arbre.all.droit:=null;
    return true;
  end if;
  res := supprimer_rec(arbre.all.droit,valeur)
  if(not res) then 
    res := supprimer_rec(arbre.all.gauche, valeur);
  end if;
  return res;
```

### Fonctions et procédures de ``p_arbre genealogique`` :

#### Récupérer les ancêtres de génération n d'un individu : (``get_ancetre_generation``) : 

Afin de pouvoir obtenir les ancetres de generation n d'un incividu il nous faudra en premier lieu pa

##### Spécification
```
--Nom : get_ancetre_generation
--sémantique : retourne la liste des ancêtres d’une certaine generation d’un individue
 --paramètres :
-- arbre : T_AG
-- persone : integer 
-- generation : integer
-- retour : List<T_Person>
-- préconditions : arbre/=null
-- postconditions : 
function get_ancetre_generation(arbre : in T_AG, persone : in integer, generation : integer) return L_Personne;
```

##### Raffinage

```
R0 : “retourne la liste des ancêtres d’une certaine generation d’un individue”
R1 : Comment “retourne la liste des ancêtres d’une certaine generation d’un individue”
    individu = find(arbre, get_dummy(personne));
parcourir récursivement jusqu’a la bonne profondeur et ajouter les ancetre une fois a la bonne profondeur -- individu : in T_AG; resultat : in out L_Personne; generation : in integer 
R2 :  Comment “parcourir récursivement jusqu’a la bonne profondeur et ajouter les ancetre une fois a la bonne profondeur ” aka “get_ancetre_generation_rec”  -- individu : in T_AG; resultat : in out L_Personne; generation : in integer
    if(individu = null) then return; end if;
    if(generation = 0) then 
       add(resultat, get_element(individu))
       return;
    end if;
    get_ancetre_generation_rec(get_droit(individu), resultat, generation-1);
    get_ancetre_generation_rec(get_gauche(individu), resultat, generation-1);
```


### Fonctions et procédures de ``main`` : 

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIwNTM1NjYxMzcsLTQ0OTAwMDc4OCwtMT
gxNDMwOTgyMiw1OTg2MTcwNzUsLTE0ODA0MzQ1MTksLTcwMDIw
ODkyMSwxMDA0MDUyMTAwLC0xNjAwNTEwOTkwLC02Nzk4NTA5Mz
AsLTE4NDUzNzY0OTcsMTMyMTA4NTc4NSwxMTc0MDE0NTM5LDIw
MzE5NDcxNzMsLTYxMzMxNjI1NCwyMDMzODg5MDc2LC0xMDM4OT
c1ODcwLDE4ODc1OTk1MSwtMTMzMzk4MDU5MCwtMTk0NDQ0NDQ4
MywxNDgzNzM4MjMwXX0=
-->