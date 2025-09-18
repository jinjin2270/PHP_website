// Cookie Consent Logic
window.addEventListener("load", () => {
    // Check if user is new (no session and not dismissed welcome modal)
  const isNewUser = !localStorage.getItem("welcomeModalDismissed") && !localStorage.getItem("cookiesAccepted");

  // Show cookie consent if not accepted
  if (!localStorage.getItem("cookiesAccepted")) {
    document.getElementById("cookieConsent").style.display = "block";
  }

  // Show welcome modal for new users
  if (isNewUser) {
    document.getElementById("joinModal").style.display = "block";
  }

  // Cookie consent buttons
  document.getElementById("acceptCookies").onclick = () => {
    localStorage.setItem("cookiesAccepted", "true");
    document.getElementById("cookieConsent").style.display = "none";
  };

  document.getElementById("declineCookies").onclick = () => {
    document.getElementById("cookieConsent").style.display = "none";
  };

  // Close welcome modal handler
  const welcomeCloseBtn = document.querySelector(".welcome-modal .close-modal");
  if (welcomeCloseBtn) {
    welcomeCloseBtn.onclick = () => {
      const modal = document.getElementById("joinModal");
      if (modal) modal.style.display = "none";
      localStorage.setItem("welcomeModalDismissed", "true");
    };
}

document.getElementById("mobile-menu").addEventListener("click", function () {
  document.querySelector(".nav-menu").classList.toggle("active");
});

  
});

// Modal Controls
function closeModals() {
  document.querySelectorAll(".modal").forEach(m => {
    m.style.display = "none";
    if (m.classList.contains("welcome-modal")) {
      localStorage.setItem("welcomeModalDismissed", "true");
    }
  });
}

window.onclick = function (event) {
  document.querySelectorAll(".modal").forEach(modal => {
    if (event.target === modal) modal.style.display = "none";
  });
};

document.querySelectorAll(".close-modal").forEach(btn => {
  btn.addEventListener("click", closeModals);
});

document.getElementById("joinBtn")?.addEventListener("click", () => {
  document.getElementById("joinModal").style.display = "block";
});
document.getElementById("loginBtn")?.addEventListener("click", () => {
  document.getElementById("loginModal").style.display = "block";
});
document.getElementById("joinHeroBtn")?.addEventListener("click", () => {
  document.getElementById("joinModal").style.display = "block";
});
document.getElementById("joinCtaBtn")?.addEventListener("click", () => {
  document.getElementById("joinModal").style.display = "block";
});
// Show Login handler
document.getElementById("showLogin")?.addEventListener("click", (e) => {
  e.preventDefault();
  closeModals();
  document.getElementById("loginModal").style.display = "block";
});

// Forgot password link opens the reset modal
document.getElementById("forgotPasswordLink")?.addEventListener("click", (e) => {
  e.preventDefault();
  closeModals(); // Hide other modals
  document.getElementById("forgotPasswordModal").style.display = "block";
});


// For the welcome form
const welcomeJoinForm = document.getElementById("welcome-joinForm");
if (welcomeJoinForm) {
  welcomeJoinForm.addEventListener("submit", async function (e) {
    e.preventDefault();
    const formData = new FormData(this);
    // Same submission logic as your regular join form
    await handleFormSubmission(formData);
  });
}

// For the regular join form
const joinForm = document.getElementById("joinForm");
if (joinForm) {
  joinForm.addEventListener("submit", async function (e) {
    e.preventDefault();
    const formData = new FormData(this);
    await handleFormSubmission(formData);
  });
}

// Shared submission handler
async function handleFormSubmission(formData) {
  try {
    const basePath = window.location.pathname.includes("/Pages/") ? "../API/" : "./API/";
    const res = await fetch(basePath + "register.php", {
      method: "POST",
      body: formData
    });
    const result = await res.json();
    
    if (result.message) {
      closeModals();
      alert("Welcome! Your account has been created.");
    } else {
      alert(result.error || "Registration failed");
    }
  } catch (error) {
    console.error("Registration error:", error);
    alert("An error occurred during registration.");
  }
}


// Login AJAX with Lockout Handling
const loginForm = document.getElementById("loginForm");
if (loginForm) {
  loginForm.addEventListener("submit", async function (e) {
    e.preventDefault();
    const lockMessage = document.getElementById('lockMessage');
    lockMessage.style.display = 'none';
    
    const formData = new FormData(this);
    try {
      const basePath = window.location.pathname.includes("/Pages/") ? "../API/" : "./API/";
      const res = await fetch(basePath + "login.php", {
        method: "POST",
        body: formData
      });
      const result = await res.json();

      if (result.error && result.error.includes("Locked")) {
        startLockoutCountdown();
      } else if (result.success) {
        closeModals();
        if (window.location.pathname.includes("community.html")) {
          loadCommunityContent();
        }
         const authButtons = document.getElementById("authButtons");
        const userProfile = document.getElementById("userProfile");
        const profileEmail = document.getElementById("profileEmail");
        
        if (authButtons) authButtons.style.display = "none";
        if (userProfile) userProfile.style.display = "block";
        if (profileEmail && result.email) profileEmail.textContent = result.email;
        
      } else {
        alert(result.error || "Login failed");
      }
    } catch (error) {
      console.error("Login error:", error);
      alert("An error occurred during login.");
    }
  });
}

