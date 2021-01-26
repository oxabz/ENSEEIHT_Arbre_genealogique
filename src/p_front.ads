with p_personne; use p_personne;
with p_arbre_genealogique; use p_arbre_genealogique;
with ada.strings.unbounded; use ada.strings.unbounded;

package P_Front is
    procedure clear_console;
    procedure create_box (label: unbounded_string; size : integer);
    function prompt_person(label, description : unbounded_string) return T_Personne;
    function prompt_menu return character;
    procedure prompt_ajout(id:out integer; parent:out E_Parent);
    function prompt_integer(label, text : unbounded_string) return integer;
    procedure error_message (message: unbounded_string);
private
    ESC : constant character := Character'val(27);
    CSI : constant string := (ESC,'[');

    previous_box_size : integer := -1;

    procedure clear_console_under;
    procedure separator (label : unbounded_string);
    procedure cursor_right (x:integer);
    procedure cursor_up (x:integer);
    procedure cursor_bottom_left;
end P_Front;