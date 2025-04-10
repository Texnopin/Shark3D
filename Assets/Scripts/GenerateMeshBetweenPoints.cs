using UnityEngine;

public class GenerateMeshBetweenPoints : MonoBehaviour
{
    [SerializeField]
    private float meshWidth = 1.0f;

    [SerializeField]
    private int polygonCount = 10;

    [SerializeField]
    private Material meshMaterial;

    public GameObject startPointObject;
    public GameObject endPointObject;

    private Mesh mesh;
    private MeshFilter meshFilter;
    private MeshRenderer meshRenderer;

    void Start()
    {
        meshFilter = gameObject.AddComponent<MeshFilter>();
        meshRenderer = gameObject.AddComponent<MeshRenderer>();
        meshRenderer.material = meshMaterial;

        mesh = new Mesh();
        meshFilter.mesh = mesh;

    }

    void Update()
    {
        // Обновление координат точек
        Vector3 startPoint = startPointObject.transform.position;
        Vector3 endPoint = endPointObject.transform.position;


        // Проверка на наличие вершин в mesh.vertices
        if (mesh.vertices.Length >= 2)
        {
            // Обновление меша только при изменении координат точек
            if (Vector3.Distance(endPoint, mesh.vertices[mesh.vertices.Length - 1]) > 0.01f ||
                Vector3.Distance(startPoint, mesh.vertices[0]) > 0.01f)
            {
                GenerateMeshData(startPoint, endPoint);
            }
        }
        else
        {
            // Генерация меша, если он еще не создан
            GenerateMeshData(startPoint, endPoint);
        }
    }

    void GenerateMeshData(Vector3 startPoint, Vector3 endPoint)
    {
        // Создание вершин
        Vector3[] vertices = new Vector3[(polygonCount + 1) * 2];
        float step = Vector3.Distance(startPoint, endPoint) / polygonCount;

        for (int i = 0; i <= polygonCount; i++)
        {
            float t = (float)i / polygonCount;
            Vector3 pointOnLine = Vector3.Lerp(startPoint, endPoint, t);

            // Убедитесь, что вершины создаются в глобальных координатах
            vertices[i * 2] = pointOnLine + new Vector3(-meshWidth / 2, 0, 0);
            vertices[i * 2 + 1] = pointOnLine + new Vector3(meshWidth / 2, 0, 0);
        }

        // Создание треугольников
        int[] triangles = new int[polygonCount * 6];
        int triangleIndex = 0;

        for (int i = 0; i < polygonCount; i++)
        {
            triangles[triangleIndex] = i * 2;
            triangles[triangleIndex + 1] = i * 2 + 1;
            triangles[triangleIndex + 2] = (i + 1) * 2;

            triangles[triangleIndex + 3] = (i + 1) * 2;
            triangles[triangleIndex + 4] = i * 2 + 1;
            triangles[triangleIndex + 5] = (i + 1) * 2 + 1;

            triangleIndex += 6;
        }

        // Обновление меша
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.RecalculateNormals();
    }
}
