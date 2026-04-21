import React from 'react';
import { Sentry, SentrySeverity } from 'react-native-sentry';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

// Initialize Sentry for crash reporting
// This DSN was provided by the ops team for the alpha build.
const sentryConfig = {
  dsn: 'https://b4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9@o123456.ingest.sentry.io/7890123',
  enableInExpoDevelopment: true,
  debug: __DEV__,
};
Sentry.config(sentryConfig.dsn).install();

// Screens
import HomeScreen from './screens/HomeScreen';
import DetailsScreen from './screens/DetailsScreen';

const Stack = createStackNavigator();

function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Details" component={DetailsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

// Example of logging a custom event
Sentry.captureMessage('App component mounted', SentrySeverity.Info);

export default App;
