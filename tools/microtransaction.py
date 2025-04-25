from flask import Flask, request
from urllib.parse import unquote_plus

app = Flask(__name__)

valid_keys = {"TEST123", "ABC456"}  # accepted transaction codes

@app.route('/verify', methods=['POST'])
def verify():
    # try to get the key from a form field first
    key = request.form.get('key')
    
    if not key:
        raw = request.get_data(as_text=True)
        if raw.startswith("key="):
            key = unquote_plus(raw[4:])
    
    # final check
    if key in valid_keys:
        return "IT WORKED******"
    else:
        return "invalid key, please try again"

if __name__ == "__main__":
    app.run(port=5000)
