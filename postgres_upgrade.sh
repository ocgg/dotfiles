#!/bin/bash

# Liste de toutes les bases de données autorisées
DB_LIST=$(psql -U postgres -Atc "SELECT datname FROM pg_database WHERE datallowconn = true;")

for db in $DB_LIST; do
    echo "Traitement de $db"
    
    # Réindexer la base
    psql -U postgres -c "REINDEX DATABASE $db;" "$db"
    
    # Rafraîchir la version de collation
    psql -U postgres -c "ALTER DATABASE $db REFRESH COLLATION VERSION;" "$db"
    
    echo "$db terminé."
done
