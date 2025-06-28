function refreshPage() {
    window.location.reload();
}

// Optional: Auto-refresh every 30 seconds
// Uncomment the line below if you want automatic refresh
// setInterval(refreshPage, 30000);

// Optional: Add a loading state to the refresh button
function refreshPageWithLoading() {
    const button = document.querySelector('.refresh-btn');
    const originalText = button.textContent;
    
    button.textContent = 'Refreshing...';
    button.disabled = true;
    
    setTimeout(() => {
        window.location.reload();
    }, 500);
}

// Optional: Replace the onclick with the loading version
// Uncomment to use the loading version instead:
// document.addEventListener('DOMContentLoaded', function() {
//     const refreshBtn = document.querySelector('.refresh-btn');
//     refreshBtn.onclick = refreshPageWithLoading;
// });