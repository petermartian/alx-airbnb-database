import time
import sqlite3
import functools

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

def retry_on_failure(retries=3, delay=2):
    """
    Decorator factory: retries the wrapped function up to `retries` times
    if it raises an exception, waiting `delay` seconds between attempts.
    """
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            last_exc = None
            for attempt in range(1, retries + 1):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    last_exc = e
                    if attempt == retries:
                        # re-raise on final failure
                        raise
                    print(f"Attempt {attempt} failed: {e!r}. Retrying in {delay}s…")
                    time.sleep(delay)
            # should never get here
            raise last_exc
        return wrapper
    return decorator

@with_db_connection
@retry_on_failure(retries=3, delay=1)
def fetch_users_with_retry(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
    return cursor.fetchall()

if __name__ == "__main__":
    try:
        users = fetch_users_with_retry()
        print(users)
    except Exception as e:
        print(f"All retries failed: {e}")
