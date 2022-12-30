package graph;


import graph.matrix.MatrixGraph;

import java.util.*;
import java.util.function.BinaryOperator;

/**
 * @author DEI-ISEP
 */
public class Algorithms {

    /**
     * Performs breadth-first search of a Graph starting in a vertex
     *
     * @param g    Graph instance
     * @param vert vertex that will be the source of the search
     * @return a LinkedList with the vertices of breadth-first search
     */
    public static <V, E> LinkedList<V> BreadthFirstSearch(Graph<V, E> g, V vert) {
        if (!g.validVertex(vert))
            return null;
        boolean[] visited = new boolean[g.numVertices()];
        LinkedList<V> qbfs = new LinkedList<>();
        LinkedList<V> qaux = new LinkedList<>();
        qbfs.add(vert);
        qaux.add(vert);
        visited[g.key(vert)] = true;

        while (!qaux.isEmpty()) {
            vert = qaux.element();
            qaux.remove();
            for (V vAdj : g.adjVertices(vert)) {
                if (!visited[g.key(vAdj)]) {
                    qbfs.add(vAdj);
                    qaux.add(vAdj);
                    visited[g.key(vAdj)] = true;
                }
            }
        }
        return qbfs;
    }

    /**
     * Performs depth-first search starting in a vertex
     *
     * @param g       Graph instance
     * @param vOrig   vertex of graph g that will be the source of the search
     * @param visited set of previously visited vertices
     * @param qdfs    return LinkedList with vertices of depth-first search
     */
    private static <V, E> void DepthFirstSearch(Graph<V, E> g, V vOrig, boolean[] visited, LinkedList<V> qdfs) {
        if (visited[g.key(vOrig)]) {
            return;
        }
        visited[g.key(vOrig)] = true;
        qdfs.add(vOrig);
        for (V v : g.adjVertices(vOrig)) {
            if (g.edge(vOrig, v) != null && !visited[g.key(v)]) {
                DepthFirstSearch(g, v, visited, qdfs);
            }
        }
    }

    /**
     * Performs depth-first search starting in a vertex
     *
     * @param g    Graph instance
     * @param vert vertex of graph g that will be the source of the search
     * @return a LinkedList with the vertices of depth-first search
     */
    public static <V, E> LinkedList<V> DepthFirstSearch(Graph<V, E> g, V vert) {
        if (!g.validVertex(vert))
            return null;
        LinkedList<V> result = new LinkedList<>();
        boolean[] visited = new boolean[g.numVertices()];
        DepthFirstSearch(g, vert, visited, result);
        return result;
    }

    /**
     * Returns all paths from vOrig to vDest
     *
     * @param g       Graph instance
     * @param vOrig   Vertex that will be the source of the path
     * @param vDest   Vertex that will be the end of the path
     * @param visited set of discovered vertices
     * @param path    stack with vertices of the current path (the path is in reverse order)
     * @param paths   ArrayList with all the paths (in correct order)
     */
    private static <V, E> void allPaths(Graph<V, E> g, V vOrig, V vDest, boolean[] visited,
                                        LinkedList<V> path, ArrayList<LinkedList<V>> paths) {

        if (visited[g.key(vOrig)]) return;

        path.push(vOrig);
        visited[g.key(vOrig)] = true;
        for (V vAdj : g.adjVertices(vOrig)) {
            if (vAdj.equals(vDest)) {
                path.push(vDest);
                LinkedList<V> pathCopy = new LinkedList<>(path);
                Collections.reverse(pathCopy);
                paths.add(pathCopy);
                path.pop();
            } else {
                allPaths(g, vAdj, vDest, visited, path, paths);
            }
        }
        path.pop();
        visited[g.key(vOrig)] = false;
    }

    /**
     * Returns all paths from vOrig to vDest
     *
     * @param g     Graph instance
     * @param vOrig information of the Vertex origin
     * @param vDest information of the Vertex destination
     * @return paths ArrayList with all paths from vOrig to vDest
     */
    public static <V, E> ArrayList<LinkedList<V>> allPaths(Graph<V, E> g, V vOrig, V vDest) {

        ArrayList<LinkedList<V>> paths = new ArrayList<>();
        boolean[] visited = new boolean[g.numVertices()];
        LinkedList<V> path = new LinkedList<>();
        allPaths(g, vOrig, vDest, visited, path, paths);
        return paths;
    }

