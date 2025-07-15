import sqlite3
import functools

def transactional(func):
    """
    Decorator that wraps the function in a transaction:
    - Opens a connection
    - Begins a transaction
    - Commits if func succeeds
    - Rolls back if func raises
    - Closes the connection
    """
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        conn = sqlite3.connect('users.db')
        try:
            # Give the function the connection
            result = func(conn, *args, **kwargs)
            conn.commit()
            return result
        except Exception as e:
            conn.rollback()
            print(f"Transaction rolled back due to: {e}")
            raise
        finally:
            conn.close()
    return wrapper

@transactional
def add_user(conn, username, email):
    """
    Example function that inserts a new user.
    If this function raises, the insert is rolled back.
    """
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO users (username, email) VALUES (?, ?)",
        (username, email)
    )
    # Return the new row’s ID
    return cursor.lastrowid

if __name__ == "__main__":
    try:
        new_id = add_user(username="jdoe", email="jdoe@example.com")
        print(f"Inserted user with ID {new_id}")
    except Exception:
        print("Failed to insert user.")
