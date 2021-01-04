# Conception du projet 

## Types de donées

### Arbre Binaire 

Nous allons avoir besoint d'un arbre binaire generique de donnés non trié afin de representer l'arbre genealogique

Pour ce faire il nous faut trois types :
- ``T_Element`` un type generique.
- ``T_AB`` Un pointeur vers une ``T_AB_Cell``
- ``T_AB_Cell`` Un record qui est une cellule d'arbre : 
```
- gauche : T_AB
- droite : T_AB
- valeur : T_Element
```


### Personnes 

Nous allons vouloir representer des individues. Pour ce faire on utilisera un type record ``T_Personne`` :
```
- Identifiant : integer
- nom : string(20)
- prenom : string(20)
... <Tout autre info sur un individu>
```

### Arbre Genealogique 

Nous allons vouloir faire un arbre généalogique. On peut se servir de l'arbre binaire precedement créé pour faire notre arbre genalogique.
On va avoir `` T_AG`` qui sera une instanciation de ``T_AB`` avec ``T_Element`` qui est ``T_Personne``


## Fonctions Et Procedures


### Fonctions et procedures de ``T_AB`` : 

#### Initialiser

##### Specification
```ada
-- nom : init
-- sémantique:  Crée un arbre binaire avec un noeud racine. 
-- paramètres:
  -- arbre : out T_AB; -- Arbre qui est initialisé par la procedure
  -- e_racine : in T_element; -- Element contenue dans le noeud racine
-- pré-condition : ∅
-- post-condition :
  -- arbre.all /= null 
  -- arbre.all.value = e_racine
  -- arbre.all.gauche = null
  -- arbre.all.droite = null
-- Tests de la procédure :
procedure init(arbre : out T_AB, e_racine : in T_element);
```

#### Rafinage
```
R0 : “Créer un arbre binaire avec un noeud racine”
R1 : comment “Créer un arbre binaire avec un noeud racine”   -- arbre : out t_AB; e_racine : in T_element
  attribuer la valeur au noeud
R2 : comment “attribuer la valeur au noeud”  -- e_racine : in T_element
  arbre:=new T_AB_Cell
  arbre.all.element <- e_racine
```

#### Inserer une valeur à gauche

##### Specification
```ada
-- Nom : inserer_gauche
-- sémantique : inserer un noeud a gauche d’un noeud donner
--paramètres : --noeud : in out T_AB -- noeud ou il faut insérer à gauche    
        -- valeur : in T_element ; -- element à insérer
--précondition : l’arbre est initialiser 
--postcondition : noeud.all.gauche.all.element = valeur
procedure inserer_gauche(noeud : in out T_AB ; valeur : in t_element)
```

#### Rafinage
```
R0 : “inserer un noeud a gauche d’un noeud donné"
R1 : Comment “inserer un noeud a gauche d’un noeud donner” -- noeud : out T_AB; e_racine : in T_element; 
    if noeud.all.gauche /= null then
        raise exception_insertion;
    else 
        assigner valeur à gauche
    end if; 
R2 : Comment “assigner valeur à gauche” -- noeud : out T_AB; e_racine : in T_element; 
    noeud.all.gauche = new T_AB_Cell
noeud.all.gauche.all.element <- e_racine
```

#### Inserer une valeur à droite

##### Specification
```ada
-- Nom : inserer_droite
-- sémantique : inserer un noeud a droite d’un noeud donner
--paramètres : --noeud : in out T_AB -- noeud ou il faut insérer à droite    
        -- valeur : in T_element ; -- element à insérer
--précondition : l’arbre est initialiser 
--postcondition : noeud.all.droite.all.element = valeur
procedure inserer_droit(noeud : in out T_AB ; valeur : in t_element)
```

#### Rafinage
```
R0 : “inserer un noeud a droite d’un noeud donné"
R1 : Comment “inserer un noeud a droite d’un noeud donner” -- noeud : out T_AB; e_racine : in T_element; 
    if noeud.all.gauche /= null then
        raise exception_insertion;
    else 
        assigner valeur à droite
    end if; 
R2 : Comment “assigner valeur à droite” -- noeud : out T_AB; e_racine : in T_element; 
    noeud.all.droite = new T_AB_Cell
noeud.all.droite.all.element <- e_racine
```

#### Calculer la taille 

##### Specification 
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

#### Rechercher un noeud
##### Specification 

```ada
-- nom : rechercher
-- sémantique :  rechercher un noeud dans un arbre
-- paramètres : racine : in T_AB --l’arbre où on fait une recherche
--        valeur : in T_element -- le noeud à rechercher
  -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
-- retour : T_AB -- le noeud
-- pré-condition : l’arbre est initialisé
-- post-condition : retourne le noeud ou null si le noeud existe pas
-- Tests de la procédure :
function rechercher(racine : in  T_AB ; valeur : in T_element) return T_AB
```

#### afficher arbre
##### Specification 
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
#### Suprimer element
##### Specification 
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

### Fonctions et procedures de ``T_Persone`` : 


### Fonctions et procedures de ``T_AG`` : 
