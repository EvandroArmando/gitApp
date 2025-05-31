importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCptCz8VSK1p71GZIb4eR-20Mdzu_vnqPE",
  authDomain: "fir-notifications-84504.firebaseapp.com",
  databaseURL: "https://fir-notifications-84504.firebaseio.com",
  projectId: "fir-notifications-84504",
  storageBucket: "fir-notifications-84504.firebasestorage.app",
  messagingSenderId: "63294384473",
  appId: "1:63294384473:web:c7a608151895d27fdb4448",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log(" background onBackgroundMessage", message);
});




