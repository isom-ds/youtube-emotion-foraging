// ========================================
// # of nodes in each community by type
// ========================================
MATCH (n)
WHERE n.community IS NOT NULL
RETURN labels(n) AS type, n.community AS community, count(*) AS count
ORDER BY count DESC
;

// ========================================
// Visualize nodes in community 18353
// ========================================
MATCH (n)-[r]-(m)
WHERE n.community = 18353 AND m.community = 18353
RETURN n, r, m
LIMIT 200
;

// ========================================
// # of nodes in each community with labels
// ========================================
// Step 1: Get emotion-topic frequency per community
MATCH (n)
WHERE n.community IS NOT NULL
MATCH (n)-[:MENTIONS]->(t:Topic)
MATCH (n)-[:EXPRESSES]->(e:Emotion)
WITH n.community AS community, e.name AS emotion, t.name AS topic, count(*) AS freq

// Step 2: Also calculate total frequency per community
WITH community, emotion, topic, freq
WITH community, collect({emotion: emotion, topic: topic, freq: freq}) AS pairs
WITH community, pairs, reduce(total = 0, p IN pairs | total + p.freq) AS totalFreq
UNWIND pairs AS pair

// Step 3: Compute percentage
RETURN 
    community, 
    pair.topic AS topic, 
    pair.emotion AS emotion, 
    pair.freq AS freq,
    round(100.0 * pair.freq / totalFreq, 2) AS percentage
ORDER BY community, topic, emotion, freq DESC
