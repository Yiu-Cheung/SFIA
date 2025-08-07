#!/usr/bin/env python3
"""
Test script for SFIA with smaller model to avoid timeouts.
This script uses a smaller model for faster processing of large Excel files.
"""

import subprocess
import sys
import os

def main():
    """Test SFIA with a smaller model."""
    
    # Check if doc folder exists
    doc_folder = "./doc"
    if not os.path.exists(doc_folder):
        print(f"Error: Document folder '{doc_folder}' not found.")
        print("Please ensure the SFIA Excel file is in the ./doc folder.")
        return
    
    # Check if Excel file exists
    excel_files = [f for f in os.listdir(doc_folder) if f.endswith(('.xlsx', '.xls'))]
    if not excel_files:
        print(f"No Excel files found in {doc_folder}")
        return
    
    print("Testing SFIA with smaller model to avoid timeouts...")
    print(f"Found Excel file: {excel_files[0]}")
    print()
    
    # Test with a smaller model
    smaller_models = [
        "llama3.2:3b",
        "deepseek-r1:1.5b", 
        "llama3.2:latest"
    ]
    
    for model in smaller_models:
        print(f"Testing with model: {model}")
        print("-" * 50)
        
        try:
            # Run the command with timeout
            cmd = [
                "python", "main.py",
                "what is level 5 description of skill Strategy and planning",
                "--doc-folder", "./doc",
                "--model", model,
                "--timeout", "120"  # 2 minutes timeout
            ]
            
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=180)
            
            if result.returncode == 0:
                print("SUCCESS!")
                print("Output:")
                print(result.stdout)
                break
            else:
                print(f"Failed with model {model}:")
                print(result.stderr)
                print()
                
        except subprocess.TimeoutExpired:
            print(f"Timeout with model {model}")
            print()
        except Exception as e:
            print(f"Error with model {model}: {e}")
            print()
    
    print("\nRecommendations:")
    print("1. If you still get timeouts, try an even smaller model")
    print("2. Make your question more specific")
    print("3. Consider processing only specific sheets of the Excel file")
    print("4. Check if Ollama is running: ollama serve")

if __name__ == "__main__":
    main() 