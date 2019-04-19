using UnityEngine;

public class Sample : MonoBehaviour
{
    public TextShader textShader;

    void Update()
    {
        this.textShader.DrawText("!", Random.value, Random.value, Random.value);

        this.textShader.DrawText("HelloWorld", 0.35f, 0.5f,
            ScreenPixelSpaceConverter.ToScreenSpace(50, 50).x, Color.green);

        this.textShader.DrawText("Line\\Break", 0.3f, 0.3f, 0.02f);

        this.textShader.DrawText(".+?(/)[|]", 0.5f, 0.3f, 0.02f, Color.red);
    }
}