-----------------------
STEP A
-----------------------
1. Ensure that minikube is running:
    minikube start

2. Add the Bitnami Helm repository:
    helm repo add bitnami https://charts.bitnami.com/bitnami

3. Pull version 18.0.15 of the Bitnami PostgreSQL Helm chart:
    helm pull bitnami/postgresql --version 18.0.15

4. Extract the downloaded chart folder.

5. Open the chart's values.yaml file and update the following values:
    - auth.database: "books"
    - service.type: ClusterIP (right above nodePorts)

6. Generate a rendered Kubernetes configuration file from the Helm chart:
    helm template bitnami/postgresql -f postgresql-18.0.15/postgresql/values.yaml > postgresql-18.0.15/config.yaml

7. Install PostgreSQL using Helm:
    helm install mypgsql-postgresql bitnami/postgresql -f postgresql-18.0.15/postgresql/values.yaml --version 18.0.15

8. Confirm that the Helm release was installed:
    helm list

-----------------------
STEP B
-----------------------
1. Prepare Kubernetes YAML files for the following:
    - Read-write Books deployment
    - Read-write Books service
    - Read-only Books deployment
    - Read-only Books service

    The original Books application is deployed as the read-write service using:
    markvellaum/springbooks:v0.0.1

    The read-only Books application is deployed using:
    markvellaum/springbooksro:v0.0.1

    The expected traffic ratio is 1:4 between the read-write and read-only workloads.

2. Apply the Kubernetes YAML files:
    kubectl apply -f k8s/

3. Optional: open the minikube dashboard to visually inspect the deployed resources:
    minikube dashboard

4. Forward the read-write Books service to local port 8080:
    kubectl port-forward service/springbooks-svc 8080:80

5. In another terminal, forward the read-only Books service to local port 8081:
    kubectl port-forward service/springbooksro-svc 8081:80

6. The services can then be accessed locally using:
    Read-write Books application:
    http://localhost:8080

    Read-only Books application:
    http://localhost:8081

    Example endpoints:
    http://localhost:8080/api/v1/books
    http://localhost:8081/api/v1/books

7. Save the read-write application logs:
    kubectl logs -l tier=frontend > logs/app-logs-rw.txt

8. Save the read-only application logs:
    kubectl logs -l tier=frontendro > logs/app-logs-ro.txt

-----------------------
STEP C
-----------------------
1. Verify that all required Kubernetes resources were created:
    kubectl get all

2. Check the services:
    kubectl get svc
3. Describe the services:
    kubectl describe svc

4. Check the running pods and their node placement:
    kubectl get pods -o wide

5. Test scaling by increasing the number of read-only application replicas:
    kubectl scale deployment springbooksro-dep --replicas=5

6. Confirm that additional pods were created:
    kubectl get pods

7. Test self-healing by manually deleting one application pod:
    kubectl delete pod <pod-name>

8. Run the following command again to confirm that Kubernetes automatically creates a replacement pod:
    kubectl get pods

-----------------------
STEP D
-----------------------
    The deployment process is automated using the run.sh script.
    The script can be executed from Git Bash using:
    bash run.sh

-----------------------
Task 2 Artifacts
-----------------------
1. Kubernetes YAML files (k8s folder)
    Deployment and service files for the read-write and read-only Books applications.

2. postgresql-18.0.15 folder
    Rendered PostgreSQL configuration generated from the Bitnami Helm chart.

3. run.sh
    Automation script used to deploy and verify the setup.

4. kubectl_task2_dumps.txt
    Command outputs showing that the Kubernetes resources were created and verified.

5. logs folder
    Logs collected from the read-write and read-only application pods.

6. readme.txt
    This file, explaining how to replicate the Task 2 setup.