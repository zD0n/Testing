import cv2
import numpy as np
import os


current_directory = os.path.dirname(os.path.abspath(__file__))

files_in_folder = os.listdir(f"{current_directory}/Removebackground")

for i in files_in_folder:

    img = cv2.imread(rf"{current_directory}/Removebackground/{i}", cv2.IMREAD_UNCHANGED)  

    bgr = img[:, :, :3]
    alpha = img[:, :, 3]

    white_bg = np.ones_like(bgr, dtype=np.uint8) * 255 

    alpha_normalized = alpha[:, :, None] / 255.0 

    composite = (bgr * alpha_normalized + white_bg * (1 - alpha_normalized)).astype(np.uint8)

    cv2.imwrite(f"{current_directory}/Output/{i[:-4]}.jpg", composite)