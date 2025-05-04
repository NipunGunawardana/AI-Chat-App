
# 💬 AI-Driven Cross-Platform Chat Application

A powerful, cross-platform chat app developed with **Flutter** on the frontend and a **Python (Flask)** backend. This system leverages **LangChain**, **OpenAI**, **MySQL**, and **CSV/structured data** to provide real-time, AI-powered responses by converting natural language messages into SQL queries.

---

## 📌 Summary

This project is an intelligent chat platform that bridges natural language and data retrieval through AI. Users can interact in a familiar chat interface while the backend translates queries using **LangChain's NLP-to-SQL** and responds with contextual, real-time information.

---

## 🚀 Features

- ✨ **Cross-platform UI**: Built with Flutter for Android, iOS.
- ⚙️ **Python Flask API**: Lightweight backend to manage AI integration and data access.
- 🤖 **LangChain + OpenAI**: Natural Language Processing to understand and interpret user intent.
- 🧠 **NLP-to-SQL**: Translates user questions into SQL queries for real-time data fetching.
- 🗃️ **Data Source Integration**:
  - MySQL for structured databases
  - CSV and other flat files for dynamic querying
- 🔄 Real-time AI response simulation in chat format
- 📊 Intelligent context handling for multi-turn conversations

---

## 🧰 Tech Stack

| Layer        | Technology                         |
|--------------|-------------------------------------|
| Frontend     | Flutter (Dart)                     |
| Backend      | Python Flask                       |
| AI Layer     | LangChain, OpenAI API (GPT-4)      |
| Database     | MySQL, CSV                         |
| NLP Engine   | LangChain SQLChain / SQLDatabaseChain |

---

## ⚙️ Setup Instructions

### 🖥️ Backend (Flask + LangChain)

1. **Clone the repository:**

```bash
git clone https://github.com/your-username/chat-app-ai.git
cd chat-app-ai/backend
```

2. **Create a virtual environment & install dependencies:**

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

3. **Set environment variables:**

```bash
export OPENAI_API_KEY=your_openai_key
```

4. **Run the backend:**

```bash
python chatApp.py
```

---

### 📱 Frontend (Flutter)

1. **Navigate to frontend:**

```bash
cd flutter_app
```

2. **Install dependencies:**

```bash
flutter pub get
```

3. **Run the app:**

```bash
flutter run
```

---

## 💡 How It Works

1. User enters a message like:  
   _"How many active customers signed up last month?"_

2. The message is sent to the Flask backend via REST API.

3. LangChain uses OpenAI to interpret the intent → converts to SQL:
   ```sql
   SELECT COUNT(*) FROM customers WHERE signup_date >= '2025-04-01';
   ```

4. Backend executes the query on MySQL (or loads CSV and parses).

5. Response is returned to the Flutter app in chat format:
   _"There were 234 active customer signups in April."_

---

## 📈 Future Enhancements

- Multi-user support with authentication
- Chat history and personalization
- Voice input and response
- Admin dashboard with query analytics
- Dockerized deployment

---

## 👨‍💻 Author

**Nipun Gunawardana**  
Mobile Engineer.  
[LinkedIn](https://www.linkedin.com/in/nipungunawardana/) • [GitHub](https://github.com/NipunGunawardana)
