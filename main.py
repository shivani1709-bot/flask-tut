from datetime import datetime
from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from werkzeug.utils import secure_filename
import json
import os

with open('config.json', 'r') as c:
    params = json.load(c)["params"]


app = Flask(__name__)
app.secret_key = 'secret-key'
app.config.update (
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']
)
mail = Mail(app)
app.config['UPLOAD_FOLDER'] = params['file_uploader']
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/codingthunder'
db = SQLAlchemy(app)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    slug = db.Column(db.String(25), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(120), nullable=False)


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()[0:params['no_of_posts']]
    return render_template("index.html", params=params,posts=posts)


@app.route("/about")
def about():
    return render_template("about.html", params=params)


@app.route("/edit/<string:sno>", methods=['GET',  'POST'])
def edit(sno):
    session['user'] = 0
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            print("inside if post method")
            box_title = request.form.get('title')
            tagline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno == '0':
                print("inside sno =0")
                post = Posts(title=box_title, tagline=tagline, slug=slug, content=content, date=date, img_file=img_file)
                print(post)
                db.session.add(post)
                db.session.commit()
            else:
                print("inside else")
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.tagline = tagline
                post.date = date
                post.img_file = img_file
                db.session.commit()
                return redirect('/edit/' + sno)
    post = Posts.query.filter_by(sno=sno).first()
    return render_template('edit.html', params=params, post=post, sno=sno)


@app.route("/dashboard", methods=['GET',  'POST'])
def dashboard():
    session['user'] = 0
    if 'user' in session and session['user'] == params['admin_user']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts= posts)

    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if username == params['admin_user'] and userpass == params['admin_password']:
            session['user'] == username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts= posts)
    else:
        return render_template("login.html", params=params)


@app.route("/uploader", methods=['GET',  'POST'])
def uploader():
    print("inside uploader")
    session['user'] = 0
    if 'user' in session and session['user'] == params['admin_user']:
        print("userrrrrr")
        if request.method == 'POST':
            print("inside post method")
            f = request.files['file1']
            print("****f is ******")
            print(f)
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename) ))
            return 'Uploaded Successfully'
        else:
            print("returned nothing")
            print("****inside else*****")
            return 'failure'


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route("/delete/<string:sno>", methods=['GET',  'POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect("/dashboard")


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html", params=params, post=post)


@app.route("/contact", methods=['GET',  'POST'])
def contact():
    if request.method == 'POST':
        '''add entry to the database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        entry = Contacts(name='name', email='email', phone_num='phone', date=datetime.now(), msg='message')
        db.session.add(entry)
        db.session.commit()
        mail.send_message("New message from " + name, sender=email,
                          recipients=[params['gmail-user']],
                          body = message)
    return render_template("contact.html")


app.run(debug=True)
