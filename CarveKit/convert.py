import cv2
import numpy as np
from matplotlib import pyplot as plt
import os


import cv2
import numpy as np
current_directory = os.path.dirname(os.path.abspath(__file__))

img = cv2.imread(rf'{current_directory}/Removebackground/Cloth.png', cv2.IMREAD_UNCHANGED)

alpha = img[:, :, 3]

mask = np.where(alpha > 0, 255, 0).astype(np.uint8)

cv2.imwrite(f'{current_directory}/Output/Mask_Cloth.jpg', mask)