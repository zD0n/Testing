import subprocess
import os
import asyncio

global current_directory
global openpose_dir

current_directory = os.path.dirname(os.path.abspath(__file__))
openpose_dir = rf"{current_directory}\openpose"


async def Picture():

    command = rf"bin\OpenPoseDemo.exe --image_dir {current_directory}/image --hand --display 0 --write_images {current_directory}/Output --num_gpu 1 --num_gpu_start 0 --render_pose 1 --alpha_pose 1.0 --alpha_heatmap 0.0 --part_to_show 0 --disable_blending"
    subprocess.run(["powershell.exe", "-Command", command], cwd=openpose_dir, capture_output=True, text=True)
    return "Done"

async def Keypoint():

    command2 = rf"bin\OpenPoseDemo.exe --image_dir {current_directory}/image --hand --disable_blending --display 0 --write_json {current_directory}/Output --num_gpu 1 --num_gpu_start 0 --render_pose 0"
    subprocess.run(["powershell.exe", "-Command", command2], cwd=openpose_dir, capture_output=True, text=True)
    return "Done"

async def main():

    print("Running Openpose")
    
    t1 = asyncio.create_task(Picture())
    t2 = asyncio.create_task(Keypoint())

    await asyncio.gather(t1, t2)

    print("Done..")


if __name__ == "__main__":
    asyncio.run(main())