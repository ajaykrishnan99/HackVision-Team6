from flask import Flask, render_template, request, redirect, session
import pandas as pd
import numpy as np
import os
from datetime import datetime
from flask_mysqldb import MySQL


app = Flask(__name__)
app.secret_key = os.urandom(16)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'hackvision'

mysql = MySQL(app)


@app.route('/form')
def form():
    return render_template('signin.html')


@app.route('/signout')
def signout():
    session.pop('username', None)
    return redirect('/')


@app.route('/signup')
def signup():
    return render_template('signup.html')


@app.route('/registereducator',methods = ['POST', 'GET'])
def register():
    if request.method == 'POST':
        e_id = request.form['e_id']
        email = request.form['email']
        name = request.form['name']
        psw = request.form['psw']
        description = request.form['description']
        qualification = request.form['qualification']
        subject = request.form['subject']
        type = "educator"
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(
                '''INSERT INTO auth (`id`,`password`,`type`) VALUES(%s,%s,%s)''', (email, psw, type))
            mysql.connection.commit()
           
            # # cursor.execute('''INSERT INTO educator  ( `e_id`,`email`,`full_name`,`description`) VALUES(%s,%s,%s,%s)''',(e_id,email,name,description)) #educator
            cursor.execute(
                '''INSERT INTO educator  (`email`,`full_name`,`description`) VALUES(%s,%s,%s)''',(email,name,description)) #educator
            mysql.connection.commit()
            # # cursor.execute('''INSERT INTO educator_qualification (`e_id`,`qualification`,`email`) VALUES(%s,%s,%s)''',(e_id,qualification,email))
            cursor.execute('''INSERT INTO educator_qualification (`qualification`,`email`) VALUES(%s,%s)''',(qualification,email))
            mysql.connection.commit()
            cursor.execute('''INSERT INTO subjects (`subject_name`, `email`) VALUES(%s,%s)''',(subject,email)) #subject
            
            mysql.connection.commit()
            cursor.close()
        except:
            pass
    else:
        pass

    return render_template('RegisteredSuccess.html')



@app.route('/registerUser',methods = ['POST', 'GET'])
def registerUser():
    if request.method == 'POST':
        u_id = request.form['u_id']
        Useremail = request.form['Useremail']
        Username = request.form['Username']
        Userpsw = request.form['Userpsw']
        country = request.form['country']
        type = "user"
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(
                '''INSERT INTO auth (`id`,`password`,`type`) VALUES(%s,%s,%s)''', (Useremail, Userpsw, type))
            mysql.connection.commit()
           
            # # cursor.execute('''INSERT INTO mentee  (`email`,`full_name`,`description`) VALUES(%s,%s,%s,%s)''',(e_id,email,name,description)) #educator
            cursor.execute(
                '''INSERT INTO mentee  (`email`,`full_name`,`country`) VALUES(%s,%s,%s)''',(Useremail,Username,country)) #educator
            mysql.connection.commit()
            # # cursor.execute('''INSERT INTO educator_qualification (`e_id`,`qualification`,`email`) VALUES(%s,%s,%s)''',(e_id,qualification,email))
           
            cursor.close()
        except:
            pass
    else:
        pass

    return render_template('RegisteredSuccess.html')


@app.route('/login', methods=['POST', 'GET'])
def login():
    
    
    if request.method == 'POST':
        ida = request.form['id']
        password = request.form['password']
        user_type = request.form['type']

        if user_type == 'user':
            if 'username' in session:
                results1=''
                cursor = mysql.connection.cursor()
                sql = "SELECT * from booking"
                cursor.execute(sql)
                results1 = cursor.fetchall()
                cursor.close()
                return render_template('mentee.html',results=results1)
        # return render_template('mentee.html')
            cursor = mysql.connection.cursor()
            sql = "SELECT * FROM auth where id='"+ida + \
                "' and password='"+password+"' and type='user'"
            cursor.execute(sql)
            results = cursor.fetchall()
            if results:
                session['username'] = request.form['id']
                # cursor = mysql.connection.cursor()
                
                return render_template('mentee.html')
            else:
                return render_template('signin.html')

        else: # Educator -> Mentor
            if 'username' in session:
                results1=''
                cursor = mysql.connection.cursor()
                sql = "SELECT * from booking"
                cursor.execute(sql)
                results1 = cursor.fetchall()
                cursor.close()
                return render_template('mentor.html',results=results1)
            cursor = mysql.connection.cursor()
            sql = "SELECT * FROM auth where id='"+ida + \
                "' and password='"+password+"' and type='educator'"
            cursor.execute(sql)
            results = cursor.fetchall()
            if results:
                session['username'] = request.form['id']
                
                # datetime object containing current date and time
                
                curr_date=datetime.now()
                dt_string = curr_date.strftime("%d/%m/%Y %H:%M:%S")
                sql = "SELECT * from booking where e_email='"+ida+"'and start_date_time>sysdate()"
                cursor.execute(sql)
                results1 = cursor.fetchall()
                cursor.close()
                return render_template('mentor.html',results=results1)
            else:
                return render_template('signin.html')

            # return render_template('page1.html', results=results)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/about')
def about():
    return render_template('about.html')


@app.route('/collaboration')
def colab():
    return render_template('collaboration.html')


@app.route('/signin')
def signin():
    return render_template('signin.html')


@app.route('/trainers')
def trainers():
    return render_template('trainers.html')


@app.route('/courses')
def courses():
    return render_template('courses.html')
