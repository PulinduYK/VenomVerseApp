from flask import Flask, request, jsonify
from keras.models import load_model
from keras.utils import load_img, img_to_array
import numpy as np
import io

app = Flask(__name__)

# Load the pre-trained .h5 model
model = load_model("VVSML.h5")  # Replace with your .h5 file path

# Preprocess function
def preprocess_image(image):
    img = load_img(image,target_size = (224,224))
    img_arr = img_to_array(img)
    img_arr = np.expand_dims(img_arr,axis=0)
    img_arr /= 255.  # Add batch dimension
    return img_arr

@app.route("/", methods=["GET"])
def home():
    return "ML Image Classification API is Running"

@app.route("/predict", methods=["POST"])
def predict():
    try:
        # Read image file from request
        if "file" not in request.files:
            return jsonify({"error": "No image uploaded"})
        
        file = request.files["file"]
        image = io.BytesIO(file.read())
        image = preprocess_image(image)

        # Make prediction
        prediction = model.predict(image)
        predicted_class = np.argmax(prediction)  # Get the highest probability class
        predicted_level = np.max(prediction)

        return jsonify({"prediction": int(predicted_class), "confidence": float(predicted_level)})
    
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)