# Gotenberg

Gotenberg is a Docker-powered stateless API for PDF conversions and office document processing. It provides a simple HTTP API to convert HTML, Markdown, and Office documents to PDF.

## Features

- **HTML to PDF Conversion**: Convert HTML documents including CSS and JavaScript
- **Office Document Conversion**: Convert Word, Excel, PowerPoint, and other office formats to PDF
- **URL to PDF**: Convert web pages to PDF documents
- **Markdown to PDF**: Convert Markdown files to PDF
- **Image Conversion**: Convert images to PDF format
- **Merge PDFs**: Combine multiple PDF documents
- **Stateless API**: No persistent storage, all operations are stateless
- **Multi-format Support**: Handles various input formats including DOCX, XLSX, PPTX, ODT, and more

## Configuration

### Deployment Settings

The application is deployed with:
- **Image**: `thecodingmachine/gotenberg:8.27.0`
- **Port**: 3000 (HTTP API)
- **Chromium Routes**: Disabled for security (`--chromium-disable-routes=true`)
- **Update Strategy**: RollingUpdate for zero-downtime deployments
- **Auto-reload**: Enabled via Reloader for automatic updates on configuration changes

### Resource Requirements

The deployment uses minimal resources suitable for light to moderate workloads. Adjust based on usage patterns:
- Consider increasing resources for heavy conversion workloads
- CPU and memory requirements scale with document complexity

## Access

- **API Endpoint**: Internal service accessible within the cluster on port 3000
- **Service Name**: `gotenberg.services.svc.cluster.local:3000`

## Usage Examples

Convert HTML to PDF:
```bash
curl --request POST \
  --url http://gotenberg.services.svc.cluster.local:3000/forms/chromium/convert/html \
  --form files=@index.html \
  -o result.pdf
```

Convert URL to PDF:
```bash
curl --request POST \
  --url http://gotenberg.services.svc.cluster.local:3000/forms/chromium/convert/url \
  --form url=https://example.com \
  -o result.pdf
```

Convert Office Document to PDF:
```bash
curl --request POST \
  --url http://gotenberg.services.svc.cluster.local:3000/forms/libreoffice/convert \
  --form files=@document.docx \
  -o result.pdf
```

## Notes

- Chromium routes are disabled for security reasons
- The service is designed for internal cluster use
- All conversions are stateless - no data is stored
- For external access, consider adding ingress configuration

## Resources

- **Official Website**: https://gotenberg.dev
- **Documentation**: https://gotenberg.dev/docs/getting-started/introduction
- **GitHub Repository**: https://github.com/gotenberg/gotenberg
- **Docker Hub**: https://hub.docker.com/r/thecodingmachine/gotenberg
