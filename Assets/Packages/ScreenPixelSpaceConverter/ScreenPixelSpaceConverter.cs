using UnityEngine;

public static class ScreenPixelSpaceConverter
{
    #region Method

    public static Vector2Int ToPixelSpace(Vector2 screenSpace)
    {
        return ScreenPixelSpaceConverter.ToPixelSpace(screenSpace.x, screenSpace.y);
    }

    public static Vector2Int ToPixelSpace(float screenSpaceX, float screenSpaceY)
    {
        return new Vector2Int((int)(Screen.width  * screenSpaceX),
                              (int)(Screen.height * screenSpaceY));
    }

    public static Vector2 ToScreenSpace(Vector2Int pixelSpace)
    {
        return ScreenPixelSpaceConverter.ToScreenSpace(pixelSpace.x, pixelSpace.y);
    }

    public static Vector2 ToScreenSpace(int pixelSpaceX, int pixelSpaceY)
    {
        return new Vector2((float)pixelSpaceX / Screen.width,
                           (float)pixelSpaceY / Screen.height);
    }

    #endregion Method
}