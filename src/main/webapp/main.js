document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('search-input');
    const searchResults = document.getElementById('search-results');
    
    function filterRestaurants(searchTerm) {
        if (!searchTerm) return [];
        searchTerm = searchTerm.toLowerCase();
        
        // This will be populated by the JSP with actual restaurant data
        const restaurants = window.restaurants || [];
        
        return restaurants.filter(restaurant => 
            restaurant.name.toLowerCase().includes(searchTerm) ||
            restaurant.cuisine.toLowerCase().includes(searchTerm)
        );
    }

    searchInput.addEventListener('input', function(e) {
        const searchTerm = e.target.value.trim();
        if (searchTerm) {
            const filteredResults = filterRestaurants(searchTerm);
            // Handle the filtered results - you might want to update the UI here
            // or make an AJAX call to get fresh results from the server
        }
    });

    // Close search results when clicking outside
    document.addEventListener('click', function(e) {
        if (searchResults && !searchInput.contains(e.target) && !searchResults.contains(e.target)) {
            searchResults.style.display = 'none';
        }
    });
});