#codice usato solo per importare diversi file all'interno di una collezione di firestore

import os
import json
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate('/home/eliagatti/Downloads/crosstrack-italia-firebase-adminsdk-2mxiw-c9aa1ad368.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

def upload_files_in_folder(folder_path, collection_name):
    batch = db.batch()
    collection_ref = db.collection(collection_name)

    for filename in os.listdir(folder_path):
        if filename.endswith('.json'):
            file_path = os.path.join(folder_path, filename)
            with open(file_path, 'r') as file:
                data = json.load(file)

            doc_ref = collection_ref.document()
            batch.set(doc_ref, data)

    batch.commit()

# Paths to your folders and collection names
folders = ['veneto_json', 'lombardia_json', 'trentino_alto_adige_json']
collection_names = ['tracks', 'tracks', 'tracks']

for folder, collection_name in zip(folders, collection_names):
    folder_path = os.path.join('/home/eliagatti/Desktop/University/prog_app/crosstrack_italia/assets/tracks', folder)
    upload_files_in_folder(folder_path, collection_name)
