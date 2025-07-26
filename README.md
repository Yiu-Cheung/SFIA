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
```

### Command Line Options

- `query`: Question to ask (optional, defaults to "What is your favorite season?")
- `--doc-folder`: Folder containing documents to load
- `--debug`: Enable debug mode to show retrieved documents
- `--model`: Ollama model to use (default: llama3.2:latest)
- `--url`: Ollama server URL (default: http://localhost:11434)
- `--top-k`: Number of documents to retrieve (default: 10)

## Requirements

- Python 3.10+
- Ollama server running locally
- Required Python packages (see requirements.txt)

## Installation

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