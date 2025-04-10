using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class PartThree : GamePartBase
{
    private const string BuildState = "Bild";
    private const string HudStateName = "HUD";
    private const string StateName = "ThreeHalf";
    private bool _isTap;

    [Header("Spawn Areas")] [SerializeField]
    private GameObject littleSpawnArea;

    [SerializeField] private GameObject spawnArea;

    [Header("Objects")] [SerializeField] private GameObject fire;
    [SerializeField] private GameObject water;
    [SerializeField] private GameObject rifle;
    [SerializeField] private GameObject rifle2;
    [SerializeField] private GameObject hand;
    [SerializeField] private GameObject HUD;

    [Header("Additional Buttons")] [SerializeField]
    private Button waterButton;

    [SerializeField] private Button fireButton;
    [SerializeField] private Button rifleButton;
    [SerializeField] private Button rifle2Button;
    [SerializeField] private Animator hudAnimator;
    [SerializeField] private Animator resourseAnimator;
    [SerializeField] private Animator HP_Animator;
    [SerializeField] private Animator TextOutOfMaterial;

    [SerializeField] private GameObject TextGoodChoise;

    [SerializeField] private Animator _tutorial;

    private void FixedUpdate()
    {
        _tutorial.gameObject.GetComponent<RectTransform>().position = fireButton.gameObject.GetComponent<RectTransform>().position;
    }

    public override void Init(GamePartConfig config)
    {
        base.Init(config);

        HUD.SetActive(true);
        hudAnimator.Play(HudStateName);
        ActionButton.gameObject.SetActive(true);
        rifleButton.gameObject.SetActive(false);
        rifle2Button.gameObject.SetActive(false);
        waterButton.gameObject.SetActive(true);
        fireButton.gameObject.SetActive(true);
    }

    protected override void OnPartStart()
    {
        base.OnPartStart();
        SetActionButtonText();
        CameraAnimator.Play(BuildState);
        spawnArea.SetActive(false);
        littleSpawnArea.SetActive(true);
        hand.SetActive(false);
        waterButton.onClick.AddListener(SpawnWater);
        fireButton.onClick.AddListener(SpawnFire);
        rifleButton.onClick.AddListener(SpawnRifle);
        rifle2Button.onClick.AddListener(SpawnRifle2);
    }

    protected override string GetActionButtonText()
    {
        return "You need food and water!";
    }

    protected override void OnActionButtonClick()
    {
    }

    protected override IEnumerator PlayAnimationSequence()
    {
        yield break;
    }

    protected override IEnumerator PlayTextAnimationsSequentially()
    {
        yield return new WaitForSeconds(0.9f);

        Debug.Log(TextToDefend);
        TextToDefend.SetActive(true);
        StartCoroutine(DelayedButtonClick(4));
    }

    private void SpawnFire()
    {
        _tutorial.SetBool("TapAnim", false);
        fire.SetActive(true);
        ActivateArea();
        StartCoroutine(DelayedButtonClick(4));
    }

    private void SpawnWater()
    {
        _tutorial.SetBool("TapAnim", false);
        water.SetActive(true);
        ActivateArea();
        StartCoroutine(DelayedButtonClick(4));
    }

    private void SpawnRifle()
    {
        _tutorial.SetBool("TapAnim", false);
        rifle.SetActive(true);
        CheckCompletion();
    }

    private void SpawnRifle2()
    {
        _tutorial.SetBool("TapAnim", false);
        rifle2.SetActive(true);
        CheckCompletion();
    }

    private void ChangeButtons()
    {
        _isTap = true;
        ActionButton.gameObject.SetActive(false);
        waterButton.gameObject.SetActive(false);
        fireButton.gameObject.SetActive(false);
        rifleButton.gameObject.SetActive(true);
        rifle2Button.gameObject.SetActive(true);
        _isTap = false;
    }

    private void ActivateArea()
    {
        _isTap = true;
        _tutorial.SetBool("TapAnim", false);
        _tutorial.gameObject.SetActive(false);
        SoundManager.PlayBildSound();
        littleSpawnArea.SetActive(false);
        spawnArea.SetActive(true);
        ChangeButtons();
        resourseAnimator.Play(StateName);
        HP_Animator.SetBool("first", true);
        HP_Animator.SetBool("second", false);
    }

    private void CheckCompletion()
    {
        _isTap = true;
        _tutorial.SetBool("TapAnim", false);
        _tutorial.gameObject.SetActive(false);
        SoundManager.PlayBildSound();
        rifleButton.gameObject.SetActive(false);
        rifle2Button.gameObject.SetActive(false);
        spawnArea.SetActive(false);
        resourseAnimator.Play("ThreeEmpty");
        HP_Animator.SetBool("first", false);
        HP_Animator.SetBool("second", true);

        if (rifle.activeSelf || rifle2.activeSelf)
        {
            StartCoroutine(CompleteWithDelay());
        }
    }

    private IEnumerator CompleteWithDelay()
    {
        if (TextGoodChoise != null)
        {
            TextGoodChoise.SetActive(true);
        }

        yield return new WaitForSeconds(1.5f);

        if (TextGoodChoise != null)
        {
            TextGoodChoise.SetActive(false);
        }

        yield return new WaitForSeconds(0.5f);

        if (TextOutOfMaterial != null)
        {
            TextOutOfMaterial.gameObject.SetActive(true);
        }

        yield return new WaitForSeconds(1.5f);

        if (TextOutOfMaterial != null)
        {
            TextOutOfMaterial.gameObject.SetActive(false);
        }

        CompleteCurrentPart();
    }

    private IEnumerator DelayedButtonClick(float delay)
    {
        yield return new WaitForSeconds(delay);
        if (!_isTap) Tutorial(); //SpawnFire();
        /*yield return new WaitForSeconds(1f);
        if (!_isTap) SpawnRifle();*/
    }

    protected override void OnDestroy()
    {
        base.OnDestroy();

        waterButton.onClick.RemoveListener(SpawnWater);
        fireButton.onClick.RemoveListener(SpawnFire);
        rifleButton.onClick.RemoveListener(SpawnRifle);
        rifle2Button.onClick.RemoveListener(SpawnRifle2);
    }

    private void Tutorial()
    {
        _tutorial.gameObject.SetActive(true);
        _tutorial.SetBool("TapAnim", true);
    }


}