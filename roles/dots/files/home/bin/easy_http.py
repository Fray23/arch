import uuid
import random
import os
import sys
import requests
import json
import pickle

methods = {
    'POST': requests.post,
    'GET': requests.get,
    'PUT': requests.put,
    'PATCH': requests.patch
}

headers = {}

def string_to_header(s):
    key, value = s.split(": ")
    headers[key] = value.strip()

def read_default_headers(default_headers_file):
    if os.path.isfile(default_headers_file):
        with open(default_headers_file, 'r') as file:
            headers.update(json.load(file))

def save_cookies(requests_cookiejar, filename):
    if os.path.exists(filename):
        with open(filename, 'rb') as f:
            try:
                existing_cookies = pickle.load(f)
            except EOFError:
                existing_cookies = requests_cookiejar
    else:
        existing_cookies = requests_cookiejar

    for cookie in requests_cookiejar:
        existing_cookies.set_cookie(cookie)

    with open(filename, 'wb') as f:
        pickle.dump(existing_cookies, f)

def load_cookies(filename):
    try:
        with open(filename, 'rb') as f:
            return pickle.load(f)
    except FileNotFoundError:
        return None

def set_vars(body):
    for key, value in body.items():
        if isinstance(value, str):
            value = value.replace('{{hex}}', uuid.uuid4().hex)
            value = value.replace('{{uuid}}', str(uuid.uuid4()))
            if ':code:' in value:
                value = value.replace(':code:', '')
                value = eval(f"{value}")
                print(value)

            body[key] = str(value)

        if isinstance(value, dict):
            set_vars(value)

    return body

def send_req(method, url, body_txt):
    func = methods[method]
    cookie = load_cookies(session_path)

    body = json.loads(body_txt) if '{' in body_txt else {}
    body = set_vars(body)

    if method == 'GET':
        resp = func(url, headers=headers, params=body, cookies=cookie)
    else:
        resp = func(url, headers=headers, json=body, cookies=cookie)

    print(f"// status_code {'':<18} {resp.status_code}")

    for header_name, header_value in resp.headers.items():
        print(f"// {header_name:<30} {header_value}")
    try:
        resp_content = resp.json()
        print(json.dumps(resp_content, indent=2))
    except ValueError:
        print(resp.content)

    save_cookies(resp.cookies, session_path)


if len(sys.argv) != 3:
    print("Usage: python script.py <file_path> <project_path>")
    sys.exit(1)

file_path = sys.argv[1]
project_path = sys.argv[2]

session_path = os.path.join(project_path, 'pysession')
default_headers = os.path.join(project_path, 'headers.json')

url = ''
body_txt = ""
_body_start = False

try:
    with open(file_path) as file:
        lines = file.readlines()
        url = lines[0]

        for line in lines[1:]:
            line = line.strip()
            if not line:
                continue
            if (_body_start or '{' in line) and not line.startswith('#'):
                _body_start = True
                body_txt += line
            elif line.startswith('#'):
                break
            elif line:
                string_to_header(line.strip())

        method, url = url.strip('\n').split(' ')
except Exception as e:
    print('got error when read body/headrs')
    print(e)

try:
    read_default_headers(default_headers)
except Exception as e:
    print('got error when read default headrs')
    print(e)

try:
    send_req(method, url, body_txt)
except Exception as e:
    print('got error when send request')
    print(e)

