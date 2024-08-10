from flask import Flask, request, jsonify
import requests
from bs4 import BeautifulSoup
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/check_barcode', methods=['POST'])
def check_barcode():
    data = request.json
    barcode = data['barcode']

    # Perform a Google search for the barcode
    search_url = f"https://www.google.com/search?q={barcode}"
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"}
    response = requests.get(search_url, headers=headers)
    soup = BeautifulSoup(response.text, 'html.parser')

    # Collect search results
    search_results = []
    for g in soup.find_all('div', class_='BVG0Nb'):
        link = g.find('a')['href']
        search_results.append(link)

    # Check if any of the search results contain known keywords for fake medicines
    known_fake_keywords = ["fake", "counterfeit", "scam"]
    is_fake = any(keyword in ' '.join(search_results).lower() for keyword in known_fake_keywords)

    return jsonify({"isFake": is_fake})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