// Reset Password Functionality
const resetPasswordForm = document.getElementById("resetPasswordForm");
if (resetPasswordForm) {
  resetPasswordForm.addEventListener("submit", async function (e) {
    e.preventDefault();
    const formData = new FormData(this);
    const messageBox = document.getElementById("resetMessage");

    try {
      const basePath = window.location.pathname.includes("/Pages/") ? "../API/" : "./API/";
      const res = await fetch(basePath + "reset_password.php", {
        method: "POST",
        body: formData
      });

      const result = await res.json();

      if (result.success) {
        messageBox.textContent = "Password has been reset successfully!";
        messageBox.style.color = "green";
        resetPasswordForm.reset();
      } else {
        messageBox.textContent = result.error || "Reset failed.";
        messageBox.style.color = "red";
      }
    } catch (err) {
      console.error("Password reset error:", err);
      messageBox.textContent = "Something went wrong.";
      messageBox.style.color = "red";
    }
  });
}


// Lockout Countdown Function
function startLockoutCountdown() {
  const countdownEl = document.getElementById('countdown');
  const lockMessage = document.getElementById('lockMessage');
  const loginBtn = document.getElementById('loginBtnSubmit');
  
  lockMessage.style.display = 'block';
  if (loginBtn) loginBtn.disabled = true;
  
  let minutes = 3;
  let seconds = 0;
  
  const interval = setInterval(() => {
    seconds--;
    if (seconds < 0) {
      minutes--;
      seconds = 59;
    }
    
    countdownEl.textContent = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
    
    if (minutes <= 0 && seconds <= 0) {
      clearInterval(interval);
      lockMessage.style.display = 'none';
      if (loginBtn) loginBtn.disabled = false;
    }
  }, 1000);
}

// Reset login form when modal opens
function resetLoginForm() {
  const lockMessage = document.getElementById('lockMessage');
  const loginBtn = document.getElementById('loginBtnSubmit');
  
  if (lockMessage) lockMessage.style.display = 'none';
  if (loginBtn) loginBtn.disabled = false;
}



// Dropdown toggle functionality
const profileDropdown = document.getElementById('profileDropdown');
if (profileDropdown) {
    profileDropdown.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        const dropdownMenu = this.nextElementSibling;
        dropdownMenu.classList.toggle('show');
    });
}

// Close dropdown when clicking outside
document.addEventListener('click', function() {
    const dropdowns = document.querySelectorAll('.dropdown-menu');
    dropdowns.forEach(dropdown => {
        dropdown.classList.remove('show');
    });
});

// Logout handler
const logoutBtn = document.getElementById("logoutBtn");
if (logoutBtn) {
  logoutBtn.addEventListener("click", async () => {
    const basePath = window.location.pathname.includes("/Pages/") ? "../API/" : "./API/";
    await fetch(basePath + "logout.php");
    checkLoginStatus();
  });
}

// Recipe Search and Filter
async function fetchRecipes() {
  const searchEl = document.getElementById('searchBox');
  const cuisineEl = document.getElementById('filterCuisine');
  const dietEl = document.getElementById('filterDiet');
  const difficultyEl = document.getElementById('filterDifficulty');

  if (!searchEl || !cuisineEl || !dietEl || !difficultyEl) return;

  const search = searchEl.value;
  const cuisine = cuisineEl.value;
  const diet = dietEl.value;
  const difficulty = difficultyEl.value;

  const url = `../API/recipes.php?search=${search}&cuisine=${cuisine}&diet=${diet}&difficulty=${difficulty}`;
  const res = await fetch(url);
  const recipes = await res.json();

  const container = document.getElementById('recipeResults');
  if (!container) return;
  container.innerHTML = '';

  recipes.forEach(recipe => {
    const card = `
      <div class="recipe-card">
        <div class="recipe-image">
          <img src="/Codefile/${recipe.image_url}" alt="${recipe.title}" onerror="this.src='../Resources/images/recipes/default.jpg'">
          <span class="difficulty ${recipe.difficulty.toLowerCase()}">${recipe.difficulty}</span>
        </div>
        <div class="recipe-info">
          <h3>${recipe.title}</h3>
          <div class="recipe-meta">
            <span><i class="fa fa-globe"></i> ${recipe.cuisine || 'Cuisine'}</span>
            <span><i class="fa fa-leaf"></i> ${recipe.diet || 'Diet'}</span>
          </div>
          <p>${recipe.description.slice(0, 100)}</p>
          <button class="btn btn-outline">View Recipe</button>
        </div>
      </div>`;
    container.innerHTML += card;
  });
}



