import requests as req
import json
import oneDriveResources as res

def refreshSignIn():
    url = res.authUrl
    payload = 'grant_type=refresh_token&client_id='+res.clientId+'&redirect_uri='+res.redirectURI+'&client_secret='+res.clientSecret+'&refresh_token='+res.refreshToken
    headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': 'buid=0.AXIA9r4KTXMm6EeQ7hG-a_HOyWzJG2WVyDZCqalTUKOzKzzDAAA.AQABAAEAAAAmoFfGtYxvRrNriQdPKIZ-dLtctMc5La0HcfIPPerdKtPihbILIVSZwsRTJxlILwun5BkPUo2XfczO47t9Ai4j4ovZqA0QCobinI77STa7r5f_LjiOj4hVfnnP0nH67RAgAA; esctx=PAQABAAEAAAAmoFfGtYxvRrNriQdPKIZ-6EJAuq5PeSoVPVe8Z6JswG7ulQvr45z1f8uJQQmETahL9xOrM2LDrF4F6sacuqCI5VQ0UQwtF09lLwsttch25ArzbUT77eQX95QFu22X3mwz4io8PjnWeNRGBLcBe5aE5lrwpYpPa-3OvdTsxpIEYNvRvu0XiNERJRTLJJoZV9sgAA; esctx-3n8WT4vILo=AQABAAEAAAAmoFfGtYxvRrNriQdPKIZ-4O76ufkYj2o9QkJLlPK8_-4xOX03ljCsp9o7K0gdmGHnAMCumj1B3izSwbkFaKefBO3OlqKORwRtwHVseolgvlz7LWyVH9ASOWIQ4rVbIj9iM97IOLCvqUXBjzaNsKxIUFD6cO9H63TBi6V06aow9iAA; esctx-AYR6GvivK0=AQABAAEAAAAmoFfGtYxvRrNriQdPKIZ-o1RLDd_Io7YW9Ygk_Ugz1vs-E3hhWZGqY_WavS69daVm3JBsEpJT4cpSz7gtvRxBya86Ho3-RvADPeHKKlK0IjyRnBv-z_AV1qDygEL_31_EcKeSpq2GwoMkmAQmTOyonf88fczttLza_jwdohOD9SAA; esctx-PN2t82vqpAE=AQABAAEAAAAmoFfGtYxvRrNriQdPKIZ-kLkaNLsyD6nEsiZtj1VdUclAg-lfPMvKW9ni1WxUZ3hgFKlLtmU0vkgIofJS1qGjYAbBy3hKuEbtchpzMUN3JqhwrFqezGH6x-OGIxubSXJ_on6CTgCCbxI04JN0N2YmZa1EahzYtbfc8_N-SgmGXCAA; esctx-RnSgugzfLyA=AQABAAEAAAAmoFfGtYxvRrNriQdPKIZ-na5dxu1iIwrZ_3kIj2smd1xFHectUcBoRVHmEqBGVslB7QaL2MrsLEnFBULQNl8TIAuM6OfrjMyRdk65Bk9ERZDCqhrXm09xDnJWd1mZln7RtDsErv30nPzfNYrkO-wn9zaWDI8gIgoXO54uUEKUbCAA; esctx-YMRAJLKoCj0=AQABAAEAAAAmoFfGtYxvRrNriQdPKIZ-T3MFq3aYtbrJdjQ_g4_N4LhHcfQO8c5YxjwtIAnCQ9V34nShb7JqMMeH-lXCHS2IphK-raUNmYDWRoUn6xW4dTTsRjEfBXoH6x5rbULCe_fsfHPi_Qr93usjmWyytsW_uK1ymMx4KrzCytXO2C0qWSAA; esctx-yH5pUuoCPMI=AQABAAEAAAAmoFfGtYxvRrNriQdPKIZ-_mXx85J7R9ebbfci4mLUfbS1Stdtk9NuxAhTcSgsZVmRKKCd6dEP7ofDWVHrNyIxfVaaJ0JhqQC2xSPKnsM6ujFpOW0O3xpGVII8HqFJhkH-rVT6On0DeJGduqZXiXlPj3YRcZ3iZeOtGXIuQ0wVGyAA; fpc=AsGXH7eo0a5AgZgXJoYcoW_Tyx7MAQAAAKKc-NwOAAAA; stsservicecookie=estsfd; x-ms-gateway-slice=estsfd'
    }
    response = req.request("POST", url, headers=headers, data=payload)
    print(json.dumps(response.json(), indent=4))


def main():
    refreshSignIn()

if __name__ == "__main__":
    main()