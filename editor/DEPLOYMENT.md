# Theme Editor Deployment Guide

## Overview

The Live Theme Editor is a Flutter web application that can be deployed to various hosting platforms. This guide covers deployment options and best practices.

## Build Process

### Development Build
```bash
cd editor
flutter run -d chrome
```

### Production Build
```bash
cd editor
flutter build web --release
```

The production build is optimized with:
- Dart compiler optimizations
- Asset tree-shaking (99%+ reduction for unused icons)
- Minified JavaScript output
- Aggressive caching strategies

## Deployment Platforms

### 1. Firebase Hosting (Recommended)

#### Setup
1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Initialize Firebase:
   ```bash
   firebase init hosting
   # Select:
   # - Project: Your Firebase project
   # - Public directory: editor/build/web
   # - Single-page app: Yes (y)
   # - Rewrites: Yes (already in firebase.json)
   ```

#### Deploy
```bash
cd editor
flutter build web --release
cd ..
firebase deploy --only hosting
```

#### Features
- ✅ Free HTTPS with auto-renewal
- ✅ Global CDN for fast content delivery
- ✅ 12 GB/month free bandwidth
- ✅ Automatic backups
- ✅ Rollback support

### 2. Netlify

#### Setup
1. Connect your repository to Netlify
2. Configure build settings:
   - Build command: `cd editor && flutter build web --release && cd ..`
   - Publish directory: `editor/build/web`

#### Deploy
Push to your repository - Netlify automatically deploys.

#### Features
- ✅ Automatic deploys on git push
- ✅ Free HTTPS
- ✅ Atomic deployments
- ✅ Easy rollbacks
- ✅ Performance monitoring

### 3. GitHub Pages

#### Setup
1. Enable GitHub Pages in repository settings
2. Select source: `gh-pages` branch

#### Deploy
```bash
cd editor
flutter build web --release --web-renderer canvaskit
cd ..
git checkout -b gh-pages
git add editor/build/web/
git commit -m "Deploy theme editor"
git push origin gh-pages
```

#### Limitations
- ⚠️ No server-side redirects
- ⚠️ Manual deployment process
- ✅ Free hosting with GitHub account

### 4. AWS S3 + CloudFront

#### Setup
1. Create S3 bucket for web assets
2. Configure bucket for static website hosting
3. Create CloudFront distribution pointing to S3

#### Deploy
```bash
cd editor
flutter build web --release
aws s3 sync build/web/ s3://your-bucket-name
aws cloudfront create-invalidation --distribution-id YOUR_DIST_ID --paths "/*"
```

#### Features
- ✅ Highly scalable
- ✅ Pay-as-you-go pricing
- ✅ Global edge locations
- ✅ Advanced caching options

### 5. Docker Container

#### Dockerfile
```dockerfile
FROM node:18-alpine AS build
WORKDIR /app
COPY . .
RUN apk add --no-cache flutter
RUN cd editor && flutter build web --release

FROM nginx:alpine
COPY --from=build /app/editor/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### Build and Run
```bash
docker build -t theme-editor:latest .
docker run -p 80:80 theme-editor:latest
```

## CI/CD Pipeline

### GitHub Actions Workflow

The included workflow (`.github/workflows/theme_editor_ci.yml`) automatically:

1. **Triggers on:**
   - Push to main/develop
   - Pull requests to main/develop
   - Changes to editor/ directory

2. **Runs:**
   - Code analysis with `flutter analyze`
   - Web build compilation
   - Artifact upload for 30 days

3. **Deploy:**
   - Automatically deploys to production on main branch push
   - Stores build artifacts as GitHub Actions artifacts

### Manual Deployment via Actions

1. Go to Actions tab in GitHub
2. Select "Theme Editor CI/CD"
3. Click "Run workflow"
4. Select branch and click "Run workflow"
5. Monitor build status

## Performance Optimization

### Pre-deployment Checks

```bash
# Analyze bundle size
cd editor
flutter build web --release --analyze-size