    /**
     * Computes shortest-path distance from a source vertex to all reachable
     * vertices of a graph g with non-negative edge weights
     * This implementation uses Dijkstra's algorithm
     *
     * @param g        Graph instance
     * @param vOrig    Vertex that will be the source of the path
     * @param visited  set of previously visited vertices
     * @param pathKeys minimum path vertices keys
     * @param dist     minimum distances
     */
    private static <V, E> void shortestPathDijkstra(Graph<V, E> g, V vOrig,
                                                    Comparator<E> ce, BinaryOperator<E> sum, E zero,
                                                    boolean[] visited, V[] pathKeys, E[] dist) {
        for (V vertices : g.vertices()) {
            dist[g.key(vertices)] = null;
            pathKeys[g.key(vertices)] = null;
            visited[g.key(vertices)] = false;
        }
        int vOrigKey = g.key(vOrig);
        dist[vOrigKey] = zero;
        while (vOrig != null) {
            vOrigKey = g.key(vOrig);
            visited[vOrigKey] = true;
            for (V vAdj : g.adjVertices(vOrig)) {
                Edge<V, E> edge = g.edge(vOrig, vAdj);
                int vAdjKey = g.key(vAdj);
                if (!visited[vAdjKey]) {
                    E newDist = sum.apply(dist[vOrigKey], edge.getWeight());
                    if (dist[vAdjKey] == null || ce.compare(dist[vAdjKey], newDist) > 0) {
                        dist[vAdjKey] = newDist;
                        pathKeys[vAdjKey] = vOrig;
                    }
                }
            }
            vOrig = getVertMinDist(g, dist, visited, ce, zero);
        }

    }


    /**
     * It returns the vertex with the minimum distance from the source vertex
     *
     * @param g       the graph
     * @param dist    an array of the same size as the number of vertices in the graph. It will contain the distance from the
     *                source vertex to each vertex in the graph.
     * @param visited an array of booleans that indicates whether a vertex has been visited or not.
     * @param ce      Comparator<E>
     * @param zero    the zero element of the type E.
     * @return The vertex with the minimum distance.
     */
    private static <V, E> V getVertMinDist(Graph<V, E> g, E[] dist, boolean[] visited, Comparator<E> ce, E zero) {
        E menorDistancia = zero;
        V vMenor = null;
        for (int i = 0; i < visited.length; i++) {
            if (!visited[i]) {
                if (dist[i] != null) {
                    if (menorDistancia == zero) {
                        menorDistancia = dist[i];
                        vMenor = g.vertex(i);
                    } else if (ce.compare(menorDistancia, dist[i]) > 0) {
                        menorDistancia = dist[i];
                        vMenor = g.vertex(i);
                    }
                }
            }
        }
        return vMenor;
    }

    /**
     * Shortest-path between two vertices
     *
     * @param g         graph
     * @param vOrig     origin vertex
     * @param vDest     destination vertex
     * @param ce        comparator between elements of type E
     * @param sum       sum two elements of type E
     * @param zero      neutral element of the sum in elements of type E
     * @param shortPath returns the vertices which make the shortest path
     * @return if vertices exist in the graph and are connected, true, false otherwise
     */
    public static <V, E> E shortestPath(Graph<V, E> g, V vOrig, V vDest,
                                        Comparator<E> ce, BinaryOperator<E> sum, E zero,
                                        LinkedList<V> shortPath) {
        if (!g.validVertex(vOrig) || !g.validVertex(vDest))
            return null;

        shortPath.clear();
        int numVertices = g.numVertices();
        E result = zero;
        E dist[] = (E[]) new Object[numVertices];
        V[] pathKeys = (V[]) new Object[numVertices];

        boolean[] visited = new boolean[numVertices];
        for (int i = 0; i < numVertices; i++) {
            visited[i] = false;
        }

        shortestPathDijkstra(g, vOrig, ce, sum, zero, visited, pathKeys, dist);
        getPath(g, vOrig, vDest, pathKeys, shortPath);

        if (shortPath.contains(vDest)) {
            for (int i = 0; i < shortPath.size() - 1; i++) {
                Edge<V, E> edge = g.edge(shortPath.get(i), shortPath.get(i + 1));
                result = sum.apply(result, edge.getWeight());
            }
        } else {
            result = null;
            shortPath.clear();
        }
        return result;
    }

