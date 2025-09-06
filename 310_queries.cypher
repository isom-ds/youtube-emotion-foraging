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

////
// 1) Get comments connected to the Topic "Legal and Regulatory Framework"
//    and limit first
MATCH (c:Comment)-[r]-(t:Topic {name: "Legal and Regulatory Framework"})
WHERE c.community = 18353 AND t.community = 18353
WITH DISTINCT c, t
LIMIT 200

// 2) Extract emotion labels from the Comment node labels
WITH c, t, labels(c) AS lbs
WITH c, t, [x IN lbs WHERE x IN [
  'anger','disgust','joy','sadness','fear','surprise','trust','anticipation','neutral'
]] AS emos
UNWIND emos AS lbl

// 3) Create/merge one shared Emotion node per category
MERGE (e:Emotion {name: lbl})

// 4) Also add the specific label (no APOC, via CASE/FOREACH)
FOREACH (_ IN CASE WHEN lbl = 'anger'        THEN [1] ELSE [] END | SET e:anger)
FOREACH (_ IN CASE WHEN lbl = 'disgust'      THEN [1] ELSE [] END | SET e:disgust)
FOREACH (_ IN CASE WHEN lbl = 'joy'          THEN [1] ELSE [] END | SET e:joy)
FOREACH (_ IN CASE WHEN lbl = 'sadness'      THEN [1] ELSE [] END | SET e:sadness)
FOREACH (_ IN CASE WHEN lbl = 'fear'         THEN [1] ELSE [] END | SET e:fear)
FOREACH (_ IN CASE WHEN lbl = 'surprise'     THEN [1] ELSE [] END | SET e:surprise)
FOREACH (_ IN CASE WHEN lbl = 'trust'        THEN [1] ELSE [] END | SET e:trust)
FOREACH (_ IN CASE WHEN lbl = 'anticipation' THEN [1] ELSE [] END | SET e:anticipation)
FOREACH (_ IN CASE WHEN lbl = 'neutral'      THEN [1] ELSE [] END | SET e:neutral)

// 5) Connect Comment → Emotion
MERGE (c)-[:HAS_EMOTION]->(e)

// 6) Return Comment, Emotion, and Topic
RETURN c, e, t

// Styling
// :style
// node.Topic {
//   font-size: 28px;
//   diameter: 200px;
// }
// node.Emotion {
//   font-size: 28px;
//   diameter: 100px;
// }

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