window.addEventListener("DOMContentLoaded", () => {
  document.getElementById('searchBox')?.addEventListener('input', fetchRecipes);
  document.getElementById('filterCuisine')?.addEventListener('change', fetchRecipes);
  document.getElementById('filterDiet')?.addEventListener('change', fetchRecipes);
  document.getElementById('filterDifficulty')?.addEventListener('change', fetchRecipes);

  fetchRecipes();
  checkLoginStatus();

});

// Check login state and update navbar
async function checkLoginStatus() {
    const basePath = window.location.pathname.includes("/Pages/") ? "../API/" : "./API/";
    const res = await fetch(basePath + "session_status.php");
    const data = await res.json();

    const authButtons = document.getElementById("authButtons");
    const userProfile = document.getElementById("userProfile");

    if (data.loggedIn) {
        authButtons.style.display = "none";
        userProfile.style.display = "block";
        
        // Update the dropdown with user info if available
        if (data.email) {
            const dropdownToggle = document.querySelector('#profileDropdown');
            if (dropdownToggle) {
                dropdownToggle.innerHTML = `<i class="fas fa-user-circle"></i>`;
                dropdownToggle.setAttribute('aria-label', `Logged in as ${data.email}`);
            }
        }
    } else {
        authButtons.style.display = "flex";
        userProfile.style.display = "none";
    }
}

// ===== COMMUNITY COOKBOOK FUNCTIONALITY ===== //

// Load community content when page loads
if (window.location.pathname.includes('community.html')) {
    document.addEventListener('DOMContentLoaded', loadCommunityContent);
}

