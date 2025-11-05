// API Configuration
const API_ENDPOINT = "https://vpz8bm25dd.execute-api.us-east-1.amazonaws.com/chat";

// Quick action handler
function quickAction(action) {
    const messages = {
        'symptoms': "I'd like to discuss some symptoms I'm experiencing.",
        'appointment': "I need to schedule a medical appointment.",
        'medication': "I have questions about my medication.",
        'emergency': "I need emergency medical assistance right now!"
    };
    
    document.getElementById('userInput').value = messages[action];
    sendMessage();
}

// Handle Enter key press
function handleKeyPress(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
}

// Typing indicator
function showTypingIndicator() {
    const chatBox = document.getElementById("chatBox");
    const typingIndicator = document.createElement('div');
    typingIndicator.id = 'typingIndicator';
    typingIndicator.className = 'message bot-message';
    typingIndicator.innerHTML = `
        <div class="typing-dots">
            <span></span>
            <span></span>
            <span></span>
        </div>
    `;
    chatBox.appendChild(typingIndicator);
    chatBox.scrollTop = chatBox.scrollHeight;
}

// Remove typing indicator
function hideTypingIndicator() {
    const typingIndicator = document.getElementById('typingIndicator');
    if (typingIndicator) {
        typingIndicator.remove();
    }
}

// Enhanced sendMessage function
async function sendMessage() {
    const inputElement = document.getElementById("userInput");
    const input = inputElement.value.trim();
    const chatBox = document.getElementById("chatBox");

    if (!input) return;

    // Add user message
    const userMessage = document.createElement('div');
    userMessage.className = 'message user-message';
    userMessage.innerHTML = `<strong>You:</strong> ${input}`;
    chatBox.appendChild(userMessage);

    // Clear input and show typing indicator
    inputElement.value = "";
    showTypingIndicator();
    chatBox.scrollTop = chatBox.scrollHeight;

    try {
        const response = await fetch(API_ENDPOINT, {
            method: "POST",
            headers: { 
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ 
                message: input,
                timestamp: new Date().toISOString()
            })
        });

        hideTypingIndicator();

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        
        // Add bot response
        const botMessage = document.createElement('div');
        botMessage.className = 'message bot-message';
        botMessage.innerHTML = `<strong>HealthAI:</strong> ${data.reply || "I'm here to help with your health concerns."}`;
        chatBox.appendChild(botMessage);

    } catch (error) {
        console.error("API Error:", error);
        hideTypingIndicator();
        
        const errorMessage = document.createElement('div');
        errorMessage.className = 'message bot-message';
        errorMessage.innerHTML = `
            <strong><i class="fas fa-exclamation-circle"></i> HealthAI:</strong> 
            I'm currently experiencing technical difficulties. Please try again in a moment or contact support if the issue persists.
        `;
        chatBox.appendChild(errorMessage);
    } finally {
        chatBox.scrollTop = chatBox.scrollHeight;
    }
}

// Add sample responses for demo purposes
function addSampleResponse(message) {
    const chatBox = document.getElementById("chatBox");
    const botMessage = document.createElement('div');
    botMessage.className = 'message bot-message';
    
    let response = "";
    
    if (message.includes("symptom")) {
        response = "I understand you're experiencing symptoms. Can you tell me more about what you're feeling? Please describe the severity, duration, and any other details that might help me understand your condition better.";
    } else if (message.includes("appointment")) {
        response = "I can help you schedule an appointment. What type of specialist are you looking for? (Primary Care, Cardiology, Dermatology, etc.)";
    } else if (message.includes("medication")) {
        response = "I can provide information about medications. Are you asking about side effects, dosage, interactions, or something else specific?";
    } else if (message.includes("emergency")) {
        response = "<strong style='color: #c53030;'⚠️ EMERGENCY NOTICE:</strong> If this is a medical emergency, please call your local emergency services immediately (911 in the US). I am an AI assistant and cannot provide emergency medical care.";
    } else if (message.includes("headache")) {
        response = "Headaches can have various causes. Have you experienced any head injury recently? How long has the headache lasted? Is it accompanied by fever, vision changes, or neck stiffness?";
    } else {
        response = "Thank you for sharing. I'm here to help with your health concerns. Could you provide more details so I can better assist you?";
    }
    
    botMessage.innerHTML = `<strong>HealthAI:</strong> ${response}`;
    chatBox.appendChild(botMessage);
    chatBox.scrollTop = chatBox.scrollHeight;
}

// Initialize chat with welcome message
document.addEventListener('DOMContentLoaded', function() {
    console.log('Healthcare-Chatbot.AI initialized successfully!');
    
    // Add event listener for demo mode (remove when connecting to real API)
    document.getElementById('userInput').addEventListener('input', function() {
        // This is just for demo purposes - remove when connecting to real API
        if (this.value.toLowerCase().includes('demo')) {
            setTimeout(() => {
                addSampleResponse(this.value);
                this.value = "";
            }, 1000);
        }
    });
});