using UnityEngine;

public class AdaptivePositionDog : MonoBehaviour
{
    [Header("Настройки смещения")]
    [Tooltip("Portrait offset X")]
    [SerializeField] private float portraitX_offset = -1f;
    [Tooltip("Landscape offset X")]
    [SerializeField] private float landscapeX_offset = -0.4f;
    [Tooltip("Offset Y")]
    [Range(-1f, 1f)]
    [SerializeField]private float yOffset = -0.5f;

    [SerializeField]private Camera mainCamera;
    private bool isLandscape;

    void Start()
    {
        isLandscape = IsLandscape();
        UpdatePosition();
    }

    void Update()
    {
        bool currentOrientation = IsLandscape();

        if (currentOrientation != isLandscape)
        {
            UpdatePosition();
            isLandscape = currentOrientation;
        }
    }

    void UpdatePosition()
    {
        if (mainCamera == null) return;

        float currentXOffset = IsLandscape() ? landscapeX_offset : portraitX_offset;

        Vector3 viewportPos = new Vector3(
            0.5f + currentXOffset / 2f,
            yOffset,
            mainCamera.nearClipPlane + 1f
        );

        Vector3 worldPos = mainCamera.ViewportToWorldPoint(viewportPos);

        transform.position = worldPos;
    }

    bool IsLandscape()
    {
        return Screen.width > Screen.height;
    }
}
