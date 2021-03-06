generic
    type T_Element is private;
    with function "=" (X, Y: T_Element) return boolean;
    with procedure afficher_element (X: T_Element);
package p_arbre_binaire is
    type T_AB is private;

    INSERTION_ERROR : exception;
    UNINTIALISE_ERROR : exception;
    NOEUD_ABSENT_ERROR : exception;

    -- TODO : WRAP afficher  


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
    procedure init(arbre : out T_AB; e_racine : in T_element) with 
    post => not is_null(arbre) and then get_racine_element(arbre)=e_racine and then is_null(get_SA_droit(arbre))and then is_null(get_SA_gauche(arbre));

    -- Nom : inserer_gauche
    -- sémantique : inserer un noeud a gauche d’un noeud donner
    --paramètres : 
        -- noeud : in out T_AB -- noeud ou il faut insérer à gauche    
        -- valeur : in T_element ; -- element à insérer
    --précondition : l’arbre est initialiser 
    --postcondition : noeud.all.gauche.all.element = valeur
    procedure inserer_gauche(noeud : in T_AB ; valeur : in t_element) with 
    pre=> not is_null(noeud),
    post=> not is_null(get_SA_gauche(noeud))and then get_racine_element(get_SA_gauche(noeud))=valeur;

    -- Nom : inserer_droite
    -- sémantique : inserer un noeud a droite d’un noeud donner
    --paramètres : --noeud : in out T_AB -- noeud ou il faut insérer à droite    
        -- valeur : in T_element ; -- element à insérer
    --précondition : l’arbre est initialiser 
    --postcondition : noeud.all.droite.all.element = valeur
    procedure inserer_droit(noeud : in T_AB ; valeur : in t_element) with
    pre=> not is_null(noeud);

    -- nom : calcul_taille
    -- sémantique :  renvoie nombre de nœuds de l’arbre 
    -- paramètres :
        -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
    -- retour : integer --nombre nœud de l’arbre
    -- pré-condition : 
    -- post-condition : 
    -- Tests de la procédure :
    function calcul_taille(arbre : in T_AB) return integer;

    -- nom : rechercher
    -- sémantique :  rechercher un noeud dans un arbre
    -- paramètres : 
        --arbre : in T_AB --l’arbre où on fait une recherche
        --valeur : in T_element -- le noeud à rechercher
    -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
    -- retour : T_AB -- le noeud
    -- pré-condition : 
    -- post-condition : retourne le noeud ou null si le noeud existe pas
    -- Tests de la procédure :
    function rechercher(arbre : in  T_AB ; valeur : in T_element) return T_AB with 
    post => is_null(rechercher'result) or else (get_racine_element(rechercher'result) = valeur);

    -- nom : afficher
    -- sémantique :  affiche un arbre  
    -- paramètres :
        -- arbre : in  T_AB -- Arbre qu’on veut afficher
    -- profondeur : in integer -- Profondeur de cette arbre pour affichage (déterminé le décalage de l’arbre)
    -- etiquette_gauche : in string  -- Étiquette pour la partie gauche 
    -- etiquette_droite : in strin(0..10) -- Étiquette pour la partie droite
    -- pré-condition : 
        -- arbre != null
    -- post-condition : 
    -- Tests de la procédure :
    procedure afficher(arbre : in T_AB; profondeur : in integer; etiquette_gauche, etiquette_droite : in string) with
    pre => not is_null(arbre);

    -- nom : supprimer
    -- sémantique :  suprime un noeud de l’arbre 
    -- paramètres :
        -- arbre : in  T_AB -- Arbre dont on veut suprimer un nœud
    -- element : in T_element -- Element à supprimer dans l’arbre
    -- pré-condition : element appartien arbre 
    -- post-condition : element n'est plus dans l'arbre
    -- Tests de la procédure :
    procedure supprimer(arbre: in T_AB;  element : in T_Element) with 
    post => is_null(rechercher(arbre, element));

    --Nom : get_SA_droit
    --sémantique : retourne le sous-arbre droit d’un noeud
    --paramètres : 
        -- arbre : T_AB
    -- retour : T_AB
    --préconditions : arbre/=null
    --postconditions :
    function get_SA_droit (arbre: T_AB) return T_AB with 
    pre=> not is_null(arbre);

    --Nom : get_SA_gauche
    --sémantique : retourne le sous-arbre droit d’un noeud
    --paramètres : 
        -- arbre : T_AB
    -- retour : T_AB
    --préconditions : arbre/=null
    --postconditions : 
    function get_SA_gauche (arbre: T_AB) return T_AB with
    pre=> not is_null(arbre);

    --Nom : get_racine_element
    --sémantique : retourne le sous-arbre droit d’un noeud
    --paramètres : 
        -- arbre : T_AB
    -- retour : T_AB
    --préconditions : arbre/=null
    --postconditions : 
    function get_racine_element (arbre: T_AB) return T_Element with
    pre=> not is_null(arbre);

    --Nom : is_null
    --sémantique : retourn le resultat de comparaison a null
    --paramètres : 
        -- arbre : T_AB
    -- retour : T_AB
    --préconditions :
    --postconditions : 
    function is_null(arbre: T_AB) return boolean;

private
    type T_AB_Cell;
    type T_AB is access T_AB_Cell;
    type T_AB_Cell is record
       gauche : T_AB;
       droite : T_AB;
       element: T_Element;
    end record;
end p_arbre_binaire;
