<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Weekend Explorer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --bg-primary: #f8fafc;
            --bg-secondary: #ffffff;
            --bg-tertiary: #f1f5f9;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --accent-primary: #3b82f6;
            --accent-secondary: #10b981;
            --accent-danger: #ef4444;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);
        }

        [data-theme="dark"] {
            --bg-primary: #0f172a;
            --bg-secondary: #1e293b;
            --bg-tertiary: #334155;
            --text-primary: #f1f5f9;
            --text-secondary: #94a3b8;
            --accent-primary: #60a5fa;
            --accent-secondary: #34d399;
            --accent-danger: #f87171;
            --border-color: #475569;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            transition: all 0.3s ease;
            min-height: 100vh;
        }

        /* Header */
        .header {
            position: sticky;
            top: 0;
            background: var(--bg-secondary);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
            z-index: 100;
            padding: 1rem 2rem;
            box-shadow: var(--shadow-sm);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .location-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .time-display {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: var(--bg-tertiary);
            border-radius: 0.5rem;
            font-weight: 600;
        }

        .theme-toggle {
            background: var(--bg-tertiary);
            border: none;
            padding: 0.5rem;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--text-primary);
        }

        .theme-toggle:hover {
            background: var(--accent-primary);
            color: white;
            transform: scale(1.1);
        }

        .view-toggle {
            display: flex;
            background: var(--bg-tertiary);
            border-radius: 0.5rem;
            padding: 0.25rem;
        }

        .view-btn {
            background: none;
            border: none;
            padding: 0.5rem;
            border-radius: 0.375rem;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--text-secondary);
        }

        .view-btn.active {
            background: var(--accent-primary);
            color: white;
            box-shadow: var(--shadow-sm);
        }

        /* Search Section */
        .search-section {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .search-container {
            position: relative;
            max-width: 500px;
            margin: 0 auto;
        }

        .search-input {
            width: 100%;
            padding: 1rem 3rem 1rem 1rem;
            background: var(--bg-secondary);
            border: 2px solid var(--border-color);
            border-radius: 1rem;
            font-size: 1rem;
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgb(59 130 246 / 0.1);
        }

        .search-btn {
            position: absolute;
            right: 0.5rem;
            top: 50%;
            transform: translateY(-50%);
            background: var(--accent-primary);
            color: white;
            border: none;
            padding: 0.75rem 1rem;
            border-radius: 0.75rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            background: var(--accent-secondary);
            transform: translateY(-50%) scale(1.05);
        }

        /* Filter Bar */
        .filter-bar {
            position: sticky;
            top: 70px;
            background: var(--bg-secondary);
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            border-bottom: 1px solid var(--border-color);
            z-index: 99;
        }

        .filter-container {
            display: flex;
            gap: 1rem;
            max-width: 1400px;
            margin: 0 auto;
            overflow-x: auto;
            padding: 0.5rem 0;
        }

        .filter-btn {
            white-space: nowrap;
            padding: 0.75rem 1.5rem;
            background: var(--bg-tertiary);
            color: var(--text-secondary);
            border: none;
            border-radius: 2rem;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: var(--accent-primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Loading */
        .loading {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 4rem;
            gap: 1rem;
        }

        .spinner {
            width: 60px;
            height: 60px;
            border: 4px solid var(--border-color);
            border-left: 4px solid var(--accent-primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .loading-text {
            color: var(--text-secondary);
            font-size: 1.1rem;
            font-weight: 500;
        }

        /* Places Container */
        .places-container {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Grid View */
        .places-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 2rem;
        }

        .place-card {
            background: var(--bg-secondary);
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .place-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl);
        }

        .card-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(45deg, #f3f4f6, #e5e7eb);
        }

        .card-content {
            padding: 1.5rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .card-flag {
            width: 32px;
            height: 24px;
            border-radius: 0.25rem;
            object-fit: cover;
        }

        .card-price {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--accent-secondary);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .card-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            background: var(--accent-primary);
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            font-size: 0.875rem;
        }

        .btn:hover {
            background: var(--accent-secondary);
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: var(--bg-tertiary);
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: var(--border-color);
        }

        /* List View */
        .places-list .place-card {
            display: flex;
            align-items: center;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }

        .places-list .card-image {
            width: 120px;
            height: 80px;
            border-radius: 0.5rem;
            margin-right: 1.5rem;
        }

        .places-list .card-content {
            flex: 1;
            padding: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .places-list .card-info {
            flex: 1;
        }

        .places-list .card-actions {
            margin-left: 1rem;
        }

        /* Chatbot */
        .chat-toggle {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            color: white;
            border: none;
            border-radius: 50%;
            font-size: 1.5rem;
            cursor: pointer;
            box-shadow: var(--shadow-lg);
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .chat-toggle:hover {
            transform: scale(1.1);
            box-shadow: var(--shadow-xl);
        }

        .chat-toggle.pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .chatbot {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 380px;
            max-height: 600px;
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            box-shadow: var(--shadow-xl);
            display: none;
            flex-direction: column;
            z-index: 1001;
            animation: slideUp 0.3s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .chat-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            color: white;
            border-radius: 1rem 1rem 0 0;
        }

        .chat-title {
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .chat-close {
            background: none;
            border: none;
            color: white;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 0.25rem;
            transition: all 0.3s ease;
        }

        .chat-close:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .chat-content {
            flex: 1;
            padding: 1rem;
            max-height: 400px;
            overflow-y: auto;
            scroll-behavior: smooth;
        }

        .chat-message {
            margin-bottom: 1rem;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .chat-message.bot {
            text-align: left;
        }

        .chat-message.user {
            text-align: right;
        }

        .message-content {
            display: inline-block;
            padding: 0.75rem 1rem;
            border-radius: 1rem;
            max-width: 80%;
            word-wrap: break-word;
        }

        .chat-message.bot .message-content {
            background: var(--bg-tertiary);
            color: var(--text-primary);
            border-bottom-left-radius: 0.25rem;
        }

        .chat-message.user .message-content {
            background: var(--accent-primary);
            color: white;
            border-bottom-right-radius: 0.25rem;
        }

        .chat-input-container {
            padding: 1rem;
            border-top: 1px solid var(--border-color);
            display: flex;
            gap: 0.5rem;
        }

        .chat-input {
            flex: 1;
            padding: 0.75rem;
            background: var(--bg-tertiary);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            color: var(--text-primary);
            resize: none;
        }

        .chat-input:focus {
            outline: none;
            border-color: var(--accent-primary);
        }

        .chat-send {
            background: var(--accent-primary);
            color: white;
            border: none;
            padding: 0.75rem;
            border-radius: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .chat-send:hover {
            background: var(--accent-secondary);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header {
                padding: 1rem;
            }

            .header-content {
                flex-direction: column;
                gap: 1rem;
            }

            .location-info,
            .time-display {
                display: none;
            }

            .search-section {
                padding: 1rem;
            }

            .filter-bar {
                padding: 1rem;
            }

            .places-container {
                padding: 1rem;
            }

            .places-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .chatbot {
                width: calc(100vw - 2rem);
                right: 1rem;
                left: 1rem;
            }

            .chat-toggle {
                right: 1rem;
            }

            .places-list .place-card {
                flex-direction: column;
                text-align: center;
            }

            .places-list .card-image {
                width: 100%;
                height: 150px;
                margin-right: 0;
                margin-bottom: 1rem;
            }

            .places-list .card-content {
                flex-direction: column;
                gap: 1rem;
            }

            .places-list .card-actions {
                margin-left: 0;
            }
        }

        /* No Results */
        .no-results {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }

        .no-results i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: var(--border-color);
        }

        .no-results h3 {
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }

        /* Typing Indicator */
        .typing-indicator {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1rem;
            background: var(--bg-tertiary);
            border-radius: 1rem;
            margin-bottom: 1rem;
            max-width: fit-content;
        }

        .typing-dots {
            display: flex;
            gap: 0.25rem;
        }

        .typing-dot {
            width: 8px;
            height: 8px;
            background: var(--text-secondary);
            border-radius: 50%;
            animation: typingBounce 1.4s infinite ease-in-out;
        }

        .typing-dot:nth-child(1) { animation-delay: -0.32s; }
        .typing-dot:nth-child(2) { animation-delay: -0.16s; }

        @keyframes typingBounce {
            0%, 80%, 100% { transform: scale(0.8); opacity: 0.5; }
            40% { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <div class="header-left">
                <div class="logo">
                    <i class="fas fa-map-marked-alt"></i>
                    Weekend Explorer
                </div>
                <div class="location-info">
                    <i class="fas fa-map-marker-alt"></i>
                    <span id="currentCity">Bengaluru, IN</span>
                </div>
            </div>
            <div class="header-right">
                <div class="time-display">
                    <i class="fas fa-clock"></i>
                    <span id="currentTime"></span>
                </div>
                <button class="theme-toggle" onclick="toggleTheme()" title="Toggle Theme">
                    <i class="fas fa-sun" id="themeIcon"></i>
                </button>
                <div class="view-toggle">
                    <button class="view-btn active" onclick="setView('grid')" title="Grid View">
                        <i class="fas fa-th"></i>
                    </button>
                    <button class="view-btn" onclick="setView('list')" title="List View">
                        <i class="fas fa-list"></i>
                    </button>
                </div>
            </div>
        </div>
    </header>

    <!-- Search Section -->
    <section class="search-section">
        <div class="search-container">
            <input type="text" id="searchBox" class="search-input" placeholder="🔍 Discover amazing places...">
            <button onclick="searchPlaces()" class="search-btn">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </section>

    <!-- Filter Bar -->
    <div class="filter-bar">
        <div class="filter-container">
            <button class="filter-btn active" onclick="setFilter('restaurant')" data-type="restaurant">
                <i class="fas fa-utensils"></i>
                Restaurants
            </button>
            <button class="filter-btn" onclick="setFilter('hotel')" data-type="hotel">
                <i class="fas fa-bed"></i>
                Hotels
            </button>
            <button class="filter-btn" onclick="setFilter('attraction')" data-type="attraction">
                <i class="fas fa-camera"></i>
                Attractions
            </button>
            <button class="filter-btn" onclick="setFilter('shopping')" data-type="shopping">
                <i class="fas fa-shopping-bag"></i>
                Shopping
            </button>
            <button class="filter-btn" onclick="setFilter('entertainment')" data-type="entertainment">
                <i class="fas fa-film"></i>
                Entertainment
            </button>
        </div>
    </div>

    <!-- Places Container -->
    <main class="places-container">
        <div id="places" class="places-grid">
            <div class="loading">
                <div class="spinner"></div>
                <div class="loading-text">Discovering amazing places near you...</div>
            </div>
        </div>
    </main>

    <!-- Chatbot -->
    <div id="chatbot" class="chatbot">
        <div class="chat-header">
            <div class="chat-title">
                <i class="fas fa-robot"></i>
                Weekend Assistant
            </div>
            <button onclick="closeChat()" class="chat-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div id="chatContent" class="chat-content"></div>
        <div class="chat-input-container">
            <textarea id="chatInput" class="chat-input" placeholder="Ask me anything..." rows="1"></textarea>
            <button onclick="sendMessage()" class="chat-send">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>

    <button onclick="openChat()" class="chat-toggle pulse" id="chatToggle">
        <i class="fas fa-comments"></i>
    </button>

    <script>
        // Global Variables
        let currentLat = 12.9716, currentLon = 77.5946, currentType = "restaurant";
        let currentView = 'grid';
        let isDarkTheme = false;
        
        // Chat Variables
        let step = 0;
        let userCity = "";
        let userLat = null, userLon = null;
        let sessionData = {};
        let isTyping = false;
        
        const greetings = [
            "Hello there, adventure seeker! 🌟 Ready to discover some amazing places?",
            "Hey wanderer! 🗺️ Let's find your perfect weekend getaway!",
            "Welcome, explorer! ✨ I'm here to help you discover incredible experiences!",
            "Greetings, fellow traveler! 🌍 Let's make your weekend unforgettable!"
        ];
        
        const farewells = [
            "Travel makes one modest, you see what a tiny place you occupy in the world. 🌎",
            "Adventure is worthwhile in itself! ✈️ Safe travels!",
            "The journey, not the arrival, matters. 🚀 Enjoy exploring!",
            "Collect memories, not things. 📸 Have an amazing adventure!"
        ];

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            updateTime();
            setInterval(updateTime, 1000);
            initializeGeolocation();
            
            // Auto-resize chat input
            const chatInput = document.getElementById('chatInput');
            chatInput.addEventListener('input', function() {
                this.style.height = 'auto';
                this.style.height = this.scrollHeight + 'px';
            });
            
            // Enter key to send message
            chatInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    sendMessage();
                }
            });
        });

        // Time Display
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString('en-US', { 
                hour: '2-digit', 
                minute: '2-digit',
                hour12: true
            });
            document.getElementById('currentTime').textContent = timeString;
        }

        // Theme Toggle
        function toggleTheme() {
            isDarkTheme = !isDarkTheme;
            const body = document.body;
            const themeIcon = document.getElementById('themeIcon');
            
            if (isDarkTheme) {
                body.setAttribute('data-theme', 'dark');
                themeIcon.className = 'fas fa-moon';
            } else {
                body.removeAttribute('data-theme');
                themeIcon.className = 'fas fa-sun';
            }
        }

        // View Toggle
        function setView(view) {
            currentView = view;
            const placesContainer = document.getElementById('places');
            const viewBtns = document.querySelectorAll('.view-btn');
            
            viewBtns.forEach(btn => btn.classList.remove('active'));
            event.target.closest('.view-btn').classList.add('active');
            
            if (view === 'list') {
                placesContainer.className = 'places-list';
            } else {
                placesContainer.className = 'places-grid';
            }
        }

        // Filter Functions
        function setFilter(type) {
            currentType = type;
            const filterBtns = document.querySelectorAll('.filter-btn');
            filterBtns.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            showLoading();
            fetchPlaces(currentLat, currentLon, currentType);
        }

        // Loading States
        function showLoading() {
            const loadingMessages = [
                "Discovering amazing places near you...",
                "Finding the perfect spots for your adventure...",
                "Exploring hidden gems in your area...",
                "Curating the best experiences for you..."
            ];
            
            document.getElementById("places").innerHTML =
                '<div class="loading">' +
                    '<div class="spinner"></div>' +
                    '<div class="loading-text">' +
                        loadingMessages[Math.floor(Math.random() * loadingMessages.length)] +
                    '</div>' +
                '</div>';

        }

        // API Functions
        function fetchPlaces(lat, lon, type = "restaurant") {
            fetch("/api/nearby?lat=" + encodeURIComponent(lat) + 
                  "&lng=" + encodeURIComponent(lon) + 
                  "&type=" + encodeURIComponent(type))
                .then(res => res.json())
                .then(data => renderPlaces(data))
                .catch(err => {
                    console.error("Error fetching places:", err);
                    document.getElementById("places").innerHTML =
                        '<div class="no-results">' +
                            '<i class="fas fa-exclamation-triangle"></i>' +
                            '<h3>Oops! Something went wrong</h3>' +
                            '<p>Unable to load places. Please try again.</p>' +
                        '</div>';

                });
        }

        function searchPlaces() {
            const q = document.getElementById("searchBox").value.trim();
            if (!q) return;
            
            showLoading();
            fetch("/api/search?query=" + encodeURIComponent(q))
                .then(res => res.json())
                .then(data => renderPlaces(data))
                .catch(err => {
                    console.error("Search error:", err);
                    document.getElementById("places").innerHTML =
                        '<div class="no-results">' +
                            '<i class="fas fa-search"></i>' +
                            '<h3>Search failed</h3>' +
                            '<p>Unable to search. Please try again.</p>' +
                        '</div>';

                });
        }

        // Render Places
        function renderPlaces(places) {
            const container = document.getElementById("places");
            
            if (places.length === 0) {
               container.innerHTML =
                    '<div class="no-results">' +
                        '<i class="fas fa-map-marker-alt"></i>' +
                        '<h3>No places found</h3>' +
                        '<p>Try adjusting your search or filters to discover more places.</p>' +
                    '</div>';

                return;
            }

            container.innerHTML = "";
            places.forEach(function(place, index) {
                const div = document.createElement("div");
                div.className = "place-card";
                div.style.animationDelay = (index * 0.1) + 's';
                const imageUrl = place.imageUrl || 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=300&fit=crop';

                let html =
                    '<img src="' + imageUrl + '" alt="' + place.name + '" class="card-image" loading="lazy">' +
                    '<div class="card-content">' +
                        '<div class="card-header">' +
                            '<div>' +
                                '<h3 class="card-title">' + place.name + '</h3>' +
                                '<div class="card-price">' +
                                    '<i class="fas fa-dollar-sign"></i>' +
                                    (place.priceLevel || "N/A") +
                                '</div>' +
                            '</div>' +
                            (place.flagUrl ? '<img src="' + place.flagUrl + '" alt="Flag" class="card-flag">' : '') +
                        '</div>' +
                        '<div class="card-actions">' +
                            '<a href="https://www.google.com/maps/search/?api=1&query=' + place.latitude + ',' + place.longitude + '" ' +
                            'target="_blank" class="btn">' +
                                '<i class="fas fa-map-marker-alt"></i>' +
                                'View on Map' +
                            '</a>' +
                            '<button onclick="loadQnA(\'' + (place.id || index) + '\')" class="btn btn-secondary">' +
                                '<i class="fas fa-question-circle"></i>' +
                                'Ask' +
                            '</button>' +
                        '</div>' +
                    '</div>';


                div.innerHTML = html;
                container.appendChild(div);
            });
        }

        // Geolocation
        function initializeGeolocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(pos => {
                    currentLat = pos.coords.latitude;
                    currentLon = pos.coords.longitude;
                    updateLocationDisplay(pos.coords.latitude, pos.coords.longitude);
                    fetchPlaces(currentLat, currentLon, currentType);
                }, () => {
                    fetchPlaces(currentLat, currentLon, currentType);
                });
            } else {
                fetchPlaces(currentLat, currentLon, currentType);
            }
        }

        function updateLocationDisplay(lat, lon) {
            // You can implement reverse geocoding here
            // For now, keeping the default Mumbai, IN
        }

        // Chatbot Functions
        function openChat() {
            document.getElementById("chatbot").style.display = "flex";
            document.getElementById("chatToggle").style.display = "none";
            document.getElementById("chatContent").innerHTML = "";
            step = 0;

            showTypingIndicator();
            setTimeout(() => {
                hideTypingIndicator();
                botSay(greetings[Math.floor(Math.random() * greetings.length)]);
                setTimeout(() => {
                    botSay("Would you like me to use your exact location for better recommendations? 📍", ["Yes, use my location", "No, I'll enter my city"]);
                }, 1500);
            }, 1000);
        }

        function closeChat() {
            document.getElementById("chatbot").style.display = "none";
            document.getElementById("chatToggle").style.display = "block";
        }

        function showTypingIndicator() {
            if (isTyping) return;
            isTyping = true;
            const chat = document.getElementById("chatContent");
            const typingDiv = document.createElement("div");
            typingDiv.className = "typing-indicator";
            typingDiv.id = "typingIndicator";
            typingDiv.innerHTML =
                '<i class="fas fa-robot" style="color: var(--text-secondary);"></i>' +
                '<div class="typing-dots">' +
                    '<div class="typing-dot"></div>' +
                    '<div class="typing-dot"></div>' +
                    '<div class="typing-dot"></div>' +
                '</div>';

            chat.appendChild(typingDiv);
            chat.scrollTop = chat.scrollHeight;
        }

        function hideTypingIndicator() {
            isTyping = false;
            const typingIndicator = document.getElementById("typingIndicator");
            if (typingIndicator) {
                typingIndicator.remove();
            }
        }

        function botSay(msg, quickReplies = null) {
            const chat = document.getElementById("chatContent");
            const messageDiv = document.createElement("div");
            messageDiv.className = "chat-message bot";
            
            let html = '<div class="message-content">' + msg + '</div>';
            
            if (quickReplies) {
                html += '<div style="margin-top: 0.5rem; display: flex; flex-wrap: wrap; gap: 0.5rem;">';
                quickReplies.forEach(reply => {
                    html += '<button onclick="quickReply(\'' + reply + '\')" style="padding: 0.25rem 0.5rem; background: var(--accent-primary); color: white; border: none; border-radius: 1rem; font-size: 0.75rem; cursor: pointer;">' + reply + '</button>';
                });
                html += '</div>';
            }
            
            messageDiv.innerHTML = html;
            chat.appendChild(messageDiv);
            chat.scrollTop = chat.scrollHeight;
        }

        function userSay(msg) {
            const chat = document.getElementById("chatContent");
            const messageDiv = document.createElement("div");
            messageDiv.className = "chat-message user";
            messageDiv.innerHTML = '<div class="message-content">' + msg + '</div>';
            chat.appendChild(messageDiv);
            chat.scrollTop = chat.scrollHeight;
        }

        function quickReply(message) {
            userSay(message);
            processMessage(message);
        }

        function sendMessage() {
            const input = document.getElementById("chatInput");
            const msg = input.value.trim();
            if (!msg) return;
            
            userSay(msg);
            input.value = "";
            input.style.height = 'auto';
            
            processMessage(msg);
        }

        function processMessage(msg) {
            showTypingIndicator();
            
            setTimeout(() => {
                hideTypingIndicator();
                
                if (step === 0) {
                    // Location permission
                    if (msg.toLowerCase().includes("yes") || msg.toLowerCase().includes("location")) {
                        if (navigator.geolocation) {
                            navigator.geolocation.getCurrentPosition(pos => {
                                userLat = pos.coords.latitude;
                                userLon = pos.coords.longitude;
                                botSay('Perfect! I\'ve got your location 📍 [' + userLat.toFixed(4) + ', ' + userLon.toFixed(4) + ']');
                                setTimeout(() => {
                                    botSay("What would you like to explore today?", ["🍽️ Nearby restaurants", "🎡 Tourist attractions", "🏨 Hotels & stays", "💬 Get support"]);
                                    step = 1;
                                }, 1000);
                            }, () => {
                                botSay("Hmm, I couldn't access your location 😅 No worries! What city are you in?");
                                step = -1;
                            });
                        } else {
                            botSay("Your device doesn't support location services 📱 What city would you like to explore?");
                            step = -1;
                        }
                    } else {
                        botSay("No problem! 🌆 Which city would you like to explore?");
                        step = -1;
                    }
                }
                else if (step === -1) {
                    // City input
                    userCity = msg;
                    botSay("Great choice! Let me search for that location... 🔍");
                    
                    setTimeout(() => {
                        fetch("/api/search?query=" + encodeURIComponent(userCity))
                            .then(res => res.json())
                            .then(data => {
                                if (data.length > 0) {
                                    userLat = data[0].latitude;
                                    userLon = data[0].longitude;
                                    botSay('Found it! 🎯 ' + userCity + ' is now set as your location.');
                                    setTimeout(() => {
                                        botSay("What would you like to explore?", ["🍽️ Nearby restaurants", "🎡 Tourist attractions", "🏨 Hotels & stays", "💬 Get support"]);
                                        step = 1;
                                    }, 1000);
                                } else {
                                    botSay("I couldn't find that city 🤔 Could you try a different spelling or a nearby major city?");
                                }
                            })
                            .catch(() => {
                                botSay("Sorry, I'm having trouble searching right now 😓 Please try again later.");
                            });
                    }, 1000);
                }
                else if (step === 1) {
                    // Main menu
                    if (msg.includes("restaurant") || msg.includes("🍽️")) {
                        botSay("Searching for delicious restaurants near you... 🍴");
                        fetchAndDisplayPlaces("restaurant", "🍽️ Here are some amazing restaurants nearby:");
                    } else if (msg.includes("attraction") || msg.includes("🎡")) {
                        botSay("Finding exciting attractions for you... 🎡");
                        fetchAndDisplayPlaces("attraction", "🎡 Check out these fantastic attractions:");
                    } else if (msg.includes("hotel") || msg.includes("🏨")) {
                        botSay("Looking for comfortable stays... 🏨");
                        fetchAndDisplayPlaces("hotel", "🏨 Here are some great hotels:");
                    } else if (msg.includes("support") || msg.includes("💬")) {
                        botSay("I'd be happy to help! 😊 What's your name?");
                        step = 2;
                    } else {
                        botSay("I'd love to help! Please choose one of the options:", ["🍽️ Nearby restaurants", "🎡 Tourist attractions", "🏨 Hotels & stays", "💬 Get support"]);
                    }
                }
                else if (step === 2) {
                    // Support - name
                    sessionData.name = msg;
                    botSay('Nice to meet you, ' + msg + '! 👋 What\'s your email address so I can follow up?');
                    step = 3;
                }
                else if (step === 3) {
                    // Support - email
                    sessionData.email = msg;
                    botSay('Perfect! I\'ve recorded your support request, ' + sessionData.name + ' ✅');
                    setTimeout(() => {
                        botSay("Our team will reach out to you soon. Is there anything else I can help you explore today?", ["🍽️ Find restaurants", "🎡 Discover attractions", "👋 End chat"]);
                        step = 1;
                    }, 1000);
                }
                else {
                    // Fallback
                    botSay("I'm here to help you discover amazing places! What would you like to explore?", ["🍽️ Restaurants", "🎡 Attractions", "🏨 Hotels"]);
                    step = 1;
                }
            }, 1500);
        }

        function fetchAndDisplayPlaces(type, introMsg) {
            fetch("/api/nearby?lat=" + userLat + "&lng=" + userLon + "&type=" + type)
                .then(res => res.json())
                .then(data => {
                    botSay(introMsg);
                    if (data.length > 0) {
                        const topPlaces = data.slice(0, 5);
                        topPlaces.forEach(place => {
                            setTimeout(() => {
                                botSay('📍 <strong>' + place.name + '</strong><br><small>Price: ' + (place.priceLevel || "N/A") + '</small>');

                            }, Math.random() * 1000);
                        });
                        setTimeout(() => {
                            botSay("Would you like to see more options or explore something else?", ["Show more places", "Different category", "End chat"]);
                        }, 2000);
                    } else {
                        botSay("I couldn't find any places in that category 😔 Would you like to try a different search?", ["🍽️ Restaurants", "🎡 Attractions", "🏨 Hotels"]);
                    }
                    endChat();
                })
                .catch(() => {
                    botSay("Sorry, I'm having trouble fetching places right now 😓 Please try again later.");
                });
        }

        function endChat() {
            setTimeout(() => {
                botSay(farewells[Math.floor(Math.random() * farewells.length)]);
                setTimeout(() => {
                    botSay("Feel free to start a new conversation anytime! 😊", ["Start over", "Close chat"]);
                }, 2000);
            }, 3000);
        }

        function loadQnA(locationId) {
            openChat();
            showTypingIndicator();
            setTimeout(() => {
                hideTypingIndicator();
                botSay("I'd love to help you learn more about this place! 🤗 What would you like to know?", ["Opening hours", "Reviews", "Directions", "Contact info"]);
            }, 1000);
        }

        function loadProducts(locationId) {
            openChat();
            showTypingIndicator();
            setTimeout(() => {
                hideTypingIndicator();
                botSay("Here are some products and services available at this location:");
                // Simulate product loading
                const products = ["City Tour Package", "Food Tasting Experience", "Photography Session", "Local Guide Service"];
                products.forEach((product, index) => {
                    setTimeout(() => {
                        botSay('🎟️ ' + product);
                    }, index * 500);
                });
            }, 1000);
        }

        // Initialize the app
        setTimeout(() => {
            fetchPlaces(currentLat, currentLon, currentType);
        }, 1000);
    </script>
</body>
</html>