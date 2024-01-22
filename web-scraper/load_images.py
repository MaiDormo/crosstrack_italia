import json
import os
import requests
from tqdm import tqdm as tqdm_module

BASE_URL = "https://tracks.mxcenter.it/core/img/circuiti"
MAX_IMAGE_NUMBER = 10

def fetch_images(regione, codice_web, format):
    urls = []
    unique_urls = set()
    for i in range(1, MAX_IMAGE_NUMBER + 1):
        img_url = f"{BASE_URL}/{regione}/{codice_web}/{i:{format}}.jpg"
        response = requests.head(img_url)
        if response.status_code == 200 and img_url not in unique_urls:
            urls.append(img_url)
            unique_urls.add(img_url)
        else:
            break
    return urls

def get_images(regione, codice_web):
    regione = regione.lower().replace(" ", "%20")
    urls = fetch_images(regione, codice_web, '02d') or fetch_images(regione, codice_web, '03d')
    return urls

def download_and_save_images(urls, save_path):
    for i, url in enumerate(urls):
        response = requests.get(url)
        if response.status_code == 200:
            img_filename = os.path.join(save_path, f"img{i+1}.jpg")
            with open(img_filename, "wb") as img_file:
                img_file.write(response.content)
        else:
            print(f"Error downloading image from {url}")

def main():
    regions = ["veneto", "lombardia", "trentino_alto_adige"]
    
    for region in regions:
        region_folder = os.path.join("track_img", f"{region}")
        os.makedirs(region_folder, exist_ok=True)
        
        json_folder = f"{region}_json"
        json_files = os.listdir(json_folder)
        
        for json_file in tqdm_module(json_files, desc=f"Processing {region}"):
            json_path = os.path.join(json_folder, json_file)
            with open(json_path, "r") as f:
                data = json.load(f)
            
            regione = data["regione"]
            codice_web = data["id"]
            track_name = data["nome"]
            
            track_folder = os.path.join(region_folder, codice_web)
            os.makedirs(track_folder, exist_ok=True)
            
            img_urls = get_images(regione, codice_web)
            download_and_save_images(img_urls, track_folder)

if __name__ == "__main__":
    main()