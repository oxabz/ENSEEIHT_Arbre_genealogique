with ada.strings; use ada.strings;
with Ada.Text_IO; use ada.Text_IO;
with Ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;

package body P_Front is
    
    procedure clear_console is 
    begin 
        put(CSI&"2J");
        put(CSI&"1;1H");
        previous_box_size := -1;
    end clear_console;

    procedure clear_console_under is
        
    begin
        put(CSI&"0J");
    end clear_console_under;

    procedure cursor_bottom_left is
    begin 
        put(CSI&"20000;1H");
    end cursor_bottom_left;

    procedure cursor_up (x:integer) is 
    begin
        put(CSI);
        put(trim(source=>To_Unbounded_String(Integer'image(x)), side=>both));
        put("A");
    end cursor_up;

    procedure cursor_down (x:integer) is 
    begin
        put(CSI);
        put(trim(source=>To_Unbounded_String(Integer'image(x)), side=>both));
        put("B");
    end cursor_down;

    procedure cursor_right (x:integer) is 
    begin
        put(CSI);
        put(trim(source=>To_Unbounded_String(Integer'image(x)), side=>both));
        put("C");
    end cursor_right;

    procedure separator (label : unbounded_string) is 
    begin
        for J in reverse 1..1000 loop
            put(CSI);
            put(trim(source=>To_Unbounded_String(Integer'image(J)), side=>both));
            put('G');
            put('#');
        end loop;
        cursor_right(2);
        put(' ');
        put(label);
        put(' ');
    end separator;

    procedure create_box (label: unbounded_string; size : integer) is 
    begin 
        cursor_bottom_left;
        if previous_box_size>size  then
            cursor_up(previous_box_size);
            clear_console_under;
            cursor_down( previous_box_size-size);
        else
            cursor_up(size);
            clear_console_under;
        end if;
        separator(label);
        new_line;
        previous_box_size := size;
    end create_box;

    function prompt_person(label, description : unbounded_string) return T_Personne is 
        person : T_Personne;
        nom,prenom : unbounded_string;
    begin
        create_box(label, 4);
        put_line(description);
        put_line("-Nom : ");
        put_line("-Prenom : ");
        cursor_bottom_left;
        cursor_up(2);
        cursor_right(7);
        get_line(nom);
        cursor_right(10);
        get_line(prenom);
        init(person, nom, prenom);
        return person;
    exception
        when  DATA_ERROR =>
            return prompt_person(label, description);
    end prompt_person;

    function prompt_menu return character is
        choice : character;
    begin 
        create_box(To_Unbounded_String("MENU"), 5);
        put("[e]xit, [a]jouter parents, [s]upprimer individue, [c]ompter ancetres, [t]rouver les ancetres, trouver les individus ayant [z]ero parent, trouver les individus ayant [u]n seul parent, trouver les individus ayant [2] parent, [T]rouver la suite des ancetres, trouver le [d]ecendant, trouver suite de [D]ecendants, [r]enitialiser l'arbre: "); 
        get(choice);skip_line;
        return choice;
    end prompt_menu;

    procedure prompt_ajout(id:out integer; parent:out E_Parent) is 
        p : character;
    begin 
        create_box(To_Unbounded_String("AJOUTER PARENT 1/2"), 4);
        put_line("-id du fils : ");
        put_line("-[p]ere / [m]ere : ");
        cursor_bottom_left;
        cursor_up(3);
        cursor_right(14);
        get(id);skip_line;
        cursor_right(19);
        get(p);skip_line;
        case p is
            when 'p' => 
                parent:=PERE;
            when 'm' =>
                parent:=MERE;
            when others => 
                prompt_ajout(id,parent);
        end case;
    exception
        when  DATA_ERROR =>
            skip_line;
            prompt_ajout(id, parent);
    end prompt_ajout;

    function prompt_integer(label, text : unbounded_string) return integer is 
        id:integer;
    begin 
        create_box(label, 4);
        put_line(text);
        get(id);skip_line;
        return id;
    exception
        when  DATA_ERROR =>
            skip_line;
            return prompt_integer(label, text);
    end prompt_integer;

    procedure error_message (message: unbounded_string)is
    begin
        put(CSI&"38;5;202m");
        create_box(To_Unbounded_String("ERROR"),3);
        put(message);
        cursor_bottom_left;
        put("appuyez sur entrer pour continuer");
        put(CSI&"39;49m");
        skip_line;
    end error_message;

end P_Front;