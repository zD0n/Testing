import os
import asyncio
import subprocess
import shutil

current_directory = os.path.dirname(os.path.abspath(__file__))

async def ClothBg():

    Background_command = ["conda", "run", "-n", "CarveKit","python",rf"{current_directory}/Bg_remover.py"] # Any Env that can run CarveKit
    subprocess.run(Background_command,shell=True)

    return "Done Removing"

async def convertBg():
    
    convert_command = ["conda", "run", "-n", "CarveKit","python",rf"{current_directory}/convert.py"]
    subprocess.run(convert_command,shell=True)

    return "Convert Done"

async def FillBg():
    
    convert_command = ["conda", "run", "-n", "CarveKit","python",rf"{current_directory}/Fill.py"]
    subprocess.run(convert_command,shell=True)

    return "Filling Done"



async def main():

    print("Running Cloth & Person Backgound Remover.")
    Clothnobg = await ClothBg()
    print("Received:", Clothnobg)

    print("Running Convert...")
    Conbg = await convertBg()
    print("Received:", Conbg)

    print("Fill White Color...")
    WhBG = await FillBg()
    print("Received:", WhBG)

if __name__ == "__main__":
    asyncio.run(main())