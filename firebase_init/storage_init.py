import os
import json
import firebase_admin
from firebase_admin import credentials, storage
from tqdm import tqdm 

# Initialize Firebase Admin SDK\
cred = credentials.Certificate('/home/eliagatti/Downloads/crosstrack-italia-firebase-adminsdk-2mxiw-c9aa1ad368.json')
firebase_admin.initialize_app(cred, {"storageBucket": "crosstrack-italia.appspot.com"})
bucket = storage.bucket()

def upload_files_to_firebase(local_folder_path, remote_folder_path):
    with tqdm(total=sum(len(files) for _, _, files in os.walk(local_folder_path)), desc="Uploading") as pbar:
        for root, _, files in os.walk(local_folder_path):
            for file_name in files:
                local_file_path = os.path.join(root, file_name)
                remote_file_path = os.path.join(remote_folder_path, os.path.relpath(local_file_path, local_folder_path))
                
                blob = bucket.blob(remote_file_path)
                blob.upload_from_filename(local_file_path)
                pbar.update(1)


def main():
    regions = ["veneto", "lombardia", "trentino_alto_adige"]
    base_local_folder = "assets/images/track_img"
    
    for region in regions:
        region_folder = os.path.join(base_local_folder, f"{region}")
        
        for track_folder in os.listdir(region_folder):
            track_folder_path = os.path.join(region_folder, track_folder)
            codice_web = track_folder.split("_")[0]  # Extract codice_web from folder name
            remote_folder_path = f"tracks/{region}/{codice_web}"
            
            upload_files_to_firebase(track_folder_path, remote_folder_path)

if __name__ == "__main__":
    main()
