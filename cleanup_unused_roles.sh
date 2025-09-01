#!/bin/bash

# List of unused EventBridge roles to delete
UNUSED_ROLES=(
    "Amazon_EventBridge_Invoke_Sns_1371675052"
    "Amazon_EventBridge_Invoke_Sns_1639909585"
    "Amazon_EventBridge_Invoke_Sns_1865395157"
    "Amazon_EventBridge_Invoke_Sns_454952292"
    "Amazon_EventBridge_Invoke_Sns_613914670"
    "Amazon_EventBridge_Invoke_Sns_929579217"
)

# Function to clean up a role
cleanup_role() {
    local role_name=$1
    echo "Cleaning up role: $role_name"
    
    # Get attached policies
    policies=$(aws iam list-attached-role-policies --role-name "$role_name" --query 'AttachedPolicies[].PolicyArn' --output text)
    
    # Detach policies
    for policy in $policies; do
        if [ "$policy" != "None" ]; then
            echo "  Detaching policy: $policy"
            aws iam detach-role-policy --role-name "$role_name" --policy-arn "$policy"
        fi
    done
    
    # Delete role
    echo "  Deleting role: $role_name"
    aws iam delete-role --role-name "$role_name"
    echo "  ✓ Role deleted"
}

# Clean up unused roles
for role in "${UNUSED_ROLES[@]}"; do
    cleanup_role "$role"
done

echo "Cleanup completed!"
