from bs4 import BeautifulSoup
from tqdm import tqdm
import json
import codecs
import os
import unicodedata
import re

TRACK_CONTAINER_WIDTH = "720px"
DETAILS_TABLE_WIDTH = "650px"
IN_FOLDER_PATHS = ["lombardia_html","veneto_html","trentino_alto_adige_html"]
OUT_FOLDER_PATHS = ["lombardia_json","veneto_json","trentino_alto_adige_json"]


def extract_track_info(track_container, soup):
    data = extract_basic_info(track_container, soup)
    data.update(extract_circuit_details(track_container))
    data.update(extract_contact_info(track_container))
    data.update(extract_opening_hours(track_container))
    data.update(extract_gps_coordinates(track_container))
    return data

def extract_basic_info(track_container, soup):
    data = {}
    track_name = track_container.find('h2').text.strip()
    link_tag = soup.find('link', href=re.compile(r'dove=\d+'))
    if link_tag:
        href_attribute = link_tag['href']
        match = re.search(r'dove=(\d+)', href_attribute)
        if match:
            dove_number = match.group(1)
            data['id'] = dove_number
    region = track_container.find('a', class_='tre', text=True).text
    location = track_container.find('a', class_='tre', text=True).find_next('a').find_next('a').text
    motoclub = track_container.find('a', class_='tre', text=True).find_next('a').find_next('a').find_next('a').find_next('a').text
    data['nome'] = track_name
    data['regione'] = region
    data['posto'] = location
    data['motoclub'] = motoclub
    path = "tracks/{}/{}/".format(
    data['regione'].replace(' ', '_').lower(),
    data['id']
)
    data['foto'] = path
    return data

def extract_circuit_details(track_container):
    data = {}
    table = track_container.find('table', width=DETAILS_TABLE_WIDTH)
    rows = table.find_all('tr')
    for row in rows:
        cols = row.find_all('td')
        if len(cols) == 2:
            key = cols[0].text.strip()
            key = key.rstrip(':').rstrip('*')
            key = key.lower().replace(' ', '_')
            if key == 'strutture':
                values = [value.strip() for value in cols[1].stripped_strings]
                data['servizi'] = values
            elif key == 'omologazione':
                values = cols[1].text.strip().split(' - ')
                data[key] = values
            else:
                value = cols[1].text.strip()
                data[key] = value
    return data

def extract_contact_info(track_container):
    data = {}
    contact_table = track_container.find('table', class_='tre')
    if contact_table:    
        contact_rows = contact_table.find_all('tr')
        for contact_row in contact_rows:
            contact_cols = contact_row.find_all('td')
            if len(contact_cols) == 2:
                contact_key = contact_cols[0].text.strip().rstrip(':').rstrip('*')
                contact_values = contact_cols[1].find_all(text=True, recursive=False)
                if contact_key == 'sito web':
                    data['sito_web'] = contact_cols[1].find('a').get('href')
                    continue
                elif contact_key == 'e-mail':
                    data['email'] = contact_cols[1].find('a').get('href').replace('mailto:','')
                    continue
                contacts_list = [c.strip() for c in contact_values]
                data[contact_key] = contacts_list
    return data

def extract_opening_hours(track_container):
    data = {}
    orari_td = track_container.find('td', class_='tre_center')
    if orari_td:
        orari_list = [unicodedata.normalize('NFKD', line).encode('ascii', 'ignore').decode('utf-8').strip() for line in orari_td.stripped_strings]
        orari_text = ' '.join(orari_list)
        data['orari_e_info'] = orari_text
    return data

def extract_gps_coordinates(track_container):
    data = {}
    gpsCoordinates = []
    coords_td_elements = track_container.find_all('td', class_='tre_center')
    count = 0
    for coords_td in coords_td_elements:
        if "latitudine:" in coords_td.text and "longitudine:" in coords_td.text:
            count += 1
            coords_info = coords_td.text.strip().split('<br>')
            for info in coords_info:
                    latitude = info.replace("latitudine:", "").strip()
                    gpsCoordinates.append(codecs.decode(latitude, 'unicode_escape').encode('utf-8').decode('utf-8'))
            if count == 2:
                break
    gpsCoordinates[1] = gpsCoordinates[1].strip(' N').replace('E','').replace('longitudine:  ',', ')
    gpsCoordinates = gpsCoordinates[1].split(', ')
    data['latitudine'] = gpsCoordinates[0]
    data['longitudine'] = gpsCoordinates[1]
    return data

def process_files(in_folder_path, out_folder_path):
    os.makedirs(out_folder_path, exist_ok=True)
    filenames = [f for f in os.listdir(in_folder_path) if f.endswith(".html")]
    for filename in tqdm(filenames, desc="Processing files in {}".format(in_folder_path).replace('_html',' folder'), unit="file"):
        process_file(in_folder_path, out_folder_path, filename)

def process_file(in_folder_path, out_folder_path, filename):
    file_path = os.path.join(in_folder_path, filename)
    html = read_file(file_path)
    soup = BeautifulSoup(html, 'html.parser')
    track_container = soup.find('table', width=TRACK_CONTAINER_WIDTH)
    track_data = extract_track_info(track_container, soup)
    track_data['servizi'] = parse_servizi(track_data['servizi'])
    out_file_name = filename.replace('.html', '.json')
    out_file_path = os.path.join(out_folder_path, out_file_name)
    write_file(out_file_path, track_data)

def read_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        return file.read()

def write_file(file_path, data):
    with open(file_path, 'w') as outfile:
        json.dump(data, outfile, indent=4, ensure_ascii=False)

def parse_servizi(servizi):
    servizi_dict = {}
    for servizio in servizi:
        parts = servizio.split('[')
        if len(parts) == 2:
            servizi_dict[parts[0].strip().replace(' ','_')] = parts[1].strip(']')
    return servizi_dict

for in_folder_path, out_folder_path in zip(IN_FOLDER_PATHS, OUT_FOLDER_PATHS):
    process_files(in_folder_path, out_folder_path)
