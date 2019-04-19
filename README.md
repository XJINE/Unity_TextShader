# Unity_TextShader

<img src="https://github.com/XJINE/Unity_TextShader/blob/master/Screenshot.jpg" width="100%" height="auto" />

Draw your text in ImageEffect (with fragment shader). This effect should be used for a debug.

## How to use

``` csharp
effect.DrawText("Your Text", posX, posY, size, color);
```

Set your text and the parameters in screen space.

### Limitation

 - Max text length is 10 (characters).
 - Valid characters are AsciiCode number 32 ~ 126.
 - `\`(back slash) becomes line-break.

## Import to Your Project

You can import this asset from UnityPackage.

- [TextShader.unitypackage](https://github.com/XJINE/Unity_TextShader/blob/master/TextShader.unitypackage)

### Dependencies

You have to import following assets to use this asset.

- [Unity_ImageEffectBase](https://github.com/XJINE/Unity_ImageEffectBase)
