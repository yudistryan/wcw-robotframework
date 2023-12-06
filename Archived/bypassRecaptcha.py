from pypasser import reCaptchaV3
import re
import requests
from requests.utils import dict_from_cookiejar

def login(email: str, password: str):

    base_headers = {
                'user-agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
                'Content-Type':'application/json',
                'referer':'https://staging.wallet-codes.com/',
        }
    
    # Get CSRF tokens
    response = requests.get('https://middleware-staging.wallet-codes.com/auth/login', headers = base_headers)
    language = re.findall(r'language_id=(.*?);',response.headers.get('Set-Cookie'))

    # Get Recaptcha Response (Bypass via PyPasser)
    recaptcha_response = reCaptchaV3(
        "https://www.google.com/recaptcha/api2/anchor?ar=1&k=6Ld6R5gUAAAAAA17dajc9vY0tzZVe-UbWS60teMg&co=aHR0cHM6Ly9zdGFnaW5nLndhbGxldC1jb2Rlcy5jb206NDQz&hl=en&type=image&v=iRvKkcsnpNcOYYwhqaQxPITz&theme=light&size=normal&badge=bottomright&cb=44rna77hmsp3"
        )
    
    # Send Login request
    payload = {
        'language_id': language,
        'email': email,
        'password': password,
        'g-recaptcha-response': recaptcha_response,

    }
    base_headers.update({'cookie':f'language_id={language};'})
    response = requests.post('https://middleware-staging.wallet-codes.com/auth/login', data=payload, headers=base_headers).json()
    
    if response['message'] == "logined":
        print('Logged in successfully.')
    
    elif response['message'] == "password":
        print('Wrong password.')

if __name__ == '__main__':
    login('yudis.yufanria@wallet-codes.com','Hello12!')