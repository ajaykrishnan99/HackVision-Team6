from flask import Flask, render_template, request, redirect, session
import pandas as pd
import numpy as np
import os


app = Flask(__name__)
app.secret_key = os.urandom(16) 

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