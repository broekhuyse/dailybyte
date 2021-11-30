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
5. Change to your password on line 11 in server.py
7. `export FLASK_APP=server.py` (Unix Command)
8. `flask run`
