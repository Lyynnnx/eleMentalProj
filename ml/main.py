# Docs https://elevenlabs.io/docs/api-reference/text-to-speech
import openai
import os
import sys
import json
import config
from elevenlabs import save
from elevenlabs.client import ElevenLabs
import os
import requests
import sseclient
import time


# def load_api_key(path):
#     with open(path, "r") as file:
#         return file.read().strip()

vioces = {
    "woman_1": "XB0fDUnXU5powFXDhCwa",
    "woman_2":"21m00Tcm4TlvDq8ikWAM",
    "kid": "AZnzlk1XvdvUeBnXmlld",
    "man": "N2lVS1w4EtoT3dr4eOWO",
    "sad_man": "5ztkbGZ95SpVJ8MBMeam",
    "mad_man": "Mg1264PmwVoIedxsF9nu",
}

subscribe_url = "https://troll-engaged-cougar.ngrok-free.app/api/audioReceiver/subscribe"
spam_url = "https://troll-engaged-cougar.ngrok-free.app/api/audio/getTranscriptedTextWithoutToken"

def text_to_speech(text_to_talk, stability, voice_id_): # stability: 1 - depresed, 0+ - energetic
    if os.path.exists("data/answer.mp3"):
        os.remove("data/answer.mp3")

    client = ElevenLabs(api_key=config.eleven_labs_api_key)
    audio = client.text_to_speech.convert(
        voice_id=voice_id_,
        optimize_streaming_latency=1,
        model_id="eleven_multilingual_v2",
        voice_settings={
            "stability": stability, # important: 1 = depresed(monoton), << 1 = emotional
            "similarity_boost": 0.9 # idk
        },
        text=text_to_talk,
    )

    save(audio, "data/answer.mp3")

