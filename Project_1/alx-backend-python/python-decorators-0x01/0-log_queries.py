import sqlite3
import functools

def log_queries(func):
    """Decorator that logs the SQL query before executing the function."""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        # try to pull the SQL string out of kwargs first, then args
        query = kwargs.get('query') if 'query' in kwargs else (args[0] if args else None)
        print(f"Executing SQL query: {query}")
        return func(*args, **kwargs)
    return wrapper

@log_queries
def fetch_all_users(query):
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    conn.close()
    return results

if __name__ == "__main__":
    users = fetch_all_users(query="SELECT * FROM users")
    print(users)
