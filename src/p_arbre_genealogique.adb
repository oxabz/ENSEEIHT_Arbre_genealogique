package body p_arbre_genealogique is
    --Nom :ajout_parent
    --sémantique : ajouter un parent à un noeud donné
    --paramètres : 
    --  arbre : T_AG; 
    --  parent : E_Parent
    --  fils :Integer
    --  person  : T_personne
    --préconditions : arbre /=null && fils > 0 && noeud est dans l'arbre 
    --postconditions :
    procedure ajout_parent(arbre : T_AG; parent : E_Parent; fils : in Integer; person : in T_Personne) is 
        SA_fils: T_AG;
    begin 
        -- Recherche de l'endroit où le parent dois etre ajouter 
        SA_fils:=rechercher(arbre, get_dummy(fils));
        if(is_null(SA_fils)) then 
            raise NOEUD_ABSENT_ERROR;
        end if;

        -- Ajout du parent
        if(parent=MERE) then
            inserer_gauche(SA_fils,person);
        else
            inserer_droit(SA_fils,person);
        end if;
    end ajout_parent;

    --Nom : nombre_ancetre
    --sémantique : retourne le compte des ancêtres d’un individue
    --paramètres :
    --  arbre : T_AG
    --  individu : Integer 
    --retour : integer
    --préconditions : arbre/=null && individu apartien a l'arbre 
    --postconditions : 
    function nombre_ancetres(arbre : in T_AG; individu : in Integer) return integer is
        SA_individu: T_AG;
    begin 
        -- Recherche de l'endrtoit où le compte doit commencer 
        SA_individu:=rechercher(arbre, get_dummy(individu));
        if(is_null(SA_individu)) then 
            raise NOEUD_ABSENT_ERROR;
        end if;

        -- Comptage des ancettres
        return calcul_taille(SA_individu);
    end nombre_ancetres;


    --Nom : get_ancetre_generation
    --sémantique : retourne la liste des ancêtres d’une certaine generation d’un individue
    --paramètres :
    --  arbre : T_AG
    --  individu : integer 
    --  generation : integer
    --retour : List<T_Personne>
    --préconditions : arbre/=null
    --postconditions : 
    function get_ancetre_generation(arbre : in T_AG; individu, generation : in integer) return L_Personne is
        procedure get_ancetre_generation_rec (individu : in T_AG; resultat : in out L_Personne; generation : in integer) is
           
        begin
            -- Fin de la recursion en bout de branche
            if(is_null(individu)) then return; end if;
            
            -- Ajout de l'individu au resultat s'il est de bonne generation 
            if(generation = 0) then 
                insertHead(resultat, get_racine_element(individu));
                return;
            end if;

            -- Recursion dans les sous arbres 
            get_ancetre_generation_rec(get_SA_droit(individu), resultat, generation-1);
            get_ancetre_generation_rec(get_SA_gauche(individu), resultat, generation-1);
        end get_ancetre_generation_rec;
        
        SA_individu: T_AG;
        result: L_Personne;
    begin
        -- Recherche du point de depart de la recherche d'ancetre
        SA_individu:=rechercher(arbre, get_dummy(individu));
        if(is_null(SA_individu)) then 
            raise NOEUD_ABSENT_ERROR;
        end if;

        init(result); -- Initialisation de la liste contenant le resultat
        get_ancetre_generation_rec(SA_individu, result, generation);
        return result;
    end get_ancetre_generation;

    --nom : afficher
    --sémantique :  affiche un arbre genealogique  
    --paramètres :
    --  arbre : in  T_AG -- Arbre qu’on veut afficher
    --pré-condition : arbre initialisé
    --post-condition : 
    procedure afficher(arbre : in T_AG) is 
    begin
        -- Reduction de parametre pour l'affichage de l'arbre
        afficher(arbre, 0, "Mere", "Pere");
    end afficher;

    --nom : afficher
    --sémantique :  affiche un arbre genealogique  
    --paramètres :
    --  arbre : in  T_AG -- Arbre qu’on veut afficher
    --  individu: in integer -- id du noeud a partir duquel on veut commencer 
    --pré-condition : arbre initialisé
    --post-condition : 
    procedure afficher(arbre : in T_AG; individu : in integer) is 
        SA_individu: T_AG;
    begin
        -- Recherche du point de depart de l'affichage 
        SA_individu:=rechercher(arbre, get_dummy(individu));
        if(is_null(SA_individu) ) then 
            raise NOEUD_ABSENT_ERROR;
        end if;

        -- Affichage
        afficher(SA_individu, 0, "Mere", "Pere");
    end afficher;

    --Nom : get_un_parent
    --sémantique : retourne la liste des individus ayant un seul parent
    --paramètres :
    --  arbre : T_AG
    --retour : List<T_Personne>
    --préconditions : arbre/=null
    --postconditions : 
    function get_un_parent(arbre : in T_AG) return L_Personne is 
        procedure get_un_parent_rec (arbre : in T_AG; resultat : in out L_Personne) is
           
        begin
            -- Fin de recursion en bout de branche
            if(is_null(arbre)) then
                return;
            end if;

            -- Ajout d'un element si il correspond aux conditions
            if(is_null(get_SA_gauche(arbre)) xor is_null(get_SA_droit(arbre))) then 
                insertHead(resultat, get_racine_element(arbre));
            end if;

            -- Recursion
            get_un_parent_rec(get_SA_gauche(arbre),resultat);
            get_un_parent_rec(get_SA_droit(arbre),resultat);
        end get_un_parent_rec;
        
        result: L_Personne;
    begin
        init(result); -- Creation d'une liste de resultat
        get_un_parent_rec(arbre,result);
        return result;
    end get_un_parent;

    --Nom : get_deux_parent
    --sémantique : retourne la liste des individus ayant deux parents
    --paramètres :
    --  arbre : T_AB
    --retour : List<T_Personne>
    --préconditions : arbre/=null
    --postconditions : 
    function get_deux_parent(arbre : in T_AG) return L_Personne  is 
        procedure get_deux_parent_rec (arbre : in T_AG; resultat : in out L_Personne) is
           
        begin
            -- Fin de recursion en bout de branche
            if(is_null(arbre)) then
                return;
            end if;
            
            -- Ajout d'un element si il correspond aux conditions
            if(not  is_null(get_SA_gauche(arbre)) and not is_null(get_SA_droit(arbre))) then 
                insertHead(resultat, get_racine_element(arbre));
            end if;

            -- Recursion 
            get_deux_parent_rec(get_SA_gauche(arbre),resultat);
            get_deux_parent_rec(get_SA_droit(arbre),resultat);
        end get_deux_parent_rec;
        
        result: L_Personne;
    begin
        init(result); -- Creation d'une liste de resultat
        get_deux_parent_rec(arbre,result);
        return result;
    end get_deux_parent;

    --Nom : get_zero_parent
    --sémantique : retourne la liste des individus ayant aucun parents
    --paramètres :
    --  arbre : T_AG
    --retour : List<T_Personne>;
    --préconditions : arbre/=null
    --postconditions : 
    function get_zero_parent(arbre : in T_AG) return L_Personne  is 
        procedure get_zero_parent_rec (arbre : in T_AG; resultat : in out L_Personne) is
           
        begin
            -- Fin de recursion en bout de branche
            if(is_null(arbre)) then
                return;
            end if;


            -- Ajout d'un element si il correspond aux conditions
            if(is_null(get_SA_gauche(arbre)) and is_null(get_SA_droit(arbre))) then 
                insertHead(resultat, get_racine_element(arbre));
                return;
            end if;

            -- Recursion
            get_zero_parent_rec(get_SA_gauche(arbre),resultat);
            get_zero_parent_rec(get_SA_droit(arbre),resultat);
        end get_zero_parent_rec;
        
        result: L_Personne;
    begin
        init(result); -- Creation d'une liste de resultat
        get_zero_parent_rec(arbre,result);
        return result;
    end get_zero_parent;

    --Nom : get_succession_ancetre_generation
    --sémantique : retourne la liste des ancêtres d’un individue
    --paramètres :
    --  arbre : in T_AG
    --  persone : in T_Persone 
    --  generation :  in integer
    --retour : resultat_arbre : T_AB
    --préconditions : arbre/=null
    --postconditions :
    function get_succession_ancetre_generation(arbre : in T_AG; individu, generation : in integer) return T_AG is
        SA_individu: T_AG;
        result_arbre : T_AG;

        procedure get_succession_ancetre_generation_rec(arbre : in T_AG; resultat:in T_AG; generation : integer)  is
        begin
            -- Sortie de la recursions une fois que la condition ne peut plus etre remplie
            if(generation <= 0) then
                return;
            end if;
    
            -- Ajout des elements dans les resultats et recursion
            if(not is_null(get_SA_gauche(arbre))) then
                inserer_gauche(resultat, get_racine_element(get_SA_gauche(arbre)));
                get_succession_ancetre_generation_rec(get_SA_gauche(arbre),get_SA_gauche( resultat), generation-1);
            end if;
            -- Ajout des elements dans les resultats et recursion 
            if(not  is_null(get_SA_droit(arbre))) then
                inserer_droit(resultat, get_racine_element(get_SA_droit(arbre)));
                get_succession_ancetre_generation_rec(get_SA_droit(arbre),get_SA_droit( resultat), generation-1);
            end if;
        end get_succession_ancetre_generation_rec;

    begin
        -- Rechercher le debut de la recherche des ancetres 
        SA_individu:=rechercher(arbre, get_dummy(individu));
        if(is_null(SA_individu)) then 
            raise NOEUD_ABSENT_ERROR;
        end if;

        init(result_arbre, get_racine_element(SA_individu)); -- Initialisation d'un arbre contenant le resultat
        get_succession_ancetre_generation_rec(SA_individu, result_arbre, generation);
        return result_arbre;
    end get_succession_ancetre_generation;

    --Nom : get_descendant_generation
    --sémantique : retourne le descendant de n-ieme generation d’un individue
    --paramètres :
    --  arbre : T_AG
    --  personne : id 
    --  generation : integer
    --retour : T_Personne
    --préconditions : arbre/=null
    --postconditions : 
    function  get_decendant_generation(arbre : in T_AG; persone : in integer; generation : integer) return T_Personne is

        function get_decendant_generation_rec(arbre : in T_AG; persone : in T_Personne; descendant : out T_Personne; generation, profondeur : integer) return integer is
            profondeur_ancetre:integer;
        begin 
            -- Sortie de la recursion un fois en bout de branche le -1 indique l'absence de l'element rechercher 
            if(is_null(arbre)) then return -1; end if;

            -- Sortie de la recursion si l'individue a été trouvé 
            if(get_racine_element(arbre) = persone) then
                return profondeur; -- Renvoie la profondeur de l'individu
            end if;

            -- Recursion
            profondeur_ancetre:= get_decendant_generation_rec(get_SA_droit(arbre), persone, descendant, generation, profondeur+1);
            if (profondeur_ancetre = -1) then
                profondeur_ancetre:= get_decendant_generation_rec(get_SA_gauche(arbre), persone, descendant, generation, profondeur+1);
            end if;
            
            -- Si l'individu est le descendant recherché faire sortir l'individu
            if (profondeur_ancetre = profondeur+generation) then 
                descendant := get_racine_element(arbre);
            end if;
            return profondeur_ancetre;
        end get_decendant_generation_rec;

        descendant : T_Personne;
    begin 
        if(get_decendant_generation_rec(arbre, get_dummy(persone), descendant, generation, 0) = -1)then 
            raise NOEUD_ABSENT_ERROR;
        end if;
        return descendant;
    end get_decendant_generation;

    --Nom :  get_sucession_decendant_generation
    --sémantique : --paramètres : retourne la liste des decendant  d’un individu
    --  arbre : T_AG
    --  persone : T_Persone 
    --  generation : integer
    --retour : List<T_Personne>
    --préconditions : arbre/=null
    --postconditions : 
    function get_sucession_decendant_generation(arbre : in T_AG; persone : in integer; generation : integer) return L_Personne is

        function get_decendant_generation_rec(arbre : in T_AG; persone : in T_Personne; descendants : in out L_personne; generation, profondeur : integer) return integer is
            profondeur_ancetre:integer;
        begin 
            -- Sortie de la recursion un fois en bout de branche le -1 indique l'absence de l'element rechercher 
            if(is_null(arbre)) then return -1; end if;

            -- Sortie de la recursion si l'individue a été trouvé 
            if(get_racine_element(arbre) = persone) then
                return profondeur;
            end if;

            -- Recursion
            profondeur_ancetre:= get_decendant_generation_rec(get_SA_droit(arbre), persone, descendants, generation, profondeur+1);
            if (profondeur_ancetre = -1) then
                profondeur_ancetre:= get_decendant_generation_rec(get_SA_gauche(arbre), persone, descendants, generation, profondeur+1);
            end if;

            -- Si l'individu est le descendant recherché ajouter l'individu à la liste de sortie
            if (profondeur_ancetre /=-1 and then profondeur_ancetre <= profondeur+generation) then 
                insertHead(descendants, get_racine_element(arbre));
            end if;
            return profondeur_ancetre;
        end get_decendant_generation_rec;

        descendants : L_Personne;
    begin 
        init(descendants);
        if(get_decendant_generation_rec(arbre, get_dummy(persone), descendants, generation, 0) = -1)then 
            raise NOEUD_ABSENT_ERROR;
        end if;
        return descendants;
    end get_sucession_decendant_generation;

end p_arbre_genealogique;