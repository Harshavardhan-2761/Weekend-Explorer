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
        #chatbot {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 12px;
            width: 350px;
            display: none;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        #chatContent {
            max-height: 250px;
            overflow-y: auto;
            margin-bottom: 10px;
        }
        #chatInput {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        #chatbot button {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            background: #007bff;
            color: #fff;
            margin-right: 5px;
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

<!-- 💬 Chatbot -->
<div id="chatbot">
    <h4>💬 Travel Assistant</h4>
    <div id="chatContent" style="max-height:250px; overflow-y:auto; margin-bottom:10px;"></div>
    <input type="text" id="chatInput" placeholder="Type your response...">
    <button onclick="sendMessage()">Send</button>
    <button onclick="closeChat()">Close</button>
</div>
<button onclick="openChat()" style="position:fixed; bottom:20px; right:20px; background:#007bff; color:#fff; padding:10px 15px; border:none; border-radius:50%; font-size:20px;">💬</button>

<script>
// Chatbot state
let chatState = {
    step: 'greeting',
    city: null,
    lat: null,
    lon: null,
    name: null,
    email: null
};

const greetings = [
    'Hello, adventurer! Ready to explore? What\'s your city?',
    'Hi there! Let\'s plan your next trip. Which city are you in?',
    'Welcome, traveler! Tell me your city to start exploring!',
    'Hey! Excited to discover new places? What\'s your city?',
    'Greetings! Let\'s find some cool spots. What\'s your city?'
];

const quotes = [
    'The journey of a thousand miles begins with a single step. – Lao Tzu',
    'Travel is the only thing you buy that makes you richer. – Unknown',
    'Not all those who wander are lost. – J.R.R. Tolkien',
    'Adventure is worthwhile. – Aesop',
    'The world is full of magic things, waiting for our senses to grow sharper. – W.B. Yeats'
];

function getRandomItem(array) {
    return array[Math.floor(Math.random() * array.length)];
}

function openChat() {
    document.getElementById('chatbot').style.display = 'block';
    chatState.step = 'greeting';
    displayMessage(getRandomItem(greetings));
}

function closeChat() {
    const goodbyeMessage = 'Thanks for chatting! Here\'s a quote for your journey: <br><i>' + getRandomItem(quotes) + '</i>';
    displayMessage(goodbyeMessage);
    setTimeout(function() {
        document.getElementById('chatbot').style.display = 'none';
        chatState.step = 'greeting';
        document.getElementById('chatContent').innerHTML = '';
    }, 3000);
}

function displayMessage(message) {
    const chatContent = document.getElementById('chatContent');
    chatContent.innerHTML = chatContent.innerHTML + '<p>' + message + '</p>';
    chatContent.scrollTop = chatContent.scrollHeight;
}

function sendMessage() {
    const input = document.getElementById('chatInput');
    const message = input.value.trim();
    if (!message) return;
    input.value = '';

    if (chatState.step === 'greeting') {
        chatState.city = message;
        searchCity(message);
    } else if (chatState.step === 'options') {
        handleOptions(message);
    } else if (chatState.step === 'support_name') {
        chatState.name = message;
        displayMessage('Please enter your email address:');
        chatState.step = 'support_email';
    } else if (chatState.step === 'support_email') {
        chatState.email = message;
        sessionStorage.setItem('userName', chatState.name);
        sessionStorage.setItem('userEmail', chatState.email);
        displayMessage('Thank you! Your details have been saved. How else can I assist you?');
        chatState.step = 'options';
        showOptions();
    }
}

function searchCity(city) {
    const url = '/api/search?query=' + encodeURIComponent(city);
    fetch(url)
        .then(function(res) { return res.json(); })
        .then(function(data) {
            if (data.length > 0) {
                chatState.lat = data[0].latitude;
                chatState.lon = data[0].longitude;
                displayMessage('Found ' + city + '! What would you like to do?');
                showOptions();
            } else {
                displayMessage('Sorry, I couldn\'t find that city. Please try again:');
                chatState.step = 'greeting';
            }
        })
        .catch(function(err) {
            console.error('Error searching city:', err);
            displayMessage('Error finding city. Please try again:');
            chatState.step = 'greeting';
        });
}

