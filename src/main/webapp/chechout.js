document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('checkoutForm');
    const confirmBtn = document.getElementById('confirmBtn');
    const successMessage = document.getElementById('successMessage');

    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Add loading state
            confirmBtn.classList.add('loading');
            confirmBtn.disabled = true;
            
            // Hide button text while loading
            confirmBtn.innerHTML = '';
            
            // Simulate form submission (replace with actual form submission)
            setTimeout(() => {
                confirmBtn.classList.remove('loading');
                successMessage.style.display = 'block';
                
                // Smooth scroll to success message
                successMessage.scrollIntoView({ behavior: 'smooth' });
                
                // Redirect after showing success message
                setTimeout(() => {
                    window.location.href = 'order-confirmation.jsp';
                }, 2000);
            }, 1500);
        });
    }

    // Add animation delay to form groups
    const formGroups = document.querySelectorAll('.form-group');
    formGroups.forEach((group, index) => {
        group.style.animationDelay = `${index * 0.1}s`;
    });

    // Phone number validation
    const phoneInput = document.getElementById('receiverPhone');
    if (phoneInput) {
        phoneInput.addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);
        });
    }

    // Add ripple effect to buttons
    const buttons = document.querySelectorAll('button');
    buttons.forEach(button => {
        button.addEventListener('click', function(e) {
            const ripple = document.createElement('span');
            const rect = button.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size/2;
            const y = e.clientY - rect.top - size/2;
            
            ripple.style.width = ripple.style.height = `${size}px`;
            ripple.style.left = `${x}px`;
            ripple.style.top = `${y}px`;
            
            button.appendChild(ripple);
            
            setTimeout(() => ripple.remove(), 600);
        });
    });
});