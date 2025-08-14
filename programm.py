import psycopg2
conn = psycopg2.connect(host="localhost", user = "postgres", password = "PostgreS", port = "5432")
cursor = conn.cursor()
try:
    conn.autocommit = True
    cursor.execute("CREATE DATABASE programm")
    print("База данных успешно создана")
    cursor.close()
    conn.close()
except (psycopg2.Error):
    print("База данных существует")
    conn.close()


#Функция, создающая структуру БД (таблицы)
def create_db(conn):
    cur.execute("""DROP TABLE phones, client CASCADE;""")
    cur.execute("""
    CREATE TABLE IF NOT EXISTS client(
    client_id SERIAL UNIQUE PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(60),
    email VARCHAR(60));
    """)
    cur.execute("""
    CREATE TABLE IF NOT EXISTS phones(
    id SERIAL UNIQUE PRIMARY KEY,
    client_id INTEGER REFERENCES client(client_id),
    phone VARCHAR(11));
    """)
    conn.commit()  # фиксируем в БД

# Функция, позволяющая добавить нового клиента
def add_client(conn, first_name, last_name, email, phones=None):
    cur.execute("""
    SELECT client_id FROM client WHERE first_name = %s AND last_name =%s AND email = %s ;
    """, (first_name, last_name, email))
    id = cur.fetchall()
    if id ==[]:
        cur.execute("""
        INSERT INTO client(first_name, last_name, email) VALUES( %s, %s, %s);
        """, ( first_name, last_name, email))
        conn.commit()
   
    cur.execute("""
    SELECT client_id FROM client WHERE first_name = %s AND last_name =%s AND email = %s ;
    """, (first_name, last_name, email))
    id_client = cur.fetchall()[0][0]

    cur.execute("""
    SELECT phone FROM phones WHERE phone = %s;
    """,(phones,))
    phon = cur.fetchall()

    if phones != None and phon == []:
        cur.execute("""
        INSERT INTO phones(client_id, phone) VALUES(%s, %s);
        """, (id_client, phones))
        conn.commit()
        cur.execute("""
        SELECT * FROM phones ;
        """)

# Функция, позволяющая добавить телефон для существующего клиента
def add_phone(conn, id_client, phone):
    cur.execute("""
    SELECT first_name FROM client WHERE client_id = %s;
    """,(id_client,))
    name = cur.fetchall()
    
    cur.execute("""
    SELECT phone FROM phones WHERE phone = %s;
    """,(phone,))
    phon = cur.fetchall()

    if name !=[] and phon == []:
        cur.execute("""
        INSERT INTO phones (client_id,phone) VALUES (%s, %s);
        """, (id_client, phone))
        conn.commit()  # фиксируем в БД 
        print (f'Добавлен номер телефона {phone}, пользователь: {name[0][0]}')
    elif phon != []:
        print (f'Телефон {phone} есть в базе')
    else:
        print (f"Пользователь c id {id_client} не существует")


#Функция, позволяющая изменить данные о клиенте
def change_client(conn, client_id, first_name=None, last_name=None, email=None, phones=None):
    cur.execute("""
    UPDATE client SET first_name=%s, last_name=%s, email=%s WHERE client_id=%s;
    """, (first_name, last_name, email, client_id))
    cur.execute("""
    SELECT * FROM client;
    """)
    print(cur.fetchall())

    add_phone(conn, client_id, phones)

#Функция, позволяющая удалить телефон для существующего клиента
def delete_phone(conn, client_id):
    cur.execute("""
    SELECT * FROM phones WHERE client_id=%s;
    """, (client_id,))
    tel = cur.fetchall()[0][2]

    cur.execute("""
    DELETE FROM phones WHERE client_id=%s;
    """, (client_id,))
    conn.commit()  # фиксируем в БД
    print(f'Телефон {tel} удален из базы')

#Функция, позволяющая удалить существующего клиента
def delete_client(conn, client_id):
    cur.execute("""
    SELECT * FROM phones WHERE client_id=%s;
    """, (client_id,))
    tel = cur.fetchall()


    cur.execute("""
    DELETE FROM phones WHERE client_id=%s;
    """, (client_id,))

    cur.execute("""
    SELECT * FROM client WHERE client_id=%s;
    """, (client_id,))
    cl = cur.fetchall()


    cur.execute("""
    DELETE FROM client WHERE client_id=%s;
    """, (client_id,))

    if tel != []:
        print(f'Телефон {tel} удален из базы')

    print(f'Клиент {cl[0][1]} {cl[0][2]} удален(а) из базы')

#Функция, позволяющая найти клиента по его данным (имени, фамилии, email-у или телефону)
def find_client(conn, first_name=None, last_name=None, email=None, phone=None):
    cur.execute("""
    SELECT * FROM client c JOIN phones p ON c.client_id = p.client_id WHERE first_name=%s OR last_name=%s 
    OR email=%s OR p.phone=%s;
    """, (first_name, last_name, email, phone))
    print(cur.fetchall())




with psycopg2.connect(host="localhost", database = "programm", user = "postgres", password = "PostgreS", port = "5432") as conn:
    with conn.cursor() as cur:
        create_db(conn)
        add_client(conn, 'Аглая', 'Романова', 'aglaya@mail.ru')
        add_client(conn, 'Владислав', 'Миклин', 'vladislav@mail.ru', '89632266321')
        add_client(conn, 'Эдуард', 'Жолдарев', 'eduard@mail.ru', '89228485723')
        add_client(conn, 'Ксения', 'Мирова', 'ksenya@mail.ru')
        add_phone(conn, 4, '89650449022')
        add_phone(conn, 1, '89650449566')
        add_phone(conn, 5, '89690452536')
        find_client(conn, first_name='Аглая')
        find_client(conn, first_name='Ксения')
        find_client(conn, last_name='Жолдарев')
        find_client(conn, phone='89650449022')
        find_client(conn, email='vladislav@mail.ru')
        change_client(conn, 2, 'Вячеслав', 'Миклин', 'vladislav@mail.ru', '89632266322')
        delete_phone(conn, 4)
        delete_client(conn, 1)