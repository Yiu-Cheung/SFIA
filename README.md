# SFIA - Semantic File Information Assistant

A professional-grade document Q&A system using Ollama and Haystack, built with clean architecture principles.

## Architecture

This project follows a four-layer clean architecture:

```
src/
├── interface/          # CLI, API interfaces
├── application/        # Use cases and services
├── domain/            # Business entities and rules
└── infrastructure/    # External dependencies (Haystack, Ollama)
```

## Features

- Load documents from text files (.txt) and Excel files (.xlsx, .xls)
- Semantic search using BM25 retrieval
- Question answering using Ollama LLM
- CLI interface with debug mode
- Clean, maintainable, and testable code structure
- Timeout protection for large files
- Optimized processing for SFIA Excel files

## Usage

### Basic Usage

```bash
# Ask a default question
python main.py

# Ask a specific question
python main.py "What is machine learning?"

# Load documents from a folder and ask questions
python main.py "What are the main topics?" --doc-folder ./documents

# Enable debug mode to see retrieved documents
python main.py "What is AI?" --doc-folder ./documents --debug

# Use a different Ollama model
python main.py "Explain quantum computing" --model llama3.1:latest

# Configure Ollama server URL
python main.py "Hello" --url http://localhost:11434

# Set custom timeout (in seconds)
python main.py "What is strategy planning?" --doc-folder ./doc --timeout 600
```

### SFIA Excel File Processing

For large SFIA Excel files, use smaller models to avoid timeouts:

```bash
# Use a smaller model for faster processing
python main.py "what is level 5 description of skill Strategy and planning" --doc-folder "./doc" --model "llama3.2:3b"

# Or use the test script to find the best model
python test_small_model.py
```

### Command Line Options

- `query`: Question to ask (optional, defaults to "What is your favorite season?")
- `--doc-folder`: Folder containing documents to load
- `--debug`: Enable debug mode to show retrieved documents
- `--model`: Ollama model to use (default: llama3.2:latest). For large files, try smaller models like 'llama3.2:3b' or 'deepseek-r1:1.5b'
- `--url`: Ollama server URL (default: http://localhost:11434)
- `--top-k`: Number of documents to retrieve (default: 10)
- `--timeout`: Timeout in seconds for processing (default: 300)

## Troubleshooting Timeout Issues

### Why Timeouts Occur

1. **Large Excel Files**: SFIA Excel files can be very large with many sheets and rows
2. **Large Models**: Models like `gpt-oss:20b` are computationally expensive
3. **Complex Processing**: Each Excel sheet is processed individually and sent to the LLM

### Solutions

1. **Use Smaller Models**:
   ```bash
   # Try these models in order of speed
   python main.py "your question" --model "llama3.2:3b"
   python main.py "your question" --model "deepseek-r1:1.5b"
   python main.py "your question" --model "llama3.2:latest"
   ```

2. **Increase Timeout**:
   ```bash
   python main.py "your question" --timeout 600  # 10 minutes
   ```

3. **Be More Specific**: Ask specific questions about particular skills or levels

4. **Use the Test Script**:
   ```bash
   python test_small_model.py
   ```

5. **Check Ollama Server**:
   ```bash
   ollama serve
   ```

### Performance Optimizations

The system includes several optimizations to prevent timeouts:

- **Sheet Limiting**: Only processes the first 10 sheets by default
- **Row Limiting**: Limits each sheet to 1000 rows
- **Content Truncation**: Limits document content to 10KB per sheet
- **Context Limiting**: Limits LLM context to 8KB
- **Timeout Protection**: 5-minute default timeout with graceful handling

## Requirements

- Python 3.10+
- Ollama server running locally
- Required Python packages (see requirements.txt)

## Installation

### Windows Users (Recommended)
1. **Setup Environment**: Double-click `setup_env.bat` or run:
   ```cmd
   setup_env.bat
   ```

2. **Start Application**: Double-click `start_app.bat` or run:
   ```cmd
   start_app.bat
   ```

### Manual Installation
1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Start Ollama server:
```bash
ollama serve
```

3. Pull the required model:
```bash
ollama pull llama3.2:latest
```

## Project Structure

```
SFIA/
├── src/
│   ├── interface/
│   │   └── cli.py              # CLI interface
│   ├── application/
│   │   └── services/
│   │       ├── document_service.py  # Document loading logic
│   │       └── qa_service.py        # Q&A orchestration
│   ├── domain/
│   │   ├── models/
│   │   │   ├── document.py     # Document entity
│   │   │   ├── query.py        # Query entity
│   │   │   └── response.py     # Response entity
│   │   └── repositories/
│   │       └── document_repository.py  # Repository interface
│   └── infrastructure/
│       ├── persistence/
│       │   └── haystack_document_store.py  # Haystack implementation
│       └── ml/
│           └── ollama_generator.py         # Ollama implementation
├── main.py                     # Entry point
├── test_small_model.py         # Test script for timeout issues
├── requirements.txt
└── README.md
```

## Development

This project follows clean architecture principles:

- **Interface Layer**: Handles user interactions (CLI, API)
- **Application Layer**: Orchestrates business operations
- **Domain Layer**: Contains business entities and rules
- **Infrastructure Layer**: Implements external dependencies

Each layer has clear responsibilities and dependencies flow inward.

## Testing

To run tests (when implemented):
```bash
pytest tests/
```

## Contributing

1. Follow the four-layer architecture
2. Add type hints and docstrings to all public functions
3. Keep files under 300 lines
4. Write tests for new features 