async function loadCommunityContent() {
    const communityContent = document.getElementById('communityContent'); // Declare first
    communityContent.innerHTML = '<div class="loading-spinner"><i class="fas fa-spinner fa-spin"></i> Loading community...</div>';

    try {
        const response = await fetch('../API/community_api.php?action=get_posts');
        const data = await response.json();

        let html = '';

        // Add post form for logged in users
        if (data.isLoggedIn) {
            html += `
                <div class="post-form">
                    <h3>Share Your Recipe</h3>
                    <form id="communityPostForm" enctype="multipart/form-data">
                        <div class="form-group">
                            <textarea name="caption" placeholder="Share your cooking experience..." required></textarea>
                        </div>
                        <div class="form-group">
                            <input type="file" name="image" id="imageInput" accept="image/*" required>
                        </div>
                        <div class="form-group">
                            <img id="imagePreview" src="#" alt="Image Preview" style="display:none; max-width: 300px; max-height: 300px;"/>
                        </div>
                        <button type="submit" class="btn btn-primary">Post</button>
                    </form>
                </div>
            `;
        } else {
            html += `
                <div class="login-prompt">
                    <p>Please <a href="../index.html">sign in</a> to share your recipes and interact with the community.</p>
                </div>
            `;
        }

        // Add posts feed
        html += '<div class="posts-feed">';
        data.posts.forEach(post => {
            html += `
                <div class="post-card" data-post-id="${post.id}">
                    <div class="post-header">
                        <div class="post-user">
                            <i class="fas fa-user-circle"></i>
                            <span>${post.username}</span>
                        </div>
                        <div class="post-time">
                            ${post.created_at}
                        </div>
                    </div>
                    
                    <div class="post-image">
                        <img src="../${post.image_path}" alt="Recipe image">
                    </div>
                    
                    <div class="post-caption">
                        <p>${post.caption}</p>
                    </div>
                    
                    <div class="post-actions">
                        <a href="#" class="like-btn ${post.isLiked ? 'liked' : ''}" data-post-id="${post.id}">
                            <i class="fas fa-heart"></i> 
                            <span class="like-count">${post.like_count}</span>
                        </a>
                        <a href="#" class="comment-btn">
                            <i class="fas fa-comment"></i> 
                            <span>${post.comment_count}</span>
                        </a>
                    </div>
                    
                    <div class="post-comments">
                    ${post.comments.map(comment => `
                    <div class="comment">
                    <strong>${comment.username}:</strong> ${comment.text}
                    </div>
                    `)
                    .join('')}
                    ${data.isLoggedIn ? 
                      `<form class="comment-form" data-post-id="${post.id}">
                          <input type="text" name="comment" placeholder="Write a comment..." required />
                          <button type="submit" class="btn btn-outline">Comment</button>
                       </form>` : ''}
                    </div>
                  </div>
              </div>`;
                  });
                  html += '</div>';

        communityContent.innerHTML = html;

        //comment form handlers
        document.querySelectorAll('.comment-form').forEach(form => {
          form.addEventListener('submit', async function (e) {
            e.preventDefault();
            const postId = this.dataset.postId;
            const commentText = this.comment.value;
            try {
              const res = await fetch(`../API/community_api.php?action=add_comment&post_id=${postId}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `comment=${encodeURIComponent(commentText)}`
              });
              const result = await res.json();
              if (result.success) {
                loadCommunityContent(); // Refresh comments
                } else {
                  alert(result.error || 'Failed to add comment');
                }
              } catch (err) {
                console.error('Error adding comment:', err);
              }
            });
          });


        // Add event listeners
        if (data.isLoggedIn) {
            document.getElementById('communityPostForm').addEventListener('submit', handlePostSubmit);
            
            const imageInput = document.getElementById('imageInput');
            const imagePreview = document.getElementById('imagePreview');
            if (imageInput && imagePreview) {
              imageInput.addEventListener('change', function() {
                const file = this.files[0];
                if (file) {
                  const reader = new FileReader();
                  reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                  };
                  reader.readAsDataURL(file);
                } else {
                  imagePreview.src = '#';
                  imagePreview.style.display = 'none';
                }
              });
            }
          }
          
        if (communityContent) {
          communityContent.addEventListener('click', (e) => {
            // Check if clicked element or its parent has .like-btn class
             const likeBtn = e.target.closest('.like-btn');
            if (likeBtn) {
              handleLike(e); 
            }
         });
        }

    } catch (error) {
        communityContent.innerHTML = `
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                Failed to load community posts. Please try again later.
            </div>
        `;
        console.error('Error loading community content:', error);
    }
}

async function handlePostSubmit(e) {
    e.preventDefault();
    const form = e.target;
    const formData = new FormData(form);
    
    try {
        const response = await fetch('../API/community_api.php?action=create_post', {
            method: 'POST',
            body: formData
        });
        const result = await response.json();
        
        if (result.success) {
            loadCommunityContent(); // Refresh the feed
        } else {
            alert(result.error || 'Failed to create post');
        }
    } catch (error) {
        console.error('Error submitting post:', error);
        alert('An error occurred while submitting your post');
    }
}

async function handleLike(e) {
  e.preventDefault();

  const likeBtn = e.target.closest('.like-btn');
  if (!likeBtn) {
    console.error("Like button element not found.");
    return;
  }

  const loggedIn = await isLoggedIn();
  if (!loggedIn) {
    alert('Please log in to like posts');
    return;
  }

  const postId = likeBtn.dataset.postId;
  const isLiked = likeBtn.classList.contains('liked');

  try {
    // Send like or unlike based on current state
    const action = isLiked ? 'unlike_post' : 'like_post';

    const response = await fetch(`../API/community_api.php?action=${action}&post_id=${postId}`, {
      method: 'POST'  // Use POST for state-changing requests
    });
    const result = await response.json();

    if (result.success) {
      // Toggle the liked class and update count
      if (isLiked) {
        likeBtn.classList.remove('liked');
        const likeCount = likeBtn.querySelector('.like-count');
        if (likeCount) {
          likeCount.textContent = Math.max(parseInt(likeCount.textContent) - 1, 0);
        }
      } else {
        likeBtn.classList.add('liked');
        const likeCount = likeBtn.querySelector('.like-count');
        if (likeCount) {
          likeCount.textContent = parseInt(likeCount.textContent) + 1;
        }
      }
    } else {
      alert(result.error || 'Failed to update like status');
    }
  } catch (error) {
    console.error('Error updating like status:', error);
  }
}



async function isLoggedIn() {
  try {
    const basePath = window.location.pathname.includes("/Pages/") ? "../API/" : "./API/";
    const res = await fetch(basePath + "session_status.php");
    const data = await res.json();
    return data.loggedIn;
  } catch (err) {
    console.error("Failed to check login status", err);
    return false;
  }
}

// Contact Us Form Submission
const contactForm = document.getElementById("contactForm");
if (contactForm) {
  contactForm.addEventListener("submit", async function (e) {
    e.preventDefault();
    const formData = new FormData(this);
    try {
      const basePath = window.location.pathname.includes("/Pages/") ? "../API/" : "./API/";
      const res = await fetch(basePath + "contact.php", {
        method: "POST",
        body: formData
      });
      const result = await res.json();
      const messageBox = document.getElementById("contactMessage");

      if (result.success) {
        messageBox.textContent = "Thank you! Your message has been received.";
        messageBox.style.display = "block";
        contactForm.reset();
      } else {
        messageBox.textContent = result.error || "Failed to send message.";
        messageBox.style.display = "block";
      }
    } catch (err) {
      alert("Error submitting contact form.");
    }
  });
}
