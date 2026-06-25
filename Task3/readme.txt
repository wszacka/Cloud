-----------------------
STEP A
-----------------------
1. Ensure that minikube is running
    minikube start

2. Add the CloudNativePG Helm repository:
    helm repo add cnpg https://cloudnative-pg.github.io/charts

3. Update the Helm repositories:
    helm repo update

4. Install the CloudNativePG operator:
    helm install cnpg cnpg/cloudnative-pg

5. Optional: open the minikube dashboard to visually confirm that the CloudNativePG operator is running:
    minikube dashboard

6. Apply the database secret manifest:
    kubectl apply -f secret.yaml

7. Apply the CloudNativePG cluster manifest:
    kubectl apply -f cluster.yaml

8. Wait until the PostgreSQL cluster is ready. The cluster status can be checked using:
    kubectl get cluster

-----------------------
STEP B
-----------------------
1. Remove the previous Bitnami PostgreSQL installation from Task 2:
    helm uninstall mypgsql-postgresql

If the release name is different, check it first using:
    helm list

2. Update the Books application deployments so that they connect to the CloudNativePG database instead of the previous PostgreSQL instance.
    The service YAML files can remain the same. New deployment YAML files were created for the read-write and read-only Books applications.

3. Apply the updated read-write and read-only Books deployment:
    kubectl apply -f spbooks-deployment.yaml
    kubectl apply -f spbooksro-deployment.yaml

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

7. Test the read-write Books application in Postman using:
    GET, POST, PUT, DELETE
    These requests should work because the read-write application is connected to the primary database endpoint.

8. Test the read-only Books application in Postman.
    GET requests should work successfully because the application can read from the read-only replica.
    POST requests should fail because the read-only application is connected to the read-only database endpoint.
    In this setup, the failed POST request returned status 500, confirming that write operations were not accepted by the read-only database path.

9. Save the read-write application logs:
    kubectl logs -l tier=frontend > logs/app-logs-rw.txt

10. Save the read-only application logs:
    kubectl logs -l tier=frontendro > logs/app-logs-ro.txt

-----------------------
Task 3 Artifacts
-----------------------
The following artefacts are included for Task 3:

1. cluster.yaml
    The CloudNativePG PostgreSQL cluster.

2. kubectl_task3_dumps.txt
    Command outputs showing that the required Kubernetes resources were created and verified.

3. postman_test.txt
    Evidence of testing the read-write and read-only application endpoints.

4. run.sh
    Deployment automation script

5. secret.yaml
    The database credentials used by the CloudNativePG cluster.

6. spbooks-deployment.yaml
    Updated deployment for the read-write Books application.

7. spbooksro-deployment.yaml
    Updated deployment for the read-only Books application.

8. logs folder
    Logs collected from the read-write and read-only Books application pods.

10. readme.txt
    This file, explaining how to replicate the Task 3 setup.