with Ada.Text_IO; use Ada.Text_IO;

package body p_arbre_binaire is
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
    procedure init(arbre : out T_AB; e_racine : in T_element) is 
    begin
        arbre := new T_AB_Cell;
        arbre.all.element := e_racine; 
    end init; 

    -- Nom : inserer_gauche
    -- sémantique : inserer un noeud a gauche d’un noeud donner
    --paramètres : 
        -- noeud : in out T_AB -- noeud ou il faut insérer à gauche    
        -- valeur : in T_element ; -- element à insérer
    --précondition : l’arbre est initialiser 
    --postcondition : noeud.all.gauche.all.element = valeur
    procedure inserer_gauche(noeud : in T_AB ; valeur : in t_element) is 
    begin
        if noeud.all.gauche /= null then
            raise INSERTION_ERROR;
        else 
            noeud.all.gauche := new T_AB_Cell;
            noeud.all.gauche.all.element := valeur;
        end if; 
    end inserer_gauche;

    -- Nom : inserer_droite
    -- sémantique : inserer un noeud a droite d’un noeud donner
    --paramètres : --noeud : in out T_AB -- noeud ou il faut insérer à droite    
        -- valeur : in T_element ; -- element à insérer
    --précondition : l’arbre est initialiser 
    --postcondition : noeud.all.droite.all.element = valeur
    procedure inserer_droit(noeud : in T_AB ; valeur : in t_element) is
    begin
        if noeud.all.droite /= null then
            raise INSERTION_ERROR;
        else 
            noeud.all.droite := new T_AB_Cell;
            noeud.all.droite.all.element := valeur;
        end if; 
    end inserer_droit;

    -- nom : calcul_taille
    -- sémantique :  renvoie nombre de nœuds de l’arbre 
    -- paramètres :
        -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
    -- retour : integer --nombre nœud de l’arbre
    -- pré-condition : 
    -- post-condition : 
    -- Tests de la procédure :
    function calcul_taille(arbre : in T_AB) return integer is
    begin
        if(arbre = null) then
            return 0;
        else
            return 1 + calcul_taille(arbre.all.gauche) + calcul_taille(arbre.all.droite);
        end if;
    end calcul_taille;


    -- nom : rechercher
    -- sémantique :  rechercher un noeud dans un arbre
    -- paramètres : 
        --arbre : in T_AB --l’arbre où on fait une recherche
        --valeur : in T_element -- le noeud à rechercher
    -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
    -- retour : T_AB -- le noeud
    -- pré-condition : l’arbre est initialisé
    -- post-condition : retourne le noeud ou null si le noeud existe pas
    -- Tests de la procédure :
    function rechercher(arbre : in  T_AB ; valeur : in T_element) return T_AB is 
        result: T_AB;
    begin
        -- Si l'element est le bon retourner le noeud si l'arbre est vide retourner null
        if(arbre = null or else arbre.all.element = valeur) then
            return arbre;
        end if;

        -- Si ce noeud ne contient pas l'element rechercher à gauche puis à droite
        result := rechercher(arbre.all.gauche,valeur);
        if(result = null) then
            result := rechercher(arbre.all.droite,valeur);
        end if;

        -- retourner le resultat de la recherche sur les sous arbres du noeuds 
        return result;
    end rechercher;

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
    procedure afficher(arbre : in T_AB; profondeur : in integer; etiquette_gauche, etiquette_droite : in string)is
    begin 
        -- Afficher l'element
        afficher_element(arbre.all.element);
        new_line;
        if(arbre.all.droite /= null )then 
            -- Afficher la tabulation du sous arbre droit 
            for i in 0..profondeur loop
                put("   ");
            end loop;
            -- Afficher l'etiquette du sous arbre droit
            put(etiquette_droite);
            put(" : ");
            -- Affichage du sous arbre droit
            afficher(arbre.all.droite, profondeur+1, etiquette_gauche, etiquette_droite);
        end if;
        if(arbre.all.gauche /= null )then
            -- Afficher la tabulation du sous arbre gauche
            for i in 0..profondeur loop
                put("   ");
            end loop;
            -- Afficher l'etiquette du sous arbre gauche
            put(etiquette_gauche);
            put(" : ");
            -- Affichage du sous arbre gauche
            afficher(arbre.all.gauche, profondeur+1, etiquette_droite, etiquette_gauche); 
        end if;
    end afficher;

    -- nom : supprimer
    -- sémantique :  suprime un noeud de l’arbre 
    -- paramètres :
        -- arbre : in  T_AB -- Arbre dont on veut suprimer un nœud
    -- element : in T_element -- Element à supprimer dans l’arbre
    -- pré-condition : 
    -- post-condition : 
    -- Tests de la procédure :
    procedure supprimer(arbre: in T_AB;  element : in T_Element)is 
        function supprimer_rec (arbre: in T_AB;  element : in T_Element) return boolean is
            res : boolean;
        begin
            -- Cas ou on arrive sur une feuille de l'arbre sans trouver l'element 
            if(arbre=null) then
                return false; -- On renvoie false pour indiquer l'absence de supression dans cette ligne de recursion
            end if;

            -- Cas ou on atteint un noeud contenant l'element a supprimer
            if(arbre.all.gauche /= null and then arbre.all.gauche.all.element = element) then
                arbre.all.gauche:=null; -- Supression du noeud
                return true; -- On renvoie true pour indquer que l'element a été supprimé
            end if;
            if(arbre.all.droite /= null and then arbre.all.droite.all.element = element) then
                arbre.all.droite:=null; -- Supression du noeud
                return true; -- On renvoie true pour indquer que l'element a été supprimé
            end if;
            
            -- Cas ou aucune suppression a été effectué on continue a chercher dans les sous arbre 
            res := supprimer_rec(arbre.all.droite,element);
            if(not res) then 
                res := supprimer_rec(arbre.all.gauche, element);
            end if;
            return res;
        end;
    begin
        -- Appel de la fonction recursive de supression de l'element a supprimer
        if(supprimer_rec(arbre, element) = false) then
            raise NOEUD_ABSENT_ERROR;
        end if;
    end supprimer;

    function get_SA_droit (arbre : T_AB) return T_AB is
       
    begin
       return arbre.all.droite;
    end get_SA_droit;

    function get_SA_gauche (arbre : T_AB) return T_AB is
       
    begin
       return arbre.all.gauche;
    end get_SA_gauche;

    function get_racine_element (arbre : T_AB) return T_element is
       
    begin
       return arbre.all.element;
    end get_racine_element;

    --Nom : is_null
    --sémantique : retourn le resultat de comparaison a null
    --paramètres : 
        -- arbre : T_AB
    -- retour : T_AB
    --préconditions :
    --postconditions : 
    function is_null(arbre: T_AB) return boolean is

    begin
        return arbre = null;
    end is_null;
end p_arbre_binaire;