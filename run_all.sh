#!/bin/bash

INVENTORIES_DIR="inventory_201"
FAILED_DIR="inventory_prod_failed"
PLAYBOOK="openkruise_fix.yml"

mkdir -p "$FAILED_DIR"

for inventory in "$INVENTORIES_DIR"/*.yml; do
    echo "Running playbook for inventory: $inventory"
    ansible-playbook -i "$inventory" "playbooks/$PLAYBOOK"
    
    if [ $? -ne 0 ]; then
        echo "Playbook failed for inventory: $inventory"
        cp "$inventory" "$FAILED_DIR/"
    else
        echo "Playbook succeeded for inventory: $inventory"
    fi
done

echo "Done. Failed inventories are stored in $FAILED_DIR"