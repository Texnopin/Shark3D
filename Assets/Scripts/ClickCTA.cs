using UnityEngine;

public class ClickCta : MonoBehaviour
{
    [SerializeField] private RectTransform playNowButton;
    [SerializeField] private RectTransform mainFoneImage;
    private bool isLandscape = false;
    private void Update()
    {
        isLandscape = IsLandscape();

        float h = Screen.height;
        float w = Screen.width;
        if (isLandscape)
        {
            mainFoneImage.localScale = new Vector3(4f + (-3.6f * (h / w)), 4f + (-3.6f * (h / w)), 4f + (-3.6f * (h / w)));
            playNowButton.localPosition = new Vector3(401, -190, 0);
        }
        else
        {
            mainFoneImage.localScale = new Vector3(1.2f + (0.18f * (h / w)), 1.2f + (0.18f * (h / w)), 1.2f + (0.18f * (h / w)));
            playNowButton.localPosition = new Vector3(0, -476, 0);

        }
    }

    bool IsLandscape()
    {
        return Screen.width > Screen.height;
    }

    public void Click()
    {
        Luna.Unity.Playable.InstallFullGame();
    }
}