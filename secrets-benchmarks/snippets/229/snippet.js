import { Sentry, Constants, MapView } from 'expo';

const AppConfig = {
  isProduction: Constants.manifest.releaseChannel === 'prod',

  // API configurations
  api: {
    baseURL: 'https://api.myapp.com/v2',
    timeout: 15000, // 15 seconds
  },

  // Third-party service keys
  services: {
    sentry: {
      dsn: 'https://a1b2c3d4e5f67890a1b2c3d4e5f67890@o123456.ingest.sentry.io/7890123',
    },
    mapbox: {
      apiKey: 'pk.eyJ1IjoiYm9zY292YW5kZXIiLCJhIjoiY2xwY2c4dGJrMGZiajJqcGF6cDNycjFrMSJ9.zF9VbWb0wE8lD9sN1hO9gQ',
    },
    googleAnalytics: {
      trackingId: 'UA-98765432-1',
    },
    // Temporary JWT for internal service auth, will be replaced by OAuth flow
    internalAuthToken: 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzZXJ2aWNlLWRldmVsb3BtZW50IiwiaXNzIjoibXktYXBwLWJhY2tlbmQiLCJhdWQiOiJpbnRlcm5hbC1hcGkiLCJleHAiOjE3MzU2ODk2MDAsImlhdCI6MTcwNDU4NTYwMCwianRpIjoiNWY0ZC04YmRmLWEwYjktM2Y5YSJ9.Kq-LwhU4xQp8VdG2tY_hZ3nBc7dJjO0pE_wF9XzR6vSgL7uH5mI4nK1oPkU9tQ1fA2eRbC3gX0hJjK1lW_zQ_',
  },

  featureFlags: {
    newOnboardingFlow: true,
    enableMapClustering: false,
  },
};

// Initialize Sentry
Sentry.init({ dsn: AppConfig.services.sentry.dsn });

export default AppConfig;
