import sqlite3
import functools

# Simple in-memory cache
query_cache = {}

def cache_query(func):
    """
    Decorator that caches the result of a query based on its SQL string.
    """
    @functools.wraps(func)
    def wrapper(conn, *args, **kwargs):
        # Extract the query string from kwargs or positional args
        query = kwargs.get('query') if 'query' in kwargs else (args[0] if args else None)
        if query in query_cache:
            print(f"[cache] hit for query: {query}")
            return query_cache[query]

        # Not cached yet: call the function and cache the result
        result = func(conn, *args, **kwargs)
        query_cache[query] = result
        print(f"[cache] set for query: {query}")
        return result

    return wrapper

def with_db_connection(func):
    """Opens a sqlite3 connection, passes it in, then closes it."""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        conn = sqlite3.connect('users.db')
        try:
            return func(conn, *args, **kwargs)
        finally:
            conn.close()
    return wrapper

@with_db_connection
@cache_query
def fetch_users_with_cache(conn, query):
    cursor = conn.cursor()
    cursor.execute(query)
    return cursor.fetchall()

if __name__ == "__main__":
    # First call: cache miss → runs the query
    users = fetch_users_with_cache(query="SELECT * FROM users")
    print(users)

    # Second call: same query → cache hit
    users_again = fetch_users_with_cache(query="SELECT * FROM users")
    print(users_again)
