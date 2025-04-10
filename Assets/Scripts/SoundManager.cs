using UnityEngine;

public class SoundManager : MonoBehaviour
{
    public static SoundManager Instance { get; private set; }

    [SerializeField] private AudioSource audioSourse;
    [SerializeField] private AudioClip attackSound;
    [SerializeField] private AudioClip hookSound;
    [SerializeField] private AudioClip waveSound;
    [SerializeField] private AudioClip bildSound;
    [SerializeField] private AudioClip takeSound;

    private void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }

    public void PlayAttackSound()
    {
        audioSourse.PlayOneShot(attackSound);
    }

    public void PlayHookSound()
    {
        audioSourse.PlayOneShot(hookSound);
    }

    public void PlayWaveSound()
    {
        audioSourse.PlayOneShot(waveSound);
    }

    public void PlayTakeSound()

    {
        audioSourse.PlayOneShot(takeSound);
    }

    public void PlayBildSound()
    {
        audioSourse.PlayOneShot(bildSound);
    }
}