using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class PartOne : GamePartBase
{
    private const string AsSharkRaftbite = "AS_Shark_RaftBite";
    private bool _isTap;
    [SerializeField] private Animator _tutorial;

    public void Init(Animator cameraAnimator, Animator dogAnimator, Animator hookAnimator, SoundManager soundManager,
        GameObject dog, Button button, GameObject textDefend, GameObject textSuccess)
    {
        base.Init(GamePartConfig.Create(
            cameraAnimator,
            dogAnimator,
            hookAnimator,
            soundManager,
            dog,
            button,
            textDefend,
            textSuccess
        ));
        SharkAnimator.Play(AsSharkRaftbite);
    }

    protected override void OnActionButtonClick()
    {
        if (_isTap)
            return;
        

        if (HookAnimator != null )
        {
            HookAnimator.Play(Hook);
            SoundManager.PlayHookSound();
        }
        _isTap = true;

        if (gameObject != null && gameObject.activeInHierarchy)
        {
            StartCoroutine(PlayAnimationSequence());
        }
        else
        {
            Debug.LogWarning($"Cannot start coroutine on inactive GameObject: {gameObject.name}");

            PlayAnimationSequenceAlternative();
        }
    }

    private void PlayAnimationSequenceAlternative()
    {
        DogAnimator.Play(TakeDog);
        SoundManager.PlayAttackSound();

        if (Dog != null)
        {
            Dog.gameObject.SetActive(true);
        }

        if (TextToDefend != null)
        {
            TextToDefend.SetActive(false);
        }

        if (TextSuccess != null)
        {
            TextSuccess.SetActive(true);
        }

        if (TextSuccess != null)
        {
            TextSuccess.SetActive(false);
        }

        if (Dog != null)
        {
            Dog.gameObject.SetActive(false);
        }

        CompleteCurrentPart();
    }

    protected override IEnumerator PlayAnimationSequence()
    {
        _tutorial.SetBool("TapAnim", false);
        _tutorial.gameObject.SetActive(false);
        yield return new WaitForSeconds(0.4f);

        if (DogAnimator != null && DogAnimator.gameObject != null && DogAnimator.gameObject.activeInHierarchy)
        {
            DogAnimator.Play(TakeDog);
        }
        else
        {
            Debug.LogWarning("Cannot play animation on inactive animator: DogAnimator");
        }

        yield return new WaitForSeconds(0.2f);

        if (Dog != null)
        {
            Dog.gameObject.SetActive(true);
        }

        if (TextToDefend != null)
        {
            TextToDefend.SetActive(false);
        }

        if (TextSuccess != null)
        {
            TextSuccess.SetActive(true);
        }

        yield return new WaitForSeconds(1.5f);

        if (TextSuccess != null)
        {
            TextSuccess.SetActive(false);
        }

        if (Dog != null)
        {
            Dog.gameObject.SetActive(false);
        }

        CompleteCurrentPart();
    }

    protected override IEnumerator PlayTextAnimationsSequentially()
    {
        yield return new WaitForSeconds(1.8f);
        StartCoroutine(DelayedButtonClick(3));

        if (TextToDefend != null)
        {
            ActionButton.interactable = true;
            TextToDefend.SetActive(true);
        }
    }

    private IEnumerator DelayedButtonClick(float delay)
    {
        yield return new WaitForSeconds(delay);
        if (!_isTap) Tutorial();//OnActionButtonClick(); теперь тут нужен туториал
    }

    protected override string GetActionButtonText()
    {
        return "Tap to save the dog";
    }

    private void Tutorial()
    {
        _tutorial.gameObject.SetActive(true);
        _tutorial.SetBool("TapAnim", true);
    }
}