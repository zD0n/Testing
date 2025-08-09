import subprocess
import os
import shutil
import asyncio
import cv2
import time

# When im writing this i didn't know that it able to do "cd .. and cd ./.."

global current_directory

current_directory = os.path.dirname(os.path.abspath(__file__))

def movefile(source_file,openpose_directory):

    try:
        shutil.copy(source_file, openpose_directory)

    except FileNotFoundError:
        print(rf"Error: Source file '{source_file}' not found.")

def resize_image(path):
        
        im_path = cv2.imread(path)
        resize_image = cv2.resize(im_path,(768,1024))
        cv2.imwrite(path,resize_image)


async def Pepare():

    folder_path = rf"{current_directory}/Input"
    files_in_folder = os.listdir(folder_path)
    
    for item in files_in_folder:
        if item[0] == "P":
            Person = rf"{folder_path}/{item}"
            resize_image(Person)
            movefile(Person,rf"{current_directory}/CarveKit/Input")
        else:
            Cloth = rf"{folder_path}/{item}"
            resize_image(Cloth)
            movefile(Cloth,rf"{current_directory}/CarveKit/Input")

    return "Done"


async def Setup_File():

    Person_openpose_directory = rf"{current_directory}/Openpose/image"
    Person_yolo_directory = rf"{current_directory}/Yolo/Input"
    Person_HD_directory =rf"{current_directory}/VITON-HD/datasets/test/image"

    Cloth_HD_directory = rf"{current_directory}/VITON-HD/datasets/test/cloth"
    ClothMask_HD_directory = rf"{current_directory}/VITON-HD/datasets/test/cloth-mask"

    folder_path = rf"{current_directory}/CarveKit/Output"


    for i in os.listdir(folder_path):
        if i[0] == 'P':
            for j in [Person_openpose_directory,Person_yolo_directory,Person_HD_directory]:
                movefile(f"{folder_path}/{i}",j)

        elif i[0] == "C":
            for j in [Cloth_HD_directory]:
                movefile(f"{folder_path}/{i}",Cloth_HD_directory)

        else:
            movefile(f"{folder_path}/{i}",f"{ClothMask_HD_directory}/{i[5:]}")

    return 'Done'


async def openpose():

    openpose_command = ["conda", "run", "-n", "HDViton","python",rf"{current_directory}/Openpose/Openpose.py"]
    subprocess.run(openpose_command,shell=True)
    return "Done"

async def yolo():

    yolo_command = ["conda", "run", "-n", "CarveKit","python",rf"{current_directory}/Yolo/Run.py"]
    subprocess.run(yolo_command,shell=True)
    return "Done"

async def HD():

    HDVitron_command = ["conda", "run", "-n", "HDViton","python",rf"{current_directory}/VITON-HD/Run.py"]
    subprocess.run(HDVitron_command,shell=True)
    return "Done"

async def CarveKit():

    BG_command = ["conda", "run", "-n", "CarveKit","python",rf"{current_directory}/CarveKit/Run.py"]
    subprocess.run(BG_command,shell=True)
    return "Done"


async def move_openpose_file():
    
    openpose_result_path = rf"{current_directory}/Openpose/Output"

    for i in os.listdir(openpose_result_path):

        if i[-1] == "n":
            file = rf'{openpose_result_path}/{i}'
            shutil.copy(file, rf"{current_directory}/VITON-HD/datasets/test/openpose-json")

        else:
            file = rf'{openpose_result_path}/{i}'
            shutil.copy(file, rf"{current_directory}/VITON-HD/datasets/test/openpose-img")

    return "Done"

async def move_yolo_file():
    
    yolo_file = rf"{current_directory}/Yolo/Output/Person.png"
    to_model = rf"{current_directory}/VITON-HD/datasets/test/image-parse"

    shutil.copy(yolo_file, to_model)

    return "Done"

async def move_result():

    result = rf"{current_directory}/VITON-HD/results/Running/Person.jpg_Cloth.jpg"
    to_model = rf"{current_directory}/Result/Output.jpg"

    shutil.copy(result, to_model)

    return "Done"

def Check_Folder(curr_directory):
    for i in os.listdir(curr_directory):
        if i in ["Input","Output","Removebackground","image"]:
            folder_path = f"{curr_directory}/{i}"
            x = os.listdir(f"{curr_directory}/{i}")

            if x != []:
                for j in x:

                    try:
                        os.remove(f'{folder_path}/{j}')
                    except:
                        pass

async def clear():
    for i in os.listdir(current_directory):
        if i[-1] == "y" or i == "Input":
            pass

        else:
            if i == "CarveKit":
                Check_Folder(f"{current_directory}/{i}")

            elif i == "Openpose":
                Check_Folder(f"{current_directory}/{i}")

            elif i == "Yolo":
                Check_Folder(f"{current_directory}/{i}")


    for i in os.listdir(f"{current_directory}/VITON-HD/datasets/test"):

        for j in os.listdir(f"{current_directory}/VITON-HD/datasets/test/{i}"):

            try:    
                os.remove(f"{current_directory}/VITON-HD/datasets/test/{i}/{j}")
            except:
                pass


async def main():

    start = time.time()

    await clear()
    data = await Pepare()
    print("Received from Input :", data)

    print("Program started.")
    
    t1 = await CarveKit()
    print("Received:", t1)

    print("Set up Preprocess File..")
    Setu = await Setup_File()
    print("Received:", Setu)

    print("Running Preprocess...")
    t2 = asyncio.create_task(openpose())
    t3 = asyncio.create_task(yolo())
    
    await asyncio.gather(t2, t3)
    print("Received: Preprocess Done")

    print("Moving File...")
    m1 = asyncio.create_task(move_openpose_file())
    m2 = asyncio.create_task(move_yolo_file())
    
    await asyncio.gather(m1, m2)
    print("Received: Moving File Done")

    print("Running HD Viton.")
    model = await HD()
    print("Status :",model)

    print("Getting Result...")
    resu = await move_result()
    print("Status :",resu)

    await clear()

    end = time.time()
    length = end - start
    print("It took", int(length), "seconds!")

if __name__ == "__main__":
    asyncio.run(main())