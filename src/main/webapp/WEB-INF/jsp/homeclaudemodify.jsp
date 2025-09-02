<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Weekend Explorer - Discover Amazing Places</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --accent-color: #28a745;
            --text-color: #333;
            --text-light: #666;
            --bg-color: #ffffff;
            --bg-secondary: rgba(255, 255, 255, 0.95);
            --bg-tertiary: rgba(255, 255, 255, 0.9);
            --shadow: rgba(0, 0, 0, 0.1);
            --shadow-hover: rgba(0, 0, 0, 0.15);
            --border-color: rgba(255, 255, 255, 0.3);
            --backdrop-filter: blur(20px);
            --gradient: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        }

        [data-theme="dark"] {
            --text-color: #ffffff;
            --text-light: #cccccc;
            --bg-color: #1a1a1a;
            --bg-secondary: rgba(20, 20, 20, 0.95);
            --bg-tertiary: rgba(30, 30, 30, 0.9);
            --shadow: rgba(0, 0, 0, 0.3);
            --shadow-hover: rgba(0, 0, 0, 0.4);
            --border-color: rgba(255, 255, 255, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--gradient);
            min-height: 100vh;
            position: relative;
            color: var(--text-color);
            transition: all 0.3s ease;
        }

        /* Enhanced Preloader Styles */
        #preloader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--gradient);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease-out;
        }

        .preloader-content {
            text-align: center;
            color: white;
        }

        .loader-animation {
            position: relative;
            width: 120px;
            height: 120px;
            margin: 0 auto 30px;
        }

        .loader-ring {
            position: absolute;
            width: 100%;
            height: 100%;
            border: 3px solid transparent;
            border-radius: 50%;
            animation: rotate 2s linear infinite;
        }

        .loader-ring:nth-child(1) {
            border-top: 3px solid #ffffff;
            animation-delay: 0s;
        }

        .loader-ring:nth-child(2) {
            border-right: 3px solid #ffffff;
            animation-delay: 0.5s;
            width: 80%;
            height: 80%;
            top: 10%;
            left: 10%;
        }

        .loader-ring:nth-child(3) {
            border-bottom: 3px solid #ffffff;
            animation-delay: 1s;
            width: 60%;
            height: 60%;
            top: 20%;
            left: 20%;
        }

        .loader-icon {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 24px;
            color: white;
            animation: pulse 2s ease-in-out infinite;
        }

        .loader-text {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
            animation: fadeInOut 3s ease-in-out infinite;
        }

        .loader-subtext {
            font-size: 14px;
            opacity: 0.8;
            animation: dots 2s ease-in-out infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes pulse {
            0%, 100% { transform: translate(-50%, -50%) scale(1); opacity: 1; }
            50% { transform: translate(-50%, -50%) scale(1.2); opacity: 0.7; }
        }

        @keyframes fadeInOut {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.6; }
        }

        @keyframes dots {
            0%, 20% { content: ''; }
            40% { content: '.'; }
            60% { content: '..'; }
            80%, 100% { content: '...'; }
        }

        /* Header Styles */
        .header {
            background: var(--bg-secondary);
            backdrop-filter: var(--backdrop-filter);
            padding: 5px 0;
            box-shadow: 0 8px 32px var(--shadow);
            margin-bottom: 30px;
            border-bottom: 1px solid var(--border-color);
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo h1 {
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 2.5rem;
            font-weight: bold;
            margin: 0;
        }

        .logo-icon {
            font-size: 2.5rem;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: rotate 10s linear infinite;
        }

        /* Theme Toggle */
        .theme-toggle {
            background: var(--bg-tertiary);
            border: 2px solid var(--border-color);
            border-radius: 25px;
            padding: 10px 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--text-color);
        }

        .theme-toggle:hover {
            background: var(--gradient);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.3);
        }

        /* Location Info Styles */
        .location-info {
            background: var(--bg-tertiary);
            padding: 2px 10px;
            border-radius: 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 4px 20px var(--shadow);
            border: 1px solid var(--border-color);
        }

        .location-details {
            display: flex;
            flex-direction: row;
            gap: 2px;
            justify-content: center;
            align-items: center;
        }

        .location-label {
            font-size: 12px;
            color: var(--text-light);
            font-weight: 500;
        }

        .location-coords {
            font-size: 14px;
            color: var(--text-color);
            font-weight: 600;
        }

        .location-btn {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .location-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.4);
        }

        /* Controls Bar */
        .controls-bar {
            position: sticky;
            top: 0;
            background: var(--bg-secondary);
            backdrop-filter: var(--backdrop-filter);
            padding: 20px;
            z-index: 1000;
            box-shadow: 0 4px 20px var(--shadow);
            margin-bottom: 30px;
            border-bottom: 1px solid var(--border-color);
        }

        .controls-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        /* Filter Bar */
        .filter-bar {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .filter-bar button {
            padding: 12px 25px;
            border: 2px solid transparent;
            border-radius: 25px;
            cursor: pointer;
            background: var(--bg-tertiary);
            color: var(--text-color);
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px var(--shadow);
        }

        .filter-bar button:hover,
        .filter-bar button.active {
            background: var(--gradient);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.3);
        }

        /* View Controls */
        .view-controls {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .view-toggle {
            display: flex;
            background: var(--bg-tertiary);
            border-radius: 25px;
            overflow: hidden;
            box-shadow: 0 4px 15px var(--shadow);
        }

        .view-toggle button {
            padding: 12px 16px;
            border: none;
            background: transparent;
            color: var(--text-color);
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 600;
        }

        .view-toggle button.active {
            background: var(--gradient);
            color: white;
        }

        .sort-dropdown {
            padding: 12px 20px;
            border: none;
            border-radius: 25px;
            background: var(--bg-tertiary);
            color: var(--text-color);
            cursor: pointer;
            box-shadow: 0 4px 15px var(--shadow);
            font-size: 14px;
            font-weight: 600;
        }

        /* Places Grid Styles */
        #places {
            padding: 0 20px 40px;
            max-width: 1400px;
            margin: 0 auto;
            transition: all 0.3s ease;
        }

        .places-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }

        .places-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .card {
            background: var(--bg-secondary);
            border-radius: 20px;
            box-shadow: 0 8px 32px var(--shadow);
            padding: 0;
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            backdrop-filter: var(--backdrop-filter);
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 48px var(--shadow-hover);
        }

        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .card:hover img {
            transform: scale(1.05);
        }

        .card-content {
            padding: 20px;
        }

        .title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 8px;
            color: var(--text-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .price {
            color: var(--accent-color);
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            background: var(--gradient);
            color: white;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.4);
            text-decoration: none;
            color: white;
        }

        /* List View Styles */
        .places-list .card {
            display: flex;
            flex-direction: row;
            min-height: 150px;
        }

        .places-list .card img {
            width: 200px;
            height: 150px;
            flex-shrink: 0;
        }

        .places-list .card-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /* Loading and Error States */
        .loading-state, .error-state {
            text-align: center;
            padding: 60px 20px;
            color: white;
            font-size: 18px;
        }

        .loading-state i, .error-state i {
            font-size: 48px;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }

        /* Stats Bar */
        .stats-bar {
            background: var(--bg-tertiary);
            padding: 15px 20px;
            margin: 20px;
            border-radius: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
            flex-wrap: wrap;
            backdrop-filter: var(--backdrop-filter);
            border: 1px solid var(--border-color);
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--text-color);
            font-weight: 600;
        }

        .stat-item i {
            color: var(--primary-color);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .controls-content {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-bar {
                justify-content: center;
            }

            .view-controls {
                justify-content: center;
            }
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                text-align: center;
            }

            .logo h1 {
                font-size: 2rem;
            }

            .location-info {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }

            .filter-bar {
                justify-content: center;
            }

            .filter-bar button {
                padding: 10px 18px;
                font-size: 13px;
            }

            .places-grid {
                grid-template-columns: 1fr;
            }

            .places-list .card {
                flex-direction: column;
            }

            .places-list .card img {
                width: 100%;
                height: 200px;
            }

            .stats-bar {
                gap: 15px;
            }

            .view-toggle {
                width: 100%;
            }

            .view-toggle button {
                flex: 1;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 10px;
            }

            .controls-bar {
                padding: 15px 10px;
            }

            .stats-bar {
                margin: 20px 10px;
                gap: 10px;
            }

            .stat-item {
                font-size: 14px;
            }

            #places {
                padding: 0 10px 40px;
            }
        }

        /* Fade in animation */
        .fade-in {
            animation: fadeIn 0.6s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Floating Action Button */
        .fab {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: var(--gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .fab:hover {
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.5);
        }
    </style>
</head>
<body data-theme="light">
    <!-- Enhanced Preloader -->
    <div id="preloader">
        <div class="preloader-content">
            <div class="loader-animation">
                <div class="loader-ring"></div>
                <div class="loader-ring"></div>
                <div class="loader-ring"></div>
                <div class="loader-icon">
                    <i class="fas fa-compass"></i>
                </div>
            </div>
            <div class="loader-text">Discovering Amazing Places</div>
            <div class="loader-subtext">Finding the perfect spots for you<span id="dots"></span></div>
        </div>
    </div>

    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-compass logo-icon"></i>
                    <h1>Weekend Explorer</h1>
                </div>
                
                <div style="display: flex; align-items: center; gap: 20px; width: 65%;">
                    
                    
                    <div class="location-info">
                        <i class="fas fa-map-marker-alt" style="color: var(--primary-color); font-size: 20px;"></i>
                        <div class="location-details">
                            <div class="location-label">Current Location</div>
                            <div class="location-coords" id="locationCoords">Getting location...</div>
                            <div class="location-coords">
                                <strong style="display:none;">Area:</strong> <span id="locationArea" style="display:none;">Detecting...</span>
                                <!-- <br> -->
                                <strong>City:</strong> <span id="locationCity">Detecting...</span>
                            </div>
                            <a id="mapBtn" href="#" target="_blank" class="location-btn" >
                                <i class="fas fa-map"></i> View Map
                            </a>
                            <button class="location-btn" onclick="refreshLocation()">
                                <i class="fas fa-sync-alt"></i>
                                Refresh
                            </button>
                        </div>

                    </div>
                    <button class="theme-toggle" onclick="toggleTheme()">
                        <i class="fas fa-moon" id="theme-icon"></i>
                        <span id="theme-text">Dark Mode</span>
                    </button>
                </div>
            </div>
        </div>
    </header>

    <!-- Controls Bar -->
    <div class="controls-bar">
        <div class="controls-content">
            <!-- Filter Bar -->
            <div class="filter-bar">
                <button onclick="setFilter('restaurant')" class="active" data-type="restaurant">
                    <i class="fas fa-utensils"></i>
                    Restaurants
                </button>
                <button onclick="setFilter('hotel')" data-type="hotel">
                    <i class="fas fa-bed"></i>
                    Hotels
                </button>
                <button onclick="setFilter('attraction')" data-type="attraction">
                    <i class="fas fa-camera"></i>
                    Attractions
                </button>
                <button onclick="setFilter('shopping')" data-type="shopping">
                    <i class="fas fa-shopping-bag"></i>
                    Shopping
                </button>
                <button onclick="setFilter('entertainment')" data-type="entertainment">
                    <i class="fas fa-film"></i>
                    Entertainment
                </button>
            </div>

            <!-- View Controls -->
            <div class="view-controls">
                <div class="view-toggle">
                    <button onclick="setView('grid')" class="active" data-view="grid">
                        <i class="fas fa-th"></i>
                        <span>Grid</span>
                    </button>
                    <button onclick="setView('list')" data-view="list">
                        <i class="fas fa-list"></i>
                        <span>List</span>
                    </button>
                </div>
                
                <select class="sort-dropdown" onchange="sortPlaces(this.value)">
                    <option value="default">Sort by Default</option>
                    <option value="name">Sort by Name</option>
                    <option value="price">Sort by Price</option>
                    <option value="distance">Sort by Distance</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Stats Bar -->
    <div class="stats-bar">
        <div class="stat-item">
            <i class="fas fa-map-marker-alt"></i>
            <span>Location: <span id="currentLocation">Detecting...</span></span>
        </div>
        <div class="stat-item">
            <i class="fas fa-list-ol"></i>
            <span>Found: <span id="placeCount">0</span> places</span>
        </div>
        <div class="stat-item">
            <i class="fas fa-clock"></i>
            <span>Updated: <span id="lastUpdate">Just now</span></span>
        </div>
    </div>

    <!-- Places Container -->
    <div id="places" class="places-grid">
        <div class="loading-state">
            <i class="fas fa-compass"></i>
            <div>Discovering amazing places near you...</div>
        </div>
    </div>

    <!-- Floating Action Button -->
    <div class="fab" onclick="scrollToTop()" title="Back to top">
        <i class="fas fa-chevron-up"></i>
    </div>

    <script>
        let currentLat = null, currentLon = null, currentType = "restaurant", currentView = "grid";
        let allPlaces = [];

        // Hide preloader after page loads
        window.addEventListener('load', () => {
            setTimeout(() => {
                document.getElementById('preloader').style.opacity = '0';
                setTimeout(() => {
                    document.getElementById('preloader').style.display = 'none';
                }, 500);
            }, 2500);
        });

        // Theme toggle functionality
        function toggleTheme() {
            const body = document.body;
            const themeIcon = document.getElementById('theme-icon');
            const themeText = document.getElementById('theme-text');
            
            if (body.getAttribute('data-theme') === 'light') {
                body.setAttribute('data-theme', 'dark');
                themeIcon.className = 'fas fa-sun';
                themeText.textContent = 'Light Mode';
                localStorage.setItem('theme', 'dark');
            } else {
                body.setAttribute('data-theme', 'light');
                themeIcon.className = 'fas fa-moon';
                themeText.textContent = 'Dark Mode';
                localStorage.setItem('theme', 'light');
            }
        }

        // Load saved theme
        function loadTheme() {
            const savedTheme = localStorage.getItem('theme') || 'light';
            const body = document.body;
            const themeIcon = document.getElementById('theme-icon');
            const themeText = document.getElementById('theme-text');
            
            body.setAttribute('data-theme', savedTheme);
            if (savedTheme === 'dark') {
                themeIcon.className = 'fas fa-sun';
                themeText.textContent = 'Light Mode';
            }
        }

        // View toggle functionality
        function setView(view) {
            currentView = view;
            const placesContainer = document.getElementById('places');
            const viewButtons = document.querySelectorAll('.view-toggle button');
            
            viewButtons.forEach(btn => btn.classList.remove('active'));
            document.querySelector('[data-view="' + view + '"]').classList.add('active');
            
            if (view === 'grid') {
                placesContainer.className = 'places-grid';
            } else {
                placesContainer.className = 'places-list';
            }
            
            localStorage.setItem('view', view);
        }

        // Load saved view
        function loadView() {
            const savedView = localStorage.getItem('view') || 'grid';
            setView(savedView);
        }

        // Scroll to top functionality
        function scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        }

        // Sort places functionality
        function sortPlaces(criteria) {
            if (allPlaces.length === 0) return;
            
            let sortedPlaces = [...allPlaces];
            
            switch(criteria) {
                case 'name':
                    sortedPlaces.sort((a, b) => a.name.localeCompare(b.name));
                    break;
                case 'price':
                    sortedPlaces.sort((a, b) => a.priceLevel.localeCompare(b.priceLevel));
                    break;
                case 'distance':
                    // Assuming distance calculation would be implemented
                    break;
                default:
                    // Keep original order
                    break;
            }
            
            displayPlaces(sortedPlaces);
        }

        function updateLocationDisplay(lat, lon) {
            const coords = lat.toFixed(4) + ", " + lon.toFixed(4);
            document.getElementById('locationCoords').textContent = coords;
            document.getElementById('currentLocation').textContent = coords;

            // Update map button link
            const mapBtn = document.getElementById('mapBtn');
            mapBtn.href = "https://www.google.com/maps?q=" + lat + "," + lon;

            // Fetch city and area using reverse geocoding
            fetch("https://nominatim.openstreetmap.org/reverse?format=json&lat=" + lat + "&lon=" + lon)
                .then(response => response.json())
                .then(data => {
                    const address = data.address;
                    const area = address.suburb || address.neighbourhood || address.village || "Unknown area";
                    const city = address.city || address.town || address.state || "Unknown city";

                    document.getElementById('locationArea').textContent = area;
                    document.getElementById('locationCity').textContent = city;
                    document.getElementById('currentLocation').textContent = city + ", " + area;
                })
                .catch(error => {
                    console.error("Reverse geocoding failed:", error);
                    document.getElementById('locationArea').textContent = "Area not found";
                    document.getElementById('locationCity').textContent = "City not found";
                });
        }

        function refreshLocation() {
            const btn = document.querySelector('.location-btn');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Getting...';

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(pos => {
                    currentLat = pos.coords.latitude;
                    currentLon = pos.coords.longitude;
                    updateLocationDisplay(currentLat, currentLon);
                    fetchPlaces(currentLat, currentLon, currentType);
                    btn.innerHTML = '<i class="fas fa-sync-alt"></i> Refresh';
                }, () => {
                    btn.innerHTML = '<i class="fas fa-sync-alt"></i> Refresh';
                    alert('Unable to get your location. Using default location.');
                });
            }
        }

        function setFilter(type) {
            currentType = type;

            document.querySelectorAll('.filter-bar button').forEach(btn => {
                btn.classList.remove('active');
            });
            document.querySelector('[data-type="' + type + '"]').classList.add('active');

            fetchPlaces(currentLat, currentLon, currentType);
        }

        function getPlaceIcon(type) {
            switch(type) {
                case 'restaurant': return 'fas fa-utensils';
                case 'hotel': return 'fas fa-bed';
                case 'attraction': return 'fas fa-camera';
                case 'shopping': return 'fas fa-shopping-bag';
                case 'entertainment': return 'fas fa-film';
                default: return 'fas fa-map-marker-alt';
            }
        }

        function displayPlaces(places) {
            const container = document.getElementById("places");
            container.innerHTML = "";

            if (places.length === 0) {
                container.innerHTML = 
                    '<div class="error-state">' +
                        '<i class="fas fa-search"></i>' +
                        '<div>No ' + currentType + 's found in this area. Try a different location!</div>' +
                    '</div>';
                return;
            }

            places.forEach((place, index) => {
                const div = document.createElement("div");
                div.className = "card fade-in";
                div.style.animationDelay = (index * 0.1) + "s";

                div.innerHTML = 
                    '<img src="' + place.imageUrl + '" alt="' + place.name + '" loading="lazy">' +
                    '<div class="card-content">' +
                        '<div class="title">' +
                            '<i class="' + getPlaceIcon(currentType) + '"></i>' +
                            place.name +
                        '</div>' +
                        '<div class="price">' +
                            '<i class="fas fa-dollar-sign"></i>' +
                            place.priceLevel +
                        '</div>' +
                        '<div style="display: flex; gap: 10px; flex-wrap: wrap;">' +
                            '<a href="https://www.google.com/maps/search/?api=1&query=' + place.latitude + ',' + place.longitude + '"' +
                                ' target="_blank" class="btn">' +
                                '<i class="fas fa-map-marked-alt"></i>' +
                                'Open in Maps' +
                            '</a>' +
                            '<a href="#" class="btn" style="background: var(--accent-color);" onclick="sharePlace(\'' + place.name + '\', ' + place.latitude + ', ' + place.longitude + ')">' +
                                '<i class="fas fa-share-alt"></i>' +
                                'Share' +
                            '</a>' +
                        '</div>' +
                    '</div>';
                container.appendChild(div);
            });

            // Update stats
            document.getElementById('placeCount').textContent = places.length;
            document.getElementById('lastUpdate').textContent = new Date().toLocaleTimeString();
        }

        function sharePlace(name, lat, lon) {
            if (navigator.share) {
                navigator.share({
                    title: 'Check out ' + name,
                    text: 'Found this amazing place on Weekend Explorer!',
                    url: 'https://www.google.com/maps/search/?api=1&query=' + lat + ',' + lon
                });
            } else {
                // Fallback to clipboard
                const url = 'https://www.google.com/maps/search/?api=1&query=' + lat + ',' + lon;
                navigator.clipboard.writeText(url).then(() => {
                    alert('Location link copied to clipboard!');
                });
            }
        }

        function fetchPlaces(lat, lon, type = "restaurant") {
            const container = document.getElementById("places");
            container.innerHTML = 
                '<div class="loading-state">' +
                    '<i class="fas fa-compass"></i>' +
                    '<div>Finding the best ' + type + 's near you...</div>' +
                '</div>';

            const url = '/api/nearby?lat=' + lat + '&lng=' + lon + '&type=' + type;
            fetch(url)
                .then(res => res.json())
                .then(data => {
                    const places = Array.isArray(data) ? data : [];
                    allPlaces = places;
                    displayPlaces(places);
                })
                .catch(err => {
                    console.error("Error fetching places:", err);
                    // For demo purposes, show mock data
                    const mockPlaces = generateMockData(type);
                    allPlaces = mockPlaces;
                    displayPlaces(mockPlaces);
                });
        }

        // Mock data generator for demo purposes
        function generateMockData(type) {
            const mockData = {
                restaurant: [
                    { name: "The Gourmet Kitchen", imageUrl: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400", priceLevel: "$$", latitude: 12.9716, longitude: 77.5946 },
                    { name: "Spice Garden", imageUrl: "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400", priceLevel: "$$", latitude: 12.9750, longitude: 77.5940 },
                    { name: "Ocean Breeze Cafe", imageUrl: "https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400", priceLevel: "$", latitude: 12.9700, longitude: 77.5950 },
                    { name: "Mountain View Bistro", imageUrl: "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400", priceLevel: "$$", latitude: 12.9680, longitude: 77.5930 }
                ],
                hotel: [
                    { name: "Luxury Palace Hotel", imageUrl: "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400", priceLevel: "$$", latitude: 12.9720, longitude: 77.5945 },
                    { name: "Comfort Inn & Suites", imageUrl: "https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=400", priceLevel: "$$", latitude: 12.9710, longitude: 77.5955 },
                    { name: "Budget Traveler Lodge", imageUrl: "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400", priceLevel: "$", latitude: 12.9690, longitude: 77.5935 }
                ],
                attraction: [
                    { name: "Historic City Museum", imageUrl: "https://images.unsplash.com/photo-1459213599465-03ab6a4d5931?w=400", priceLevel: "$", latitude: 12.9730, longitude: 77.5940 },
                    { name: "Botanical Gardens", imageUrl: "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400", priceLevel: "Free", latitude: 12.9705, longitude: 77.5960 },
                    { name: "Adventure Park", imageUrl: "https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=400", priceLevel: "$$", latitude: 12.9695, longitude: 77.5925 }
                ],
                shopping: [
                    { name: "Grand Shopping Mall", imageUrl: "https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400", priceLevel: "$", latitude: 12.9725, longitude: 77.5948 },
                    { name: "Local Artisan Market", imageUrl: "https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=400", priceLevel: "$", latitude: 12.9715, longitude: 77.5938 },
                    { name: "Fashion District", imageUrl: "https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400", priceLevel: "$$", latitude: 12.9708, longitude: 77.5952 }
                ],
                entertainment: [
                    { name: "Cinema Complex", imageUrl: "https://images.unsplash.com/photo-1489599904510-b5b8625d9b96?w=400", priceLevel: "$", latitude: 12.9712, longitude: 77.5942 },
                    { name: "Gaming Zone", imageUrl: "https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400", priceLevel: "$$", latitude: 12.9702, longitude: 77.5932 },
                    { name: "Live Music Venue", imageUrl: "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400", priceLevel: "$$", latitude: 12.9722, longitude: 77.5958 }
                ]
            };
            return mockData[type] || [];
        }

        // Initialize the app
        function initializeApp() {
            loadTheme();
            loadView();
            
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(pos => {
                    currentLat = pos.coords.latitude;
                    currentLon = pos.coords.longitude;
                    updateLocationDisplay(currentLat, currentLon);
                    fetchPlaces(currentLat, currentLon, currentType);
                }, () => {
                    // Default to Bangalore coordinates
                    currentLat = 12.9716;
                    currentLon = 77.5946;
                    updateLocationDisplay(currentLat, currentLon);
                    fetchPlaces(currentLat, currentLon, currentType);
                });
            } else {
                currentLat = 12.9716;
                currentLon = 77.5946;
                updateLocationDisplay(currentLat, currentLon);
                fetchPlaces(currentLat, currentLon, currentType);
            }
        }

        // Smooth scrolling for navigation
        document.addEventListener('DOMContentLoaded', function() {
            // Show/hide FAB based on scroll position
            window.addEventListener('scroll', function() {
                const fab = document.querySelector('.fab');
                if (window.pageYOffset > 300) {
                    fab.style.opacity = '1';
                    fab.style.visibility = 'visible';
                } else {
                    fab.style.opacity = '0';
                    fab.style.visibility = 'hidden';
                }
            });

            // Initialize the app
            initializeApp();
        });

        // Add some loading animations for dots
        setInterval(() => {
            const dotsElement = document.getElementById('dots');
            if (dotsElement) {
                const currentText = dotsElement.textContent;
                if (currentText === '') {
                    dotsElement.textContent = '.';
                } else if (currentText === '.') {
                    dotsElement.textContent = '..';
                } else if (currentText === '..') {
                    dotsElement.textContent = '...';
                } else {
                    dotsElement.textContent = '';
                }
            }
        }, 500);

        // Add keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'k') {
                e.preventDefault();
                document.querySelector('.filter-bar button').focus();
            }
            if (e.key === 'Escape') {
                scrollToTop();
            }
        });

    </script>

</body>
</html>