// Add this to your existing JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Prevent popup from showing on mobile devices
    if (window.innerWidth > 768) {
        const restaurantCards = document.querySelectorAll('.restaurant-card');
        
        restaurantCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.querySelector('.popup-overlay').style.opacity = '1';
                this.querySelector('.popup-overlay').style.visibility = 'visible';
            });
            
            card.addEventListener('mouseleave', function() {
                this.querySelector('.popup-overlay').style.opacity = '0';
                this.querySelector('.popup-overlay').style.visibility = 'hidden';
            });
        });
    }
});