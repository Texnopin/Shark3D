using UnityEngine;
using UnityEngine.UI;

public class Controller : MonoBehaviour
{
    [SerializeField] private Animator cameraAnimator;
    [SerializeField] private Animator dogAnimator;
    [SerializeField] private Animator hookAnimator;
    [SerializeField] private Animator sharkAnimator;
    [SerializeField] private GameObject dog;
    [SerializeField] private Button _button;
    [SerializeField] private GameObject _textToDefend;
    [SerializeField] private GameObject _textSuccess;
    [SerializeField] private SoundManager _soundManager;

    [Header("Game Parts")] [SerializeField]
    private GameObject _partOneGameObject;

    [SerializeField] private GameObject _partTwoGameObject;
    [SerializeField] private GameObject _partThreeGameObject;
    [SerializeField] private GameObject _partFourGameObject;

    private GamePartBase _currentPart;
    private int _currentPartIndex = 0;

    private void Start()
    {
        Luna.Unity.LifeCycle.GameStarted();
        InitializeGamePartObjects();
        PlayNextPart();
    }

    private void InitializeGamePartObjects()
    {
        SafeSetActive(_partOneGameObject, false);
        SafeSetActive(_partTwoGameObject, false);
        SafeSetActive(_partThreeGameObject, false);
        SafeSetActive(_partFourGameObject, false);

        ValidateGamePart(_partOneGameObject, "PartOne");
        ValidateGamePart(_partTwoGameObject, "PartTwo");
        ValidateGamePart(_partThreeGameObject, "PartThree");
        ValidateGamePart(_partFourGameObject, "PartFour");
    }

    private void ValidateGamePart(GameObject partObject, string partName)
    {
        if (partObject == null)
        {
            Debug.LogError($"{partName} GameObject не назначен в Inspector");
            return;
        }

        if (partObject.GetComponent<GamePartBase>() == null)
        {
            Debug.LogError($"{partName} не содержит компонент GamePartBase");
        }
    }

    private void SafeSetActive(GameObject obj, bool isActive)
    {
        if (obj != null)
        {
            obj.SetActive(isActive);
        }
    }

    private void PlayNextPart()
    {
        if (_currentPart != null)
        {
            SafeSetActive(_currentPart.gameObject, false);
        }

        SafeSetActive(_textToDefend, false);
        SafeSetActive(_textSuccess, false);

        _currentPartIndex++;

        var config = GamePartConfig.Create(
            cameraAnimator,
            dogAnimator,
            hookAnimator,
            _soundManager,
            dog,
            _button,
            _textToDefend,
            _textSuccess,
            sharkAnimator
        );

        GameObject nextPartObject = null;
        switch (_currentPartIndex)
        {
            case 1:
                nextPartObject = _partOneGameObject;
                break;
            case 2:
                nextPartObject = _partTwoGameObject;
                break;
            case 3:
                nextPartObject = _partThreeGameObject;
                break;
            case 4:
                nextPartObject = _partFourGameObject;
                break;
            default:
                Debug.Log("Game completed!");
                return;
        }

        if (nextPartObject != null)
        {
            SafeSetActive(nextPartObject, true);
            _currentPart = nextPartObject.GetComponent<GamePartBase>();

            if (_currentPart != null)
            {
                _currentPart.OnPartComplete += OnPartComplete;
                _currentPart.Init(config);
            }
        }
    }

    private void OnPartComplete()
    {
        if (_currentPart != null)
        {
            _currentPart.OnPartComplete -= OnPartComplete;
        }

        PlayNextPart();
    }

    private void OnDestroy()
    {
        if (_currentPart != null)
        {
            _currentPart.OnPartComplete -= OnPartComplete;
        }
    }
}