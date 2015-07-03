---
layout: post
title: "Verifying X509 Certificate Chain of Trust in Python"
date: 2015-06-18 17:07
comments: true
categories: Python, X509, Certificate, Security
---

Executing network spoofing and man in the middle attacks have become easier than ever. This is more of an issue if a client has an open server for you to send push notifications, since the open port can be detected by methods such as port scanning. As such, it is important to sign data, and ship the signature and metadata about verifying the data against the signature along with the data itself. This provides a way for the client to verify that the data received is unaltered, from the correct sender and indented for the correct recipient. Python's pyopenssl has a handy method called [verify](http://pyopenssl.readthedocs.org/en/latest/api/crypto.html?highlight=verify#OpenSSL.crypto.verify) for checking the authenticity of data.

```python
OpenSSL.crypto.verify(certificate, signature, data, digest)
```

The problem then becomes how to provide the certificate while retaining the flexibility necessary to update the certificate without clients needing to modify their certificate stores every time. Providing a url that can be used to download the cert provides that but leaves the door open for the same kind of attacks.

Therefore, clients will need to ensure that the downloaded certificate is trustworthy before using it to verify the authenticity of a message. The openssl module on the terminal has a [verify method](https://www.openssl.org/docs/apps/verify.html) that can be used to verify the certificate against a chain of trusted certificates, going all the way back to the root CA. The builtin ssl module has create_default_context(), which can build a certificate chain while creating a new SSLContext. However, it does not expose that functionality for adhoc post processing when you are not opening new connections. 

pyopenssl provides some very handy abstractions for exactly this purpose:

- [X509Store](http://pyopenssl.readthedocs.org/en/latest/api/crypto.html#x509store-objects): The chain of certificates you have chosen to trust going back to root Certificate Authority

 - [X509StoreContext](http://pyopenssl.readthedocs.org/en/latest/api/crypto.html#x509storecontext-objects) - Takes in a X509Store and a new certificate which you can now validate against your store by calling verify_certificate. It raises exceptions if the intermediate or root CA is missing in the chain or the certificate is invalid.

 The full example of verifying a downloaded certificate against a trust chain is given below

```python
import requests
from OpenSSL import crypto

def _verify_certificate_chain(cert_url, trusted_certs):

    # Download the certificate from the url and load the certificate
    cert_str = requests.get(cert_url)
    certificate = crypto.load_certificate(crypto.FILETYPE_PEM, str(cert_str.text))

    #Create a certificate store and add your trusted certs
    try:
        store = crypto.X509Store()

        # Assuming the certificates are in PEM format in a trusted_certs list
        for _cert in trusted_certs:
            store.add_cert(_cert)

        # Create a certificate context using the store and the downloaded certificate
        store_ctx = crypto.X509StoreContext(store, certificate)

        # Verify the certificate, returns None if it can validate the certificate
        store_ctx.verify_certificate()

        return True

    except Exception as e:
        print(e)
        return False
```

Using this can be really useful for client libaries where you cannot rely on the system to provide the certificates, so you can ship your trust chain along with the library. There are also other useful abstractions in the pyopenssl library for some useful checks against the certificate. get_subject() provides information about the certificate such as common name, has_expired() which checks if the certificate is within valid time range and other features such as blacklisting potentially compromised certificates are possible. Thus pyopenssl is really handy when you need ssl abstractions beyond the standard library while not needing to execute the openssl shell calls via a subprocess.
