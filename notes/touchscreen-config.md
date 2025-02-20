source: https://who-t.blogspot.com/2024/03/enforcing-touchscreen-mapping-in-gnome.html

date: 2025-02-20

# Configurer un 2ème écran touchscreen dans Gnome

Le problème est que l'écran et le touch sont 2 périphériques différents.  
Dans Gnome le touch est mappé par défaut aux 2 écrans à la fois, ce qui met le bordel, et il n'y a pas (encore) d'options permettant de régler ça dans les paramètres.

- regarder dans `~/.config/monitors.xml` et noter `<vendor>`, `<product>` et `<serial>` du moniteur à lier au touchscreen
- noter l'ID du périph touchscreen donné par `lsusb` (un truc du genre 0123:0123)
- commande: `gsettings set org.gnome.desktop.peripherals.touchscreen:/org/gnome/desktop/peripherals/touchscreens/$USB_ID/ output "['$VENDOR', '$PRODUCT', '$SERIAL']"`

ça a donné:

```bash
gsettings set org.gnome.desktop.peripherals.touchscreen:/org/gnome/desktop/peripherals/touchscreens/0457:0819/ output "['RTK', 'Verbatim MT14', 'demoset-1']"
```
