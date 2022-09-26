MATCH (a:Course{name:"Primary Education"}), (b:Course{name:"Computing for Business"})
CALL algo.shortestPath.stream(start, end, "cost")
YIELD nodeId, cost
MATCH (other:Loc) WHERE id(other) = nodeId
RETURN other.name AS name, cost


// Calls shortest path on all nodes, and shows relationships nodes less than
// 2 away
CALL gds.alpha.allShortestPaths.stream({
  nodeProjection: 'Course',
  relationshipProjection: {
    ROAD: {
      type: 'DISSIMILARITY',
      properties: 'percent'
    }
  },
  relationshipWeightProperty: 'percent'
})
YIELD sourceNodeId, targetNodeId, distance
WITH sourceNodeId, targetNodeId, distance
WHERE gds.util.isFinite(distance) = true

MATCH (source:Course) WHERE id(source) = sourceNodeId
MATCH (target:Course) WHERE id(target) = targetNodeId
WITH source, target, distance WHERE source <> target AND distance < 2

RETURN source.name AS source, target.name AS target, distance
ORDER BY source, target ASC

// Creating new students outgoing relationships
MATCH (ds:Course {name:"Data Science"}), (ec:Course {name:"Computing for Business"}), (cs:Course {name:"Computer Science"}),
(a:Course {name: "Electronic & Computer Engineering", students: 50}), (b:Course {name: "Mechanical Engineering", students: 30}), (c:Course {name: "Business", students: 100}),
(d:Course {name: "Accounting", students: 30}), (e:Course {name: "Applied Physics", students: 20}), (f:Course {name: "Actuarial Maths", students: 50}),
(g:Course {name: "Economics, Politics & Law", students: 60}), (h:Course {name: "Primary Education", students: 120}), (i:Course {name: "Physical Education and Maths", students: 30}),
(j:Course {name: "Chemistry", students: 40}), (k:Course {name: "Biotechnology", students: 30}), (l:Course {name: "Genetics & Cell Biology", students:30}),
(m:Course {name: "Psychology", students: 50}), (n:Course {name: "Nursing", students:80}), (o:Course {name: "Social Science", students: 40}), (p:Course {name: "Journalism", students: 50})
CREATE
(d)-[:OUTGOING_STUDENTS{no_of_students:1}]->(f),
(d)-[:OUTGOING_STUDENTS{no_of_students:1}]->(ec),
(d)-[:OUTGOING_STUDENTS{no_of_students:1}]->(g),
(f)-[:OUTGOING_STUDENTS{no_of_students:1}]->(e),
(f)-[:OUTGOING_STUDENTS{no_of_students:1}]->(cs),
(f)-[:OUTGOING_STUDENTS{no_of_students:2}]->(ec),
(f)-[:OUTGOING_STUDENTS{no_of_students:1}]->(ds),
(e)-[:OUTGOING_STUDENTS{no_of_students:1}]->(j),
(e)-[:OUTGOING_STUDENTS{no_of_students:1}]->(l),
(k)-[:OUTGOING_STUDENTS{no_of_students:1}]->(e),
(k)-[:OUTGOING_STUDENTS{no_of_students:1}]->(a),
(k)-[:OUTGOING_STUDENTS{no_of_students:1}]->(n),
(c)-[:OUTGOING_STUDENTS{no_of_students:1}]->(d),
(c)-[:OUTGOING_STUDENTS{no_of_students:5}]->(f),
(c)-[:OUTGOING_STUDENTS{no_of_students:1}]->(cs),
(c)-[:OUTGOING_STUDENTS{no_of_students:1}]->(ec),
(c)-[:OUTGOING_STUDENTS{no_of_students:1}]->(ds),
(c)-[:OUTGOING_STUDENTS{no_of_students:1}]->(p),
(j)-[:OUTGOING_STUDENTS{no_of_students:2}]->(e),
(j)-[:OUTGOING_STUDENTS{no_of_students:1}]->(a),
(j)-[:OUTGOING_STUDENTS{no_of_students:1}]->(l),
(cs)-[:OUTGOING_STUDENTS{no_of_students:2}]->(c),
(cs)-[:OUTGOING_STUDENTS{no_of_students:3}]->(ec),
(cs)-[:OUTGOING_STUDENTS{no_of_students:2}]->(ds),
(cs)-[:OUTGOING_STUDENTS{no_of_students:5}]->(b),
(ec)-[:OUTGOING_STUDENTS{no_of_students:1}]->(d),
(ec)-[:OUTGOING_STUDENTS{no_of_students:2}]->(c),
(ds)-[:OUTGOING_STUDENTS{no_of_students:1}]->(cs),
(ds)-[:OUTGOING_STUDENTS{no_of_students:1}]->(ec),
(g)-[:OUTGOING_STUDENTS{no_of_students:2}]->(d),
(g)-[:OUTGOING_STUDENTS{no_of_students:2}]->(c),
(g)-[:OUTGOING_STUDENTS{no_of_students:2}]->(cs),
(a)-[:OUTGOING_STUDENTS{no_of_students:1}]->(k),
(a)-[:OUTGOING_STUDENTS{no_of_students:2}]->(cs),
(a)-[:OUTGOING_STUDENTS{no_of_students:1}]->(ec),
(a)-[:OUTGOING_STUDENTS{no_of_students:1}]->(b),
(l)-[:OUTGOING_STUDENTS{no_of_students:1}]->(k),
(l)-[:OUTGOING_STUDENTS{no_of_students:2}]->(j),
(p)-[:OUTGOING_STUDENTS{no_of_students:2}]->(d),
(p)-[:OUTGOING_STUDENTS{no_of_students:1}]->(c),
(p)-[:OUTGOING_STUDENTS{no_of_students:2}]->(o),
(b)-[:OUTGOING_STUDENTS{no_of_students:1}]->(j),
(b)-[:OUTGOING_STUDENTS{no_of_students:1}]->(cs),
(b)-[:OUTGOING_STUDENTS{no_of_students:1}]->(a),
(n)-[:OUTGOING_STUDENTS{no_of_students:1}]->(k),
(n)-[:OUTGOING_STUDENTS{no_of_students:1}]->(j),
(n)-[:OUTGOING_STUDENTS{no_of_students:4}]->(l),
(n)-[:OUTGOING_STUDENTS{no_of_students:2}]->(m),
(i)-[:OUTGOING_STUDENTS{no_of_students:1}]->(e),
(i)-[:OUTGOING_STUDENTS{no_of_students:2}]->(h),
(h)-[:OUTGOING_STUDENTS{no_of_students:4}]->(f),
(h)-[:OUTGOING_STUDENTS{no_of_students:3}]->(e),
(h)-[:OUTGOING_STUDENTS{no_of_students:5}]->(i),
(m)-[:OUTGOING_STUDENTS{no_of_students:2}]->(n),
(m)-[:OUTGOING_STUDENTS{no_of_students:3}]->(o),
(o)-[:OUTGOING_STUDENTS{no_of_students:1}]->(l),
(o)-[:OUTGOING_STUDENTS{no_of_students:2}]->(n),
(o)-[:OUTGOING_STUDENTS{no_of_students:1}]->(m)