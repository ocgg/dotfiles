-- Traduction Lua de hyprland.conf
--
-- IMPORTANT: ce fichier a été écrit alors que le système n'a QUE Hyprland 0.56.2
-- (pas encore 0.57). Je me suis basé sur :
--   - /usr/share/hypr/hyprland.lua (exemple officiel livré avec le paquet)
--   - les en-têtes C++ de la config Lua (/usr/include/hyprland/src/config/lua/*)
--   - les chaînes trouvées dans le binaire /usr/bin/Hyprland
-- pour reconstituer la syntaxe réelle plutôt que de l'inventer.
--
-- Les blocs marqués "-- VERIFIER" utilisent une syntaxe que je n'ai pas pu
-- confirmer avec certitude (dispatchers absents de l'exemple officiel).
-- Avant de basculer dessus en vrai, lance `hyprctl reload` / regarde les logs
-- Hyprland, et confronte ces lignes au wiki à jour sur 0.57.

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "",      mode = "preferred", position = "auto-up",   scale = "auto" })
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto",      scale = 1 })
hl.monitor({ output = "DP-1",  mode = "preferred", position = "auto-down", scale = 1 })
hl.monitor({ output = "HDMI-1",mode = "preferred", position = "auto-down", scale = 1 })


---------------------
---- MY PROGRAMS ----
---------------------

local fileManager = "nautilus"
local switchcmd    = "~/.config/hypr/switch_workspace.sh"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync & hyprsunset & systemctl --user start hyprpolkitagent")
    -- Fix dead keys avec ghostty
    hl.exec_cmd("ibus-daemon -drx")

    -- Historique du presse-papier
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("GTK_IM_MODULE", "ibus")
hl.env("QT_IM_MODULE", "ibus")
hl.env("XMODIFIERS", "@im=ibus")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 1,
        gaps_out = 0,

        border_size = 3,

        col = {
            active_border   = "rgba(33ccffee)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 3,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        dim_special = 0,

        shadow = { enabled = false },
        blur   = { enabled = false },
    },

    animations = {
        enabled = false,
    },
})

hl.config({
    dwindle = {
        force_split         = 2,
        preserve_split      = true,
        smart_resizing      = false,
        default_split_ratio = 1.18,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "fr,us",
        kb_variant = "oss",
        kb_model   = "",
        kb_options = "caps:escape_shifted_capslock,grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse                 = 2,
        float_switch_override_focus  = 0,

        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- VERIFIER: "output" comme champ de hl.device n'est pas démontré dans
-- l'exemple officiel (qui ne montre que "sensitivity"), mais c'est un champ
-- classique des blocs device{} pour router un écran tactile vers un moniteur.
hl.device({
    name   = "silicon-integrated-system-co.-sis-hid-touch-controller",
    output = "DP-1",
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- VERIFIER: "bindo" dans le .conf original sert au "long press" (commentaire
-- d'origine). Je n'ai pas trouvé la clé d'option Lua exacte pour ça ; les
-- options connues et confirmées sont { locked, repeating, mouse }.
hl.bind(mainMod .. " + escape", hl.dsp.window.close(), { long_press = true })

hl.bind(mainMod .. " + tab",      hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + shift_r",  hl.dsp.exec_cmd('kitty -d "$(fd -t dir | rofi -dmenu)"'))
hl.bind(mainMod .. " + M",        hl.dsp.exec_cmd("~/.config/hypr/shutdown-menu.sh"))
hl.bind(mainMod .. " + N",        hl.dsp.exec_cmd("~/.config/hypr/nuts-menu.sh"))
hl.bind(mainMod .. " + return",   hl.dsp.exec_cmd("~/.config/hypr/kitty-session-launcher.sh"))

-- VERIFIER: dispatcher "fullscreen" non démontré dans l'exemple officiel.
-- Hypothèse par analogie avec hl.dsp.window.float({ action = "toggle" }).
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind(mainMod .. " + O", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle

hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("ghostty"))

-- Capture d'écran
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Historique du presse-papier
hl.bind(mainMod .. " + c", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -p cliphist | cliphist decode | wl-copy"))

-- Déplacer le focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

-- VERIFIER: "swapwindow" / "movewindow" avec direction (déplacement dans le
-- tiling, pas changement de workspace) ne sont pas démontrés dans l'exemple.
-- hl.window.swap existe (vu dans le binaire) et semble le candidat le plus
-- probable pour les deux cas (movewindow par direction = swap avec le voisin
-- dans Hyprland "classique").
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "right" }))

-- VERIFIER: "resizeactive" non démontré dans l'exemple. hl.dsp.window.resize()
-- n'est montré que sans argument (pour le drag souris) ; la forme avec un
-- delta explicite est une hypothèse.
hl.bind(mainMod .. " + up",            hl.dsp.window.resize({ x = 0,   y = -50 }))
hl.bind(mainMod .. " + down",          hl.dsp.window.resize({ x = 0,   y = 50 }))
hl.bind(mainMod .. " + right",         hl.dsp.window.resize({ x = 50,  y = 0 }))
hl.bind(mainMod .. " + left",          hl.dsp.window.resize({ x = -50, y = 0 }))
hl.bind(mainMod .. " + less",          hl.dsp.window.resize({ x = 50,  y = 0 }))
hl.bind(mainMod .. " + SHIFT + less",  hl.dsp.window.resize({ x = -50, y = 0 }))

-- Changer de workspace avec mainMod + touches symboles (clavier FR), en
-- passant par le script externe comme dans l'original (pas de dispatcher natif)
hl.bind(mainMod .. " + ampersand",   hl.dsp.exec_cmd(switchcmd .. " switch 1"))
hl.bind(mainMod .. " + eacute",      hl.dsp.exec_cmd(switchcmd .. " switch 2"))
hl.bind(mainMod .. " + quotedbl",    hl.dsp.exec_cmd(switchcmd .. " switch 3"))
hl.bind(mainMod .. " + apostrophe",  hl.dsp.exec_cmd(switchcmd .. " switch 4"))
hl.bind(mainMod .. " + parenleft",   hl.dsp.exec_cmd(switchcmd .. " switch 5"))
hl.bind(mainMod .. " + minus",       hl.dsp.exec_cmd(switchcmd .. " switch 6"))
hl.bind(mainMod .. " + egrave",      hl.dsp.exec_cmd(switchcmd .. " switch 7"))
hl.bind(mainMod .. " + underscore",  hl.dsp.exec_cmd(switchcmd .. " switch 8"))
hl.bind(mainMod .. " + ccedilla",    hl.dsp.exec_cmd(switchcmd .. " switch 9"))

hl.bind(mainMod .. " + SHIFT + ampersand",   hl.dsp.exec_cmd(switchcmd .. " move 1"))
hl.bind(mainMod .. " + SHIFT + eacute",      hl.dsp.exec_cmd(switchcmd .. " move 2"))
hl.bind(mainMod .. " + SHIFT + quotedbl",    hl.dsp.exec_cmd(switchcmd .. " move 3"))
hl.bind(mainMod .. " + SHIFT + apostrophe",  hl.dsp.exec_cmd(switchcmd .. " move 4"))
hl.bind(mainMod .. " + SHIFT + parenleft",   hl.dsp.exec_cmd(switchcmd .. " move 5"))
hl.bind(mainMod .. " + SHIFT + minus",       hl.dsp.exec_cmd(switchcmd .. " move 6"))
hl.bind(mainMod .. " + SHIFT + egrave",      hl.dsp.exec_cmd(switchcmd .. " move 7"))
hl.bind(mainMod .. " + SHIFT + underscore",  hl.dsp.exec_cmd(switchcmd .. " move 8"))
hl.bind(mainMod .. " + SHIFT + ccedilla",    hl.dsp.exec_cmd(switchcmd .. " move 9"))

-- Workspaces nommés
hl.bind(mainMod .. " + W",         hl.dsp.focus({ workspace = "name:Bterm" }))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "name:Bterm" }))
hl.bind(mainMod .. " + A",         hl.dsp.focus({ workspace = "name:Aweb" }))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "name:Aweb" }))

-- VERIFIER: "focusmonitor" et "movewindow mon:+1" non démontrés dans l'exemple.
hl.bind(mainMod .. " + twosuperior",         hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + twosuperior", hl.dsp.window.move({ monitor = "+1" }))

-- Workspaces spéciaux (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("ZZmagic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:ZZmagic" }))

-- Workspaces nommés sans movetoworkspace
hl.bind(mainMod .. " + F1", hl.dsp.focus({ workspace = "name:Z1network" }))
hl.bind(mainMod .. " + F2", hl.dsp.focus({ workspace = "name:Z2mail" }))
hl.bind(mainMod .. " + F3", hl.dsp.focus({ workspace = "name:Z3music" }))
hl.bind(mainMod .. " + SHIFT + F1", hl.dsp.window.move({ workspace = "name:Z1network" }))
hl.bind(mainMod .. " + SHIFT + F2", hl.dsp.window.move({ workspace = "name:Z2mail" }))
hl.bind(mainMod .. " + SHIFT + F3", hl.dsp.window.move({ workspace = "name:Z3music" }))

hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd(
    'notify-send "$(rhythmbox-client --no-start --print-playing-format "%tt")" ' ..
    '"$(rhythmbox-client --no-start --print-playing-format "\\n<span size=\'15pt\'>󰳩   %aa</span>\\n\\n󰀥    %at <span style=\'italic\' alpha=\'60%\'>(track %tn)</span>")"'
))

-- Défiler les workspaces avec mainMod + molette (via le script, comme l'original)
hl.bind(mainMod .. " + mouse_down", hl.dsp.exec_cmd(switchcmd .. " switch e+1"))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.exec_cmd(switchcmd .. " switch e-1"))

-- Déplacer/redimensionner avec mainMod + clic souris
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Touches multimédia (volume, luminosité)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Filtre lumière bleue
hl.bind("XF86LaunchA",  hl.dsp.exec_cmd('hyprctl hyprsunset temperature -300; notify-send -t 400 "  $(hyprctl hyprsunset temperature)"'), { locked = true })
hl.bind("XF86Explorer", hl.dsp.exec_cmd('hyprctl hyprsunset temperature +300; notify-send -t 400 "  $(hyprctl hyprsunset temperature)"'), { locked = true })
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd('hyprctl hyprsunset gamma -5; notify-send -t 400 "󱃮  $(hyprctl hyprsunset gamma)"'), { locked = true })
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd('hyprctl hyprsunset gamma +5; notify-send -t 400 "󱃮  $(hyprctl hyprsunset gamma)"'), { locked = true })
hl.bind(mainMod .. " + SHIFT + F5", hl.dsp.exec_cmd('hyprctl hyprsunset temperature -300; notify-send -t 400 "  $(hyprctl hyprsunset temperature)"'), { locked = true })
hl.bind(mainMod .. " + SHIFT + F6", hl.dsp.exec_cmd('hyprctl hyprsunset temperature +300; notify-send -t 400 "  $(hyprctl hyprsunset temperature)"'), { locked = true })
hl.bind(mainMod .. " + XF86LaunchA",  hl.dsp.exec_cmd("hyprctl hyprsunset temperature 6000"), { locked = true })
hl.bind(mainMod .. " + XF86Explorer", hl.dsp.exec_cmd("hyprctl hyprsunset temperature 6000"), { locked = true })

-- playerctl
hl.bind("Pause",          hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- VERIFIER: fermeture/ouverture du capot ("switch:Lid Switch") -- je n'ai
-- trouvé aucune trace, dans l'exemple ou le binaire, d'une API Lua pour les
-- binds de type "switch". Il faudra vérifier sur le wiki 0.57 si un
-- équivalent existe (peut-être hors de hl.bind).
-- bind sur switch:Lid Switch -> exec hyprlock


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]",   gaps_out = 0, gaps_in = 0 })

hl.window_rule({
    name  = "no-gaps-wtv1",
    match = { float = false, workspace = "w[tv1]s[false]" },
    border_size = 0,
    rounding    = 0,
})
hl.window_rule({
    name  = "no-gaps-f1",
    match = { float = false, workspace = "f[1]s[false]" },
    border_size = 0,
    rounding    = 0,
})

hl.window_rule({
    name  = "fullscreen-workspace-border-rounding",
    match = { workspace = "s[true]" },
    border_size = 1,
    rounding    = 0,
})

-- VERIFIER: "on_created_empty" est une hypothèse de conversion snake_case du
-- nom classique "on-created-empty" (non démontré dans l'exemple officiel).
hl.workspace_rule({ workspace = "name:Bterm",     on_created_empty = "ghostty" })
hl.workspace_rule({ workspace = "name:Aweb",      on_created_empty = "zen-browser" })
hl.workspace_rule({ workspace = "name:Z1network", on_created_empty = "ferdium" })
hl.workspace_rule({ workspace = "name:Z2mail",    on_created_empty = "evolution || thunderbird" })
hl.workspace_rule({ workspace = "name:Z3music",   on_created_empty = "rhythmbox" })

-- Exemples désactivés dans l'original (laissés en commentaire ici aussi)
-- hl.window_rule({ name = "example-float-kitty", match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })
-- hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })
-- hl.window_rule({
--     name  = "fix-xwayland-drags",
--     match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })
-- hl.window_rule({ name = "stay-focused-rofi", match = { class = "(Rofi)" }, stay_focused = true })