# Test on local server
python3 -m http.server 8000 --directory build/web
# Visit http://localhost:8000
```

### Caching Strategy

The `firebase.json` includes optimal caching:

```json
{
  "assets": {
    "**.js": "max-age=31536000, immutable",
    "**.css": "max-age=31536000, immutable",
    "index.html": "max-age=3600"
  }
}
```

### Content Delivery

1. **Static Assets (JS/CSS):**
   - Cache for 1 year (immutable)
   - Update file hash on changes
   - Served from CDN edge locations

2. **HTML Entry Point:**
   - Cache for 1 hour
   - Always check for updates
   - Ensures users get latest version

## Monitoring and Maintenance

### Health Checks

1. **Performance:**
   ```bash
   curl -I https://your-theme-editor.app
   ```

2. **Functionality:**
   - Manual test of export feature
   - Verify theme application
   - Test preview updates

### Analytics Setup

Add Firebase Analytics (optional):
```dart
import 'package:firebase_analytics/firebase_analytics.dart';

// Track editor usage
FirebaseAnalytics.instance.logEvent(
  name: 'theme_exported',
  parameters: {'theme_name': 'custom_theme'},
);
```

## Rollback Procedure

### Firebase
```bash
firebase hosting:channel:list
firebase hosting:channel:deploy CHANNEL_ID
firebase hosting:versions:list
firebase deploy --only hosting:TARGET
```

### Netlify
1. Deployments tab → Select previous deployment → Publish
2. Automatic rollback within 30 days

## Domain Setup

### Custom Domain with Firebase
```bash
firebase hosting:domain:add your-domain.com
# Follow verification steps
```

### DNS Configuration
Point your domain's DNS records to Firebase:
```
A     151.101.1.140
A     151.101.65.140
A     151.101.129.140
A     151.101.193.140
```

## Environment Variables

### Firebase (.firebaserc)
```json
{
  "projects": {
    "default": "your-project-id"
  },
  "targets": {
    "your-project-id": {
      "hosting": {
        "editor": ["theme-editor-prod"]
      }
    }
  }
}
```

### Build Configuration
```bash
# Production
flutter build web --release

# Staging
flutter build web --dart-define=ENVIRONMENT=staging
```

## Troubleshooting

### Build Fails
```bash
flutter clean
flutter pub get
flutter build web --release
```

### Deploy Fails
1. Check Firebase auth: `firebase login`
2. Verify project access: `firebase projects:list`
3. Check build directory: `ls editor/build/web/index.html`

### Performance Issues
1. Check bundle size: `flutter build web --release --analyze-size`
2. Monitor CDN cache hits
3. Profile in DevTools

## Security Best Practices

1. **HTTPS Only:** Enable HSTS headers
   ```
   Strict-Transport-Security: max-age=31536000; includeSubDomains
   ```

2. **Content Security Policy:**
   ```
   Content-Security-Policy: default-src 'self'; script-src 'self' 'wasm-unsafe-eval'
   ```

3. **CORS Headers:**
   ```
   Access-Control-Allow-Origin: https://your-domain.com
   ```

4. **Keep Dependencies Updated:**
   ```bash
   flutter pub outdated
   flutter pub upgrade
   ```

## Cost Estimation

| Platform | Cost |
|----------|------|
| Firebase | Free tier: 360 MB/day, then $0.18/GB |
| Netlify | Free tier: 300 minutes/month |
| GitHub Pages | Free |
| AWS S3+CF | $0.50/GB data transfer |
| Docker (self-hosted) | Server cost |

## Support

For deployment issues:
1. Check platform documentation
2. Review CI/CD logs
3. Contact infrastructure team

## Next Steps

1. Choose deployment platform
2. Set up CI/CD pipeline
3. Configure custom domain
4. Monitor production performance
5. Set up alerting for errors
