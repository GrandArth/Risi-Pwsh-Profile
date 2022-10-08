function Eq-Render{
    param(
        [Parameter(Position=0)][string]$EquationInString)
    $urlEncoded_String = [System.Web.HTTPUtility]::UrlEncode($EquationInString)
    $Zhihu_RenderUrl = "https://www.zhihu.com/equation?tex=$($urlEncoded_String)"
    Set-Clipboard $Zhihu_RenderUrl
    # Write-Output $Zhihu_RenderUrl
    return $Zhihu_RenderUrl
}