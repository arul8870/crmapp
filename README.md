Features Implemented
Authentication (Mocked)
Simple login screen with email and password

Predefined login credentials:

Email: sam@gmail.com
Password: 12345

Email: arul@gmail.com
Password: 9876543210

Customer Management
List customers (name, email, phone, status)

Add, edit, delete customers

Search and filter customers

Customer data stored using local storage or a mock REST API

Messaging Module
WhatsApp-like 1:1 chat UI with customers

Real-time messaging simulated using wss://echo.websocket.org

Simulates message exchange (not actual user-to-user chat)

Chat bubble UI

Message timestamps and delivery indicators

VoIP Call Simulation
Simulated VoIP calls using flutter_webrtc

Call screen includes mute, speaker, and end call controls

Calls initiated from customer details

Call logs feature – Pending

Architecture & Design
State management: Bloc

Data stored in local storage (shared_preferences) and mock APIs

Messaging via mocked WebSocket chat using echo server

VoIP simulation only, not real-time peer-to-peer

Submission
APK: https://drive.google.com/file/d/1Vzdq8cuEPDCI7N0WV_oVnF7GVtbO1DQO/view?usp=drive_link

GitHub Repository: https://github.com/arul8870/crmapp/tree/development
