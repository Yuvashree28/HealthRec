from diabetes import dprediction
from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin

app = Flask("Predicting Diabetes")
CORS(app, support_credentials=True)


@app.route("/")
@cross_origin(support_credentials=True)
def home():
    return "ml model"


@app.route("/predictdiabetes")
@cross_origin(support_credentials=True)
def predictingchd():
    response = {}
    glucose = request.args.get('glucose')
    bloodpressure = request.args.get('bp')
    risk = dprediction().predict(([[int(glucose), int(bloodpressure)]]))
    if risk == 0:
        response['diabetes'] = "Negative"
    else:
        response['diabetes'] = "Positive"
    return jsonify(response)


app.run(host='0.0.0.0', port=8000)
