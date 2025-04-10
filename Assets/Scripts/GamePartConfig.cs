using UnityEngine;
using UnityEngine.UI;

public class GamePartConfig
{
    public Animator CameraAnimator { get; set; }
    public Animator DogAnimator { get; set; }
    public Animator HookAnimator { get; set; }
    public GameObject Dog { get; set; }
    public Button Button { get; set; }
    public GameObject TextToDefend { get; set; }
    public GameObject TextSuccess { get; set; }
    public Animator SharkAnimator { get; set; }
    
    public SoundManager SoundManager { get; set; }
    
    public static GamePartConfig Create(
        Animator cameraAnimator,
        Animator dogAnimator,
        Animator hookAnimator,
        SoundManager soundManager,
        GameObject dog,
        Button button,
        GameObject textToDefend,
        GameObject textSuccess,
        Animator sharkAnimator = null)
    {
        return new GamePartConfig
        {
            CameraAnimator = cameraAnimator,
            DogAnimator = dogAnimator,
            HookAnimator = hookAnimator,
            Dog = dog,
            Button = button,
            TextToDefend = textToDefend,
            TextSuccess = textSuccess,
            SharkAnimator = sharkAnimator,
            SoundManager = soundManager
        };
    }
}
