import torch
from carvekit.api.high import HiInterface
import os

current_directory = os.path.dirname(os.path.abspath(__file__))

# Check doc strings for more information
interface = HiInterface(object_type="object",  # Can be "object" or "hairs-like".
                        batch_size_seg=5,
                        batch_size_matting=1,
                        device='cuda' if torch.cuda.is_available() else 'cpu',
                        seg_mask_size=640,  # Use 640 for Tracer B7 and 320 for U2Net
                        matting_mask_size=2048,
                        trimap_prob_threshold=231,
                        trimap_dilation=30,
                        trimap_erosion_iters=5,
                        fp16=False)

files_in_folder = os.listdir(f"{current_directory}/Input")

for i in files_in_folder:

    images_without_background = interface([f'{current_directory}/Input/{i}'])
    images_without_background[0].save(f'{current_directory}/Removebackground/{i[:-4]}.png')
