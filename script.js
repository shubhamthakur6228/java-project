<script>
const addToCartButtons = document.querySelectorAll('.item button');
addToCartButtons.forEach(button => {
    button.addEventListener('click', function () {
        alert("Item added to cart!");
    });
});
</script>
