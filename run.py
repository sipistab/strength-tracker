#!/usr/bin/env python3
"""
Simple launcher for StrengthTracker.
"""

import subprocess
import sys
from pathlib import Path

def main():
    print("StrengthTracker")
    print("===============")
    print()
    print("Starting Strength Workout Tracker")
    print()
    
    # Check if requirements are installed
    try:
        import click
        import rich
        import yaml
    except ImportError:
        print("Installing dependencies...")
        subprocess.run([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])
        print("Dependencies installed!")
        print()
    
    # Run the application
    print("Starting StrengthTracker...")
    subprocess.run([sys.executable, "strength_tracker.py"])

if __name__ == "__main__":
    main() 