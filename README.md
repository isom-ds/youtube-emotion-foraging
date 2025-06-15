# Affective Foraging

A research project focused on modeling and analyzing emotional responses in YouTube content using knowledge graphs. 
This repository contains code related to emotion foraging experiments and information modeling.

## Features

- Data collection from YouTube videos
- Emotion analysis and annotation
- Statistical modeling and visualization

## Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/isom-ds/youtube-emotion-foraging.git
    ```
2. Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```
3. Install Neo4j Desktop from [https://neo4j.com/download/](https://neo4j.com/download/) and set it up according to your operating system.
4. Create a `key.py` file in the root directory and add your OpenAI and YouTube API keys:
    ```python
    OPENAI_API_KEY = "your-openai-api-key"
    YOUTUBE_API_KEY = "your-youtube-api-key"
    ```
5. Make sure to keep this file private and do not commit it to version control.
Before committing large files, increase Git's HTTP post buffer size to avoid errors:
    ```bash
    git config --global http.postBuffer 524288000
    ```