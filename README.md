# youtube-emotion-foraging
> Knowledge graph-assisted analysis of emotional and topical information patches in YouTube discourse — extending Information Foraging Theory with an affective dimension.

## Abstract

Online discourse exhibits structured patterns in how users navigate and consume emotional content, yet existing Information Foraging Theory does not account for affective motivations. This repository implements a computational framework that constructs a Neo4j knowledge graph from 5,874 YouTube transcripts and 866,673 comments on US Tariff discourse (2025), then uses it to surface patterns of affective foraging — identifying how users cluster around emotionally charged topics. The work extends Information Foraging Theory by introducing the concept of Affective Foraging, which integrates Digital Emotion Regulation with rational information-seeking to model emotionally driven online behaviour [Online]. Available: https://hdl.handle.net/10125/111706.

## Research Context

- **Thesis:** *Epidemiology of Online Emotions* (Kok-Shun, 2026)
- **Chapter:** Chapter 6 — Affective Information Models
- **Contribution type:** Artefact (knowledge graph pipeline) + Theoretical (Affective Foraging Theory)
- **Associated paper:** "Affective Foraging: Knowledge Graph-Assisted Analysis of Emotion and Topic Information Patches in Online Discourse on the 2025 US Tariffs," HICSS 2026

## Methods

- Knowledge graph construction (Neo4j 5.28.1 with APOC and Graph Data Science)
- Emotion annotation via OpenAI API
- Topic modelling (BERTopic + Agentopic)
- Graph Data Science (GDS) algorithms for cluster analysis
- Affective foraging pattern extraction

## Datasets

| Dataset | Description | Access |
|---------|-------------|--------|
| YouTube Transcripts | 5,874 video transcripts on US Tariffs 2025 | Collected via YouTube Data API |
| YouTube Comments | 866,673 comments on US Tariff videos | Collected via YouTube Data API |

## Repository Structure

```
youtube-emotion-foraging/
├── agentopic/               # Agentopic topic modelling module
│   ├── llm/
│   ├── prompts/
│   ├── schemas/
│   ├── vectordb/
│   └── utils/
├── data/                    # Collected and processed datasets
│   ├── agentopic/           # Agentopic topic outputs
│   ├── BERTopic/            # BERTopic outputs
│   ├── extracted/           # Extracted features
│   ├── neo4j/               # Neo4j import files
│   └── parquet/             # Parquet data files
├── 100_data_apism.ipynb     # Data collection via APISM
├── 200_ai_topic_emotion.ipynb
├── 210_ai_extraction.ipynb
├── 220_ai_topic_refinement.ipynb
├── 230_combine_reshape.ipynb
├── 300_knowledge_graph.ipynb
├── 310_queries.cypher       # Cypher queries for graph analysis
└── requirements.txt
```

## Requirements & Setup

Python 3.12, Neo4j Desktop 5.28.1 (with APOC and Graph Data Science plugins), OpenAI API key, ChromaDB.

```bash
pip install -r requirements.txt
```

Install [Neo4j Desktop](https://neo4j.com/download/) and create a new database. Enable the **APOC** and **Graph Data Science** plugins via the Plugins tab in Neo4j Desktop.

Add your API keys to `keys.py` in the root directory:

```python
OPENAI_API_KEY = "your-openai-api-key"
YOUTUBE_API_KEY = "your-youtube-api-key"
```

## Usage

Run notebooks in ascending numerical order:

1. `100_data_apism.ipynb` — Data collection from YouTube
2. `200_ai_topic_emotion.ipynb` — Emotion annotation and topic modelling
3. `210_ai_extraction.ipynb` — Feature extraction
4. `220_ai_topic_refinement.ipynb` — Topic refinement
5. `230_combine_reshape.ipynb` — Data consolidation
6. `300_knowledge_graph.ipynb` — Knowledge graph construction and loading
7. `310_queries.cypher` — Cypher queries for affective foraging analysis

## References

B. V. Kok-Shun, J. Chan, G. Peko, and D. Sundaram, "Affective Foraging: Knowledge Graph-Assisted Analysis of Emotion and Topic Information Patches in Online Discourse on the 2025 US Tariffs," in *Proceedings of the 59th Hawaii International Conference on System Sciences*, 2026 [Online]. Available: https://hdl.handle.net/10125/111706.

<details>
<summary>BibTeX</summary>

```bibtex
@inproceedings{P7_kok-shun_affective_2026,
  title     = {Affective {Foraging}: {Knowledge} {Graph}-{Assisted} {Analysis} of {Emotion} and {Topic} {Information} {Patches} in {Online} {Discourse} on the 2025 {US} {Tariffs}},
  booktitle = {Proceedings of the 59th {Hawaii} {International} {Conference} on {System} {Sciences}},
  author    = {Kok-Shun, Brice Valentin and Chan, Johnny and Peko, Gabrielle and Sundaram, David},
  year      = {2026},
  url      = {https://hdl.handle.net/10125/111706},
}
```

</details>
