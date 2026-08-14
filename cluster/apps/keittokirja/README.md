When you modify the bootstrap SQL the PersistentVolumeClaim needs to be deleted and reapplied. 
To force the bootstrap SQL to re-run, create a fresh instance:

# 1. Delete the Cluster
kubectl delete cluster keittokirja-db -n keittokirja

# 2. Delete the PVC
kubectl get pvc -n keittokirja | grep keittokirja-db
kubectl delete pvc keittokirja-db-1 -n keittokirja

# 3. Re-run Ansible
ansible-playbook playbook.yml --ask-vault-password

# 4. Restart backend
kubectl rollout restart deployment/keittokirja-backend -n keittokirja


--


Appending recipes can be done with an SQL update to the running container.

# 1. Copy the SQL file into the container
kubectl cp cluster/apps/keittokirja/postgres/UPDATE.sql \
  keittokirja/keittokirja-db-1:/tmp/UPDATE.sql
  
# 2. Apply contents of UPDATE.sql to the database
kubectl exec -n keittokirja keittokirja-db-1 -- \
  psql -U keittokirja -d keittokirja -f /tmp/UPDATE.sql

Note: To avoid conflict errors with duplicates, use INSERT ... ON CONFLICT DO NOTHING 
