The deployment uses two separate containers:
1. Books application container
2. PostgreSQL database container

The Books application connects to PostgreSQL using the required environment variables:
PGHOST, PGPORT, PGDB, PGUSER, and PGPASS.

-----------------------
STEP A
-----------------------
1. Copy the Dockerfile and target folder from the provided class exercise files.

2. Build the Books application Docker image using:
    docker build -t markvellaum/springbooks:v0.0.1 -t markvellaum/springbooks:latest .

3. Create a docker-compose.yaml file using the values provided in the class exercise files.

4. Start both containers using Docker Compose:
    docker compose up -d

5. Check that both containers are running:
    docker ps

    Docker Desktop can also be used to visually confirm that both containers are running.

-----------------------
STEP B
-----------------------
1. Open the Swagger UI in the browser to confirm that the Books application is running:
    http://localhost:8080/swagger-ui/index.html

2. To import the API into Postman, inspect the Swagger UI page using the browser developer tools.

3. Refresh the page and check the Network tab to identify where the OpenAPI JSON is being fetched from.
    In this setup, the OpenAPI JSON was available at:
    http://localhost:8080/api-docs

4. Import the OpenAPI JSON URL into Postman and test the available API endpoints.

5. Access the PostgreSQL database inside the running container:
    docker exec -it postgres-db psql -U myuser -d books

6. Check whether the books table contains data:
    SELECT * FROM books
    
    If needed, use the schema-qualified version:
    SELECT * FROM public.books;

7. The same query can also be executed directly from the terminal using:
    docker exec -it postgres-db psql -U myuser -d books -c "SELECT * FROM books;"

8. Export the books table to a CSV file inside the PostgreSQL container:
    COPY books TO '/tmp/books.csv' WITH (FORMAT csv, HEADER true);

9. Exit PostgreSQL.
    \q

10. Copy the exported CSV file from the container to the local machine:
    docker cp postgres-db:/tmp/books.csv .

-----------------------
Task 1 Artifacts
-----------------------

1. docker-compose.yaml
    The Books application and PostgreSQL database containers.

3. postman_test.txt
    Evidence of API endpoint testing using Postman.

4. books.csv
    Exported PostgreSQL table after API testing.

5. run.sh
    Automates the Docker deployment process.

6. readme.txt
    This file, explaining how to replicate the Task 1 setup.