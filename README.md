# CS4471 

## Backend

### Requirement

- Python (Version 3)
- MySQL

### Run
Can skip step 2 and 3

1. `mysql -uroot -p{your password} < cs4471.sql`
2. `python3 -m venv venv` (Unix Command)
3. `source venv/bin/activate` (Unix Command)
4. `pip install -r requirements.txt`
5. `export DB_HOST=localhost` (Unix Command)
6. `export DB_USER=root` (Unix Command)
7. `export DB_PASSWORD={your password}` (Unix Command)
8. `export FLASK_APP=server.py` (Unix Command)
9. `flask run`
