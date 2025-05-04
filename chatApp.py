from dotenv import load_dotenv
from langchain.llms import OpenAI
from langchain.utilities import SQLDatabase
from langchain_experimental.sql import SQLDatabaseChain
from transformers import AutoModelForCausalLM, AutoTokenizer
import os
import json
from flask import Flask, jsonify, request

app = Flask(__name__)

load_dotenv()

# Add your OpenAI API key
openai_api_key = "KEY"
os.environ["OPENAI_API_KEY"] = openai_api_key

# Define a list of database URIs
database_uris = [
    # "sqlite:///academy/academy.db",
    # "postgresql://user:password@localhost:5432/database1",
  
    "mysql://root:password@localhost:3306/whole_db",
    # Add more database URIs as needed
]

# Initialize variables to store database connection and language model
db = None
llm = None
db_chain=None
# Function to initialize database connection and language model
def initialize():
    global db, llm,db_chain
    for db_uri in database_uris:
        db = SQLDatabase.from_uri(db_uri)
        llm = OpenAI(api_key=os.getenv("OPENAI_API_KEY"), temperature=0)
        db_chain = SQLDatabaseChain(llm=llm, database=db, verbose=True)

        break  # Only connect to the first database URI for now

# Define a route for handling POST requests
@app.route('/query', methods=['POST'])
def query_database():
    # Check if database and language model are initialized
    if db is None or llm is None:
        initialize()

    # Extract the query string from the request parameters
    query = request.json.get('query')

    # Run the query using SQLDatabaseChain
    result = db_chain.run(query)

    # Convert the result to a JSON string
    json_response = json.dumps(result)

    return {'response':result}

if __name__ == '__main__':
     app.run(host='localhost Ip Address', debug=True)
