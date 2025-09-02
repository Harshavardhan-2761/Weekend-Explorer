<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Weekend Explorer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 20px; }
        #places { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; }
        .card { background: #fff; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); padding: 16px; }
        .card img { width: 100%; height: 160px; object-fit: cover; border-radius: 8px; }
        .title { font-size: 18px; font-weight: bold; margin: 10px 0; }
        .price { color: #28a745; font-weight: bold; }
        .btn { display: inline-block; margin-top: 10px; padding: 8px 12px; background: #007bff; color: #fff; border-radius: 6px; text-decoration: none; }
        
        /* Sticky filter bar */
        #filterBar {
            position: sticky;
            top: 0;
            background: #fff;
            padding: 10px;
            display: flex;
            gap: 10px;
            border-bottom: 2px solid #eee;
            z-index: 1000;
        }
        #filterBar button {
            padding: 8px 14px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            background: #f0f0f0;
            font-size: 14px;
            transition: 0.3s;
        }
        #filterBar button:hover {
            background: #007bff;
            color: #fff;
        }
    </style>
</head>
<body>
<h1>🌍 Weekend Explorer</h1>

<!-- 🔍 Search bar -->
<div style="margin-bottom:20px;">
    <input type="text" id="searchBox" placeholder="Search a place..." style="padding:8px; width:250px;">
    <button onclick="searchPlaces()" class="btn">Search</button>
</div>

<div id="filterBar">
    <button onclick="setFilter('restaurant')">🍽 Restaurants</button>
    <button onclick="setFilter('hotel')">🏨 Hotels</button>
    <button onclick="setFilter('attraction')">🎡 Attractions</button>
</div>

<div id="places">Loading nearby places...</div>

<div id="chatbot" style="position:fixed; bottom:20px; right:20px; background:#fff; border:1px solid #ccc; border-radius:12px; width:320px; display:none; padding:10px;">
    <h4>🤖 Weekend Bot</h4>
    <div id="chatContent" style="max-height:240px; overflow-y:auto; margin-bottom:10px;"></div>
    <input type="text" id="chatInput" placeholder="Type here..." style="width:75%; padding:6px;">
    <button onclick="sendMessage()" class="btn">Send</button>
    <button onclick="closeChat()" style="float:right; background:#dc3545; color:#fff; border:none; padding:5px 10px; border-radius:6px;">X</button>
</div>
<button onclick="openChat()" style="position:fixed; bottom:20px; right:20px; background:#007bff; color:#fff; padding:12px; border:none; border-radius:50%; font-size:20px;">💬</button>
<script>
let step = 0;
let userCity = "";
let userLat = null, userLon = null;
let sessionData = {};
const greetings = [
    "Hey traveler 👋",
    "Hello there! 🌍",
    "Hi! Ready to explore?",
    "Welcome adventurer ✨"
];
const quotes = [
    "Travel makes one modest, you see what a tiny place you occupy in the world. 🌎",
    "Adventure is worthwhile. ✈️",
    "The journey, not the arrival, matters. 🚀",
    "Collect memories, not things. 📸"
];

function openChat() {
    document.getElementById("chatbot").style.display = "block";
    document.getElementById("chatContent").innerHTML = "";
    step = 0;
    botSay(greetings[Math.floor(Math.random() * greetings.length)]);
    setTimeout(() => botSay("Please enter your city name 🌆"), 1000);
}
function closeChat() {
    document.getElementById("chatbot").style.display = "none";
}

function botSay(msg) {
    const chat = document.getElementById("chatContent");
    // chat.innerHTML += `<p><b>Bot:</b> ${msg}</p>`;
    chat.innerHTML += "<p style=\"text-align:right;\"><b>You:</b> " + msg + "</p>";

    chat.scrollTop = chat.scrollHeight;
}
function userSay(msg) {
    const chat = document.getElementById("chatContent");
    // chat.innerHTML += `<p style="text-align:right;"><b>You:</b> ${msg}</p>`;
    chat.innerHTML += "<p style=\"text-align:right;\"><b>You:</b> " + msg + "</p>";
    chat.scrollTop = chat.scrollHeight;
}