function showOptions() {
    chatState.step = 'options';
    displayMessage('Please select an option:<br>' +
                   '1. See what\'s nearby (restaurants, hotels, attractions)<br>' +
                   '2. See attractions nearby<br>' +
                   '3. Contact support');
}

function handleOptions(choice) {
    if (choice === '1') {
        fetchNearbyPlaces();
    } else if (choice === '2') {
        fetchAttractions();
    } else if (choice === '3') {
        displayMessage('Please enter your name:');
        chatState.step = 'support_name';
    } else {
        displayMessage('Invalid option. Please choose 1, 2, or 3:');
        showOptions();
    }
}

function fetchNearbyPlaces() {
    const data = JSON.stringify({
        contentId: 'cc8fc7b8-88ed-47d3-a70e-0de9991f6604',
        contentType: 'restaurant',
        filters: [
            { id: 'placetype', value: ['hotel', 'attraction', 'restaurant'] },
            { id: 'minRating', value: ['30'] }
        ],
        boundingBox: {
            northEastCorner: {
                latitude: chatState.lat + 0.005,
                longitude: chatState.lon + 0.005
            },
            southWestCorner: {
                latitude: chatState.lat - 0.005,
                longitude: chatState.lon - 0.005
            }
        }
    });

    fetch('https://travel-advisor.p.rapidapi.com/locations/v2/list-nearby?lang=en_US', {
        method: 'POST',
        headers: {
            'x-rapidapi-key': 'b6f2512c05msh1c72b5bf387af7cp1a5e63jsn225b54f35a8e',
            'x-rapidapi-host': 'travel-advisor.p.rapidapi.com',
            'Content-Type': 'application/json'
        },
        body: data
    })
        .then(function(res) {
            if (!res.ok) {
                throw new Error('HTTP error, status = ' + res.status);
            }
            return res.json();
        })
        .then(function(data) {
            console.log('Nearby Places Response:', data); // Log the full response
            displayPlaces(data);
            chatState.step = 'options';
            showOptions();
        })
        .catch(function(err) {
            console.error('Error fetching nearby places:', err);
            displayMessage('Error fetching nearby places. Please try again:');
            chatState.step = 'options';
            showOptions();
        });
}

function fetchAttractions() {
    const data = JSON.stringify({
        geoId: 293928,
        startDate: '2025-08-20',
        endDate: '2025-08-25',
        pax: [{ ageBand: 'ADULT', count: 2 }],
        sort: 'TRAVELER_FAVORITE_V2',
        sortOrder: 'asc',
        filters: [
            { id: 'category', value: ['40'] },
            { id: 'rating', value: ['40'] },
            { id: 'navbar', value: ['ATTRACTIONOVERVIEW:-true'] }
        ],
        boundingBox: {
            northEastCorner: {
                latitude: chatState.lat + 0.005,
                longitude: chatState.lon + 0.005
            },
            southWestCorner: {
                latitude: chatState.lat - 0.005,
                longitude: chatState.lon - 0.005
            }
        },
        updateToken: ''
    });

    fetch('https://travel-advisor.p.rapidapi.com/attractions/v2/list?currency=USD&units=km&lang=en_US', {
        method: 'POST',
        headers: {
            'x-rapidapi-key': 'b6f2512c05msh1c72b5bf387af7cp1a5e63jsn225b54f35a8e',
            'x-rapidapi-host': 'travel-advisor.p.rapidapi.com',
            'Content-Type': 'application/json'
        },
        body: data
    })
        .then(function(res) {
            if (!res.ok) {
                throw new Error('HTTP error, status = ' + res.status);
            }
            return res.json();
        })
        .then(function(data) {
            console.log('Attractions Response:', data); // Log the full response
            displayPlaces(data);
            chatState.step = 'options';
            showOptions();
        })
        .catch(function(err) {
            console.error('Error fetching attractions:', err);
            displayMessage('Error fetching attractions. Please try again:');
            chatState.step = 'options';
            showOptions();
        });
}

