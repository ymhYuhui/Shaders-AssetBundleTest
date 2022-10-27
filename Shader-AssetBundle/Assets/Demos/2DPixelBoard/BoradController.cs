using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoradController : MonoBehaviour
{
    float[,] ValueMatrix;
    Material BoradMaterial;
    // Start is called before the first frame update
    void Start()
    {
        //ValueMatrix = GetRandomValueMatrix();
    }

    // Update is called once per frame
    void Update()
    {

    }

    #region Script To shader
    void PushValueMatrixToShader()
    {
    }
    #endregion


}
