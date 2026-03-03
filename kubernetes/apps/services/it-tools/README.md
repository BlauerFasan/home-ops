# IT-Tools

IT-Tools is a comprehensive collection of useful tools for developers and IT professionals, all accessible through a clean web interface. It provides quick access to encoding/decoding, conversion, generation, and various development utilities.

## Features

### Encoding & Decoding
- **Base64 Encoder/Decoder**: Convert text and files to/from Base64
- **URL Encoder/Decoder**: Encode and decode URLs
- **HTML Entities**: Convert HTML special characters
- **JWT Decoder**: Decode and inspect JSON Web Tokens
- **Unicode Converter**: Convert between Unicode and text

### Hash & Crypto
- **Hash Generator**: MD5, SHA1, SHA256, SHA512, and more
- **UUID Generator**: Generate various versions of UUIDs
- **Password Generator**: Create secure random passwords
- **Bcrypt**: Hash and verify passwords
- **HMAC Generator**: Generate hash-based message authentication codes

### Converters
- **JSON to YAML**: Convert between JSON and YAML formats
- **Color Converter**: Convert between HEX, RGB, HSL, HSV
- **Case Converter**: Convert text case (camelCase, snake_case, etc.)
- **Number Base Converter**: Convert between binary, decimal, hex
- **Date Converter**: Convert timestamps and dates

### Formatters
- **JSON Formatter**: Pretty print and minify JSON
- **SQL Formatter**: Format SQL queries
- **XML Formatter**: Format and validate XML
- **HTML Formatter**: Format HTML documents

### Generators
- **Lorem Ipsum**: Generate placeholder text
- **QR Code Generator**: Create QR codes
- **Cron Expression**: Build cron schedules
- **Regular Expression Tester**: Test and debug regex

### Network & Web
- **IP Information**: Get details about IP addresses
- **DNS Lookup**: Query DNS records
- **HTTP Status Codes**: Reference for HTTP status codes
- **MIME Types**: Look up MIME types

### Development
- **JSON Diff**: Compare JSON objects
- **String Utilities**: Various string manipulation tools
- **Math Evaluator**: Calculate mathematical expressions
- **Git Cheatsheet**: Quick reference for Git commands

## Configuration

### Deployment Settings

The application is deployed with:
- **Image**: `ghcr.io/sharevb/it-tools:2026.1.4`
- **Port**: 8080 (HTTP Web UI)
- **Replicas**: 1 instance
- **Update Strategy**: RollingUpdate for zero-downtime deployments
- **Auto-reload**: Enabled via Reloader for automatic updates
- **Timezone**: Uses cluster timezone from environment variable

### Security

The deployment includes multiple security hardening measures:
- **No privilege escalation**: Prevents container from gaining additional privileges
- **Read-only root filesystem**: Enhanced security posture
- **Dropped capabilities**: All Linux capabilities removed
- **Resource limits**: 256Mi memory limit, minimal CPU request

### Resource Requirements

- **CPU Request**: 5m (minimal)
- **Memory Request**: 32Mi
- **Memory Limit**: 256Mi

IT-Tools is extremely lightweight and suitable for any environment.

## Access

- **Web UI**: Access through the configured service endpoint
- **Service Name**: `it-tools.services.svc.cluster.local:8080`

## Usage

1. **Navigate to Tool**: Browse the catalog or search for a specific tool
2. **Input Data**: Enter or paste your data
3. **Get Results**: Instantly see the converted, formatted, or generated output
4. **Copy Results**: Easily copy results to clipboard

## Notes

- All operations are performed client-side in the browser
- No data is sent to external servers
- Tools work offline once the page is loaded
- Perfect for quick development tasks
- Lightweight and fast, runs entirely in the browser

## Resources

- **GitHub Repository**: https://github.com/CorentinTh/it-tools
- **Original Project**: https://it-tools.tech
- **Docker Image**: ghcr.io/sharevb/it-tools
