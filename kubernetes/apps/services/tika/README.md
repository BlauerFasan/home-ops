# Apache Tika

Apache Tika is a content analysis toolkit that detects and extracts metadata and text from over a thousand different file types. It provides a unified API for content extraction, making it ideal for search engines, content management systems, and data mining applications.

## Features

- **Universal Parser**: Extracts text and metadata from 1000+ file formats
- **Format Detection**: Automatic detection of file types
- **Metadata Extraction**: Extract author, title, dates, and other metadata
- **Text Extraction**: Convert documents to plain text
- **Language Detection**: Identify the language of document content
- **OCR Support**: Extract text from images using Tesseract OCR
- **MIME Type Detection**: Accurate file type identification
- **Embedded Documents**: Handle documents with embedded files

## Supported File Types

- **Office Documents**: DOC, DOCX, XLS, XLSX, PPT, PPTX, ODT, ODS, ODP
- **PDFs**: Portable Document Format files
- **Images**: JPEG, PNG, TIFF, GIF (with OCR)
- **Archives**: ZIP, TAR, RAR, 7Z
- **Email**: MSG, EML, PST, MBOX
- **Web**: HTML, XML, RSS
- **Media**: MP3, MP4, WAV (metadata)
- **And many more**: CSV, RTF, TXT, JSON, YAML, etc.

## Configuration

### Deployment Settings

The application is deployed with:
- **Image**: `apache/tika:3.2.3.0`
- **Port**: 9998 (HTTP API)
- **Update Strategy**: RollingUpdate for zero-downtime deployments
- **Auto-reload**: Enabled via Reloader for automatic updates on configuration changes

### Resource Requirements

Tika can be resource-intensive depending on document size and complexity:
- Memory usage scales with document size
- OCR operations require additional CPU resources
- Consider resource limits for production workloads

## Access

- **API Endpoint**: Internal service accessible within the cluster on port 9998
- **Service Name**: `tika.services.svc.cluster.local:9998`

## Usage Examples

Detect file type:
```bash
curl -X PUT -H "Content-Type: application/octet-stream" \
  --data-binary @document.pdf \
  http://tika.services.svc.cluster.local:9998/detect/stream
```

Extract text from document:
```bash
curl -X PUT -H "Accept: text/plain" \
  --data-binary @document.pdf \
  http://tika.services.svc.cluster.local:9998/tika
```

Extract metadata:
```bash
curl -X PUT -H "Accept: application/json" \
  --data-binary @document.pdf \
  http://tika.services.svc.cluster.local:9998/meta
```

Full extraction (text + metadata):
```bash
curl -X PUT -H "Accept: application/json" \
  --data-binary @document.pdf \
  http://tika.services.svc.cluster.local:9998/rmeta/text
```

## API Endpoints

- `/tika` - Extract text content
- `/meta` - Extract metadata only
- `/detect/stream` - Detect MIME type
- `/rmeta` - Recursive metadata and text extraction
- `/language/stream` - Detect document language
- `/version` - Get Tika version

## Notes

- The service is designed for internal cluster use
- Large documents may require increased timeout settings
- OCR operations can be CPU and time-intensive
- For external access, consider adding ingress with authentication

## Resources

- **Official Website**: https://tika.apache.org
- **Documentation**: https://tika.apache.org/documentation.html
- **API Documentation**: https://tika.apache.org/2.9.2/api/
- **GitHub Repository**: https://github.com/apache/tika
- **Docker Hub**: https://hub.docker.com/r/apache/tika
