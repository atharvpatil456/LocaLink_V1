<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LocaLink - Advertiser Portal</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            scroll-behavior: smooth;
        }

        body {
            background: linear-gradient(135deg, #e4e2df 0%, #cf9b58 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Navigation Styles */
        nav {
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #d32f2f;
            text-decoration: none;
        }

        .logo span {
            color: #f3a024;
        }

        .nav-buttons {
            display: flex;
            gap: 1rem;
        }

        .nav-btn {
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .nav-btn-primary {
            background: #d32f2f;
            color: white;
        }

        .nav-btn-secondary {
            border: 2px solid #d32f2f;
            color: #d32f2f;
        }

        .nav-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(211, 47, 47, 0.2);
        }

        /* Section Styles */
        section {
            min-height: 100vh;
            padding: 6rem 2rem 4rem;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        /* Form Container Styles */
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%;
            max-width: 400px;
            display: none;
        }

        .form-container.active {
            display: block;
        }

        h2 {
            font-size: 2rem;
            color: #d32f2f;
            margin-bottom: 1.5rem;
            text-align: center;
            position: relative;
        }

        h2::after {
            content: '';
            display: block;
            width: 50px;
            height: 3px;
            background: #f3a024;
            margin: 10px auto;
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        label {
            display: block;
            color: #333;
            margin-bottom: 0.5rem;
            font-weight: 600;
            font-size: 0.9rem;
        }

        input {
            width: 100%;
            padding: 1rem 1.5rem;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #d32f2f;
            box-shadow: 0 0 0 4px rgba(211, 47, 47, 0.1);
        }

        .btn {
            width: 100%;
            padding: 1rem 1.5rem;
            border-radius: 25px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            background: linear-gradient(45deg, #d32f2f, #ff6b6b);
            color: white;
            font-size: 1rem;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(211, 47, 47, 0.4);
        }

        .switch-form {
            text-align: center;
            margin-top: 1.5rem;
            color: #666;
        }

        .switch-form a {
            color: #d32f2f;
            text-decoration: none;
            font-weight: 600;
            margin-left: 0.5rem;
        }

        .switch-form a:hover {
            color: #f3a024;
        }

        /* Benefits Section */
        .benefits {
            background: white;
            padding: 4rem 2rem;
            text-align: center;
        }

        .benefits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 3rem auto 0;
        }

        .benefit-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .benefit-card:hover {
            transform: translateY(-10px);
        }

        .benefit-card h3 {
            color: #d32f2f;
            margin-bottom: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            section {
                padding: 5rem 1rem 3rem;
            }

            .benefits-grid {
                grid-template-columns: 1fr;
            }

            .nav-buttons {
                gap: 0.5rem;
            }

            .nav-btn {
                padding: 0.6rem 1rem;
                font-size: 0.9rem;
            }
        }
    </style>
    
</head>
<body>
    <nav>
        <a href="#" class="logo">Loca<span>Link</span></a>
        <div class="nav-buttons">
            <a href="#login" class="nav-btn nav-btn-secondary" onclick="showForm('dashboard')">Back</a>
           
        </div>
    </nav>
   






    <section id="forms-section">
        <!-- Login Form -->
        <div id="login-form" class="form-container active">
            <h2>Add Advertisement</h2>
            <form action="/advertisement/updateAdvertisement" method="post">
                <!-- Hidden inputs -->
<div class="form-group">
    <input type="hidden" name="adId" value="${advertisement.adId}" />
    <input type="hidden" name="rating" value="${advertisement.rating}" />
    <input type="hidden" name="category" value="${advertisement.category}" />
    <input type="hidden" name="advertiserEmail" value="${advertisement.advertiserEmail}" />
</div>

<div class="form-group">
    <label for="adName">Advertisement Name:</label>
    <input type="text" id="adName" name="adName" value="${advertisement.adName}" required placeholder="Enter ad name" />
</div>

<div class="form-group">
    <label for="adDesc">Description:</label>
    <textarea id="adDesc" name="adDesc" required placeholder="Enter ad description">${advertisement.adDesc}</textarea>
</div>

<div class="form-group">
    <label for="adPrice">Price:</label>
    <input type="number" step="0.01" id="adPrice" name="adPrice" value="${advertisement.adPrice}" required placeholder="Enter ad price" />
</div>

<div class="form-group">
    <label for="imageUrl">Image URL:</label>
    <input type="text" id="imageUrl" name="imageUrl" value="${advertisement.imageUrl}" required placeholder="Enter image URL" />
</div>

<div class="form-group">
    <label for="latitude">Latitude:</label>
    <input type="number" step="0.0001" id="latitude" name="latitude" value="${advertisement.latitude}" readonly required placeholder="Select on map" />
</div>

<div class="form-group">
    <label for="longitude">Longitude:</label>
    <input type="number" step="0.0001" id="longitude" name="longitude" value="${advertisement.longitude}" readonly required placeholder="Select on map" />
</div>

<div class="form-group">
    <button type="button" class="btn map-button" onclick="openMapPage()">Select Location on Map</button>
</div>

<div class="form-group">
    <button type="submit" class="btn">Update Advertisement</button>
</div>

                
            </form>
            
        </div>

      
      
    </section>

    <!-- Benefits Section -->
    <section class="benefits">
        <h2>Why Choose LocaLink?</h2>
        <div class="benefits-grid">
            <div class="benefit-card">
                <h3>Local Reach</h3>
                <p>Connect with customers in your area and grow your local presence</p>
            </div>
            <div class="benefit-card">
                <h3>Easy Management</h3>
                <p>Simple tools to manage your campaigns and track performance</p>
            </div>
            <div class="benefit-card">
                <h3>Real Results</h3>
                <p>Track your success with detailed analytics and reporting</p>
            </div>
        </div>
    </section>

    <script>

    function openMapPage() {
        window.open("/advertisement/mapPage", "Select Location", "width=800,height=600");
    }

        // Initialize GSAP
        gsap.registerPlugin(ScrollTrigger);

        // Show/Hide Forms
        function showForm(formType) {
            const loginForm = document.getElementById('login-form');
            const registerForm = document.getElementById('register-form');
            
            if (formType === 'login') {
                loginForm.classList.add('active');
                registerForm.classList.remove('active');
            } else {
                loginForm.classList.remove('active');
                registerForm.classList.add('active');
            }
        }

        // Animations
        gsap.from(".form-container", {
            opacity: 0,
            y: 50,
            duration: 1,
            ease: "power3.out"
        });

        gsap.from(".benefit-card", {
            scrollTrigger: {
                trigger: ".benefits-grid",
                start: "top center",
                toggleActions: "play none none reverse"
            },
            opacity: 0,
            y: 50,
            duration: 1,
            stagger: 0.2,
            ease: "power3.out"
        });

        // Smooth scroll
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>
</html>