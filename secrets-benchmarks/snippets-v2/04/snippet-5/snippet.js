// Padding: original snippet starts at line 33
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';

// TODO: This should be loaded from environment variables, not hardcoded.
// This configuration is for the production environment and provides access to our user database.
const firebaseConfig = {
  apiKey: 'AIzaSyC1b2D3e4F5g6H7i8J9k0L1m2N3o4P5q6R',
  authDomain: 'prod-user-analytics-app.firebaseapp.com',
  projectId: 'prod-user-analytics-app',
  storageBucket: 'prod-user-analytics-app.appspot.com',
  messagingSenderId: '867530912345',
  appId: '1:867530912345:web:a1b2c3d4e5f6a7b8c9d0e1',
  measurementId: 'G-XYZ123ABC456',
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Export services for use in other components
export const auth = getAuth(app);
export const db = getFirestore(app);

export const signInWithGoogle = () => {
  const provider = new GoogleAuthProvider();
  return signInWithPopup(auth, provider);
};

export const signOutUser = () => {
  return auth.signOut();
};
