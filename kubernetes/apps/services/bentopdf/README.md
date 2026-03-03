# BentoPDF

BentoPDF is a simple, lightweight PDF manipulation tool that provides a web interface for common PDF operations. It's designed for quick PDF tasks without the complexity of full-featured PDF editors.

## Features

- **PDF Merging**: Combine multiple PDF files into one
- **PDF Splitting**: Split PDF documents into separate pages or ranges
- **Page Extraction**: Extract specific pages from PDF documents
- **Page Rotation**: Rotate pages in PDF documents
- **PDF Compression**: Reduce PDF file sizes
- **Simple Web UI**: Easy-to-use web interface
- **No Account Required**: Use without registration or authentication
- **Privacy-Focused**: Files processed locally, no cloud storage

## Configuration

### Deployment Settings

The application is deployed with:
- **Image**: `ghcr.io/alam00000/bentopdf-simple:2.3.1`
- **Update Strategy**: Configured for reliable deployments
- **Auto-reload**: Enabled via Reloader for automatic updates on configuration changes
- **CRD Management**: CreateReplace strategy for custom resources

### Resource Requirements

BentoPDF is lightweight and suitable for general use:
- Minimal resource requirements for basic operations
- Memory usage scales with PDF file sizes
- Consider resource limits based on expected workload

## Access

- **Web UI**: Access through the configured service endpoint
- **Service Name**: `bentopdf.services.svc.cluster.local`

## Usage

1. **Upload PDF**: Select your PDF file(s) through the web interface
2. **Choose Operation**: Select the desired operation (merge, split, rotate, etc.)
3. **Configure Options**: Set any specific options for the operation
4. **Process**: Execute the operation and download the result

## Common Operations

### Merging PDFs
Upload multiple PDF files and combine them into a single document.

### Splitting PDFs
Split a PDF by page numbers or ranges:
- Single pages
- Custom ranges
- All pages as separate files

### Rotating Pages
Rotate pages 90°, 180°, or 270° clockwise.

### Extracting Pages
Extract specific pages to create a new PDF document.

## Notes

- Files are processed in-memory for privacy
- No persistent storage of user files
- Suitable for internal cluster use
- For external access, consider adding ingress with appropriate security

## Resources

- **GitHub Repository**: https://github.com/alam00000/bentopdf-simple
- **Docker Image**: ghcr.io/alam00000/bentopdf-simple
