using System;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public abstract class GamePartBase : MonoBehaviour
{
    protected const string Hook = "Hook";
    protected const string TakeDog = "TakeDog";
    
    protected virtual string StateName => "SaveDog";

    protected Animator CameraAnimator;
    protected Animator DogAnimator;
    protected Animator HookAnimator;
    protected Animator SharkAnimator;
    protected SoundManager SoundManager;
    protected GameObject Dog;
    protected Button ActionButton;
    protected GameObject TextToDefend;
    protected GameObject TextSuccess;
    protected SoundManager AudioManager;
    
    public event Action OnPartComplete;
    
    public virtual void Init(GamePartConfig config)
    {
        CameraAnimator = config.CameraAnimator;
        DogAnimator = config.DogAnimator;
        HookAnimator = config.HookAnimator;
        SoundManager = config.SoundManager;
        Dog = config.Dog;
        ActionButton = config.Button;
        TextToDefend = config.TextToDefend;
        TextSuccess = config.TextSuccess;
        SharkAnimator = config.SharkAnimator;
        
        OnPartStart();
    }
    
    protected virtual void OnPartStart()
    {
        if (ActionButton != null)
        {
            ActionButton.onClick.AddListener(OnActionButtonClick);
            SetActionButtonText();
            ActionButton.interactable = false;
        }
        
        if (CameraAnimator != null && CameraAnimator.gameObject != null && CameraAnimator.gameObject.activeInHierarchy)
        {
            CameraAnimator.Play(StateName);
        }
        
        if (gameObject != null && gameObject.activeInHierarchy)
        {
            StartCoroutine(PlayTextAnimationsSequentially());
        }
    }

    protected virtual void SetActionButtonText()
    {
        if (ActionButton != null && ActionButton.gameObject != null)
        {
            var buttonText = ActionButton.GetComponentInChildren<TextMeshProUGUI>();
            if (buttonText != null)
            {
                buttonText.text = GetActionButtonText();
            }
        }
    }

    protected abstract string GetActionButtonText();

    protected abstract void OnActionButtonClick();
    protected abstract IEnumerator PlayTextAnimationsSequentially();
    protected abstract IEnumerator PlayAnimationSequence();
    
    protected void CompleteCurrentPart()
    {
        OnPartComplete?.Invoke();
    }
    
    protected virtual void OnDestroy()
    {
        if (ActionButton != null)
        {
            ActionButton.onClick.RemoveListener(OnActionButtonClick);
        }
    }
}
