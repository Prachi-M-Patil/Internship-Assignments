document.addEventListener('DOMContentLoaded', function() {
    const categoryDropdown = document.getElementById('category');
    const priceDropdown = document.getElementById('price');
    const searchBar = document.getElementById('search-bar');
    const productCards = document.querySelectorAll('.product-card');
    const cart = JSON.parse(localStorage.getItem('cart')) || [];

    if (categoryDropdown && priceDropdown) {
        categoryDropdown.addEventListener('change', filterProducts);
        priceDropdown.addEventListener('change', filterProducts);
    }

    if (searchBar) {
        searchBar.addEventListener('input', searchProducts);
    }

    if (productCards.length > 0) {
        productCards.forEach(card => {
            card.querySelector('.add-to-cart').addEventListener('click', function() {
                addToCart(card);
            });
        });
    }

    function filterProducts() {
        const selectedCategory = categoryDropdown.value;
        const selectedPrice = priceDropdown.value;

        productCards.forEach(card => {
            const productCategory = card.getAttribute('data-category');
            const productPrice = parseFloat(card.getAttribute('data-price'));

            let categoryMatch = (selectedCategory === 'all') || (selectedCategory === productCategory);
            let priceMatch = false;

            if (selectedPrice === 'all') {
                priceMatch = true;
            } else if (selectedPrice === 'low') {
                priceMatch = productPrice < 500;
            } else if (selectedPrice === 'medium') {
                priceMatch = productPrice >= 500 && productPrice <= 1000;
            } else if (selectedPrice === 'high') {
                priceMatch = productPrice > 1000;
            }

            if (categoryMatch && priceMatch) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    function searchProducts() {
        const searchTerm = searchBar.value.toLowerCase();

        productCards.forEach(card => {
            const productName = card.querySelector('h4').innerText.toLowerCase();
            if (productName.includes(searchTerm)) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    function addToCart(card) {
        const productName = card.querySelector('h4').innerText;
        const productPrice = card.querySelector('p:nth-of-type(2)').innerText.replace('Price: $', '');
        cart.push({ name: productName, price: parseFloat(productPrice) });
        localStorage.setItem('cart', JSON.stringify(cart));
        updateCartSummary();
    }

    function removeFromCart(index) {
        cart.splice(index, 1);
        localStorage.setItem('cart', JSON.stringify(cart));
        updateCartSummary();
        if (document.getElementById('cart-items')) {
            displayCartItems();
        }
    }

    function updateCartSummary() {
        const cartSummary = document.querySelector('.cart-summary ul');
        const cartTotal = document.querySelector('.cart-summary p');
        cartSummary.innerHTML = '';
        let total = 0;
    
        cart.forEach((item, index) => {
            const price = parseFloat(item.price);
            if (isNaN(price)) {
                console.error(`Invalid price for item: ${item.name}`);
                return;
            }
    
            const li = document.createElement('li');
            li.innerHTML = `${item.name}: $${price.toFixed(2)} <button class="remove-from-cart" data-index="${index}">Remove</button>`;
            cartSummary.appendChild(li);
            total += price;
        });
    
        cartTotal.innerText = `Total: $${total.toFixed(2)}`;
    
        document.querySelectorAll('.remove-from-cart').forEach(button => {
            button.addEventListener('click', function() {
                const index = this.getAttribute('data-index');
                removeFromCart(index);
            });
        });
    }
    

    function displayCartItems() {
        const cartItemsContainer = document.getElementById('cart-items');
        const cartTotal = document.getElementById('cart-total');
        cartItemsContainer.innerHTML = '';
        let total = 0;
    
        cart.forEach((item, index) => {
            const price = parseFloat(item.price);
            if (isNaN(price)) {
                console.error(`Invalid price for item: ${item.name}`);
                return;
            }
    
            const li = document.createElement('li');
            li.innerHTML = `${item.name}: $${price.toFixed(2)} <button class="remove-from-cart" data-index="${index}">Remove</button>`;
            cartItemsContainer.appendChild(li);
            total += price;
        });
    
        cartTotal.innerText = `Total: $${total.toFixed(2)}`;
    
        document.querySelectorAll('.remove-from-cart').forEach(button => {
            button.addEventListener('click', function() {
                const index = this.getAttribute('data-index');
                removeFromCart(index);
            });
        });
    }
    
    if (document.getElementById('cart-items')) {
        displayCartItems();
    }
    
    // updateCartSummary();
})












