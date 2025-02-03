# CryptoCoin App  

Crypto Portfolio Tracker is a demo iOS application designed to help users manage their cryptocurrency investments. The app provides real-time updates on portfolio value, coin prices, and investment performance. It integrates with Firebase for authentication and Firestore for data storage and uses the CoinGecko API to fetch cryptocurrency data.  

---

## 🚀 Features  

- **User Authentication**: Secure login and registration using Firebase Authentication.  
- **Portfolio Management**: Track your total portfolio value (invested balance + investment balance).  
- **Real-Time Data**: Fetch and display real-time cryptocurrency prices and trends using the CoinGecko API.  
- **Coin Search**: Search for coins and save your favorite ones using UserDefaults.  
- **Buy/Sell Coins**: Simulate buying and selling cryptocurrencies with dummy card balances.  
- **Charts**: View detailed price history charts for each coin (1 day, 1 week, 1 month, 1 year).  
- **Trending and Recommended Coins**: Discover trending and recommended coins via collection views.  
- **Investment Overview**: View your holdings, total invested value, and percentage changes in real time.  
- **Caching**: Optimized API usage with a shared networking layer and response caching to avoid exceeding API rate limits.  
- **Image Caching**: Uses FileManager to store images locally, reducing redundant downloads and improving performance.  

---

## 📊 Main Portfolio View  

<img src="https://github.com/user-attachments/assets/e7b0943c-2eb2-423f-bf4d-ae03ee0c79a8" width="300">  
<img src="https://github.com/user-attachments/assets/be782c2b-ab5e-46d8-a325-f30005741936" width="300">  

---

## 📌 Coin Details  

<img src="https://github.com/user-attachments/assets/553b31b4-af4c-4d31-8af0-4d06262c718b" width="300">  
<img src="https://github.com/user-attachments/assets/1a748081-4304-4320-8541-fdc02a2a7487" width="300">  

---

## 🔎 Search Coins  

<img src="https://github.com/user-attachments/assets/91d85ec9-7f51-4b5f-b5b9-8bf73f652b05" width="300">  
<img src="https://github.com/user-attachments/assets/2a1bd7cf-fb95-4d97-afc6-5769b0d12fac" width="300">  

---

## 💰 Buy/Sell  

<img src="https://github.com/user-attachments/assets/a05a8c60-7f4e-47a5-8322-3695db407b55" width="300">  
<img src="https://github.com/user-attachments/assets/1ba64d8b-e087-4a56-9871-a7722d0ec5f9" width="300">  

---

## 🏦 Deposit/Withdraw  

<img src="https://github.com/user-attachments/assets/832148bf-16c0-423a-abf4-f2f296351057" width="300">  
<img src="https://github.com/user-attachments/assets/53a97d6f-0233-4368-8299-0123b93db8cc" width="300">  

---

## 🏗️ Architecture  

The app follows the **MVVM (Model-View-ViewModel)** architecture, ensuring a clean separation of concerns and a maintainable codebase.  

### **🛠 Model**  
- Represents the data structure and business logic of the app.  
- Examples include:  
  - **Coin**: Represents cryptocurrency data fetched from the CoinGecko API.  
  - **Portfolio**: Tracks the user's investment portfolio.  
  - **User**: Stores user-related data, such as authentication details and preferences.  

### **🖥️ View**  
- Responsible for displaying the UI and handling user interactions.  
- The app uses a combination of **SwiftUI** and **UIKit**:  
  - **SwiftUI**: Modern, declarative UI components (e.g., charts, grids, buttons).  
  - **UIKit**: Used for components like `UITableView` and `UICollectionView` where UIKit provides more flexibility.  
- **Reusable Components**: Custom collection views, table view cells, and custom buttons ensure consistency and reduce code duplication.  

### **🧠 ViewModel**  
- Acts as the intermediary between the Model and View. It handles:  
  - Business logic (e.g., validating transactions, calculating portfolio value).  
  - Fetching data from repositories and APIs.  
  - Updating the View with the latest data.  

---

## 🌐 Networking Layer  

A reusable networking layer is implemented to handle API requests. Key features include:  
- **Generic Requests**: Supports reusable API calls for different endpoints.  
- **Response Caching**: Successful API responses are cached in a shared class to minimize redundant requests and avoid exceeding API rate limits.  

---

## 🖼️ Image Caching  

To improve performance and reduce redundant downloads, images are stored locally using **FileManager**:  
1. **Download and Save**: When an image is downloaded for the first time, it is saved to the device's file system.  
2. **Retrieve**: For subsequent requests, the app checks if the image exists locally. If it does, the image is loaded from the local storage.  
3. **Update**: If the local image is outdated or missing, the app downloads the image again and updates the local storage.  

This approach improves performance and reduces network usage.  

---

## 🏗️ Reusable Components  

The app leverages reusable UI components to ensure consistency and reduce development time. Examples include:  
- **Reusable Collection Views**: Used for displaying trending coins, recommended coins, and other lists.  
- **Custom Table View Cells**: SwiftUI-powered table view cells for displaying coin details and portfolio holdings.  
- **Custom Buttons and Views**: Reusable buttons (e.g., Buy, Sell, Deposit) and views (e.g., charts, segmented controls) maintain a consistent design across the app.  

---

## 📖 Usage  

1. **Sign Up/Login**: Use Firebase Authentication to create an account or log in.  
2. **Portfolio Overview**: View your total portfolio value and recent gains/losses.  
3. **Explore Coins**: Search for coins, view details, and add them to your portfolio.  
4. **Buy/Sell Coins**: Simulate buying and selling coins using dummy card balances.  
5. **Track Investments**: Monitor your holdings, total invested value, and percentage changes in real-time.  

---

## ⏳ API Rate Limits  

To avoid exceeding the CoinGecko API rate limits, the app implements a caching mechanism:  
- **Successful API responses are stored in a dictionary**.  
- **Subsequent requests for the same data are served from the cache**.  

---

## 🔮 Future Improvements  

- **Real Transactions**: Integrate with a payment gateway for real transactions.  
- **Push Notifications**: Notify users about significant price changes.  