function displayPlaces(data) {
    // Check if data and data.data exist and are an array
    let places = [];
    if (data && data.data && Array.isArray(data.data)) {
        places = data.data;
    } else if (data && data.results && Array.isArray(data.results)) {
        places = data.results; // Fallback for different response structure
    } else if (data && Array.isArray(data)) {
        places = data; // Direct array case
    }

    if (places.length === 0) {
        displayMessage('No places found nearby.');
        return;
    }

    let html = '<h5>Nearby Places</h5>';
    places.forEach(function(place) {
        html = html + '<p><b>' + (place.name || 'Unknown') + '</b><br>';
        if (place.address) {
            html = html + 'Address: ' + place.address + '<br>';
        }
        if (place.rating) {
            html = html + 'Rating: ' + place.rating + '/5<br>';
        }
        if (place.website) {
            html = html + '<a href="' + place.website + '" target="_blank">Website</a></p>';
        }
    });
    displayMessage(html);
}

function setFilter(type) {
    currentType = type;
    fetchPlaces(currentLat, currentLon, currentType);
}

function fetchPlaces(lat, lon, type) {
    const url = '/api/nearby?lat=' + encodeURIComponent(lat) + '&lng=' + encodeURIComponent(lon) + '&type=' + encodeURIComponent(type);
    fetch(url)
        .then(function(res) { return res.json(); })
        .then(function(data) { renderPlaces(data); })
        .catch(function(err) {
            console.error('Error fetching places:', err);
            document.getElementById('places').innerHTML = '<p>Error loading data.</p>';
        });
}

function searchPlaces() {
    const q = document.getElementById('searchBox').value;
    if (!q) return;
    const url = '/api/search?query=' + encodeURIComponent(q);
    fetch(url)
        .then(function(res) { return res.json(); })
        .then(function(data) { renderPlaces(data); })
        .catch(function(err) { console.error('Search error:', err); });
}

function renderPlaces(places) {
    const container = document.getElementById('places');
    container.innerHTML = '';
    if (places.length === 0) {
        container.innerHTML = '<p>No results found.</p>';
        return;
    }

    places.forEach(function(place) {
        const div = document.createElement('div');
        div.className = 'card';

        let html = '<img src="' + place.imageUrl + '" alt="' + place.name + '">';
        html = html + '<div class="title">' + place.name + '</div>';

        if (place.flagUrl) {
            html = html + '<img src="' + place.flagUrl + '" style="width:30px; height:20px;">';
        }

        html = html + '<div class="price">💲 ' + (place.priceLevel || 'N/A') + '</div>';
        html = html + '<a href="https://www.google.com/maps/search/?api=1&query=' + place.latitude + ',' + place.longitude + '" target="_blank" class="btn">Open in Maps</a>';
        html = html + '<button class="btn" onclick="loadQnA(\'' + place.id + '\')">Q&A</button>';
        html = html + '<button class="btn" onclick="loadProducts(\'' + place.id + '\')">Products</button>';

        div.innerHTML = html;
        container.appendChild(div);
    });
}

function loadQnA(locationId) {
    openChat();
    const url = '/api/questions?locationId=' + encodeURIComponent(locationId);
    fetch(url)
        .then(function(res) { return res.json(); })
        .then(function(data) {
            const chat = document.getElementById('chatContent');
            chat.innerHTML = '';
            data.forEach(function(q) {
                chat.innerHTML = chat.innerHTML + '<p>❓ ' + q + '</p>';
            });
        });
}

function loadProducts(locationId) {
    openChat();
    const url = '/api/products?locationId=' + encodeURIComponent(locationId);
    fetch(url)
        .then(function(res) { return res.json(); })
        .then(function(data) {
            const chat = document.getElementById('chatContent');
            chat.innerHTML = '<h5>🎟 Products</h5>';
            data.forEach(function(p) {
                chat.innerHTML = chat.innerHTML + '<p>• ' + p + '</p>';
            });
        });
}

// Geolocation
let currentLat = 12.9716, currentLon = 77.5946, currentType = 'restaurant';
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(pos) {
        currentLat = pos.coords.latitude;
        currentLon = pos.coords.longitude;
        fetchPlaces(currentLat, currentLon, currentType);
    }, function() { fetchPlaces(currentLat, currentLon, currentType); });
} else {
    fetchPlaces(currentLat, currentLon, currentType);
}
</script>
</body>
</html>