from ultralytics import YOLO
import numpy as np
from PIL import Image
import os
import cv2

current_directory = os.path.dirname(os.path.abspath(__file__))
model = YOLO(rf"{current_directory}/best.pt")
results = model(rf"{current_directory}/Input/Person.jpg")[0]

masks = results.masks.data.cpu().numpy()
class_ids = results.boxes.cls.cpu().numpy().astype(int)

h, w = masks.shape[1:]
class_map = np.zeros((h, w), dtype=np.uint8)

for i, class_id in enumerate(class_ids + 1):
    class_map[masks[i] > 0.0] = class_id

remap_dict = {
  2: 6,
  3: 13,
  4: 3,
  5: 9,
  6: 7,
  7: 12,
  8: 15,
  9: 14,
  10: 11,
  11: 10,
  12: 8,
  13: 16,
  14: 1,
  15: 4,
  16: 17,
  17: 2,
  18: 5,
  19: 19,
  1: 18
}

orig_map = class_map.copy()
new_map = class_map.copy()

for old_id, new_id in remap_dict.items():
    new_map[orig_map == old_id] = new_id

class_map = new_map

class_colors = {
    1: (128, 0, 0),
    2: (254, 0, 0),
    3: (0, 85, 0),
    4: (169, 0, 51),
    5: (254, 85, 0),
    6: (0, 0, 85),
    7: (0, 119, 220),
    8: (85, 85, 0),
    9: (0, 85, 85),
    10: (85, 51, 0),
    11: (52, 86, 128),
    12: (0, 128, 0),
    13: (0, 0, 254),
    14: (51, 169, 220),
    15: (0, 254, 254),
    16: (85, 254, 169),
    17: (169, 254, 85),
    18: (254, 254, 0),
    19: (254, 169, 0)
}

img_p = Image.fromarray(class_map, mode='P')

palette = []
for i in range(256):
    if i in class_colors:
        palette.extend(class_colors[i])
    else:
        palette.extend((0, 0, 0))
img_p.putpalette(palette)

img_p.save(rf"{current_directory}/Output/Person.png")
