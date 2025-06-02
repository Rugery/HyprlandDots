# Aplicar esquema de colores con pywal
wal -i "$1" -n 

matugen image "$1" -m "dark" 
# Actualizar pywalfox
pywalfox 
# Recargar CSS para cambiar colores
swaync-client --reload-css