    /**
     * Shortest-path between a vertex and all other vertices
     *
     * @param g     graph
     * @param vOrig start vertex
     * @param ce    comparator between elements of type E
     * @param sum   sum two elements of type E
     * @param zero  neutral element of the sum in elements of type E
     * @param paths returns all the minimum paths
     * @param dists returns the corresponding minimum distances
     * @return if vOrig exists in the graph true, false otherwise
     */
    public static <V, E> boolean shortestPaths(Graph<V, E> g, V vOrig,
                                               Comparator<E> ce, BinaryOperator<E> sum, E zero,
                                               ArrayList<LinkedList<V>> paths, ArrayList<E> dists) {

        if (!g.validVertex(vOrig))
            return false;

        int numVertices = g.numVertices();
        boolean[] visited = new boolean[numVertices];
        V[] pathKeys = (V[]) new Object[numVertices];
        E[] dist = (E[]) new Object[numVertices];

        shortestPathDijkstra(g, vOrig, ce, sum, zero, visited, pathKeys, dist);

        dists.clear();
        paths.clear();

        for (int i = 0; i < numVertices; i++) {
            paths.add(null);
            dists.add(null);
        }

        for (V vDest : g.vertices()) {
            int i = g.key(vDest);
            if (dist[i] != null) {
                LinkedList<V> shortPath = new LinkedList<>();
                getPath(g, vOrig, vDest, pathKeys, shortPath);
                paths.set(i, shortPath);
                dists.set(i, dist[i]);
            }
        }
        return true;
    }

    /**
     * Extracts from pathKeys the minimum path between voInf and vdInf
     * The path is constructed from the end to the beginning
     *
     * @param g        Graph instance
     * @param vOrig    information of the Vertex origin
     * @param vDest    information of the Vertex destination
     * @param pathKeys minimum path vertices keys
     * @param path     stack with the minimum path (correct order)
     */
    private static <V, E> void getPath(Graph<V, E> g, V vOrig, V vDest,
                                       V[] pathKeys, LinkedList<V> path) {
        V vert = vDest;
        while (pathKeys[g.key(vert)] != null && !vert.equals(vOrig)) {
            path.add(vert);
            vert = pathKeys[g.key(vert)];
        }
        path.add(vOrig);
        Collections.reverse(path);
    }

