from flask import Flask, request, jsonify
from keras.models import load_model
from keras.utils import load_img, img_to_array
import numpy as np
import io

app = Flask(__name__)

# Load different models based on an integer identifier
models = {
    1: load_model("path_to_your_first_model.h5"),  # Model for ID 1
    2: load_model("path_to_your_second_model.h5"),  # Model for ID 2
    3: load_model("path_to_your_third_model.h5"),   # Model for ID 3
}

# Preprocess function
def preprocess_image(image):
    img = load_img(image,target_size = (224,224))
    img_arr = img_to_array(img)
    img_arr = np.expand_dims(img_arr,axis=0)
    img_arr /= 255.  # Add batch dimension
    return img_arr

@app.route("/", methods=["GET"])
def home():
    return "New 3 Model ML Image Classification API is Running"

@app.route("/predict", methods=["POST"])
def predict():
    try:
        # Read image file from request
        if "file" not in request.files:
            return jsonify({"error": "No image uploaded"})
        
        if "model_id" not in request.form:
            return jsonify({"error": "No model_id provided"})
        
        # Retrieve model_id and convert to int
        model_id = int(request.form["model_id"])

        # Validate model_id
        if model_id not in models:
            return jsonify({"error": "Invalid model_id. Choose between 1, 2, or 3"})
        
        # Load the corresponding model
        model = models[model_id]
        
        file = request.files["file"]
        image = io.BytesIO(file.read())
        image = preprocess_image(image)

        # Make prediction
        prediction = model.predict(image)
        predicted_class = np.argmax(prediction)  # Get the highest probability class
        predicted_level = np.max(prediction)

        return jsonify({"model_id": model_id,"prediction": int(predicted_class), "confidence": float(predicted_level)})
    
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)