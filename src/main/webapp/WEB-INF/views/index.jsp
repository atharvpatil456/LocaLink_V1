<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LocaLink - Connect Locally</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: #f3a; /* Changed to match image background */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        nav {
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #cd5151; /* Changed to match red button */
        }

        .logo span {
            color: #f3a024; /* Changed to match background */
        }

        .main-content {
            display: flex;
            align-items: center;
            justify-content: space-around;
            padding: 4rem 2rem;
            flex: 1;
            background: linear-gradient(135deg, #e4e2df 0%, #cf9b58 100%); /* Added gradient */
        }

        .content-section {
            max-width: 500px;
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        h1 {
            font-size: 3rem;
            color: #d32f2f; /* Changed to match red button */
            margin-bottom: 1.5rem;
        }

        p {
            color: #333;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .buttons {
            display: flex;
            gap: 1rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            background: #d32f2f; /* Changed to match red button */
            color: white;
        }

        .btn-secondary {
            background: white;
            color: #d32f2f; /* Changed to match red button */
            border: 2px solid #d32f2f;
        }

        .phone-container {
            position: relative;
            width: 300px;
            height: 600px;
            perspective: 1000px;
        }

        .phone {
            width: 350px;
            height: 580px;
            background: #1a1a1a;
            border-radius: 40px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            border: 8px solid #1a1a1a;
        }

        .notch {
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 150px;
            height: 25px;
            background: #1a1a1a;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
            z-index: 2;
        }

        .camera {
            position: absolute;
            top: 8px;
            right: 45px;
            width: 10px;
            height: 10px;
            background: #2c3e50;
            border-radius: 50%;
            box-shadow: inset 0 0 2px rgba(255,255,255,0.5);
        }

        .speaker {
            position: absolute;
            top: 10px;
            left: 45px;
            width: 40px;
            height: 4px;
            background: #2c3e50;
            border-radius: 2px;
        }

        .power-button {
            position: absolute;
            right: -8px;
            top: 120px;
            width: 3px;
            height: 50px;
            background: #2c3e50;
            border-radius: 2px;
        }

        .volume-button {
            position: absolute;
            left: -8px;
            top: 100px;
            width: 3px;
            height: 60px;
            background: #2c3e50;
            border-radius: 2px;
        }

        .screen {
            width: 100%;
            height: 100%;
            background: #f3a024;
            border-radius: 32px;
            overflow: hidden;
            position: relative;
            display: flex;
            flex-direction: column;
        }

        .status-bar {
            height: 40px;
            background: rgba(255,255,255,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 15px;
            font-size: 12px;
            color: white;
        }

        .time {
            font-weight: bold;
        }

        .status-icons {
            display: flex;
            gap: 5px;
        }

        .app-welcome {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            text-align: center;
        }

        .welcome-title {
            color: white;
            font-size: 24px;
            font-weight: bold;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin: 20px 0;
        }

        .app-illustration {
            width: 100%;
            max-width: 400px;
            height: auto;
            margin: 20px 0;
            position: relative;
        }

        .app-illustration img {
            width: 100%;
            height: auto;
            object-fit: contain;
        }

        .app-button {
            background: #d32f2f;
            color: white;
            padding: 12px 40px;
            border-radius: 25px;
            font-weight: bold;
            font-size: 18px;
            margin: 20px 0;
            border: none;
            cursor: pointer;
            transition: transform 0.3s ease;
            box-shadow: 0 4px 15px rgba(211, 47, 47, 0.3);
        }

        .app-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(211, 47, 47, 0.4);
        }

        @keyframes float {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
            100% {
                transform: translateY(0px);
            }
        }

        .phone-container {
            animation: float 3s ease-in-out infinite;
        }

        @media (max-width: 768px) {
            .main-content {
                flex-direction: column-reverse;
                text-align: center;
                gap: 2rem;
                padding: 2rem 1rem;
            }

            .buttons {
                justify-content: center;
            }

            h1 {
                font-size: 2rem;
            }

            .phone-container {
                transform: scale(0.8);
            }

            .content-section {
                padding: 1.5rem;
                margin: 0 1rem;
            }
        }

    </style>
</head>
<body>
    <nav>
        <div class="logo">Loca<span>Link</span></div>
        <div class="buttons">
        
            <a href="/advertiser/advlogin" class="btn btn-secondary">Advertiser Login</a>
            <a href="/admin/login" class="btn btn-primary">Admin Login</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="content-section">
            <h1>Discover Your Local World</h1>
            <p>Connect with local businesses, find amazing deals, and explore your neighborhood like never before. LocaLink brings the best of your community right to your fingertips.</p>
            <div class="buttons">
                <a href="#" class="btn btn-primary">Get Started</a>
                <a href="#" class="btn btn-secondary">Learn More</a>
            </div>
        </div>

        <div class="phone-container">
            <div class="phone">
                <div class="notch">
                    <div class="speaker"></div>
                    <div class="camera"></div>
                </div>
                <div class="power-button"></div>
                <div class="volume-button"></div>
                <div class="screen">
                    <div class="status-bar">
                        <span class="time">9:41</span>
                        <div class="status-icons">
                            
                            <span>📶</span>
                            <span>🔋</span>
                        </div>
                    </div>
                    <div class="app-welcome">
                        <div class="welcome-title">Welcome to LocaLink App!</div>
                        <div class="app-illustration">
                            <img src="/img_1.png" alt="LocaLink Delivery Illustration">

                        </div>
                        <button class="app-button">LocaLink</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Initialize GSAP animations
        gsap.from(".content-section", {
            duration: 1,
            opacity: 0,
            x: -50,
            ease: "power3.out"
        });

        gsap.from(".phone-container", {
            duration: 1,
            opacity: 0,
            y: 50,
            ease: "power3.out"
        });

        // Add floating animation to phone
        gsap.to(".phone-container", {
            y: "10px",
            duration: 2,
            repeat: -1,
            yoyo: true,
            ease: "power1.inOut"
        });
    </script>
</body>
</html>