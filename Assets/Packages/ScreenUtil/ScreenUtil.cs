using UnityEngine;

public static class ScreenUtil
{
    #region Property

    public static float AspectRatio
    {
        get { return (float)Screen.width / Screen.height; }
    }

    #endregion Property

    #region Method

    public static Vector2Int ViewportToScreen(Vector2 coord)
    {
        return ScreenUtil.ViewportToScreen(coord.x, coord.y);
    }

    public static Vector2Int ViewportToScreen(float coordX, float coordY)
    {
        return new Vector2Int((int)(Screen.width  * coordX),
                              (int)(Screen.height * coordY));
    }

    public static Vector2 ScreenToViewport(Vector2Int coord)
    {
        return ScreenUtil.ScreenToViewport(coord.x, coord.y);
    }

    public static Vector2 ScreenToViewport(int coordX, int coordY)
    {
        return new Vector2((float)coordX / Screen.width,
                           (float)coordY / Screen.height);
    }

    #endregion Method
}