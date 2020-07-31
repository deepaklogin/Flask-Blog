from flask import Flask, render_template, request,session,redirect
# from werkzeug import secure_filename
from flask_mail import Mail
from flask_sqlalchemy import SQLAlchemy
import json
from datetime import datetime
import os
import math

with open('config.json', 'r') as c:
    params = json.load(c)["params"]

app = Flask(__name__)
app.config['UPLOAD_FOLDER']=params['upload_location']
app.secret_key='deepak-rajak'
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)
mail = Mail(app)
local_server = True
if (local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db = SQLAlchemy(app)


class Contacts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phone = db.Column(db.String(12), nullable=False)
    message = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)


class Posts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    tag_line = db.Column(db.String(200), nullable=False)
    slug = db.Column(db.String(30), nullable=False)
    content = db.Column(db.String(200), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(200), nullable=True)


@app.route("/")
def home():
    post = Posts.query.filter_by().all()
    last=math.ceil(len(post)/int(params['no_of_post']))
    # [0:params['no_of_post']]
    page=request.args.get('page')
    if(not str(page).isnumeric()):
        page=1
    page=int(page)
    post=post[(page-1)*int(params['no_of_post']):(page-1)*int(params['no_of_post'])+int(params['no_of_post'])]
    if(page==1):
        prev = "#"
        next = "/?page=" + str(page + 1)
    elif(page==last):
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)


    return render_template("index.html", params=params,posts=post,prev=prev,next=next)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html",params=params,post=post)

@app.route("/about")
def about():
    return render_template("about.html", params=params)

@app.route("/dashboard",methods=["GET","POST"])
def dashboard():
    if ('user' in session and session['user']==params['admin_user']):
        post = Posts.query.all()
        return render_template('dashboard.html',params=params,post=post)
    if request.method=='POST':
        uname=request.form.get('email')
        upass=request.form.get('pass')
        if(uname==params['admin_user'] and upass==params['admin_pass']):
            session['user']=uname
            post=Posts.query.all()
            return render_template('dashboard.html',params=params,post=post)
    return render_template("login.html", params=params)


@app.route("/edit/<string:id>",methods=['GET','POST'])
def edit(id):
    if ('user' in session and session['user']==params['admin_user']):
        if request.method=='POST':
            b_title=request.form.get('title')
            b_tagline=request.form.get('tagline')
            b_slug=request.form.get('slug')
            b_content=request.form.get('content')
            b_img_file=request.form.get('imgfile')
            date=datetime.now()
            if id=='0':
                post=Posts(title=b_title,slug=b_slug,tag_line=b_tagline,content=b_content,img_file=b_img_file,date=date)
                db.session.add(post)
                db.session.commit()

            else:
                post=Posts.query.filter_by(id=id).first()
                post.tilte=b_title
                post.slug=b_slug
                post.content=b_content
                post.tag_line=b_tagline
                post.img_file=b_img_file
                post.date=date
                db.session.commit()
                return redirect('/edit/'+id)
        post=Posts.query.filter_by(id=id).first()
        return  render_template('edit.html',params=params,id=id,post=post)



def about():
    return render_template("about.html", params=params)

@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if('user' in session and session['user'] == params['admin_user']):
        if(request.method=='POST'):
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER']))
            return "Uploaded Successfully"
@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/delete/<string:id>",methods=['GET','POST'])
def delete(id):
    if('user' in session and session['user'] == params['admin_user']):
        post=Posts.query.filter_by(id=id).first()
        db.session.delete(post)
        db.session.commit()
        return redirect('/dashboard')

@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        ''' add entry to databse'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name, email=email, phone=phone, message=message, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message("new message from blogs", sender=email, recipients=[email],
                          body="Thank you for your response we are happy to connect with us...")

    return render_template("contact.html", params=params)


app.run(debug=True)
