using UnityEngine;

public class Sample : MonoBehaviour
{
    public TextShader textShader;

    void Update()
    {
        this.textShader.DrawText("HelloWorld", 0.35f, 0.5f,
            ScreenUtil.ScreenToViewport(50, 50).x, Color.green);

        this.textShader.DrawText("Line\\Break", 0.3f, 0.3f, 0.02f);

        string asciicode = " !\"#$%&'()*+,-./\\"
                         + "0123456789:;<=>?\\"
                         + "@ABCDEFGHIJKLMNO\\"
                         + "PQRSTUVWXYZ[]^_\\"
                         + "`abcdefghijklmno\\"
                         + "pqrstuvwxyz{|}~";

        this.textShader.DrawText(asciicode, 0.5f, 0.3f, 0.02f, Color.red);
    }
}