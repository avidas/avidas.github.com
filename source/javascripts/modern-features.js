// Modern features for 2025 Octopress theme

document.addEventListener('DOMContentLoaded', function() {
  // Initialize dark mode
  initDarkMode();
  
  // Initialize modern animations
  initAnimations();
  
  // Add sharing button functionality
  initSharingButtons();
  
  // Make images zoomable
  initImageZoom();
  
  // Add estimated reading time
  addReadingTime();
});

// Dark mode functionality
function initDarkMode() {
  // Check for system preference
  const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
  
  // Check for user preference in localStorage
  const savedMode = localStorage.getItem('darkMode');
  
  // Set initial mode
  if (savedMode === 'dark' || (savedMode !== 'light' && prefersDarkMode)) {
    document.documentElement.classList.add('dark-mode');
  }
  
  // Create dark mode toggle
  const header = document.querySelector('body > header');
  if (header) {
    const darkModeToggle = document.createElement('button');
    darkModeToggle.classList.add('dark-mode-toggle');
    darkModeToggle.innerHTML = '<i class="fas fa-moon"></i>';
    darkModeToggle.setAttribute('aria-label', 'Toggle dark mode');
    darkModeToggle.setAttribute('title', 'Toggle dark mode');
    
    darkModeToggle.addEventListener('click', function() {
      document.documentElement.classList.toggle('dark-mode');
      
      // Save preference
      if (document.documentElement.classList.contains('dark-mode')) {
        localStorage.setItem('darkMode', 'dark');
        this.innerHTML = '<i class="fas fa-sun"></i>';
      } else {
        localStorage.setItem('darkMode', 'light');
        this.innerHTML = '<i class="fas fa-moon"></i>';
      }
    });
    
    // Set correct icon based on current mode
    if (document.documentElement.classList.contains('dark-mode')) {
      darkModeToggle.innerHTML = '<i class="fas fa-sun"></i>';
    }
    
    header.appendChild(darkModeToggle);
  }
}

// Animations
function initAnimations() {
  // Add fade-in animation to articles
  const articles = document.querySelectorAll('article');
  articles.forEach((article, index) => {
    article.style.opacity = '0';
    article.style.transform = 'translateY(20px)';
    article.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
    
    // Stagger the animations
    setTimeout(() => {
      article.style.opacity = '1';
      article.style.transform = 'translateY(0)';
    }, 100 * index);
  });
}

// Social sharing functionality
function initSharingButtons() {
  const sharingContainers = document.querySelectorAll('.sharing');
  
  sharingContainers.forEach(container => {
    const links = container.querySelectorAll('a');
    
    links.forEach(link => {
      link.addEventListener('click', function(e) {
        e.preventDefault();
        
        const url = this.getAttribute('href');
        window.open(url, 'share-dialog', 'width=626,height=436');
      });
    });
    
    // Add LinkedIn and Reddit sharing if they don't exist
    if (!container.querySelector('.linkedin')) {
      const postUrl = encodeURIComponent(window.location.href);
      const postTitle = encodeURIComponent(document.title);
      
      const linkedinLink = document.createElement('a');
      linkedinLink.classList.add('linkedin');
      linkedinLink.href = `https://www.linkedin.com/sharing/share-offsite/?url=${postUrl}`;
      linkedinLink.innerHTML = '<i class="fab fa-linkedin-in"></i> LinkedIn';
      
      const redditLink = document.createElement('a');
      redditLink.classList.add('reddit');
      redditLink.href = `https://www.reddit.com/submit?url=${postUrl}&title=${postTitle}`;
      redditLink.innerHTML = '<i class="fab fa-reddit-alien"></i> Reddit';
      
      container.appendChild(linkedinLink);
      container.appendChild(redditLink);
      
      // Add event listeners to new buttons
      linkedinLink.addEventListener('click', function(e) {
        e.preventDefault();
        window.open(this.getAttribute('href'), 'share-dialog', 'width=626,height=436');
      });
      
      redditLink.addEventListener('click', function(e) {
        e.preventDefault();
        window.open(this.getAttribute('href'), 'share-dialog', 'width=626,height=436');
      });
    }
  });
}

// Image zoom functionality
function initImageZoom() {
  const contentImages = document.querySelectorAll('#content img:not(.no-zoom)');
  
  contentImages.forEach(img => {
    // Make images clickable
    img.style.cursor = 'zoom-in';
    
    img.addEventListener('click', function() {
      // Create modal
      const modal = document.createElement('div');
      modal.classList.add('image-zoom-modal');
      modal.style.position = 'fixed';
      modal.style.top = '0';
      modal.style.left = '0';
      modal.style.width = '100%';
      modal.style.height = '100%';
      modal.style.backgroundColor = 'rgba(0, 0, 0, 0.9)';
      modal.style.display = 'flex';
      modal.style.alignItems = 'center';
      modal.style.justifyContent = 'center';
      modal.style.zIndex = '9999';
      modal.style.cursor = 'zoom-out';
      
      // Create zoomed image
      const zoomedImg = document.createElement('img');
      zoomedImg.src = this.src;
      zoomedImg.style.maxWidth = '90%';
      zoomedImg.style.maxHeight = '90%';
      zoomedImg.style.objectFit = 'contain';
      zoomedImg.style.boxShadow = 'none';
      
      // Add close button
      const closeBtn = document.createElement('button');
      closeBtn.innerHTML = '×';
      closeBtn.style.position = 'absolute';
      closeBtn.style.top = '20px';
      closeBtn.style.right = '20px';
      closeBtn.style.background = 'none';
      closeBtn.style.border = 'none';
      closeBtn.style.color = 'white';
      closeBtn.style.fontSize = '36px';
      closeBtn.style.cursor = 'pointer';
      
      // Add elements to modal
      modal.appendChild(zoomedImg);
      modal.appendChild(closeBtn);
      
      // Add modal to body
      document.body.appendChild(modal);
      
      // Add event listeners to close modal
      modal.addEventListener('click', function() {
        document.body.removeChild(modal);
      });
      
      closeBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        document.body.removeChild(modal);
      });
      
      // Prevent closing when clicking on image
      zoomedImg.addEventListener('click', function(e) {
        e.stopPropagation();
      });
      
      // Close on escape key
      document.addEventListener('keydown', function escapeClose(e) {
        if (e.key === 'Escape') {
          document.body.removeChild(modal);
          document.removeEventListener('keydown', escapeClose);
        }
      });
    });
  });
}

// Add estimated reading time
function addReadingTime() {
  const articles = document.querySelectorAll('article');
  
  articles.forEach(article => {
    // Only add reading time if it doesn't already exist
    if (!article.querySelector('.reading-time')) {
      const content = article.querySelector('.entry-content');
      
      if (content) {
        const text = content.textContent;
        const wordCount = text.split(/\s+/).length;
        const readingTime = Math.ceil(wordCount / 200); // Average reading speed: 200 words per minute
        
        // Create reading time element
        const readingTimeEl = document.createElement('span');
        readingTimeEl.classList.add('reading-time');
        readingTimeEl.innerHTML = `<i class="far fa-clock"></i> ${readingTime} min read`;
        
        // Add to article meta
        const meta = article.querySelector('p.meta');
        if (meta) {
          meta.appendChild(document.createTextNode(' • '));
          meta.appendChild(readingTimeEl);
        }
      }
    }
  });
}