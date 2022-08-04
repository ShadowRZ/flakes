import sys
import json

file = sys.argv[1]

def make_license_str(license_name, license_url):
    if license_url:
        return f'[[{license_url}][{license_name}]]'
    else:
        return license_name

with open(file) as f:
    data = json.load(f)
    # Print package infomation
    for attr, value in data.items():
        meta = value['meta']
        print(f'** ={attr}=\n')
        description = meta.get('description') or '(No Description)'
        print(f'{description}\n')
        version = value.get('version')
        if version:
            print(f'Version: ={version}=\n')
        homepage = meta.get('homepage')
        if homepage:
            print(f'[[{homepage}][~> Homepage]]')
        license_ = meta.get('license')
        unfree = meta.get('unfree')
        if license_:
            license_url = license_.get('url')
            license_name = license_.get('fullName')
            license_str = make_license_str(license_name, license_url)
            print(f'License: {license_str}\n')
            if unfree is not None:
                if unfree:
                    print(f'**This package has an unfree license: {license_str}.**')
