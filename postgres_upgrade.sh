#!/bin/bash

# Liste de toutes les bases de données autorisées
DB_LIST=$(psql -Atc "SELECT datname FROM pg_database WHERE datallowconn = true;")

for db in $DB_LIST; do
    echo "Traitement de $db"
    
    # Réindexer la base
    psql -c "REINDEX DATABASE $db;" "$db"
    
    # Rafraîchir la version de collation
    psql -c "ALTER DATABASE $db REFRESH COLLATION VERSION;" "$db"
    
    echo "$db terminé."
done
