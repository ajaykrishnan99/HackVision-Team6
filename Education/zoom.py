import jwt
import requests
import json
from time import time


class Zoom:
    """
    Args:
        topic: The topic/heading of the meeting.
        timezone: The timezone of the indicated start time.
        agenda: The meeting agenda. No more than 2,000 characters.
    """

    def __init__(self, topic, start_time, duration, timezone, agenda):
        # API key and your API secret for Zoom API
        self.API_KEY = 'ukrD8PsUQHajTjVi6A9Ajg'
        self.API_SEC = 'rNP45IkYE61CWyZvtoAcyk7lqemMjpOhxemq'
        self._topic = topic
        self._start_time = start_time
        self._duration = duration
        self._timezone = timezone
        self._agenda = agenda
        self._meetingURL = None
        self._meetingPassword = None

    def topic(self):
        return self._topic

    def start_time(self):
        return self._start_time

    def duration(self):
        return self._duration

    def timezone(self):
        return self._timezone

    def agenda(self):
        return self._agenda

    def meetingURL(self, url=None):
        if url: self._meetingURL = url
        return self._meetingURL

    def meetingPassword(self, password=None):
        if password: self._meetingPassword = password
        return self._meetingPassword

    # create a function to generate a token
    # using the pyjwt library
    def generateToken(self):
        token = jwt.encode(

            # Create a payload of the token containing
            # API Key & expiration time
            {'iss': self.API_KEY, 'exp': time() + 5000},

            # Secret used to generate token signature
            self.API_SEC,

            # Specify the hashing alg
            algorithm='HS256'
        )
        return token

    # create json data for post requests
    def generateDetails(self):
        meetingdetails = {"topic": self._topic,
                          "type": 2,
                          "start_time": self._start_time,
                          "duration": self._duration,
                          "timezone": self._timezone,
                          "default_password": "true",
                          "agenda": self._agenda,
                          "settings": {"host_video": "true",
                                       "participant_video": "true",
                                       "join_before_host": "False",
                                       "mute_upon_entry": "False",
                                       "watermark": "true",
                                       "audio": "voip",
                                       "auto_recording": "none"
                                       }
                          }

        return meetingdetails

    # send a request with headers including
    # a token and meeting details
    def createMeeting(self):
        headers = {'authorization': 'Bearer %s' % self.generateToken(),
                   'content-type': 'application/json'}
        r = requests.post(
            f'https://api.zoom.us/v2/users/me/meetings',
            headers=headers, data=json.dumps(self.generateDetails()))

        print("\n creating zoom meeting ... \n")
        # print(r.text)
        # converting the output into json and extracting the details
        y = json.loads(r.text)
        self._meetingURL = y["join_url"]
        self._meetingPassword = y["password"]

        print(
            f'\n here is your zoom meeting link {self._meetingURL} and your \
            password: "{self._meetingPassword}"\n')
