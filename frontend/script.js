async function sendMessage() {
    const message = document.getElementById("userInput").value;
    
    const response = await fetch("YOUR_API_GATEWAY_URL", {
        method: "POST",
        body: JSON.stringify({ message }),
    });
    
    const data = await response.json();

    document.getElementById("chatBox").innerHTML += `<p><b>You:</b> ${message}</p>`;
    document.getElementById("chatBox").innerHTML += `<p><b>Bot:</b> ${data.reply}</p>`;
}
