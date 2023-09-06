Sure, I can provide a basic overview of the concepts of "dependencies", "privileges", and "compilation" within the context of PL/SQL in the form of bullet points. 

**Dependencies**

1. Dependencies in PL/SQL refers to the relationship between different database objects like procedures, functions, packages, triggers, or views.

2. If an object relies on another object to function correctly, it's said to be dependent on that object. For example, a function that uses a table is dependent on that table.

3. Dependencies are stored in the data dictionary and can be viewed using the `USER_DEPENDENCIES` view.

4. If an object that others depend on changes (for instance, if a column is dropped from a table), it can invalidate dependent objects.

5. Invalid objects must be recompiled before they can be used again.

**Privileges**

1. Privileges in PL/SQL are permissions or authorizations granted to a user or role.

2. Two types of privileges exist: system and object. System privileges apply to administrative tasks like creating tables or views, while object privileges pertain to actions on specific objects like select, insert, update, and delete.

3. The GRANT command is used to provide privileges. The syntax is: `GRANT privilege_name ON object_name TO {user_name | PUBLIC | role_name}`.

4. The REVOKE command removes privileges: `REVOKE privilege_name ON object_name FROM {user_name | PUBLIC | role_name}`.

5. Keep in mind that granting too many privileges can present a security risk. It's best to stick to the principle of least privilege, i.e., only grant necessary privileges for the tasks a user or role needs to perform.

**Compilation**

1. In PL/SQL, compilation is the process of transforming the human-readable code into a format the database can understand and execute.

2. You can compile a PL/SQL unit by creating it in the SQL*Plus environment or using a database management system like Oracle SQL Developer.

3. PL/SQL will be automatically compiled when it is created or when an ALTER command is issued. You can manually compile using the command: `ALTER {PROCEDURE | FUNCTION | PACKAGE | PACKAGE BODY} plsql_unit COMPILE`.

4. If there are syntax errors, they will be reported during the compilation process. The `USER_ERRORS` view can be used to find detailed information about these errors.

5. The compiled code is stored in the database, and it's what's actually run when the PL/SQL unit is executed. The stored, compiled code provides benefits in terms of performance because it doesn't need to be recompiled every time it's executed.

Remember, these are just basics. Each of these topics is quite vast and would require a deeper dive for full comprehension. It's recommended to refer to Oracle's official documentation or trusted PL/SQL learning resources for detailed study.

Sure, let's provide some practical examples to illustrate these concepts.

**Dependencies**

Assume we have a table and a function that relies on that table:

```sql
CREATE TABLE employees (
    id NUMBER,
    name VARCHAR2(100),
    salary NUMBER
);

CREATE OR REPLACE FUNCTION get_salary (p_id NUMBER) 
RETURN NUMBER IS
    v_salary NUMBER;
BEGIN
    SELECT salary INTO v_salary
    FROM employees
    WHERE id = p_id;
    
    RETURN v_salary;
END;
/
```
In this case, the `get_salary` function is dependent on the `employees` table. If the `employees` table is dropped or altered (say a column is deleted), the function becomes invalid and needs to be recompiled.

**Privileges**

Let's say we have two users, `user1` and `user2`. `user1` owns a table named `my_table`, and `user2` needs to select data from it. `user1` can grant the necessary privilege to `user2` like so:

```sql
GRANT SELECT ON my_table TO user2;
```
This SQL statement gives `user2` the privilege to perform SELECT operations on `my_table`.

**Compilation**

Consider the following PL/SQL procedure:

```sql
CREATE OR REPLACE PROCEDURE print_message (p_message VARCHAR2) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE(p_message);
END;
/
```
When you run the `CREATE OR REPLACE PROCEDURE` statement, Oracle automatically compiles the procedure. If the procedure compiles successfully, it's stored in the database and can be invoked by applications.

If you need to manually recompile the procedure, you can use the following command:

```sql
ALTER PROCEDURE print_message COMPILE;
```

If there were errors during the compilation, you can view them using the following command:

```sql
SHOW ERRORS PROCEDURE print_message;
```
This command will show errors that occurred during the compilation of the `print_message` procedure. You can correct these errors and then recompile the procedure.