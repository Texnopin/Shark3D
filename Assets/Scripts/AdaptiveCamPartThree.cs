using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AdaptiveCamPartThree : MonoBehaviour
{
    [SerializeField] private Animator Cam;
    

    private void Update()
    {
        if (Screen.width > Screen.height)
        {
            Cam.SetBool("isLandskape", true);

        }
        else
        {
            Cam.SetBool("isLandskape", false);
        }

    }
}
