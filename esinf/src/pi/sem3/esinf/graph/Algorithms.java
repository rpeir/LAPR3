package pi.sem3.esinf.graph;



import pi.sem3.esinf.graph.matrix.MatrixGraph;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.function.BinaryOperator;

/**
 *
 * @author DEI-ISEP
 *
 */
public class Algorithms {

    /** Performs breadth-first search of a Graph starting in a vertex
     *
     * @param g Graph instance
     * @param vert vertex that will be the source of the search
     * @return a LinkedList with the vertices of breadth-first search
     */
    public static <V, E> LinkedList<V> BreadthFirstSearch(Graph<V, E> g, V vert) {
        LinkedList<V> result = new LinkedList<>();
        LinkedList<V> queue = new LinkedList<>();
        ArrayList<V> visited = new ArrayList<>();
        queue.add(vert);
        while (!queue.isEmpty()) {
            V v = queue.removeFirst();
            if (!visited.contains(v)) {
                visited.add(v);
                result.add(v);
                for (V w : g.vertices()) {
                    if (g.edge(v, w) != null) {
                        queue.add(w);
                    }
                }
            }
        }
        return result;

    }

    /** Performs depth-first search starting in a vertex
     *
     * @param g Graph instance
     * @param vOrig vertex of graph g that will be the source of the search
     * @param visited set of previously visited vertices
     * @param qdfs return LinkedList with vertices of depth-first search
     */
    private static <V, E> void DepthFirstSearch(Graph<V, E> g, V vOrig, boolean[] visited, LinkedList<V> qdfs) {

        visited[g.key(vOrig)] = true;
        qdfs.add(vOrig);
        for (V v : g.vertices()) {
            if (g.edge(vOrig, v) != null && !visited[g.key(v)]) {
                DepthFirstSearch(g, v, visited, qdfs);
            }
        }
    }

    /** Performs depth-first search starting in a vertex
     *
     * @param g Graph instance
     * @param vert vertex of graph g that will be the source of the search

     * @return a LinkedList with the vertices of depth-first search
     */
    public static <V, E> LinkedList<V> DepthFirstSearch(Graph<V, E> g, V vert) {

        LinkedList<V> result = new LinkedList<>();
        boolean[] visited = new boolean[g.numVertices()];
        DepthFirstSearch(g, vert, visited, result);
        return result;
    }

    /** Returns all paths from vOrig to vDest
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

        visited[g.key(vOrig)] = true;
        path.addFirst(vOrig);
        if (vOrig.equals(vDest)) {
            paths.add(path);
        } else {
            for (V v : g.vertices()) {
                if (g.edge(vOrig, v) != null && !visited[g.key(v)]) {
                    allPaths(g, v, vDest, visited, path, paths);
                }
            }
        }
    }

    /** Returns all paths from vOrig to vDest
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
                                                    boolean[] visited, V [] pathKeys, E [] dist) {
        dist[g.key(vOrig)] = zero;
        while (g.key(vOrig) != -1) {
            int vOrigKey = g.key(vOrig);
            visited[vOrigKey] = true;
            for (V vAdj : g.adjVertices(vOrig)) {
                Edge<V, E> edge = g.edge(vOrig, vAdj);
                int vAdjKey = g.key(vAdj);
                if (!visited[vAdjKey] && ce.compare(dist[vAdjKey], dist[vOrigKey]) > 0) {
                    dist[vAdjKey] = sum.apply(dist[vOrigKey], edge.getWeight());
                    pathKeys[vAdjKey] = vOrig;
                }
            }
            vOrig = getVertMinDist(pathKeys, dist, visited, ce);
        }
    }

    private static <V, E> V getVertMinDist(V[] pathKeys, E[] dist, boolean[] visited, Comparator<E> ce) {
        int shortest = 0;
        for (int i = 0; i < visited.length; i++) {
            if (!visited[i]) {
                shortest = i;
                break;
            }
        }
        for (int i = 0; i < dist.length; i++) {
            if (!visited[i]) {
                if (ce.compare(dist[i], dist[shortest]) < 0) {
                    shortest = i;
                }
            }
        }
        return pathKeys[shortest];
    }

    /** Shortest-path between two vertices
     *
     * @param g graph
     * @param vOrig origin vertex
     * @param vDest destination vertex
     * @param ce comparator between elements of type E
     * @param sum sum two elements of type E
     * @param zero neutral element of the sum in elements of type E
     * @param shortPath returns the vertices which make the shortest path
     * @return if vertices exist in the graph and are connected, true, false otherwise
     */
    public static <V, E> E shortestPath(Graph<V, E> g, V vOrig, V vDest,
                                        Comparator<E> ce, BinaryOperator<E> sum, E zero,
                                        LinkedList<V> shortPath) {
        throw new UnsupportedOperationException("Not implemented yet!");
    }

    /** Shortest-path between a vertex and all other vertices
     *
     * @param g graph
     * @param vOrig start vertex
     * @param ce comparator between elements of type E
     * @param sum sum two elements of type E
     * @param zero neutral element of the sum in elements of type E
     * @param paths returns all the minimum paths
     * @param dists returns the corresponding minimum distances
     * @return if vOrig exists in the graph true, false otherwise
     */
    public static <V, E> boolean shortestPaths(Graph<V, E> g, V vOrig,
                                               Comparator<E> ce, BinaryOperator<E> sum, E zero,
                                               ArrayList<LinkedList<V>> paths, ArrayList<E> dists) {
        int numVertices = g.numVertices();
        boolean[] visited = new boolean[numVertices];
        V[] pathKeys = (V[]) new Object[numVertices];
        E[] dist = (E[]) new Object[numVertices];
        for (int i = 0; i < numVertices; i++) {
            visited[i] = false;
            //
            // dist[i] =;
        }
        shortestPathDijkstra(g, vOrig, ce, sum, zero, visited, pathKeys, dist);
        throw new UnsupportedOperationException("Not implemented yet!");
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
                                       V [] pathKeys, LinkedList<V> path) {

       for (V v = vDest; !v.equals(vOrig); v = pathKeys[g.key(v)]) {
            path.addFirst(v);
        }
        path.addFirst(vOrig);
    }

    /** Calculates the minimum distance graph using Floyd-Warshall
     *
     * @param g initial graph
     * @param ce comparator between elements of type E
     * @param sum sum two elements of type E
     * @return the minimum distance graph
     */
    public static <V,E> MatrixGraph <V,E> minDistGraph(Graph <V,E> g, Comparator<E> ce, BinaryOperator<E> sum) {
        MatrixGraph<V,E> matrix = new MatrixGraph<>(g);
        int n = matrix.numVertices();
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                if (i != k && matrix.edge(i,k) != null) {
                    for (int j = 0; j < n; j++) {
                        if (i != j && k != j && matrix.edge(k,j) != null) {
                            matrix.addEdge(matrix.vertex(i), matrix.vertex(j), sum.apply(matrix.edge(i,k).getWeight(),matrix.edge(k,j).getWeight()));
                        }
                    }
                }
            }
        }
        return matrix;
    }

}