class PatientSimulator:
    def __init__(self, patient_data_path):
        openai.api_key = config.openai_api_key
        self.model = "gpt-4o-mini"
        self.patient_profile = {}
        self.conversation = []
        
        # Correct JSON loading
        try:
            with open(patient_data_path, 'r') as file:
                patient_data = json.load(file)
        except json.JSONDecodeError as e:
            raise ValueError(f"Invalid JSON format in patient data file: {e}")
        except FileNotFoundError:
            raise FileNotFoundError(f"Patient data file not found: {patient_data_path}")
        
        self.stability = patient_data['stability']
        self.voice_id = patient_data['voice_id']
        
        keys_to_exclude = {"voice_id", "stability"}
        filtered_patient_data = {key: value for key, value in patient_data.items() if key not in keys_to_exclude}
        system_prompt = f"""
        You are assisting in a role play for psychotherapy students. You are simulating a patient with {patient_data['diagnosis']}. The the user will be playing the therapist. Please respond in a realistic way.
        
        The patient has the following characteristics:

        {filtered_patient_data}
        """

        self.conversation = [{"role": "system", "content": system_prompt}]
        print("\nPatient simulation ready. Start conversation.")


    def chat(self):
        print("\nType 'exit' to quit, 'reset' to create new patient, 'profile' to view current profile")

        current_text = ""
        while True:
            try:

                try:
                    time.sleep(2)
                    # get request
                    response = requests.get(spam_url)

                    # check answer status
                    if response.status_code == 200:
                        # get text from response
                        json_input = response.json()
                        user_input = json_input['transcription']

                        if user_input == current_text:
                            print("Old text from API:", user_input)
                            raise Exception("Got old value. Wait 2 seconds") 
                        else:
                            print("New text recieved from API:", user_input)
                            current_text = user_input
                    else:
                        print(f"Error : {response.status_code} - {response.reason}")
                except requests.exceptions.RequestException as e:
                    print(f"Error happens during the request: {e}")



                # SSE part (doesnt work corectly)
                # try:
                #     response = requests.get(url, stream=True, timeout=60)  # Set timeout to handle retries
                #     client = sseclient.SSEClient(response)

                #     print("Connected to SSE. Listening for updates...")
                #     for event in client.events():
                #         print(f"Received event: {event.event}")
                #         print(f"Event data: {event.data}")

                #         # You can fetch the latest transcription here if needed
                #         if event.event == "update":
                #             fetch_latest_transcription()

                # except requests.exceptions.RequestException as e:
                #     print(f"Connection error: {e}")

                # def fetch_latest_transcription():
                #     try:
                #         response = requests.get("https://troll-engaged-cougar.ngrok-free.app/api/audio/getTranscriptedTextWithoutToken")
                #         if response.status_code == 200:
                #             print(f"Latest Transcription: {response.json()}")
                #         else:
                #             print(f"Failed to fetch transcription: {response.status_code}")
                #     except Exception as e:
                #         print(f"Error while fetching transcription: {e}")



                

                # SSE varian 2 (dont work correctly)
                #     response = requests.get(url, stream=True)  # Устанавливаем постоянное соединение
                #     client = sseclient.SSEClient(response)    # Создаем SSE-клиента

                #     print("Подключено к SSE. Ожидание обновлений...")
                #     for event in client.events():
                #         print(f"Получено событие: {event.event}")
                #         print(f"Данные события: {event.data}")

                #         data = json.loads(event.data)

                # except requests.exceptions.RequestException as e:
                #     print(f"Ошибка соединения: {e}")




                # user_input = input("\nTherapist: ").strip()
                if user_input.lower() == 'exit':
                    break
                elif user_input.lower() == 'reset':
                    self.setup_patient()
                    continue
                elif user_input.lower() == 'profile':
                    print("\nCurrent patient profile:")
                    print(self.conversation[0]["content"])
                    continue

                self.conversation.append({"role": "user", "content": user_input})
                response = openai.chat.completions.create(
                    model=self.model,
                    messages=self.conversation,
                    temperature=0.7
                )
                patient_response = response.choices[0].message.content

                
                text_to_speech(patient_response, stability=self.stability, voice_id_=self.voice_id)

                url_get = "https://troll-engaged-cougar.ngrok-free.app/api/audioReceiver/sendAudio"  # url to send audio

                # audio file path
                file_path = "data/answer.mp3"

                try:
                    # open file in binary mode
                    with open(file_path, "rb") as audio_file:
                        # create object of files
                        files = {"audioFile": ("answer.mp3", audio_file, "audio/mpeg")}
                        
                        # send request
                        response = requests.post(url_get, files=files)
                        
                        # check response
                        if response.status_code == 200:
                            print("File succsesfully send!")
                            print("Server response:", response.json())
                        else:
                            print(f"Send error: {response.status_code} - {response.text}")
                except FileNotFoundError:
                    print(f"file {file_path} not found.")
                except requests.exceptions.RequestException as e:
                    print(f"Network error: {e}")


                # try:
                #     with open(file_path, 'rb') as f:
                #         files = {'audioFile': f}
                #         response = requests.post(url, files=files)
                #         print(response.json())
                # except FileNotFoundError:
                #     print("File not found:", file_path)
                # except Exception as e:
                #     print("An error occurred:", str(e))

                print(f"\nPatient: {patient_response}")
                with open('data/output.json', 'w', encoding='utf-8') as f:
                    json.dump(self.conversation, f, indent=2, ensure_ascii=False)
                print("File answer.mp3 send to the server")
                self.conversation.append({"role": "assistant", "content": patient_response})
            except (KeyboardInterrupt, EOFError):
                break
            except Exception as e:
                print(f"\nError: {str(e)}")

if __name__ == "__main__":
    # API_KEY_PATH = "/Users/piuskern/psybot/api-keys/api-key-openai.txt"
    # PATIENT_DATA_PATH = "/Users/piuskern/psybot/data/patients/johnny.json"
    PATIENT_DATA_PATH = os.path.abspath("data/johnny.json")
    
    try:
        simulator = PatientSimulator(PATIENT_DATA_PATH)
        simulator.chat()
    except Exception as e:
        print(f"Error initializing simulator: {e}")
        sys.exit(1)