from flask import Flask, flash, redirect, render_template, request, session, abort
application = Flask(__name__)

@application.route("/")
def index():
    return "Index!"

@application.route("/members")
def members():
    return "Members"

@application.route("/members/<string:name>/")
def getMember(name):
    return name

@application.route("/hello/<string:name>/")
def hello(name):
    return render_template(
        'test.html',name=name)


if __name__ == "__main__":
    application.run("0.0.0.0",debug=False)
    #application.run("0.0.0.0",debug=True)