import numpy as np
from keras.models import load_model
from keras.utils import load_img, img_to_array
import os


model = load_model(os.path.join(os.getcwd(),"Edited.h5"), compile=False)
#print(os.path.join(os.getcwd(),"SnakeModel.h5"))

img = load_img(r"path\to\your\image",target_size = (224,224))
img_arr = img_to_array(img)
img_arr = np.expand_dims(img_arr,axis=0)
img_arr /= 255.

prediction = model.predict(img_arr)
print(prediction)

predicted_class = np.argmax(prediction)
confidence_level = np.max(prediction)
print('Predicted class:', predicted_class)
print('Confidence level:', confidence_level*100,"%")
