
import firebase_admin
from firebase_admin import credentials
from firebase_admin import messaging

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)