    /**
     * Calculates the minimum distance graph using Floyd-Warshall
     *
     * @param g   initial graph
     * @param ce  comparator between elements of type E
     * @param sum sum two elements of type E
     * @return the minimum distance graph
     */
    public static <V, E> MatrixGraph<V, E> minDistGraph(Graph<V, E> g, Comparator<E> ce, BinaryOperator<E> sum) {
        MatrixGraph<V, E> matrix = new MatrixGraph<>(g);
        int n = matrix.numVertices();
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                if (i != k && matrix.edge(i, k) != null) {
                    for (int j = 0; j < n; j++) {
                        if (i != j && k != j && matrix.edge(k, j) != null) {
                            E newSum = sum.apply(matrix.edge(i, k).getWeight(), matrix.edge(k, j).getWeight());
                            if (matrix.edge(i, j) == null || ce.compare(matrix.edge(i, j).getWeight(), newSum) > 0) {
                                matrix.addEdge(matrix.vertex(i), matrix.vertex(j), newSum);
                            }
                        }
                    }
                }
            }
        }
        return matrix;
    }


    /**
     * This function takes a graph, a comparator, a binary operator, and a zero value, and returns the minimum number of
     * connections needed to connect all vertices in the graph
     *
     * @param g    The graph to be analyzed
     * @param ce   Comparator<E>
     * @param sum  a function that takes two edges and returns the sum of the two edges.
     * @param zero the zero element of the edge type.
     * @return The minimum number of connections between any two vertices in the graph.
     */
    public static <V, E> int minConnections(Graph<V, E> g, Comparator<E> ce, BinaryOperator<E> sum, E zero) {
        int minConnections = 0;
        boolean[] visited = new boolean[g.numVertices()];
        for (V vert : g.vertices()) {
            for (V vert2 : g.vertices()) {
                if (!vert.equals(vert2)) {
                    LinkedList<V> path = new LinkedList<>();
                    ArrayList<LinkedList<V>> paths = new ArrayList<>();
                    Algorithms.allPaths(g, vert, vert2, visited, path, paths);
                    if (paths.size() == 0) {
                        return -1;
                    } else {
                        LinkedList<V> caminhoMin = null;
                        for (LinkedList<V> caminho : paths) {
                            if (caminhoMin == null)
                                caminhoMin = caminho;
                            else if (caminhoMin.size() -1 > caminho.size() - 1)
                                caminhoMin = caminho;
                        }
                        if (minConnections < caminhoMin.size() - 1) {
                            minConnections = caminhoMin.size() - 1;
                        }
                    }
                }
            }
        }
        return minConnections;
    }

    /**
     * Determines a Minimum Spanning Tree using Kruskal's algorithm
     *
     * @param g  The graph to be processed
     * @param ce Comparator<E>
     * @return A minimum spanning tree
     */
    public static <V, E> Graph<V, E> kruskall(Graph<V, E> g, Comparator<E> ce) {
        if (g.isDirected())
            throw new IllegalArgumentException("Graph must be undirected");

        Graph<V, E> mst = new MatrixGraph<>(false, g.numVertices());

        for (V vert : g.vertices()) {
            mst.addVertex(vert);
        }

        List<Edge<V, E>> lstEdges = new ArrayList<>(g.edges());
        lstEdges.sort(new Comparator<Edge<V, E>>() {
            @Override
            public int compare(Edge<V, E> o1, Edge<V, E> o2) {
                return ce.compare(o1.getWeight(), o2.getWeight());
            }
        });

        for (Edge<V, E> edge : lstEdges) {
            V vOrig = edge.getVOrig();
            V vDest = edge.getVDest();
            List<V> connectedVerts = DepthFirstSearch(mst, vOrig);
            if (connectedVerts != null && !connectedVerts.contains(vDest)) {
                mst.addEdge(vOrig, vDest, edge.getWeight());
            }
        }
        return mst;
    }

    /**
     * Determines a Minimum Spanning Tree using Prim's algorithm
     *
     * @param g    the graph
     * @param ce   Comparator<E>
     * @param zero the zero value for the edge weights.
     * @return A minimum spanning tree.
     */
    public static <V, E> Graph<V, E> prim(Graph<V, E> g, Comparator<E> ce, E zero) {
        if (g.isDirected())
            throw new IllegalArgumentException("Graph must be undirected");

        int numVertices = g.numVertices();
        boolean[] visited = new boolean[numVertices];
        V[] pathKeys = (V[]) new Object[numVertices];
        E[] dist = (E[]) new Object[numVertices];

        int vOrigKey = 0;
        V vOrig = g.vertex(0);
        dist[vOrigKey] = zero;

        while (vOrig != null) {
            vOrigKey = g.key(vOrig);
            visited[vOrigKey] = true;
            for (V vAdj : g.adjVertices(vOrig)) {
                Edge<V, E> edge = g.edge(vOrig, vAdj);
                E newDist = edge.getWeight();
                int vAdjKey = g.key(vAdj);
                if (!visited[vAdjKey]) {
                    if (dist[vAdjKey] == null || ce.compare(dist[vAdjKey], newDist) > 0) {
                        dist[vAdjKey] = newDist;
                        pathKeys[vAdjKey] = vOrig;
                    }
                }
            }
            vOrig = getVertMinDist(g, dist, visited, ce, zero);
        }

        return buildMst(g, pathKeys, dist);
    }

    /**
     * Builds a minimum spanning tree from a graph and a pathKeys array and a dist array
     *
     * @param g        the graph to find the MST of
     * @param pathKeys An array of vertices that represent the path from the source vertex to the current vertex.
     * @param dist     The array of distances from the source vertex to each vertex in the graph.
     * @return A minimum spanning tree of the graph.
     */
    private static <V, E> Graph<V, E> buildMst(Graph<V, E> g, V[] pathKeys, E[] dist) {
        Graph<V, E> mst = new MatrixGraph<>(false);
        for (V vert : g.vertices()) {
            mst.addVertex(vert);
        }

        int numVertices = g.numVertices();
        for (int i = 0; i < numVertices; i++) {
            V vDest = pathKeys[i];
            if (vDest != null) {
                mst.addEdge(mst.vertex(i), vDest, dist[i]);
            }
        }

        return mst;
    }

    /**
     * Gets the total weight of a graph
     *
     * @param g    The graph to get the weight of
     * @param sum  The sum function
     * @param zero The zero value for the edge weights
     * @param <V>  The vertex type
     * @param <E>  The edge type
     * @return The total weight of the graph
     */
    public static <V, E> E totalWeight(Graph<V, E> g, BinaryOperator<E> sum, E zero) {
        E totalWeight = zero;
        for (Edge<V, E> edge : g.edges()) {
            totalWeight = sum.apply(totalWeight, edge.getWeight());
        }
        return totalWeight;
    }
}
