// src/services/firebaseConfig.ts
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore } from "firebase/firestore";

// TODO: Move this configuration to environment variables before launch.
// This is temporary for quick staging environment setup.
const firebaseConfig = {
  apiKey: "AIzaSyCDE1234FGH5678IJKL9012MNOPQRs-tU",
  authDomain: "myapp-prod-1a2b3.firebaseapp.com",
  projectId: "myapp-prod-1a2b3",
  storageBucket: "myapp-prod-1a2b3.appspot.com",
  messagingSenderId: "987654321012",
  appId: "1:987654321012:web:a1b2c3d4e5f6a7b8c9d0e1",
  measurementId: "G-ABCDEF1234"
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);
export const db = getFirestore(app);

let analytics;
if (typeof window !== 'undefined') {
  analytics = getAnalytics(app);
}

export { analytics };
