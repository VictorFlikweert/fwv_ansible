# Ansible Playbooks Documentation
This Ansible project provides a collection of playbooks to streamline the provisioning of new QualityGrader kubernetes clusters consisting of a PanelPC and one or more Jetsons as part of the Quality Grader setup. The playbooks include tasks for:

- Installing k3s and registering the ppc cluster with ArgoCD. (`main.yml`)

- Uninstalling all Kubernetes-related components from all of the nodes. (`reset.yml`)

To run these playbooks, you must ensure that SSH access is set up for all nodes. The following sections will guide you through setting up the project and using it to provision the quality grader clusters.

## Prerequisites
Before running the playbooks, ensure the following prerequisites are met:

1. Create an inventory file (e.g., `inventory/[ip].yml`) specifying the details of the machines in the cluster. (look at the files there for examples)
  
2. Set up SSH authentication to the different machines, you can test if this has been done correctly by running the following command:
    ```
    ansible all -m ping -i inventory/[machine_ip].yml
    ```

3. Set up secrets:
    Configure sensitive information (e.g., passwords, tokens) in the `roles/panel_pc/vars/main.yml` file.

    Example:

    ```
    rancher_url: "***"
    dockerhub_token: "***"
    main_cluster_pass: "***"
    ```


## How to Run

Command to test whether the machines in the inventory file are reachable:

```
ansible all -m ping -i inventory/[cluster_ip].yml
```


To provision a new cluster:
```
ansible-playbook -i inventory/[cluster_ip].yml playbooks/main.yml
ansible-playbook -i inventory/[cluster_ip].yml playbooks/openkruise.yml
```


To completely uninstall K3S and Rancher from the cluster:
```
ansible-playbook -i inventory/[cluster_ip].yml playbooks/reset.yml
```


## How to Reset a Cluster Before Reinitializing

To reset a cluster properly before reinitializing, follow these steps carefully:

1.  Delete the Cluster via ArgoCD UI
    - Log in to the ArgoCD UI.
    - Navigate to the Clusters section.
    - Select the cluster you want to reset.
    - Click Delete and confirm the action.
    - Refresh to confirm the cluster has been removed.

2. Run the reset.yml Script
   - To completely uninstall K3S and Rancher from the cluster:
    ```
    ansible-playbook -i inventory/[cluster_ip].yml playbooks/reset.yml
    ```
   - Verify that the script completes successfully and clears all cluster-related configurations.

---

Note: Perform these steps in the exact order to avoid issues during reinitialization. Always back up critical data before resetting a cluster.