function sendMessage() {
    const input = document.getElementById("chatInput");
    const msg = input.value.trim();
    if (!msg) return;
    userSay(msg);
    input.value = "";

    if (step === 0) {
        // user entered city
        userCity = msg;
        fetch("/api/search?query=" + encodeURIComponent(userCity))

          .then(res => res.json())
          .then(data => {
              if (data.length > 0) {
                  userLat = data[0].latitude;
                  userLon = data[0].longitude;
                //   botSay(`Got it! 📍 ${userCity} is located at [${userLat}, ${userLon}]`);
                  botSay("Got it! 📍 " + userCity + " is located at [" + userLat + ", " + userLon + "]");

                  setTimeout(() => botSay("What would you like to do?\n1️⃣ See nearby (hotels/restaurants/attractions)\n2️⃣ See attractions only\n3️⃣ Support"), 1000);
                  step = 1;
              } else {
                  botSay("Hmm, I couldn't find that city. Try again?");
              }
          });
    } 
    else if (step === 1) {
        if (msg.startsWith("1")) {
            fetch("/api/nearby?lat=" + userLat + "&lng=" + userLon + "&type=restaurant")

              .then(res => res.json())
              .then(data => {
                  botSay("Here are some nearby places 🍴:");
                  data.slice(0,5).forEach(p => botSay("• " + p.name));
                  endChat();
              });
        } else if (msg.startsWith("2")) {
            // fetch(`/api/nearby?lat=${userLat}&lng=${userLon}&type=attraction`)
            fetch("/api/nearby?lat=" + userLat + "&lng=" + userLon + "&type=attraction")

              .then(res => res.json())
              .then(data => {
                  botSay("Top attractions 🎡:");
                  data.slice(0,5).forEach(p => botSay("• " + p.name));
                  endChat();
              });
        } else if (msg.startsWith("3")) {
            botSay("Please enter your name:");
            step = 2;
        } else {
            botSay("Please type 1, 2, or 3 ✅");
        }
    } 
    else if (step === 2) {
        sessionData.name = msg;
        botSay("Thanks " + msg + "! Now enter your email:");
        step = 3;
    } 
    else if (step === 3) {
        sessionData.email = msg;
        botSay("Support request saved ✅");
        endChat();
    }
}

function endChat() {
    setTimeout(() => botSay("Goodbye 👋 " + quotes[Math.floor(Math.random() * quotes.length)]), 1500);
    step = 99; // conversation ended
}
</script>
<script>
let currentLat = 12.9716, currentLon = 77.5946, currentType = "restaurant";

function setFilter(type) {
    currentType = type;
    fetchPlaces(currentLat, currentLon, currentType);
}

function fetchPlaces(lat, lon, type = "restaurant") {
    // fetch(`/api/nearby?lat=${lat}&lng=${lon}&type=${type}`)
    fetch("/api/nearby?lat=" + encodeURIComponent(lat) + 
      "&lng=" + encodeURIComponent(lon) + 
      "&type=" + encodeURIComponent(type))

        .then(res => res.json())
        .then(data => renderPlaces(data))
        .catch(err => {
            console.error("Error fetching places:", err);
            document.getElementById("places").innerHTML = "<p>Error loading data.</p>";
        });
}

function searchPlaces() {
    const q = document.getElementById("searchBox").value;
    if (!q) return;
    // fetch(`/api/search?query=${q}`)
    fetch("/api/search?query=" + encodeURIComponent(q))

        .then(res => res.json())
        .then(data => renderPlaces(data))
        .catch(err => console.error("Search error:", err));
}

function renderPlaces(places) {
    const container = document.getElementById("places");
    container.innerHTML = "";
    if (places.length === 0) {
        container.innerHTML = "<p>No results found.</p>";
        return;
    }

    places.forEach(function(place) {
        const div = document.createElement("div");
        div.className = "card";

        let html = "";
        html += '<img src="' + place.imageUrl + '" alt="' + place.name + '">';
        html += '<div class="title">' + place.name + '</div>';

        if (place.flagUrl) {
            html += '<img src="' + place.flagUrl + '" style="width:30px; height:20px;">';
        }

        html += '<div class="price">💲 ' + (place.priceLevel || "N/A") + '</div>';
        html += '<a href="https://www.google.com/maps/search/?api=1&query=' + place.latitude + ',' + place.longitude + '" target="_blank" class="btn">Open in Maps</a>';
        html += '<button class="btn" onclick="loadQnA(\'' + place.id + '\')">Q&A</button>';
        html += '<button class="btn" onclick="loadProducts(\'' + place.id + '\')">Products</button>';

        div.innerHTML = html;
        container.appendChild(div);
    });
}

// Chatbot Q&A
function openChat() {
    document.getElementById("chatbot").style.display = "block";
}
function closeChat() {
    document.getElementById("chatbot").style.display = "none";
}
function loadQnA(locationId) {
    openChat();
    // fetch(`/api/questions?locationId=${locationId}`)
    fetch("/api/questions?locationId=" + encodeURIComponent(locationId))

        .then(res => res.json())
        .then(data => {
            const chat = document.getElementById("chatContent");
            chat.innerHTML = "";
            data.forEach(q => chat.innerHTML += "<p>❓"+ encodeURIComponent(q) + "</p>");
        });
}
function loadProducts(locationId) {
    openChat();
    // fetch(`/api/products?locationId=${locationId}`)
    fetch("/api/products?locationId=" + encodeURIComponent(locationId))

        .then(res => res.json())
       .then(function(data) {
    const chat = document.getElementById("chatContent");
    chat.innerHTML = "<h5>🎟 Products</h5>";
    data.forEach(function(p) {
        chat.innerHTML += "<p>• " + p + "</p>";
    });
});

}

// Geolocation
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(pos => {
        currentLat = pos.coords.latitude;
        currentLon = pos.coords.longitude;
        fetchPlaces(currentLat, currentLon, currentType);
    }, () => fetchPlaces(currentLat, currentLon, currentType));
} else {
    fetchPlaces(currentLat, currentLon, currentType);
}
</script>
</body>
</html>
